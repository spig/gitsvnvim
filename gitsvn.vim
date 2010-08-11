if !exists('g:gitsvn_command_edit')
    let g:gitsvn_command_edit = 'new'
endif

if !exists('g:gitsvn_bufhidden')
    let g:gitsvn_bufhidden = ''
endif

nnoremap <Leader>gsd :GitSvnDcommit<Enter>

" Git SVN Dcommit
function! GitSvnDcommit()
    let output = system('git svn dcommit')
    if !strlen(output)
        echo "No output from git svn dcommit"
        return
    endif
    call <SID>OpenBuffer(output)
endfunction

function! s:OpenBuffer(content)
    if exists('b:is_gitsvn_msg_buffer') && b:is_gitsvn_msg_buffer
        enew!
    else
        execute g:gitsvn_command_edit
    endif

    setlocal buftype=nofile readonly modifiable
    execute 'setlocal bufhidden=' . g:gitsvn_bufhidden

    silent put=a:content
    keepjumps 0d
    setlocal nomodifiable

    let b:is_gitsvn_msg_buffer = 1
endfunction

command!          GitSvnDcommit       call GitSvnDcommit()
