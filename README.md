# vim-x2x #

Functions to convert one radix to another (also see [x2x](https://github.com/uxcn/x2x))

## Using ##

The two main ways to use this are directly calling the functions
(Bin, Oct, Dec, Hex), and mappings.

For example, to insert a binary value from hexadecimal in insert mode

    <c-r>=Bin('0xdeadbeef')

Maps can also be useful.

    xmap <leader>b  <plug>x2b
    nmap <leader>b  <plug>x2b
    xmap <leader>o  <plug>x2o
    nmap <leader>o  <plug>x2o
    xmap <leader>d  <plug>x2d
    nmap <leader>d  <plug>x2d
    xmap <leader>h  <plug>x2h
    nmap <leader>h  <plug>x2h

The above convert values using visual select (vw<leader\>h), and motions
(<leader\>hw).

## Help ##

:help x2x

                                                    *Bin()*
    Bin({expr})              Convert {expr} to binary.

                                                    *Oct()*
    Oct({expr})              Convert {expr} to octal.

                                                    *Dec()*
    Dec({expr})              Convert {expr} to decimal.

                                                    *Hex()*
    Hex({expr})              Convert {expr} to hexadecimal.

                                                    *v_x2b*
    {Visual}<Plug>x2b        Convert highlighted to binary.

                                                    *x2b*
    <Plug>x2b{motion}        Convert value that {motion} moves over to binary.

                                                    *v_x2o*
    {Visual}<Plug>x2o        Convert highlighted to octal.

                                                    *x2o*
    <Plug>x2o{motion}        Convert value that {motion} moves over to octal.

                                                    *v_x2d*
    {Visual}<Plug>x2d        Convert highlighted to decimal.

                                                    *x2d*
    <Plug>x2d{motion}        Convert value that {motion} moves over to decimal.

                                                    *v_x2h*
    {Visual}<Plug>x2h        Convert highlighted to hexadecimal.

                                                    *x2h*
    <Plug>x2h{motion}        Convert value that {motion} moves over to hexadecimal.

## Install ##

The two easiest ways to install are vundle and pathogen.

### vundle ###

See [vundle](https://github.com/gmarik/Vundle.vim) for vundle install
instructions.

In your vimrc, add

    Plugin 'uxcn/vim-x2x'

From vim, run

    :PluginInstall

### pathogen ###

See [pathogen](https://github.com/tpope/vim-pathogen) for pthogen install
instructions.

Clone vim-x2x into the bundle directory

    git clone git://github.com/uxcn/vim-x2x.git ~/.vim/bundle/vim-x2x
    

