" Very simple function to change the color scheme from a list of color scheme names.
" Press F8 for next scheme, or Shift-F8 for previous scheme.

let s:swindex = 0
let s:swcolors =  []  
let s:swcolors += ['blue', 'darkblue', 'delek', 'desert', 'elflord','evening', 'industry', 'koehler', 'morning'] 
let s:swcolors += ['murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'torte', 'zellner'] 

function! SwitchColor(swinc)
  let s:swindex += a:swinc
  let s:swindex = s:swindex % (len(s:swcolors))
  execute "colorscheme " . s:swcolors[s:swindex]
	redraw
	execute "colorscheme"
endfunction

map  <F8>        :call SwitchColor(1)<CR>
imap <F8>   <Esc>:call SwitchColor(1)<CR>

map  <S-F8>      :call SwitchColor(-1)<CR>
imap <S-F8> <Esc>:call SwitchColor(-1)<CR>
