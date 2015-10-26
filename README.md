### GNU Scientific Library for Axiom (and FriCAS and OpenAxiom) ###

    )abbrev package GSL gsl
    GNU Scientific Library for Axiom (and FriCAS and OpenAxiom)
    Date Created: October 25, 2015
    License: BSD  (GSL is distributed under the GPL)
    Date Last Updated: October 26, 2015
    Basic Operations: integration
    Related Domains:
    Also See:
    AMS Classifications:
    Keywords: GNU; GSL; numeric; integration
    Examples: gslIntegrationQng(f,0.0::DF,1.0::DF).result
    References:
       https://common-lisp.net/project/gsll/
       http://www.gnu.org/software/gsl/
       http://www.gnu.org/software/gsl/manual/gsl-ref.html
    Description:
      Provides an interface to the routines of the GNU Scientific Library.
      http://www.gnu.org/software/gsl/manual/
    Author(s):
      Kurt Pagani, Alasdair McAndrew, Bill Page

### Compile and Test ###

    $ git clone https://github.com/billpage/gsla.git
    $ cd ~/gsla
    $ fricas
    (1) -> )r gsl-test

Output

<pre>
1) -> )co gsl
 
   Compiling FriCAS source code from file /home/wspage/gsla/gsl.spad 
      using old system compiler.
Value = T
To load "gsll":
  Load 1 ASDF system:
    gsll
; Loading "gsll"

Value = ("gsll")
Value = T

   GSL abbreviates package gsl 
------------------------------------------------------------------------
   initializing NRLIB GSL for gsl 
   compiling into NRLIB GSL 
   compiling exported gslLookup : String -> Symbol

;;;     ***       |GSL;gslLookup;SS;1| REDEFINED
Time: 0 SEC.

   compiling exported gslIntegrationQng : (DoubleFloat -> DoubleFloat,DoubleFloat,DoubleFloat) -> Record(result: DoubleFloat,abserr: DoubleFloat,neval: Integer)

;;;     ***       |GSL;gslIntegrationQng;M2DfR;2| REDEFINED
Time: 0.00 SEC.

(time taken in buildFunctor:  0)

;;;     ***       |gsl| REDEFINED

;;;     ***       |gsl| REDEFINED
Time: 0 SEC.


   Cumulative Statistics for Constructor gsl
      Time: 0.00 seconds
 
   finalizing NRLIB GSL 
   Processing gsl for Browser database:
--------constructor---------
--->/home/wspage/gsla/gsl.spad-->gsl((gslLookup ((Symbol) (String)))): Not documented!!!!
--------(gslIntegrationQng ((Record (: result (DoubleFloat)) (: abserr (DoubleFloat)) (: neval (Integer))) (Mapping (DoubleFloat) (DoubleFloat)) (DoubleFloat) (DoubleFloat)))---------
; compiling file "/home/wspage/gsla/GSL.NRLIB/GSL.lsp" (written 26 OCT 2015 12:17:16 PM):

; /home/wspage/gsla/GSL.NRLIB/GSL.fasl written
; compilation finished in 0:00:00.006
------------------------------------------------------------------------
   gsl is now explicitly exposed in frame frame1 
   gsl will be automatically loaded when needed from 
      /home/wspage/gsla/GSL.NRLIB/GSL

(1) -> gslLookup("gsl_sf_elljac_e")
 
GSLL:JACOBIAN-ELLIPTIC-FUNCTIONS
  [symbol]

JACOBIAN-ELLIPTIC-FUNCTIONS names a compiled function:
  Lambda-list: (U M)
  Derived type: (FUNCTION (DOUBLE-FLOAT DOUBLE-FLOAT)
                 (VALUES DOUBLE-FLOAT DOUBLE-FLOAT DOUBLE-FLOAT
                         &OPTIONAL))
  Documentation:
    The Jacobian elliptic functions sn(u|m),
      cn(u|m), dn(u|m) computed by descending Landen transformations.
  Source file: /home/wspage/quicklisp/dists/quicklisp/software/gsll-master-b2f6ae1f-git/special-functions/elliptic-functions.lisp

   (1)  JACOBIAN-ELLIPTIC-FUNCTIONS
                                                                 Type: Symbol
(2) -> gslLookup("gsl_integration_qng")
 
GSLL:INTEGRATION-QNG
  [symbol]

INTEGRATION-QNG names a compiled function:
  Lambda-list: (FUNCTION A B &OPTIONAL
                (ABSOLUTE-ERROR *DEFAULT-ABSOLUTE-ERROR*)
                (RELATIVE-ERROR *DEFAULT-RELATIVE-ERROR*))
  Derived type: (FUNCTION
                 (T DOUBLE-FLOAT DOUBLE-FLOAT &OPTIONAL DOUBLE-FLOAT
                  DOUBLE-FLOAT)
                 (VALUES DOUBLE-FLOAT DOUBLE-FLOAT (UNSIGNED-BYTE 64)
                         &OPTIONAL))
  Documentation:
    Apply the Gauss-Kronrod 10-point, 21-point, 43-point and
       87-point integration rules in succession until an estimate of the
       integral of f over (a,b) is achieved within the desired
       absolute and relative error limits, absolute-error and relative-error.  The
       function returns the final approximation, an estimate of
       the absolute error, and the number of function evaluations
       used.  The Gauss-Kronrod rules are designed in such a way
       that each rule uses all the results of its predecessors, in order to
       minimize the total number of function evaluations.
  Source file: /home/wspage/quicklisp/dists/quicklisp/software/gsll-master-b2f6ae1f-git/calculus/numerical-integration.lisp

   (2)  INTEGRATION-QNG
                                                                 Type: Symbol
(3) -> DF ==> DoubleFloat
 
                                                                   Type: Void
(4) -> f:=(x:DF):DF+->exp(-x^2)

   (4)  theMap(*1;anonymousFunction;1;frame1;internal)
                                           Type: (DoubleFloat -> DoubleFloat)

(5) -> gslIntegrationQng(f,0.0::DF,1.0::DF)

   (5)  [result= 0.7468241328124271,abserr= 8.291413475940725e-15,neval= 21]
         Type: Record(result: DoubleFloat,abserr: DoubleFloat,neval: Integer)

(6) -> g(x:DF):DF == exp(-x^2)
 
   Function declaration g : DoubleFloat -> DoubleFloat has been added 
      to workspace.
                                                                   Type: Void
(7) -> gslIntegrationQng(g,0.0::DF,1.0::DF).result
 
   Compiling function g with type DoubleFloat -> DoubleFloat 

   (7)  0.7468241328124271
                                                            Type: DoubleFloat
</pre>

