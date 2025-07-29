{ config, pkgs, lib, home-manager, ... }: {
  home-manager.users.ayham = { pkgs, ... }: {
    programs.vim = {
      enable = true;
      #defaultEditor = true;

      plugins = with pkgs.vimPlugins; [
        vim-ledger
        vim-fugitive
        vim-gitgutter
        ctrlp-vim
        vim-polyglot
        vim-bracketed-paste
        vim-surround
        vim-lsp
        vim-lsp-settings
        vim-nix
        asyncomplete-vim
        asyncomplete-lsp-vim
      ];

      extraConfig = ''
        let mapleader=" "
        let g:ledger_maxwidth = 80
        let g:ledger_is_hledger = 0
        let g:lsp_diagnostics_enabled = 0
        let g:lsp_document_highlight_enabled = 0
        let g:asyncomplete_auto_completeopt = 0

        autocmd BufWritePre *.ledger call execute('LedgerAlign')
        autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

        function! s:on_lsp_buffer_enabled() abort
          setlocal omnifunc=lsp#complete
          setlocal signcolumn=yes
          if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
          nmap <buffer> gd <plug>(lsp-definition)
          nmap <buffer> gs <plug>(lsp-document-symbol-search)
          nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
          nmap <buffer> gr <plug>(lsp-references)
          nmap <buffer> gi <plug>(lsp-implementation)
          nmap <buffer> gt <plug>(lsp-type-definition)
          nmap <buffer> <leader>rn <plug>(lsp-rename)
          nmap <buffer> [g <plug>(lsp-previous-diagnostic)
          nmap <buffer> ]g <plug>(lsp-next-diagnostic)
          nmap <buffer> K <plug>(lsp-hover)
          nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
          nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

          let g:lsp_format_sync_timeout = 1000
          autocmd! BufWritePre *.rs,*.go,*.c,*.cpp,*.h,*.hxx,*.py,*.md call execute('LspDocumentFormatSync')
        endfunction

        augroup lsp_install
          au!
          autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
        augroup END

        " UI Settings
        set number
        set relativenumber
        set cursorline
        "set spell
        set mouse=a

        map <ScrollWheelUp> <C-Y>
        map <ScrollWheelDown> <C-E>

        " Arrow key discipline
        noremap <up> :echoerr "Umm, use k instead"<CR>
        noremap <down> :echoerr "Umm, use j instead"<CR>
        noremap <left> :echoerr "Umm, use h instead"<CR>
        noremap <right> :echoerr "Umm, use l instead"<CR>
        inoremap <up> <NOP>
        inoremap <down> <NOP>
        inoremap <left> <NOP>
        inoremap <right> <NOP>
        nnoremap <up> <C-a>
        nnoremap <down> <C-x>
        noremap <C-n> <C-d>
        noremap <C-p> <C-b>

        let &t_SI = "\e[4 q"
        let &t_EI = "\e[2 q"
      '';
    };
  };
}
