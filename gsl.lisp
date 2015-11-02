(in-package :boot)
(import 'gsll:gsl-lookup)
(import (list 'gsll:nanp 'gsll:finitep 'gsl:double-float-unequal))
;(import 'gsll:integration-qng)
;(import 'gsl:lu-decomposition)
; more ...

(defun |lambdaFuncallSpad| (f)
 (lambda (x) (funcall f x nil)))
 
(defun |mkLispFunction1| (f)
 (lambda (x) (spadcall x f)))
(defun |mkLispFunction2| (f)
 (lambda (x y) (spadcall x y f)))
(defun |mkLispFunction3| (f)
 (lambda (x y z) (spadcall x y z f)))
 
(defun |lispFromSpad| (f dom args)
 (let ((spadf (|getFunctionFromDomain| f (list dom) args)))
   (lambda (x) (spadcall x spadf))))

; need to avoid conflict with BOOT:INFINITYP
(defun GSLIsInf (a) (gsl:infinityp a))

;   The first parameter of each routine below, is a function 'per' written
; in Spad which must convert the internal representation of returned
; values to an appropriate external representation. The purpose of 'per'
; is to minimize the number of assumptions in the Lisp code concerning the
; representation of values.
;   The internal representation is that obtained directly from GSLL and
; modified if necessary to be either atomic and compatible with Spad or a
; List of such returned values. When the output of GSL is multivalued the
; output of 'per' is usually of type Record.
;   The rest of the parameters must be either atomic and compatible with Spad
; or a List of such input values. The input values are modified if necessary
; to be compatible with GSLL.

(defun gslintegrationqng (per f a b)
  (apply (|mkLispFunction3| per) (multiple-value-list (gsl:integration-qng (|mkLispFunction1| f) a b))))

(defvar intrules (list ':gauss15 ':gauss21 ':gauss31 ':gauss41 ':gauss51 ':gauss61))

(defun gslintegrationqag (per f a b n)
  (apply (|mkLispFunction2| per)
    (multiple-value-list (gsl:integration-qag (|mkLispFunction1| f) a b (nth (- n 1) intrules)))
  )
)

(defun gslludecomp (per m nrows ncols)
  (let*
    (
      (A
        (grid:make-foreign-array 'double-float :dimensions (list nrows ncols) :initial-contents
          (loop for row below nrows collecting
            (loop for col below ncols collecting (elt (elt m row) col))
          )
        )
      )
    )
    (multiple-value-bind (A P S) (gsl:lu-decomposition A)
      (funcall (|mkLispFunction3| per)
        (loop for row below nrows collecting
          (loop for col below ncols collecting (grid:aref A row col))
        )
        (loop for row below nrows collecting
          (grid:aref
            (gsl:permute P
              (grid:make-foreign-array '(unsigned-byte 64) :initial-contents
                (loop for row below nrows collecting (+ 1 row))
              )
            )
            row
          )
        )
        S
      )
    )
  )
)

