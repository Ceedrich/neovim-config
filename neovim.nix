pkgs: let
  ceedrichVimPlugin =
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
  neovim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = extraConfig;
      packages.main = {start = [ceedrichVimPlugin];};
    };
    extraMakeWrapperArgs = ''--suffix PATH : ${pkgs.lib.makeBinPath extraPackages}'';
  };
  ceedrichVim = ceedrichVimPlugin;
  hmModule = {
    programs.neovim = {
      inherit extraConfig extraPackages;
      plugins = [ceedrichVimPlugin];
    };
  };
}
