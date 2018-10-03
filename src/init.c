#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .C calls */
extern void gsC(void *, void *, void *, void *, void *, void *, void *);
extern void splinebasis(void *, void *, void *, void *, void *, void *);

/* .Call calls */
extern SEXP DECODE(SEXP, SEXP);
extern SEXP ENCODE(SEXP, SEXP);

/* .Fortran calls */
extern void F77_NAME(amalgm)(void *, void *, void *, void *, void *, void *, void *, void *);

static const R_CMethodDef CEntries[] = {
    {"gsC",         (DL_FUNC) &gsC,         7},
    {"splinebasis", (DL_FUNC) &splinebasis, 6},
    {NULL, NULL, 0}
};

static const R_CallMethodDef CallEntries[] = {
    {"DECODE", (DL_FUNC) &DECODE, 2},
    {"ENCODE", (DL_FUNC) &ENCODE, 2},
    {NULL, NULL, 0}
};

static const R_FortranMethodDef FortranEntries[] = {
    {"amalgm", (DL_FUNC) &F77_NAME(amalgm), 8},
    {NULL, NULL, 0}
};

void R_init_Gifi(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, CallEntries, FortranEntries, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
