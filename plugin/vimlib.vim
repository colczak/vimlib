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
  if curdir == '/'
    let curdir = origcurdir
    exe 'cd ' curdir
  end
  "echo 'CURDIR='.curdir
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

function! vimlib#search(query)
  call vimlib#gitDir()
  let curdir = getcwd()

  let grep_cmd = "cd ".curdir."; search \"".a:query."\""
  let vim_func = "VimlibSearchResults"

  echo grep_cmd
  call AsyncCommand(grep_cmd, vim_func)
endfunction

function! VimlibSearchResults(temp_file_name)
  let &errorformat = &grepformat
  call OnCompleteLoadErrorFile(a:temp_file_name)
endfunction

command! -nargs=1 VimlibSearch call vimlib#search(<q-args>)
