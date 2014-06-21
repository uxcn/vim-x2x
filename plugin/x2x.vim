" x2x.vim - convert values from one radix to another
" Author: Jason Schulz <https://github.com/uxcn>
" Description: Some functions to convert one radix into another
" Version: 0.1

if exists("g:loaded_x2x") || &cp
  finish
endif

let g:loaded_x2x = 1

let s:digits = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f']

function! Bin(s)
  return s:Sgn(a:s) . '0b' . s:To(a:s, 2)
endfunction

function! Oct(s)
  return s:Sgn(a:s) . '0' . s:To(a:s, 8)
endfunction

function! Dec(s)
  return s:Sgn(a:s) . s:To(a:s, 10)
endfunction

function! Hex(s)
  return s:Sgn(a:s) . '0x' . s:To(a:s, 16)
endfunction

function! s:Sgn(s)
  if (a:s[0] ==# '-')
    return '-'
  else
    return ''
  endif
endfunction

function! s:To(s, r)

  let s = a:s
  let v = []

  if (s[0] ==# '-')
    let s = strpart(s, 1, strlen(s))
  endif

  if (s[0] ==# '0')
    if (s[1] ==? 'x')
      let s = strpart(s, 2, strlen(s))
      let b = 16
    elseif (s[1] ==? 'b')
      let s = strpart(s, 2, strlen(s))
      let b = 2
    else
      let s = strpart(s, 1, strlen(s))
      let b = 8
    endif
  else
    let b = 10
  endif

  for i in range(0, strlen(s) - 1)
    let v = s:Add(s:Mul(v, b, a:r), s:Dig(s[i], b), a:r)
  endfor

  let s = ''

  for i in range(0, len(v) - 1)
    let s = s:digits[v[i]] . s
  endfor

  return s

endfunction

function! s:Dig(c, b)

  let a = char2nr(a:c)

  if (a > 47 && a < 59) 
    let d = a - 48 " 0..9
  elseif (a > 64 && a < 71) 
    let d = a - 55 " A..F
  elseif (a > 96 && a < 103) 
    let d = a - 87 " a..f
  else
    throw "invalid character " . a:c
  endif

  if (d >= a:b)
    throw 'value ' . a:c . 'out of base(' . a:b . ') range'
  endif

  return d

endfunction

function! s:Add(x, y, b)

  let i = 0
  let c = a:y

  let l = len(a:x)

  while (c)

    if (i >= l)
      let v = c
      call add(a:x, v % a:b)
    else
      let v = a:x[i] + c
      let a:x[i] = v % a:b
    endif 

    let c = v / a:b
    let i += 1
  endwhile

  return a:x

endfunction

function! s:Mul(x, y, b)

  let i = 0
  let c = 0

  let l = len(a:x)

  while ((c != 0) || (i < l))

    if (i >= l)
      let v = c
      call add(a:x, v % a:b)
    else
      let v = a:x[i] * a:y + c
      let a:x[i] = v % a:b
    endif 

    let c = v / a:b
    let i += 1
  endwhile

  return a:x

endfunction

function! s:X2b(type, ...) 
  call s:X2x(function('Bin'), a:type, a:0)
endfunction

function! s:X2o(type, ...) 
  call s:X2x(function('Oct'), a:type, a:0)
endfunction

function! s:X2d(type, ...) 
  call s:X2x(function('Dec'), a:type, a:0)
endfunction

function! s:X2h(type, ...) 
  call s:X2x(function('Hex'), a:type, a:0)
endfunction

function! s:X2x(fun, type, visual)
  let r = @"

  if a:visual
    execute "normal! `<" . a:type . "`>d"
  else
    execute "normal! `[v`]d"
  endif

  try
    let @" = a:fun(@")
    execute 'normal! p`['
  catch /.*/
    execute 'normal! u'
    echohl ErrorMsg
    echo v:exception
  endtry

  let @" = r
endfunction

xnoremap <silent> <Plug>x2b :call <SID>X2b(visualmode(), 1)<CR>
nnoremap <silent> <Plug>x2b :set opfunc=<SID>X2b<CR>g@

xnoremap <silent> <Plug>x2o :call <SID>X2o(visualmode(), 1)<CR>
nnoremap <silent> <Plug>x2o :set opfunc=<SID>X2o<CR>g@

xnoremap <silent> <Plug>x2d :call <SID>X2d(visualmode(), 1)<CR>
nnoremap <silent> <Plug>x2d :set opfunc=<SID>X2d<CR>g@

xnoremap <silent> <Plug>x2h :call <SID>X2h(visualmode(), 1)<CR>
nnoremap <silent> <Plug>x2h :set opfunc=<SID>X2h<CR>g@


" vim:ft=vim:et:ts=2:sw=2:tw=80
