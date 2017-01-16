exe "doau filetypedetect BufRead " . expand("<afile>:r")
let s:last_syntax = ''
if exists("b:current_syntax")
  let s:last_syntax = b:current_syntax
  unlet b:current_syntax
endif
function! s:reset_hl(hl_name)
  let id = hlID(a:hl_name)
  if id != 0
    let id = synIDtrans(id)
    exe "syntax clear " . synIDattr(id,"name")
  endif
endfunction

" Reset all base hilight groups to revert to original perl hilighting
call s:reset_hl("podCmdText")
call s:reset_hl("podCommand")
call s:reset_hl("podOverIndent")
call s:reset_hl("podForKeywd")
call s:reset_hl("podFormat")
call s:reset_hl("podVerbatimLine")
call s:reset_hl("podSpecial")
call s:reset_hl("podEscape")
call s:reset_hl("podEscape2")
call s:reset_hl("podBoldItalic")
call s:reset_hl("podBoldOpen")
call s:reset_hl("podBoldAlternativeDelimOpen")
call s:reset_hl("podItalicBold")
call s:reset_hl("podItalicOpen")
call s:reset_hl("podItalicAlternativeDelimOpen")
call s:reset_hl("podNoSpaceOpen")
call s:reset_hl("podNoSpaceAlternativeDelimOpen")
call s:reset_hl("podIndexOpen")
call s:reset_hl("podIndexAlternativeDelimOpen")
call s:reset_hl("podBold")
call s:reset_hl("podBoldAlternativeDelim")
call s:reset_hl("podItalic")
call s:reset_hl("podItalicAlternativeDelim")
call s:reset_hl("perlTodo")
call s:reset_hl("perlConditional")
call s:reset_hl("perlElseIfError")
call s:reset_hl("perlRepeat")
call s:reset_hl("perlOperator")
call s:reset_hl("perlControl")
call s:reset_hl("perlFiledescStatementNocomma")
call s:reset_hl("perlFiledescStatementComma")
call s:reset_hl("perlStatementIndirObjWrap")
call s:reset_hl("perlLabel")
call s:reset_hl("perlVarMember")
call s:reset_hl("perlVarBlock")
call s:reset_hl("perlVarBlock2")
call s:reset_hl("perlFloat")
call s:reset_hl("perlNumber")
call s:reset_hl("perlString")
call s:reset_hl("perlPackageConst")
call s:reset_hl("perlNotEmptyLine")
call s:reset_hl("perlComment")
call s:reset_hl("perlAutoload")
call s:reset_hl("perlSubError")
call s:reset_hl("perlSubAttributes")
call s:reset_hl("perlSubPrototypeError")
call s:reset_hl("perlSubPrototype")
call s:reset_hl("perlSubName")
call s:reset_hl("perlFunction")
call s:reset_hl("perlSharpBang")
call s:reset_hl("perlFormat")
call s:reset_hl("perlPackageFold")
call s:reset_hl("perlSubFold")
call s:reset_hl("perlBlockFold")
call s:reset_hl("perlInclude")
call s:reset_hl("perlSpecial")
call s:reset_hl("perlCharacter")
call s:reset_hl("perlType")
call s:reset_hl("perlIdentifier")
call s:reset_hl("perlStatement")
call s:reset_hl("perlSync")
call s:reset_hl("perlSyncPOD")
call s:reset_hl("perlDelim")
call s:reset_hl("perlCode")
call s:reset_hl("perlBlock")
" These highlight groups are overriden by vim-colors-solarized,
" need to turn them off
exe "hi! link perlVarPlain perlIdentifier"
exe "hi! link perlHereDoc perlString"
exe "hi! link perlStatementFileDesc perlStatement"

let perl_fold = 1
let perl_fold_blocks = 1
syn include @Perl syntax/perl.vim
syn clear perlFunctionPRef perlFunctionName perlElseIfError perlNotEmptyLine
if !exists("perl_no_scope_in_variables")
  syn match  perlFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" contains=perlPackageRef nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
else
  syn match  perlFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
