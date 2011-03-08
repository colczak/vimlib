function! vimlib#testFunct()
  echo 'hello world3'
endfunction

function! vimlib#gitDir()

  let origcurdir = getcwd()
  let curdir = origcurdir
  let prevdir = ""
  let gitdir = ""

  while curdir != prevdir
    if isdirectory(".git")
      let gitdir = getcwd()
      break
    endif
    cd ..
    let prevdir = curdir
    let curdir = getcwd()
  endwhile
 
"  cd origcurdir
  echo gitdir
endfunction

function! vimlib#projectFuzzyFind()
  call vimlib#gitDir()
  let curdir = getcwd()
  let files = []
  let files += split(glob(curdir . "/**/*"), "\n")
  call fuf#givenfile#launch('', 0, '>', files)
  " call fuf#givendir#launch('', 0, '>', split(&runtimepath, ','))
  "  :FufFileWithCurrentBufferDir 
endfunction
