if ! exists("g:jenkins_job_builder_autodetect")
    let g:jenkins_job_builder_autodetect = 0
endif

let s:known_jjb_entities = ["builder", "defaults", "job", "job-group", "job-template", "project", "publisher", "scm", "view"]

function s:CheckForJJBEntities()
    " Check file for known JJB entities
    let known = 0
    let unknown = 0
    for i in range(1, line("$"))
        let temp_line = getline(i)
        if temp_line !~ '^- .*:$'
            " This isn't a list item, skip it
            continue
        endif
        let entity_type = substitute(temp_line, '- \(.*\):', '\1', 'g')
        if index(s:known_jjb_entities, entity_type) >= 0
            let known += 1
        else
            let unknown += 1
        endif
    endfor
    if known > unknown
        set filetype=jjb_yaml
    endif
endfunction

if g:jenkins_job_builder_autodetect
    autocmd BufNewFile,BufRead *.yaml call s:CheckForJJBEntities()
endif
