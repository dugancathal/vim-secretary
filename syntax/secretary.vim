" Vim syntax file for Vim Secretary
" Language: Secretary
" Maintainer: TJ Taylor (@dugancathal)
" Latest Revision: 8 July 2013

if exists("b:current_syntax")
  finish
endif

" Comments
syn match secretaryComment "#.*$"

" DateTime strings - Anything that's not a comment
syn match secretaryDateTime /^[^#]\+\s\+\[/me=e-2

" Metadata - Name[:Tag[:Tag...]]
syn region secretaryMetadata start='\[' end='\]' contains=secretaryProjectName,secretaryProjectTag
syn match secretaryProjectName /\[[^:\]]*/ms=s+1
syn match secretaryProjectTag  /:[^:\]]*/ms=s+1 contained

" Notes
syn match secretaryProjectEntryNotes /- .*$/ms=s+2

" Highlight definitions
hi def link secretaryComment      Comment
hi def link secretaryDateTime     Type
hi def link secretaryProjectName  Label
hi def link secretaryProjectTag   Identifier
hi def link secretaryProjectEntryNotes  String

let b:current_syntax = "ruby"
