#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* doref is defined both in perl.h and nauty/nausparse.h.
   Undefining it is a quick-and-dirty fix, as something
   might be broken... */
#undef doref
#include <nauty/nausparse.h>

#include "const-c.inc"

MODULE = Nausparse		PACKAGE = Nausparse		

INCLUDE: const-xs.inc
