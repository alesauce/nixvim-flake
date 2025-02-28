{
  pkgs,
  helpers,
  ...
}: {
  extraConfigLuaPre = let
    java-debug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
    java-test = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
  in ''
    local jdtls_dap = require("jdtls.dap")

    _M.jdtls = {}
    _M.jdtls.bundles = {}
    local java_debug_bundle = vim.split(vim.fn.glob("${java-debug}" .. "/*.jar"), "\n")
    local java_test_bundle = vim.split(vim.fn.glob("${java-test}" .. "/*.jar", true), "\n")

    -- Following filters out unwanted bundles
    local ignored_bundles = { "com.microsoft.java.test.runner-jar-with-dependencies.jar", "jacocoagent.jar" }
    local find = string.find
    local function should_ignore_bundle(bundle)
        for _, ignored in ipairs(ignored_bundles) do
            if find(bundle, ignored, 1, true) then
                return true
            end
        end
    end
    local filtered_java_debug_bundle = vim.tbl_filter(function(bundle) return bundle ~= "" and not should_ignore_bundle(bundle) end, java_debug_bundle)
    local filtered_java_test_bundle = vim.tbl_filter(function(bundle) return bundle ~= "" and not should_ignore_bundle(bundle) end, java_test_bundle)
    vim.list_extend(_M.jdtls.bundles, filtered_java_debug_bundle)
    vim.list_extend(_M.jdtls.bundles, filtered_java_test_bundle)
  '';

  plugins.nvim-jdtls = {
    enable = true;
    configuration.__raw = ''vim.fn.stdpath 'cache' .. "/jdtls/config"'';
    data = helpers.mkRaw "os.getenv('HOME') .. '/.local/share/eclipse' .. vim.fn.fnamemodify(vim.fs.root(0, '.git'), ':p:h:t')";
    settings = {
      java = {
        configuration = {
          runtimes = [
            pkgs.jdk
            pkgs.jdk17
          ];
        };
        signatureHelp.enable = true;
        completion = {
          enable = true;
          filteredTypes = [
            "com.sun.*"
            "io.micrometer.shaded.*"
            "java.awt.*"
            "jdk.*"
            "sun.*"
            "are.you.sure.*"
          ];
        };
        implementationsCodeLens.enable = true;
        referenceCodeLens.enable = true;
        inlayHints = {
          parameterNames.enabled = "all";
        };
        codeGeneration = {
          generateComments = true;
        };
      };
    };
    initOptions = {
      bundles = helpers.mkRaw "_M.jdtls.bundles";
    };
    extraOptions = {
      onAttach = ''
        function(client, bufnr)
          jdtls.setup_dap({hotcodereplace = 'auto'})
          jdtls.setup.add_commands()
          bemol()
        end
      '';
    };
  };
}
