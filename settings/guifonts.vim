if (exists('g:use_gui') && g:use_gui)
    set guifont=Meslo\ LG\ S\ for\ Powerline:h20
    if has('gui_gtk2')
        " linux
    elseif has('gui_macvim')
        " mac
    elseif has('gui_win32')
        " windows
        set guifont=Noto_Mono_for_Powerline:h16:cANSI:qDRAFT
    endif
endif

