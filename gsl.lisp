(in-package :boot)
(import 'gsll:gsl-lookup)
(import (list 'gsll:nanp 'gsll:finitep 'gsl:double-float-unequal))
(import 'gsll:integration-qng)
;(import 'gsl:lu-decomposition)
; more ...

(defun |lambdaFuncallSpad| (f)
 (lambda (x) (funcall f x nil)))
 
(defun |mkLispFunction1| (f)
 (lambda (x) (spadcall x f)))
 
(defun |lispFromSpad| (f dom args)
 (let ((spadf (|getFunctionFromDomain| f (list dom) args)))
   (lambda (x) (spadcall x spadf))))

; need to avoid conflict with BOOT:INFINITYP
(defun IsInf (a) (gsl:infinityp a))

; Return multiple values as a vector (can be interpreted as Axiom Record if number of values > 2)
(defun integration-qng-vector (f a b)
  (apply #'vector (multiple-value-list (integration-qng f a b))))

(defun lu-decomp (m r c)
  (let*
    (
      (matrix
        (grid:make-foreign-array 'double-float :dimensions (list r c) :initial-contents
          (loop for row below r collecting
            (loop for col below c collecting
              (elt (elt m row) col)
            )
          )
        )
      )
    )
    (multiple-value-bind (matrix perm) (gsl:lu-decomposition matrix)
      (list
        (loop for row below r collecting
          (loop for col below c collecting
            (grid:aref matrix row col)
          )
        )
        (loop for row below r collecting
          (grid:aref
            (gsl:permute perm
              (grid:make-foreign-array '(unsigned-byte 64) :initial-contents
                (loop for row below r collecting (+ 1 row))
              )
            )
            row
          )
        )
      )
    )
  )
)
