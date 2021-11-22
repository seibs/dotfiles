{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        fzf
        neovim
        nodejs
        pyright
        ripgrep
        tmux
      ];
      pathsToLink = [ "/share" "/bin" "/Applications"];
    };
  };
}
