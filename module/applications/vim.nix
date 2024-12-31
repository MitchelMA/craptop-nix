{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize {
      name = "vim";
     
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix ];
        opt = [ ];
      };

      vimrcConfig.customRC = ''
        set nocompatible
        set backspace=indent,eol,start
        syntax on

        set number
        set relativenumber

        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
        set autoindent smartindent

        set noswapfile

        color slate
      '';
    }
  )];
}
