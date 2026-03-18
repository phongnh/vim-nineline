vim9script

const VISUAL_MODE_INDICATORS = {v: ' [C]', V: '', '': ' [B]'}

def GetName(): string
    if exists('b:nrrw_instn')
        return 'NrrwRgn#' .. b:nrrw_instn
    endif
    
    var bufname = bufname('%')
    var name = substitute(bufname, '^NrrwRgn_\zs.*\ze_\d\+$', submatch(0), '')
    return substitute(name, '__', '#', '')
enddef

def GetVisualIndicator(visual_mode: any): string
    return get(VISUAL_MODE_INDICATORS, visual_mode ?? 'V', '')
enddef

export def Status(): string
    var name = GetName()
    var buffer = ''
    
    if exists('*nrrwrgn#NrrwRgnStatus')
        var status = nrrwrgn#NrrwRgnStatus()
        
        if !empty(status)
            var prefix = status.multi ? 'Multi' : ''
            var indicator = GetVisualIndicator(get(status, 'visual', null))
            name = prefix .. name .. indicator
            
            buffer = fnamemodify(status.fullname, ':~:.')
            if !status.multi
                buffer ..= $' [{status.start[1]}-{status.end[1]}]'
            endif
        endif
    endif
    
    if empty(buffer) && get(b:, 'orig_buf', 0)
        buffer = bufname(b:orig_buf)
    endif
    
    return empty(buffer) ? $'[{name}]' : $'[{name}] {buffer}'
enddef
