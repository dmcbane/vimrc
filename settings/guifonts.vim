if has("gui_running")
    if has("gui_gtk2")
        " linux
    elseif has("gui_macvim")
        " mac
    elseif has("gui_win32")
        set guifont=Noto_Mono_for_Powerline:h16:cANSI:qDRAFT
    endif
endif

