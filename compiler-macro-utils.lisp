;;;;
;;;; Common Lisp compiler macro utilities
;;;;

(defpackage :compiler-macro-utils
  (:documentation "Utilities for working with and writing compiler macros.")
  (:use #:cl)
  (:export

   #:compiler-macro-expand-1
   #:compiler-macro-expand
   #:compiler-macro-p

   ))

(in-package :compiler-macro-utils)


;;;
;;; Expansion
;;;

(defun compiler-macro-expand-1 (form &optional env)
  (if (atom form)
      (values form nil)
      (let ((cm-fun (compiler-macro-function
                     (let ((first (first form)))
                       (case first
                         (funcall (cadadr form)) ;; (funcall #'name . args)
                         (otherwise first))))))  ;; (name . args)
        (if (null cm-fun)
            (values form nil)
            (let ((expanded-form (funcall cm-fun form env)))
              (values expanded-form (not (equalp form expanded-form)))) )) ))

(defun compiler-macro-expand (form &optional env)
  (labels ((cm-expand (form env)
             (multiple-value-bind (exp exp-p) (compiler-macro-expand-1 form env)
               (if (not exp-p)
                   exp
                   (cm-expand exp env)))))
    (multiple-value-bind (exp expanded-p) (compiler-macro-expand-1 form env)
      (if (not expanded-p)
          (values exp nil)
          (values (cm-expand exp env) t)))))


;;;
;;; Misc
;;;

(defun compiler-macro-p (name)
  (functionp (compiler-macro-function name)))
