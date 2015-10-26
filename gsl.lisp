(in-package :boot)
(import 'gsll:gsl-lookup)
(import 'gsll:integration-qng)
; more ...



(defun |lambdaFuncallSpad| (f)
 (lambda (x) (funcall f x nil)))
 
(defun |mkLispFunction1| (f)
 (lambda (x) (spadcall x f)))
 
(defun |lispFromSpad| (f dom args)
 (let ((spadf (|getFunctionFromDomain| f (list dom) args)))
   (lambda (x) (spadcall x spadf))))
   
(defun integration-qng-list (f a b)
  (multiple-value-list (integration-qng f a b)))
