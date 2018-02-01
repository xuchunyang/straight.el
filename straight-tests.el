;;; straight-tests.el --- Tests for straight.el -*- lexical-binding: t; -*-

;;; Commentary:

;; 

;;; Code:

(require 'ert)
(require 'straight)

(ert-deftest straight--if-let ()
  ;; Expansion
  (should (equal
           (macroexpand
            '(straight--if-let (a 1)
                 (- a)
               "no"))
           '(let ((a 1))
              (if a
                  (- a)
                "no"))))
  ;; True
  (should (equal
           (straight--if-let (a 1)
               a
             "no")
           1))
  ;; False
  (should (equal
           (straight--if-let (a nil)
               (list a b c)
             "no")
           "no")))

(ert-deftest straight--when-let ()
  ;; Expansion
  (should (equal
           (macroexpand
            '(straight--when-let (a 1)
               (message "opposite")
               (- a)))
           '(let ((a 1))
              (if a
                  (progn
                    (message "opposite")
                    (- a))))))
  ;; True
  (should (equal
           (straight--when-let (a 1)
             a)
           1))
  ;; False
  (should (equal
           (straight--when-let (a nil)
             (list a b c)
             "no")
           nil)))

(provide 'straight-tests)
;;; straight-tests.el ends here
