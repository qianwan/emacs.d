;;; package --- Summary

;;; Commentary:

;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))

(require-package 'elpy)
(elpy-enable)

(when *is-a-mac*
  (setq mac-option-modifier 'meta))

;;; shell
(defun clear-shell ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))
(add-hook 'comint-output-filter-functions
          'comint-truncate-buffer)

(require-package 'slime)
(setq slime-lisp-implementations
      '((ccl ("/usr/local/bin/ccl64"))
        (cmucl ("/usr/local/Cellar/cmucl/20e/bin/lisp"))))
(after-load 'slime
  (slime-setup '(slime-repl slime-fancy)))

(require-package 'exec-path-from-shell)
(after-load 'exec-path-from-shell
  (dolist (var '("JAVA_HOME"))
    (add-to-list 'exec-path-from-shell-variables var)))

;;(require-package 'pretty-lambdada)
;;(pretty-lambda-for-modes)

(require 'cltl2)

;;; ensime
(require-package 'ensime)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;; OPTIONAL
;; there are some great Scala yasnippets, browse through:
;; https://github.com/AndreaCrotti/yasnippet-snippets/tree/master/scala-mode
(add-hook 'scala-mode-hook #'yas-minor-mode)
;; but company-mode / yasnippet conflict. Disable TAB in company-mode with
(define-key company-active-map [tab] nil)

;;; global key bind
(global-set-key (kbd "C-x a w") 'delete-other-window)

;;; pig mode
(require-package 'pig-mode)
(require 'pig-mode)
(setq pig-indent-level 2)

;;; cider
(add-hook 'cider-repl-mode-hook #'eldoc-mode)

;;; line-number
(require-package 'linum)
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)
     (defun linum-format-func (line)
       (let ((w (length
                 (number-to-string (count-lines (point-min) (point-max))))))
         (concat
          (propertize (make-string (- w (length (number-to-string line))) ?0)
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum))))
     (setq linum-format 'linum-format-func)))

;;; disable tab expand in yas-minor mode
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(provide 'init-local)
;;; init-local.el ends here
