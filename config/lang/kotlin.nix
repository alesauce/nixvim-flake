{pkgs, ...}: {
  plugins = {
    lsp.servers.kotlin_language_server = {
      enable = true;
      package = pkgs.kotlin-language-server.overrideAttrs (old: {
        version = "1.3.3";
        src = pkgs.fetchFromGitHub {
          owner = "fwcd";
          repo = "kotlin-language-server";
          rev = "1.3.3";
          hash = "sha256-qT4Q4fQg8d/2xzaWDNJHTq6pnzSYA1b+3UL6hdXnCzg=";
        };
        dontBuild = false;
        buildPhase = ''
          ./gradlew :server:installDist
        '';
        installPhase = ''
          # mkdir -p $out/lib
          mkdir -p $out/bin
          # cp -r lib/* $out/lib
          cp -r ./server/build/install/server/bin/* $out/bin
        '';
      });
    };
  };
}
