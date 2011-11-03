" görillas.vim : a remake of the classic game 'Gorillas.bat'
" Version      : 0.1
" Maintainer   : jackie kircher <kircher.jackie@gmail.com>
" License      : WTFPL

" ** JUMP SHIP ** "
if v:version < 600 || !has("ruby")
  echomsg "GORILLAS REQUIRES RUBY SUPPORT"
  finish
end

" ** LOAD FILE? ** "
if exists("loaded_gorillas")
  finish "too many gorillas"
  " unload görillas here instead?
endif
let loaded_gorillas = 1
let s:user_cpo = &cpo " store current compatible-mode
set cpo&vim           " go into noncompatible-mode

" ** CONFIGURATION ** "
" variable script path
if !exists("gorillas_path")
  let s:vim_path = split(&runtimepath, ',')
  let s:gorillas_path = s:vim_path[0]."/plugin/görillas.vim"
else
  let s:gorillas_path = gorillas_path
  unlet gorillas_path
end

" ** SAFE FUNCTION MAPPING **"
" or something...
"if !hasmapto('<Plug>StartGorillas')
"  map <unique> <Leader>a <Plug>StartGorillas
"endif
"noremap <unique> <script> <Plug>StartGorillas
"noremap <SID>StartGorillas :call <SID>StartGorillas()<CR>

command! -nargs=? Gorillas :call <SID>Gorillas(<args>)

function! s:Gorillas(...)
  call gorillas#Gorillas()
endfunction

function! gorillas#Gorillas()

  try
    call s:play()
  catch /^Vim:Interrupt$/
    " Do nothing.
  finally

  endtry
  
endfunction

function! s:play()
  ruby load "gorillas.rb"
endfunction

let &cpo = s:user_cpo " restore user's compatible-mode
unlet s:user_cpo
