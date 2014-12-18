! Copyright (C) 2014 Andrea Ferretti.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors combinators kernel namespaces packages.fs
    packages.projects packages.publish packages.scm parser
    sequences strings vocabs vocabs.loader words.symbol ;
IN: packages

<PRIVATE

DEFER: activate-file

: setup-deps ( project -- ) deps>> [ setup ] each ;

: setup-roots ( project -- ) deps>> set-vocab-roots ;

: setup-requirements ( project -- ) vocabs>> [ require ] each ;

: setup-recursive ( project -- )
  deps>> [ name>> project-file activate-file ] each ;

: setup-all ( project -- )
    {
        [ setup-deps ]
        [ setup-roots ]
        [ setup-recursive ]
        [ setup-requirements ]
    } cleave ;

: activate-file ( path -- )
    run-file current-project get setup-all ;

: publish-file ( path -- )
    dup run-file publish-current ;

PRIVATE>

: activate ( vocab -- ) vocab-source-path activate-file ;

: publish ( vocab -- ) vocab-source-path publish-file ;