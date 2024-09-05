let g:buffer_list_file = expand('~/.vim_buffer_list')
let g:buffer_list = []
" On delete save and re load buffer list 
" On delete remove value from list and print the list of files again
" On add print the list of files again


" Load the buffer list from the file on startup
function! LoadBufferList()
  if filereadable(g:buffer_list_file)
    let file_paths = readfile(g:buffer_list_file)
    let g:buffer_list = []
    for file in file_paths
      let buf = bufnr(file, 1)  " Open the file in a buffer if not already open
      if buf != -1
        call add(g:buffer_list, buf)
      endif
    endfor
  endif
endfunction

" Save the buffer list (file paths) to a file on exit
function! SaveBufferList()
  let file_paths = map(copy(g:buffer_list), 'fnamemodify(bufname(v:val), ":p")')
  call writefile(file_paths, g:buffer_list_file)
  echo "Buffer list saved."
endfunction

" Add the current file's buffer to the buffer list
function! AddBuffer()
  if len(g:buffer_list) >= 5
    echo "Buffer list is full. Please delete a buffer before adding a new one."
    return
  endif
  let l:bufnr = bufnr('%')
  if index(g:buffer_list, l:bufnr) != -1
    echo "Buffer already exists: " . expand('%')
    return
  endif
  call add(g:buffer_list, l:bufnr)
  call SaveBufferList()
  call ListBuffers()
  echo "Buffer added: " . expand('%')
endfunction

" Remove the current file's buffer from the buffer list
function! RemoveBuffer()
  let l:bufnr = bufnr('%')
  let l:index = index(g:buffer_list, l:bufnr)
  if l:index != -1
    call remove(g:buffer_list, l:index)
    call SaveBufferList()
    call ListBuffers()
    echo "Buffer removed: " . expand('%')
  else
    echo "Buffer not found: " . expand('%')
  endif
endfunction


" List all buffers with corresponding key mappings
function! ListBuffers()
  let keys = ['q', 'w', 'e', 'r', 't']
  echo "Buffers:"
  for i in range(len(g:buffer_list))
    let bufnr = g:buffer_list[i]
    if bufnr > 0  " Skip empty slots
      let key = keys[i]
      echo key . ": " . bufname(bufnr)
    endif
  endfor
endfunction

" Go to the buffer at the specified index
function! GoToBuffer(index)
  if a:index >= 0 && a:index < len(g:buffer_list) && g:buffer_list[a:index] > 0
    exec 'buffer' g:buffer_list[a:index]
  else
    echo "Invalid buffer index"
  endif
endfunction

" Automatically load the buffer list on Vim startup
autocmd VimEnter * call LoadBufferList()

" Automatically save the buffer list on Vim exit
autocmd VimLeavePre * call SaveBufferList()

" Define key mappings
nnoremap <leader>a :call AddBuffer()<CR>
nnoremap <leader>d :call RemoveBuffer()<CR>
nnoremap <leader>l :call ListBuffers()<CR>

" Map specific buffers to keys (e.g., <leader>q, <leader>w) with conditional save
nnoremap <leader>q :if &modifiable && !empty(&filetype) <Bar> w <Bar> endif <CR>:call GoToBuffer(0)<CR>
nnoremap <leader>w :if &modifiable && !empty(&filetype) <Bar> w <Bar> endif <CR>:call GoToBuffer(1)<CR>
nnoremap <leader>e :if &modifiable && !empty(&filetype) <Bar> w <Bar> endif <CR>:call GoToBuffer(2)<CR>
nnoremap <leader>r :if &modifiable && !empty(&filetype) <Bar> w <Bar> endif <CR>:call GoToBuffer(3)<CR>
nnoremap <leader>t :if &modifiable && !empty(&filetype) <Bar> w <Bar> endif <CR>:call GoToBuffer(4)<CR>

