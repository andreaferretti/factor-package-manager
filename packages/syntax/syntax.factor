! Copyright (C) 2014 Andrea Ferretti.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors kernel lexer namespaces packages.projects
  parser sequences ;
IN: packages.syntax

<PRIVATE

: new-project ( name -- project ) local-project new swap >>name ;

: add-dependency ( project dep -- project ) [ suffix ] curry change-deps ;

: add-vocab ( project vocab -- project ) [ suffix ] curry change-vocabs ;

: add-vocabs ( project vocabs -- project ) [ append ] curry change-vocabs ;

PRIVATE>

SYNTAX: PROJECT: scan-token new-project current-project set-global ;

SYNTAX: VERSION: scan-token current-project get version<< ;

SYNTAX: SCM: scan-word current-project get scm<< ;

SYNTAX: URL: scan-token current-project get url<< ;

SYNTAX: VOCAB: current-project get scan-token add-vocab drop ;

SYNTAX: VOCABS: current-project get ";" parse-tokens add-vocabs drop ;

SYNTAX: GIT-DEP: current-project get ";" parse-tokens first3 <git> add-dependency drop ;

SYNTAX: HG-DEP: current-project get ";" parse-tokens first3 <hg> add-dependency drop ;

SYNTAX: GITHUB-DEP: current-project get ";" parse-tokens first4 <github> add-dependency drop ;
