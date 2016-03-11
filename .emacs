; clang tools
; (load "~/clang/tools/clang-format/clang-format.el")
; (global-set-key [C-M-q] 'clang-format-region)


; color theme
(setq debug-on-error t)
; (require 'color-theme)
(load-file "~/.emacs.d/zenburn-theme.el")
; (zenburn)

; c++
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
(global-ede-mode 1)
(ede-cpp-root-project "OPM-parser" :file "~/opm/opm-parser/CMakeLists.txt")

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode,
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; (defun my-c-mode-cedet-hook ()
;;   (local-set-key "." 'semantic-complete-self-insert)
;;   (local-set-key ">" 'semantic-complete-self-insert))
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)


;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberant ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languages only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)


;(require 'semantic/ia)
;(require 'semantic/bovine/gcc)
;(semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)
(semantic-add-system-include "~/opm/opm-parser" 'c++-mode)
;(semantic-add-system-include "~/opm/opm-parser/opm" 'c++-mode)
;(semantic-add-system-include "~/opm/opm-parser/opm/parser" 'c++-mode)
;(semantic-add-system-include "~/opm/opm-parser/opm/parser/eclipse" 'c++-mode)
(semantic-add-system-include "~/ert/ert" 'c++-mode)
(semantic-add-system-include "~/opm/opm-common" 'c++-mode)
(semantic-add-system-include "~/opm/opm-core" 'c++-mode)
(semantic-add-system-include "~/ert/ert/devel/libert_util/include" 'c-mode)
(semantic-add-system-include "~/ert/ert/devel/libecl/include/" 'c-mode)


(custom-set-variables
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote text-mode))
 '(initial-scratch-message ""))

(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
;(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(setq line-number-mode t)
(setq column-number-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-ignore-extensions t)


(setq show-paren-delay 0)
(show-paren-mode 1)

(setq default-directory "~/" )


(setq-default fill-column 80)

(require 'whitespace)
; (setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face empty tabs trailing))
(global-whitespace-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; c++ indentation stuff
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq c-default-style "linux"
      c-basic-offset 4)




;; cmake
(autoload 'cmake-mode "~/.emacs.d/cmake-mode.el" t)

(autoload 'cmake-font-lock-activate "~/.emacs.d/cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

; Add cmake listfile names to the mode list.
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode))
              '(("\\.cmake\\'" . cmake-mode)) auto-mode-alist))

;; eclipse
(load-file "~/.emacs.d/eclipse.el")
