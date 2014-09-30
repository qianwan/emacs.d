;;; package --- Summary

;;; Commentary:

;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))

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

(require-package 'pretty-lambdada)
(pretty-lambda-for-modes)

(require 'cltl2)

;;; maxima
(add-to-list 'load-path "/usr/local/Cellar/maxima/5.33.0/share/maxima/5.33.0/emacs/")
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(setq imaxima-use-maxima-mode-flag t)
(add-to-list 'auto-mode-alist '("\\.ma[cx]" . maxima-mode))

;;; ensime
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;;; global shortcut
(global-set-key (kbd "<f5>") 'ibuffer)

(provide 'init-local)
;;; init-local.el ends here
