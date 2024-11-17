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
    local jdtls_setup = require("jdtls.setup")

    _M.ws_folders_jdtls = {}
    _M.root_dir = jdtls_setup.find_root({ "packageInfo" }, "Config")

    if _M.root_dir then
     local file = io.open(_M.root_dir .. "/.bemol/ws_root_folders")
     if file then
      for line in file:lines() do
       table.insert(_M.ws_folders_jdtls, "file://" .. line)
      end
      file:close()
     end
    end

    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    _M.capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

    local jdtls = require("jdtls")
    local jdtls_dap = require("jdtls.dap")

    _M.jdtls = {}
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

  autoCmd = [
    {
      event = "BufNewFile";
      pattern = "*.java";
      callback.__raw = ''
        function()
          local header = {
            "/*",
            " * Copyright " .. os.date("%Y") .. " Amazon.com, Inc. or its affiliates. All Rights Reserved.",
            " * All rights reserved.",
            " */",
          }
          vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
        end
      '';
    }
  ];

  plugins.nvim-jdtls = {
    enable = true;
    rootDir = helpers.mkRaw "_M.root_dir";
    cmd = [
      (lib.getExe pkgs.jdt-language-server)
      "-Dlog.protocol=true"
      "-Dlog.level=ALL"
      "--add-modules=ALL-SYSTEM"
    ];
    data.__raw = "os.getenv('HOME') .. '/.local/share/eclipse/' .. vim.fn.fnamemodifyal(_M.root_dir, ':p:h:t')";
    settings = {
      java = {
        signatureHelp.enable = true;
        completion.enable = true;
        saveActions.organizeImports = true;
        implementationsCodeLens.enable = true;
        referenceCodeLens.enable = true;
        inlayHints = {
          parameterNames.enabled = "all";
        };
      };
    };
    extraOptions = {
      capabilities = helpers.mkRaw "_M.capabilities";
    };
    initOptions = {
      workspaceFolders = helpers.mkRaw "_M.ws_folders_jdtls";
    };
  };
}
