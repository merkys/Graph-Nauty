#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* doref is defined both in perl.h and nauty/nausparse.h.
   Undefining it is a quick-and-dirty fix, as something
   might be broken... */
#undef doref
#include <nauty/nausparse.h>

MODULE = Nausparse		PACKAGE = Nausparse

SV *
sparsenauty(sg, lab, ptn, orbits, options, sg2)
        sparsegraph &sg
        int * lab
        int * ptn
        int * orbits
        optionblk &options
        statsblk &stats = NO_INIT
        sparsegraph &sg2
    CODE:
        sparsenauty(&sg, lab, ptn, orbits, &options, &stats, &sg2);
        HV *statsblk = newHV();
        hv_store( statsblk, "errstatus", 9, newSViv( stats.errstatus ), 0 );
        hv_store( statsblk, "grpsize1",  8, newSViv( stats.grpsize1 ), 0 );
        hv_store( statsblk, "grpsize2",  8, newSViv( stats.grpsize2 ), 0 );
        hv_store( statsblk, "numorbits", 9, newSViv( stats.numorbits ), 0 );
        RETVAL = newRV( (SV*)statsblk );
    OUTPUT:
        RETVAL