endif
syn match perlElseIfError	"\(else\s*\_[\s]*\)\@<=\s\+if" contained
syn clear perlBraces "perlBraces is a fold feature that interferes with our own syntax groups
syn region perlCode matchgroup=perlDelim start="^<s>" matchgroup=perlDelim end="^</s>" contains=@Perl containedin=ALL fold keepend
syn region perlCode matchgroup=perlDelim start="^<l/>" matchgroup=NONE end="$"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
syn region perlCode matchgroup=perlDelim start="<i>"  matchgroup=perlDelim end="</i>"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
syn region perlCode matchgroup=perlDelim start="<f>"  matchgroup=perlDelim end="</f>"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
syn region perlBlock start="^<l/>\([^{#}]\|\$#\)*\({\([^#]\|\$#\)*\)*{\([^{#}]\|\$#\)*\(#\|$\)" end="^<l/>\([^{#}]\|\$#\)*\(}\([^#]\|\$#\)*\)*}\([^{#}]\|\$#\)*\(#\|$\)" transparent containedin=ALL fold keepend extend

" default values for global variables
if !exists("g:template_guibg_dark")
  let g:template_guibg_dark = "#"."101010"
endif
if !exists("g:template_guibg_light")
  let g:template_guibg_light = "#"."F0F0F0"
endif
let g:template_guibg = (&background=="dark") ? g:template_guibg_dark : g:template_guibg_light
if !exists("g:template_guifg_dark")
  let g:template_guifg_dark = "#"."808080"
endif
if !exists("g:template_guifg_light")
  let g:template_guifg_light = "#"."606060"
endif
let g:template_guifg = (&background=="dark") ? g:template_guifg_dark : g:template_guifg_light
if !exists("g:template_guifg_offset")
  let g:template_guifg_offset = "#000000"
endif
if !exists("g:template_delim_guifg")
  let g:template_delim_guifg = (&background=="dark") ? "#"."505050" : "#"."B0B0B0"
endif
if !exists("g:template_ctermbg_dark")
  let g:template_ctermbg_dark = 7
endif
if !exists("g:template_ctermbg_light")
  let g:template_ctermbg_light = 7
endif
let g:template_ctermbg = (&background=="dark") ? g:template_ctermbg_dark : g:template_ctermbg_light
if !exists("g:template_ctermfg_dark")
  let g:template_ctermfg_dark = 0
endif
if !exists("g:template_ctermfg_light")
  let g:template_ctermfg_light = 0
endif
let g:template_ctermfg = (&background=="dark") ? g:template_ctermfg_dark : g:template_ctermfg_light
if !exists("g:template_ctermfg_offset")
  let g:template_ctermfg_offset = 0
endif
if !exists("g:template_delim_ctermfg")
  let g:template_delim_ctermfg = (&background=="dark") ? 0 : 15
endif
" derived components from global variables
let s:gfg_r_off = str2nr(strpart(g:template_guifg_offset,1,2),16)
let s:gfg_g_off = str2nr(strpart(g:template_guifg_offset,3,2),16)
let s:gfg_b_off = str2nr(strpart(g:template_guifg_offset,5,2),16)

function! s:update_hl(hl_name)
  let id = hlID(a:hl_name)
  let nid = hlID("Normal")
  if id == 0
    let id = nid
  endif
  let id = synIDtrans(id)
  let nid = synIDtrans(nid)

  let gbg=synIDattr(id, "bg#")
  let gbg= (gbg=="") ? g:template_guibg : gbg
  let gbg_r=str2nr(strpart(gbg,1,2),16)
  let gbg_g=str2nr(strpart(gbg,3,2),16)
  let gbg_b=str2nr(strpart(gbg,5,2),16)
  let gbg=printf("#%02x%02x%02x",gbg_r,gbg_g,gbg_b)

  let gfg=synIDattr(id, "fg#")
  let gfg= (gfg=="") ? g:template_guifg : gfg
  let gfg_r=(str2nr(strpart(gfg,1,2),16) + s:gfg_r_off) % 256
  let gfg_g=(str2nr(strpart(gfg,3,2),16) + s:gfg_g_off) % 256
  let gfg_b=(str2nr(strpart(gfg,5,2),16) + s:gfg_b_off) % 256
  let gfg=printf("#%02x%02x%02x",gfg_r,gfg_g,gfg_b)

  let bg=str2nr(synIDattr(id, "bg"))
  let bg= (bg==-1) ? g:template_ctermbg : bg

  let fg=str2nr(synIDattr(id, "fg"))
  let fg= (fg==-1) ? g:template_ctermfg : fg
  let fg=(fg + g:template_ctermfg_offset) % 16

  let attrlist = synIDattr(id, "bold")      ? ["bold"     ] : []
  let attrlist+= synIDattr(id, "italic")    ? ["italic"   ] : []
  let attrlist+= synIDattr(id, "reverse")   ? ["reverse"  ] : []
  let attrlist+= synIDattr(id, "inverse")   ? ["inverse"  ] : []
  let attrlist+= synIDattr(id, "standout")  ? ["standout" ] : []
  let attrlist+= synIDattr(id, "underline") ? ["underline"] : []
  let attrlist+= synIDattr(id, "undercurl") ? ["undercurl"] : []
  let attrs=join(attrlist,',')
  if attrs == ""
    let attrs = "NONE"
  endif
  let hl=printf("highlight %s term=%s ctermbg=%d ctermfg=%d gui=%s guibg=%s guifg=%s",a:hl_name,attrs,bg,fg,attrs,gbg,gfg)
  execute hl
endfunction

" New highlight groups
call s:update_hl("perlCode")
call s:update_hl("perlDelim")
let s:hl=printf("highlight perlDelim term=bold cterm=bold ctermfg=%d gui=bold guifg=%s",g:template_delim_ctermfg,g:template_delim_guifg)
execute s:hl
" Parent Perl highlight groups
call s:update_hl("podCmdText")
call s:update_hl("podCommand")
call s:update_hl("podOverIndent")
call s:update_hl("podForKeywd")
call s:update_hl("podFormat")
call s:update_hl("podVerbatimLine")
call s:update_hl("podSpecial")
call s:update_hl("podEscape")
call s:update_hl("podEscape2")
call s:update_hl("podBoldItalic")
call s:update_hl("podBoldOpen")
call s:update_hl("podBoldAlternativeDelimOpen")
call s:update_hl("podItalicBold")
call s:update_hl("podItalicOpen")
call s:update_hl("podItalicAlternativeDelimOpen")
call s:update_hl("podNoSpaceOpen")
call s:update_hl("podNoSpaceAlternativeDelimOpen")
call s:update_hl("podIndexOpen")
call s:update_hl("podIndexAlternativeDelimOpen")
call s:update_hl("podBold")
call s:update_hl("podBoldAlternativeDelim")
call s:update_hl("podItalic")
call s:update_hl("podItalicAlternativeDelim")
call s:update_hl("perlTodo")
call s:update_hl("perlConditional")
call s:update_hl("perlElseIfError")
call s:update_hl("perlRepeat")
call s:update_hl("perlOperator")
call s:update_hl("perlControl")
call s:update_hl("perlFiledescStatementNocomma")
call s:update_hl("perlFiledescStatementComma")
call s:update_hl("perlStatementIndirObjWrap")
call s:update_hl("perlLabel")
call s:update_hl("perlVarMember")
call s:update_hl("perlVarBlock")
call s:update_hl("perlVarBlock2")
call s:update_hl("perlFloat")
call s:update_hl("perlNumber")
call s:update_hl("perlString")
call s:update_hl("perlPackageConst")
call s:update_hl("perlNotEmptyLine")
call s:update_hl("perlComment")
call s:update_hl("perlAutoload")
call s:update_hl("perlSubError")
call s:update_hl("perlSubAttributes")
call s:update_hl("perlSubPrototypeError")
call s:update_hl("perlSubPrototype")
call s:update_hl("perlSubName")
call s:update_hl("perlFunction")
call s:update_hl("perlSharpBang")
call s:update_hl("perlFormat")
call s:update_hl("perlPackageFold")
call s:update_hl("perlSubFold")
call s:update_hl("perlBlockFold")
call s:update_hl("perlInclude")
call s:update_hl("perlSpecial")
call s:update_hl("perlCharacter")
call s:update_hl("perlType")
call s:update_hl("perlIdentifier")
call s:update_hl("perlStatement")
call s:update_hl("perlSync")
call s:update_hl("perlSyncPOD")
call s:update_hl("perlDelim")
call s:update_hl("perlCode")
call s:update_hl("perlBlock")

let b:current_syntax=s:last_syntax
unlet s:last_syntax
unlet s:hl

nnoremap <F2> :exe "set conceallevel=" . (&conceallevel==0?2:0)<CR>
