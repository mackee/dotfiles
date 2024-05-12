" https://miyazi888.hatenablog.com/entry/2019/07/01/235647
function! RenameFile(...)
  let old_name = expand('%')

  if a:0 >= 1
    let default_name = expand("%:h") . '/' . a:1
  else
    let default_name = expand('%')
  endif
  let new_name = input('New current file name: ', default_name)
  if filereadable(new_name)
    redraw!
    echo "Can't rename : Already exists new filename."
    return
  end

  if new_name != '' && new_name != old_name
    exec ':f ' . new_name . '|call delete(expand("#"))'
    exec ':saveas ' . new_name
    redraw!
  endif
endfunction
command! -nargs=? Rename call RenameFile(<f-args>)
