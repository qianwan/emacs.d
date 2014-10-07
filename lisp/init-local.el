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
(require-package 'ensime)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;;; w3m
(require-package 'w3m)
(require 'w3m)
(setq w3m-mode-map (make-sparse-keymap))
(define-key w3m-mode-map (kbd "RET") 'w3m-view-this-url)
(define-key w3m-mode-map (kbd "q") 'bury-buffer)
(define-key w3m-mode-map (kbd "<mouse-1>") 'w3m-maybe-url)
(define-key w3m-mode-map [f5] 'w3m-reload-this-page)
(define-key w3m-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)
(define-key w3m-mode-map (kbd "M-<left>") 'w3m-view-previous-page)
(define-key w3m-mode-map (kbd "M-<right>") 'w3m-view-next-page)
(define-key w3m-mode-map (kbd "M-.") 'w3m-haddock-find-tag)
(defun w3m-maybe-url ()
  (interactive)
  (if (or (equal '(w3m-anchor) (get-text-property (point) 'face))
          (equal '(w3m-arrived-anchor) (get-text-property (point) 'face)))
    (w3m-view-this-url)))
(require 'w3m-haddock)
(add-hook 'w3m-display-hook 'w3m-haddock-display)

;;; global key bind
(global-set-key (kbd "C-x a w") 'delete-other-windows)
(global-set-key (kbd "C-x w") 'delete-other-window)

(provide 'init-local)
;;; init-local.el ends here
