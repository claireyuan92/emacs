;------------------------;
;;; Python Programming ;;;
;------------------------;

; It seems like the new version of python mode doesn't work as
; well... grumble. Going to continue using the old version until
; IPython integration is better.

;; ; python-mode
;; (setq py-install-directory "~/.emacs.d/python-mode-5.1.0")
;; (add-to-list 'load-path py-install-directory)
;; (require 'python-mode) 

;; ; use IPython
;; (add-to-list 'load-path "~/.emacs.d/ipython")
;; (require 'ipython)
;; ; use the wx backend, for both mayavi and matplotlib
;; (setq py-python-command-args 
;;   '("--gui=wx" "--pylab=wx" "--colors" "Linux"))


; python-mode
;(setq py-install-directory "~/.emacs.d/python-mode-6.0.11")
;(setq py-install-directory "~/.emacs.d/python-mode-6.0.12")
(setq py-install-directory "~/.emacs.d/python-mode-6.1.0")
(add-to-list 'load-path py-install-directory)
(require 'python-mode) 

; use IPython
(setq-default py-shell-name "/usr/local/bin/ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq-default py-python-command-args
	      (if (system-is-mac)
		  '("--gui=osx" "--pylab=osx" "--colors" "Linux")
		(if (system-is-linux)
		    '("--gui=wx" "--pylab=wx" "--color" "Linux")
		  '())))
(setq py-force-py-shell-name-p 1)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p 1)
(setq py-switch-buffers-on-execute-p 1)
; don't split windows
(setq py-split-windows-on-execute-p -1)
; try to automagically figure out indentation
(setq py-indent-honors-inline-comment 1)
;(setq py-indent-honors-inline-comment -1)
(setq-default py-smart-indentation 1)

; pymacs
(add-to-list 'load-path "~/.emacs.d/pymacs-0.25")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" -1 1)
(autoload 'pymacs-exec "pymacs" -1 1)
(autoload 'pymacs-load "pymacs" -1 1)
(autoload 'pymacs-autoload "pymacs")
(setq py-load-pymacs-p 1)
(setq py-complete-set-keymap-p 1)

; ropemacs
(defun load-ropemacs ()
  "Load pymacs and ropemacs"
  (interactive)
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  ;; Automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil))
;(add-hook 'python-mode-hook 'load-ropemacs)

; IPython notebook
(add-to-list 'load-path "~/.emacs.d/emacs-ipython-notebook-0.2.0alpha0")
(require 'ein)

; use autocompletion, but don't start to autocomplete after a dot
(setq ein:complete-on-dot -1)
(setq ein:use-auto-complete 1)
; set python console args
(setq ein:console-args
      (if (system-is-mac)
	  '("--profile nbserver" "--gui=osx" "--pylab=osx" "--colors" "Linux")
	(if (system-is-linux)
	    '("--profile nbserver" "--gui=wx" "--pylab=wx" "--colors" "Linux"))))

; timeout settings
(setq ein:query-timeout 5000)

; load the notebook list after initialization
;(add-hook 'after-init-hook 'ein:notebooklist-load)
(defun load-ein () 
  (ein:notebooklist-load)
  (interactive)
  (ein:notebooklist-open))

(provide 'python-settings)

