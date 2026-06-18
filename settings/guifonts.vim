if (exists('g:use_gui') && g:use_gui)
    if has('gui_gtk2')
        " linux
        set guifont=JuliaMono\ 16
    elseif has('gui_gtk3')
        " linux
        set guifont=JuliaMono\ 16
    elseif has('gui_macvim')
        " mac
        set guifont=Hack_Nerd_font_Mono_Regular:h18 
    elseif has('gui_win32')
        " windows
        " set guifont=Noto_Mono_for_Powerline:h16:cANSI:qDRAFT
        set guifont=Hack_Nerd_Font_Mono:h16:cANSI:qDRAFT
    endif
elseif exists("g:gui_vimr")
    " macOs VimR specific settings
   set guifont=Hack_Nerd_font_Mono_Regular:h18 
elseif exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    set guifont=Hack_Nerd_Font_Mono:h16:cANSI:qDRAFT
endif

