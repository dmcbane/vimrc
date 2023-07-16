if (exists('g:use_gui') && g:use_gui)
    if has('gui_gtk2')
        " linux
        set guifont=JuliaMono\ 16
    elseif has('gui_gtk3')
        " linux
        set guifont=JuliaMono\ 16
    elseif has('gui_macvim')
        " mac
        set guifont=Meslo\ LG\ S\ for\ Powerline:h20
    elseif has('gui_win32')
        " windows
        set guifont=Noto_Mono_for_Powerline:h16:cANSI:qDRAFT
    endif
endif

