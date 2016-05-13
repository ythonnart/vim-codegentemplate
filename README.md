vim-vlsi : useful scripts for VLSI design
=========================================

Vim-vlsi template files are files of any type which contain embedded perl code
for generation of more complex files. XML-like annotations indicate the
sections of Perl code in the original file format.

This plugin allows to embed Perl highlighting in the Perl sections,
and provides a fold mechanism based on Perl opening and closing braces
transparently across Perl sections.

## Markers
`<s>`		On a single line, opens a Perl section

`</s>`		On a single line, closes a Perl section

`<l/>`		At beginning of line to interpret line as Perl code

`<i>`...`</i>`	Inside a line, to evaluate and print a Perl expression

`<f>`...`</f>`	Inside a line, to evaluate and format a Perl expression
		input as Perl printf arguments

## Authors:
* Jean-Frédéric Christmann
* Yvain Thonnart

## Copyright & Licencse:
(c) 2009 - 2016 by the authors

The VIM LICENSE applies to vim-vlsi
(see vim copyright) except use vim-vlsi instead of "Vim".

NO WARRANTY, EXPRESS OR IMPLIED.  USE AT-YOUR-OWN-RISK.
