#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* doref is defined both in perl.h and nauty/nausparse.h.
   Undefining it is a quick-and-dirty fix, as something
   might be broken... */
#undef doref
#include <nauty/nausparse.h>

typedef struct optionblk   Options;
typedef struct sparsegraph Sparsegraph;
typedef struct statsblk    Stats;

MODULE = Nausparse		PACKAGE = Nausparse

void
sparsenauty(sg, lab, ptn, orbits, options, stats, sg2)
    Sparsegraph *sg
    int lab
    int ptn
    int orbits
    Options *options
    Stats *stats
    Sparsegraph *sg2

MODULE = Nausparse		PACKAGE = SparsegraphPtr
MODULE = Nausparse		PACKAGE = OptionsPtr
MODULE = Nausparse		PACKAGE = StatsPtr
