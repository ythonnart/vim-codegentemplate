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
syn include @Perl syntax/perl.vim
syn clear perlFunctionPRef perlFunctionName perlElseIfError perlNotEmptyLine
if !exists("perl_no_scope_in_variables")
  syn match  perlFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" contains=perlPackageRef nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
else
  syn match  perlFunctionName                "&\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
endif
syn match perlElseIfError	"\(else\s*\_[\s]*\)\@<=\s\+if" contained

syn region perlCode matchgroup=perlDelim start="^<s>" matchgroup=perlDelim end="^</s>" contains=@Perl containedin=ALL fold keepend
syn region perlCode matchgroup=perlDelim start="^<l/>" matchgroup=perlDelim end="$"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
syn region perlCode matchgroup=perlDelim start="<i>"  matchgroup=perlDelim end="</i>"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
syn region perlCode matchgroup=perlDelim start="<f>"  matchgroup=perlDelim end="</f>"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
syn region perlBlock start="^<l/>[^}]*\({[^{}]*}[^{}]*\)*{[^{}]*$"rs=s+1 end="^<l/>[^{]*}\({[^{}]*}[^{}]*\)*$"re=e-1 transparent containedin=ALL fold keepend extend
" deprecated -- will be removed in a future release
"syn region perlCode matchgroup=perlDelim start="^§" matchgroup=perlDelim end="^§" contains=@Perl containedin=ALL fold keepend
"syn region perlCode matchgroup=perlDelim start="^£" matchgroup=perlDelim end="$"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
"syn region perlCode matchgroup=perlDelim start="`"  matchgroup=perlDelim end="`"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
"syn region perlCode matchgroup=perlDelim start="¤"  matchgroup=perlDelim end="¤"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
"syn region perlCode matchgroup=perlDelim start="°"  matchgroup=perlDelim end="°"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
"syn region perlBlock start="^£[^}]*\({[^{}]*}[^{}]*\)*{[^{}]*$"rs=s+1 end="^£[^{]*}\({[^{}]*}[^{}]*\)*$"re=e-1 transparent containedin=ALL fold keepend extend
"if s:last_syntax =~ "vhdl" || s:last_syntax =~ "verilog"
"  syn region perlCode matchgroup=perlDelim start="^#" matchgroup=perlDelim end="$"  concealends contains=@Perl containedin=ALLBUT,perlCode keepend
"  syn region perlBlock start="^#[^}]*\({[^{}]*}[^{}]*\)*{[^{}]*$"rs=s+1 end="^#[^{]*}\({[^{}]*}[^{}]*\)*$"re=e-1 transparent containedin=ALL fold keepend extend
"endif
" deprecated -- will be removed in a future release

" default values for global variables
if !exists("g:template_guibg")
  let g:template_guibg = (&background=="dark") ? "#"."101010" : "#"."F0F0F0"
endif
if !exists("g:template_guifg_offset")
  let g:template_guifg_offset = "#000000"
endif
if !exists("g:template_delim_guifg")
  let g:template_delim_guifg = (&background=="dark") ? "#"."505050" : "#"."B0B0B0"
endif
if !exists("g:template_delim_ctermfg")
  let g:template_delim_ctermfg = (&background=="dark") ? 1 : 14
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

  let gfg=synIDattr(id, "fg#")
  let gfg= (gfg=="") ? synIDattr(nid, "fg#") : gfg
  let gfg_r=(str2nr(strpart(gfg,1,2),16) + s:gfg_r_off) % 256
  let gfg_g=(str2nr(strpart(gfg,3,2),16) + s:gfg_g_off) % 256
  let gfg_b=(str2nr(strpart(gfg,5,2),16) + s:gfg_b_off) % 256
  let gfg=printf("#%02x%02x%02x",gfg_r,gfg_g,gfg_b)

  let bg=str2nr(synIDattr(id, "bg"))
  let bg= (bg==-1) ? str2nr(synIDattr(nid, "bg")) : bg
  let bg= (bg==-1 && &background=="dark"  ) ? 0  : bg
  let bg= (bg==-1 && &background=="light" ) ? 15 : bg
  let bg=(bg + 8) % 16

  let fg=synIDattr(id, "fg")
  let fg= (fg=="") ? synIDattr(nid, "fg") : fg
  let fg= (fg==-1 && &background=="dark"  ) ? 15 : fg
  let fg= (fg==-1 && &background=="light" ) ? 0  : fg
  let fg=(fg + 8) % 16

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

let b:current_syntax=s:last_syntax
unlet s:last_syntax
unlet s:hl

nnoremap <F2> :exe "set conceallevel=" . (&conceallevel==0?2:0)<CR>
