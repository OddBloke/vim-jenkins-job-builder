function FindYamlNamesInFold()
    let names = []
    for i in range(v:foldstart, v:foldend)
        let temp_line = getline(i)
        if temp_line =~ '^ \+name: '
            let name = substitute(temp_line, '^ \+name: ''\?\([^'']*\)''\?', '\1', 'g')
            let names = add(names, name)
        endif
    endfor
    return names
endfunction

function FindYamlListItemsInFold()
    let expected_prefix = substitute(getline(v:foldstart), '\( \+\)-.*', '\1', 'g') . '-'
    let items = []
    for i in range(v:foldstart, v:foldend)
        let temp_line = getline(i)
        if temp_line =~ '^' . expected_prefix
            let name = substitute(temp_line, '^ \+- ''\?\([^'':]*\)''\?.*\(:.*\)\?', '\1', 'g')
            let items = add(items, name)
        endif
    endfor
    return items
endfunction

function JJBYamlFoldText()
    let line_count = v:foldend - v:foldstart + 1
    let fold_prefix = "+-" . v:folddashes . "  " . printf("%3d", line_count) . " lines: "
    if v:foldlevel == 1
        " At the top-level, attempt to display the name of each JJB object.
        let names = FindYamlNamesInFold()
        if ! empty(names)
            return fold_prefix . names[0]
        endif
    elseif v:foldlevel == 2
        " At the next level down, attempt to display all the names found in
        " the fold or, failing that, all the top-level list item strings in
        " the fold.
        let display_items = FindYamlNamesInFold()
        if empty(display_items)
            let display_items = FindYamlListItemsInFold()
        endif
        if ! empty(display_items)
            return fold_prefix . "[" . join(display_items, ", ") . "]"
        endif
    endif
    " If we haven't returned a special representation by here, return the
    " default representation.
    return foldtext()
endfunction

autocmd FileType jjb_yaml setlocal foldmethod=indent foldnestmax=2 foldtext=JJBYamlFoldText() syntax=yaml
