#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <nauty/nausparse.h>

#include "const-c.inc"

MODULE = Nausparse		PACKAGE = Nausparse		

INCLUDE: const-xs.inc
