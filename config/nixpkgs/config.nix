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
        rustup
        git
        "nixpkgs.sumneko-lua-language-server"
        mypy
        black
        lazygit
        fd
        exa
      ];
      pathsToLink = [ "/share" "/bin" ];
    };
  };
}
