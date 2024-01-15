" TODO better way to configure vim plugins with packer?
let test#strategy = "neovim"
let test#python#runner = "pyunit"
let test#python#pyunit#executable = "bin/pytest --no-cov --no-buffer"

" Hack to get things working, should probably make a custom runner
function! TSTransform(cmd) abort
  return a:cmd->substitute('pytest\.', '', '')
endfunction

let g:test#custom_transformations = {'ts': function('TSTransform')}
let g:test#transformation = 'ts'

nmap <silent> <leader>t :TestNearest<CR>
