pkgs: let
  ceedrichVim =
    pkgs.vimUtils.buildVimPlugin
    {
      name = "CeedrichVim";
      src = ./.;
      dependencies = import ./plugin_dependencies.nix pkgs;
    };
  extraConfig = ''
    lua << EOF
    require("CeedrichVim").init()
    EOF
  '';

  extraPackages = import ./dependencies.nix pkgs;
in {
  neovim = pkgs.neovim.override {
    configure = {
      customRC = extraConfig;
      packages.main = {start = [ceedrichVim];};
    };
    extraMakeWrapperArgs = ''--suffix PATH : ${pkgs.lib.makeBinPath extraPackages}'';
  };
  ceedrichVim = ceedrichVim;
  hmModule = {
    programs.neovim = {
      inherit extraConfig extraPackages;
      plugins = [ceedrichVim];
    };
  };
}
