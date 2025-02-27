{
  pkgs,
  lib,
  helpers,
  ...
}: {
  extraPackages = with pkgs;
    [
      jdt-language-server
    ]
    ++ (with vscode-extensions.vscjava; [
      vscode-java-debug
      vscode-java-test
    ]);

  extraConfigLuaPre = let
    java-debug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
    java-test = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
  in ''
    local jdtls = require("jdtls")
    _M.jdtls = {}

    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    _M.capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

    local jdtls_dap = require("jdtls.dap")

    _M.jdtls.bundles = {}
    local java_debug_bundle = vim.split(vim.fn.glob("${java-debug}" .. "/*.jar"), "\n")
    local java_test_bundle = vim.split(vim.fn.glob("${java-test}" .. "/*.jar", true), "\n")
    -- add jars to the bundle list if there are any
    if java_debug_bundle[1] ~= "" then
        vim.list_extend(_M.jdtls.bundles, java_debug_bundle)
    end

    if java_test_bundle[1] ~= "" then
        vim.list_extend(_M.jdtls.bundles, java_test_bundle)
    end
  '';

  plugins.nvim-jdtls = {
    enable = true;
    rootDir = helpers.mkRaw "_M.workspace_root_dir";
    cmd = [
      (lib.getExe pkgs.jdt-language-server)
      "-Dlog.protocol=true"
      "-Dlog.level=ALL"
      "--add-modules=ALL-SYSTEM"
    ];
    data.__raw = "os.getenv('HOME') .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(_M.workspace_root_dir, ':p:h:t')";
    settings = {
      java = {
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
    extraOptions = {
      capabilities = helpers.mkRaw "_M.capabilities";
    };
    initOptions = {
      bundles = helpers.mkRaw "_M.jdtls.bundles";
    };
  };
}
