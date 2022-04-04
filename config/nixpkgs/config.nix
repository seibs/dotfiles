{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        bison
        fzf
        libjpeg
        libpng
        neovim
        nodejs
        pyright
        ripgrep
        tmux
	"nodePackages.typescript"
	"nodePackages.typescript-language-server"
      ];
      pathsToLink = [ "/share" "/bin" ];
    };
  };
}
