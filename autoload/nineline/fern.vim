vim9script

const FERN_PATTERN = '^fern://\(.\+\)/file://\(.\+\)\$'

def GetName(mode: string): string
    return stridx(mode, 'drawer') > -1 ? 'Drawer' : 'Fern'
enddef

def GetFolder(path: string): string
    var folder = substitute(path, ';\?\(#.\+\)\?\$\?$', '', '')
    return fnamemodify(folder, ':p:~:.:h')
enddef

export def Status(): string
    var data = matchlist(expand('%'), FERN_PATTERN)
    
    if empty(data)
        return '[Fern]'
    endif
    
    var name = GetName(get(data, 1, ''))
    var folder = GetFolder(get(data, 2, ''))
    
    return $'[{name}] {folder}'
enddef
