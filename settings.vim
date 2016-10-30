let vimsettings = '~/.vim/settings'
let uname = system("uname -s")

let g:flow_path = '/usr/local/bin/flow'

for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor
