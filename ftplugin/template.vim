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
call s:reset_hl("perlSharpBang")
call s:reset_hl("perlControl")
call s:reset_hl("perlInclude")
call s:reset_hl("perlSpecial")
call s:reset_hl("perlString")
call s:reset_hl("perlCharacter")
call s:reset_hl("perlNumber")
call s:reset_hl("perlFloat")
call s:reset_hl("perlType")
call s:reset_hl("perlIdentifier")
call s:reset_hl("perlLabel")
call s:reset_hl("perlStatement")
call s:reset_hl("perlConditional")
call s:reset_hl("perlRepeat")
call s:reset_hl("perlOperator")
call s:reset_hl("perlFunction")
call s:reset_hl("perlSubName")
call s:reset_hl("perlSubPrototype")
call s:reset_hl("perlSubAttributes")
call s:reset_hl("perlSubAttributesCont")
call s:reset_hl("perlComment")
call s:reset_hl("perlTodo")
if exists("perl_string_as_statement")
  call s:reset_hl("perlStringStartEnd")
else
  call s:reset_hl("perlStringStartEnd")
endif
call s:reset_hl("perlVStringV")
call s:reset_hl("perlList")
call s:reset_hl("perlMisc")
call s:reset_hl("perlVarPlain")
call s:reset_hl("perlVarPlain2")
call s:reset_hl("perlArrow")
call s:reset_hl("perlFiledescRead")
call s:reset_hl("perlFiledescStatement")
call s:reset_hl("perlVarSimpleMember")
call s:reset_hl("perlVarSimpleMemberName")
call s:reset_hl("perlVarNotInMatches")
call s:reset_hl("perlVarSlash")
call s:reset_hl("perlQQ")
call s:reset_hl("perlHereDoc")
call s:reset_hl("perlStringUnexpanded")
call s:reset_hl("perlSubstitutionSQ")
call s:reset_hl("perlSubstitutionGQQ")
call s:reset_hl("perlTranslationGQ")
call s:reset_hl("perlMatch")
call s:reset_hl("perlMatchStartEnd")
call s:reset_hl("perlFormatName")
call s:reset_hl("perlFormatField")
call s:reset_hl("perlPackageDecl")
call s:reset_hl("perlStorageClass")
call s:reset_hl("perlPackageRef")
call s:reset_hl("perlStatementPackage")
call s:reset_hl("perlStatementStorage")
call s:reset_hl("perlStatementControl")
call s:reset_hl("perlStatementScalar")
call s:reset_hl("perlStatementRegexp")
call s:reset_hl("perlStatementNumeric")
call s:reset_hl("perlStatementList")
call s:reset_hl("perlStatementHash")
call s:reset_hl("perlStatementIOfunc")
call s:reset_hl("perlStatementFiledesc")
call s:reset_hl("perlStatementVector")
call s:reset_hl("perlStatementFiles")
call s:reset_hl("perlStatementFlow")
call s:reset_hl("perlStatementInclude")
call s:reset_hl("perlStatementProc")
call s:reset_hl("perlStatementSocket")
call s:reset_hl("perlStatementIPC")
call s:reset_hl("perlStatementNetwork")
call s:reset_hl("perlStatementPword")
call s:reset_hl("perlStatementTime")
call s:reset_hl("perlStatementMisc")
call s:reset_hl("perlStatementIndirObj")
call s:reset_hl("perlFunctionName")
call s:reset_hl("perlMethod")
call s:reset_hl("perlFunctionPRef")
call s:reset_hl("perlPOD")
call s:reset_hl("perlShellCommand")
call s:reset_hl("perlSpecialAscii")
call s:reset_hl("perlSpecialDollar")
call s:reset_hl("perlSpecialString")
call s:reset_hl("perlSpecialStringU")
call s:reset_hl("perlSpecialMatch")
call s:reset_hl("perlDATA")

" NOTE: Due to a bug in Vim (or more likely, a misunderstanding on my part),
"       I had to remove the transparent property from the following regions
"       in order to get them to highlight correctly.  Feel free to remove
"       these and reinstate the transparent property if you know how.
"call s:reset_hl("perlParensSQ")
"call s:reset_hl("perlBracketsSQ")
"call s:reset_hl("perlBracesSQ")
"call s:reset_hl("perlAnglesSQ")
"
"call s:reset_hl("perlParensDQ")
"call s:reset_hl("perlBracketsDQ")
"call s:reset_hl("perlBracesDQ")
"call s:reset_hl("perlAnglesDQ")

call s:reset_hl("perlSpecialStringU2")

" Possible errors
call s:reset_hl("perlNotEmptyLine")
call s:reset_hl("perlElseIfError")
call s:reset_hl("perlSubPrototypeError")
call s:reset_hl("perlSubError")

let perl_fold = 1
let perl_fold_blocks = 1
syn include @Perl syntax/perl.vim
" Fix a few syntax elements incompatible with our colors
syn clear perlFunctionPRef perlFunctionName perlElseIfError perlNotEmptyLine
if !exists("perl_no_scope_in_variables")
  syn match  perlFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" contains=perlPackageRef nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
else
  syn match  perlFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
endif
syn match perlElseIfError	"\(else\s*\_[\s]*\)\@<=\s\+if" contained
syn region perlStatementIndirObjWrap   matchgroup=perlStatementIndirObj start="\<\%(map\|grep\|sort\|printf\=\|say\|system\|exec\)\>\s*{" end="}" contains=@perlTop,perlBraces extend transparent "transparent attribute not used in original syntax
syn clear perlBraces "perlBraces is a fold feature that interferes with our own syntax groups
" These highlight groups are overriden by vim-colors-solarized,
" need to turn them off
exe "hi! link perlVarPlain perlIdentifier"
exe "hi! link perlHereDoc perlString"
exe "hi! link perlStatementFileDesc perlStatement"


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
  let g:template_ctermbg_dark = 0
endif
if !exists("g:template_ctermbg_light")
  let g:template_ctermbg_light = 7
endif
let g:template_ctermbg = (&background=="dark") ? g:template_ctermbg_dark : g:template_ctermbg_light
if !exists("g:template_ctermfg_dark")
  let g:template_ctermfg_dark = 12
endif
if !exists("g:template_ctermfg_light")
  let g:template_ctermfg_light = 11
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
  if id == 0
    let id = hlID("Normal")
  endif
  let id = synIDtrans(id)

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
execute "highlight perlCode ctermfg=fg ctermbg=NONE"
call s:update_hl("perlCode")
let s:hl=printf("highlight perlDelim term=bold cterm=bold ctermfg=%d gui=bold guifg=%s",g:template_delim_ctermfg,g:template_delim_guifg)
execute s:hl
call s:update_hl("perlDelim")

" Parent Perl highlight groups
call s:update_hl("perlSharpBang")
call s:update_hl("perlControl")
call s:update_hl("perlInclude")
call s:update_hl("perlSpecial")
call s:update_hl("perlString")
call s:update_hl("perlCharacter")
call s:update_hl("perlNumber")
call s:update_hl("perlFloat")
call s:update_hl("perlType")
call s:update_hl("perlIdentifier")
call s:update_hl("perlLabel")
call s:update_hl("perlStatement")
call s:update_hl("perlConditional")
call s:update_hl("perlRepeat")
call s:update_hl("perlOperator")
call s:update_hl("perlFunction")
call s:update_hl("perlSubName")
call s:update_hl("perlSubPrototype")
call s:update_hl("perlSubAttributes")
call s:update_hl("perlSubAttributesCont")
call s:update_hl("perlComment")
call s:update_hl("perlTodo")
if exists("perl_string_as_statement")
  call s:update_hl("perlStringStartEnd")
else
  call s:update_hl("perlStringStartEnd")
endif
call s:update_hl("perlVStringV")
call s:update_hl("perlList")
call s:update_hl("perlMisc")
call s:update_hl("perlVarPlain")
call s:update_hl("perlVarPlain2")
call s:update_hl("perlArrow")
call s:update_hl("perlFiledescRead")
call s:update_hl("perlFiledescStatement")
call s:update_hl("perlVarSimpleMember")
call s:update_hl("perlVarSimpleMemberName")
call s:update_hl("perlVarNotInMatches")
call s:update_hl("perlVarSlash")
call s:update_hl("perlQQ")
call s:update_hl("perlHereDoc")
call s:update_hl("perlStringUnexpanded")
call s:update_hl("perlSubstitutionSQ")
call s:update_hl("perlSubstitutionGQQ")
call s:update_hl("perlTranslationGQ")
call s:update_hl("perlMatch")
call s:update_hl("perlMatchStartEnd")
call s:update_hl("perlFormatName")
call s:update_hl("perlFormatField")
call s:update_hl("perlPackageDecl")
call s:update_hl("perlStorageClass")
call s:update_hl("perlPackageRef")
call s:update_hl("perlStatementPackage")
call s:update_hl("perlStatementStorage")
call s:update_hl("perlStatementControl")
call s:update_hl("perlStatementScalar")
call s:update_hl("perlStatementRegexp")
call s:update_hl("perlStatementNumeric")
call s:update_hl("perlStatementList")
call s:update_hl("perlStatementHash")
call s:update_hl("perlStatementIOfunc")
call s:update_hl("perlStatementFiledesc")
call s:update_hl("perlStatementVector")
call s:update_hl("perlStatementFiles")
call s:update_hl("perlStatementFlow")
call s:update_hl("perlStatementInclude")
call s:update_hl("perlStatementProc")
call s:update_hl("perlStatementSocket")
call s:update_hl("perlStatementIPC")
call s:update_hl("perlStatementNetwork")
call s:update_hl("perlStatementPword")
call s:update_hl("perlStatementTime")
call s:update_hl("perlStatementMisc")
call s:update_hl("perlStatementIndirObj")
call s:update_hl("perlFunctionName")
call s:update_hl("perlMethod")
call s:update_hl("perlFunctionPRef")
call s:update_hl("perlPOD")
call s:update_hl("perlShellCommand")
call s:update_hl("perlSpecialAscii")
call s:update_hl("perlSpecialDollar")
call s:update_hl("perlSpecialString")
call s:update_hl("perlSpecialStringU")
call s:update_hl("perlSpecialMatch")
call s:update_hl("perlDATA")

" NOTE: Due to a bug in Vim (or more likely, a misunderstanding on my part),
"       I had to remove the transparent property from the following regions
"       in order to get them to highlight correctly.  Feel free to remove
"       these and reinstate the transparent property if you know how.
"call s:update_hl("perlParensSQ")
"call s:update_hl("perlBracketsSQ")
"call s:update_hl("perlBracesSQ")
"call s:update_hl("perlAnglesSQ")
"
"call s:update_hl("perlParensDQ")
"call s:update_hl("perlBracketsDQ")
"call s:update_hl("perlBracesDQ")
"call s:update_hl("perlAnglesDQ")

call s:update_hl("perlSpecialStringU2")

" Possible errors
call s:update_hl("perlNotEmptyLine")
call s:update_hl("perlElseIfError")
call s:update_hl("perlSubPrototypeError")
call s:update_hl("perlSubError")

let b:current_syntax=s:last_syntax
unlet s:last_syntax
unlet s:hl

nnoremap <F2> :exe "set conceallevel=" . (&conceallevel==0?2:0)<CR>
