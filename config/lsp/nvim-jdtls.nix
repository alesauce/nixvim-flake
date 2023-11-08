{
  plugins.nvim-jdtls = {
    enable = true;
    cmd = [
      "$\{pkgs.jdt-language-server}/bin/jdt-language-server"
      "--jvm-arg=-javaagent:/home/alesauce/Developer/lombok.jar"
      "-data .idea/nvim-jdtls"
    ];
    rootDir = {
      __raw = "require('jdtls.setup').find_root({ 'packageInfo' }, 'Config')";
    };
    initOptions = {
      workspaceFolders = {
        __raw = ''
        function ()
          local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
          local ws_folders_jdtls = {}
          if root_dir then
           local file = io.open(root_dir .. "/.bemol/ws_root_folders")
           if file then
            for line in file:lines() do
             table.insert(ws_folders_jdtls, "file://" .. line)
            end
            file:close()
           end
          end
        end
        '';
      };
    };
  };
}
