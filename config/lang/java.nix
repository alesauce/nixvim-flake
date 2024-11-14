{
  pkgs,
  lib,
  helpers,
  ...
}: {
  # TODO: add debug adapter support
  extraPackages = with pkgs; [
    jdt-language-server
  ];

  extraConfigLuaPre = ''
    local jdtls_setup = require("jdtls.setup")
    _M.root_dir = jdtls_setup.find_root({ "packageInfo" }, "Config")
    _M.ws_folders_jdtls = {}
    if root_dir then
     local file = io.open(root_dir .. "/.bemol/ws_root_folders")
     if file then
      for line in file:lines() do
       table.insert(_M.ws_folders_jdtls, "file://" .. line)
      end
      file:close()
     end
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
            " * Copyright " .. os.date("%Y") .. " 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.",
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
    initOptions = {
      workspaceFolders = helpers.mkRaw "_M.ws_folders_jdtls";
    };
  };
}
