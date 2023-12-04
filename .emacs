; ediff one and one character
;(setq-default ediff-forward-word-function 'forward-char)

(set-default-font "JetBrains Mono-14")

(setq ring-bell-function 'ignore)


(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
      (message "No non-ascii characters."))))


(defun evince (fname &optional output-buffer error-buffer)
  (interactive
   (list
    (read-file-name
     "evince: "
     nil nil nil nil (lambda (fname)
                       (string=
                        (file-name-extension fname) "pdf")))
    current-prefix-arg
    shell-command-default-error-buffer))
  (shell-command (concat "evince" " " fname "&")
                 output-buffer error-buffer))

(global-set-key (kbd "C-c p") 'evince)
(global-set-key (kbd "C-c C-b") 'blacken-buffer)


;;
;; python stuff
;;
(defun insert-pdb-set-trace ()
  (interactive)
  (insert "import pdb; pdb.set_trace()"))
;;(global-set-key (kbd "C-c C-a") 'insert-pdb-set-trace)

(defun insert-if-name-then-main ()
  (interactive)
  (insert "#!/usr/bin/env python
from __future__ import print_function

def main(args):
    pass

if __name__ == '__main__':
    from sys import argv
    if len(argv) < 2:
        exit('Usage: app arg')
    main(argv[1:])
")
  )
(global-set-key (kbd "C-c C-e") 'insert-if-name-then-main)

;;
;; end python stuff
;;



;; make frequently used commands short
(defalias 'fb 'flyspell-buffer)
(defalias 'fm 'flyspell-mode)
(defalias 'wsc 'whitespace-cleanup)
(defalias 'wsr 'whitespace-cleanup-region)
(defalias 'mm 'mail-mode)

;(load-file "~/.emacs.d/rst.el")

;(load-file "~/.emacs.d/word-count.el")


(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 130))

;(add-to-list 'load-path "/private/pgdr/.emacs.d/neotree")
;(require 'neotree)
;(global-set-key [f8] 'neotree-toggle)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(package-initialize) ;; You might already have this line

; clang tools
; (load "~/clang/tools/clang-format/clang-format.el")
; (global-set-key [C-M-q] 'clang-format-region)

(push ".cache" completion-ignored-extensions)


; metno
(setq weather-metno-location-name "Bergen,  Norway"
      weather-metno-location-latitude 60.389444
      weather-metno-location-longitude 5.33)


;; clock time org mode
;; format string used when creating CLOCKSUM lines and when generating a
;; time duration (avoid showing days)
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-split-window-function (quote split-window-horizontally))
 '(inhibit-startup-screen t)
 '(initial-major-mode (quote text-mode))
 '(initial-scratch-message "")
 '(org-calc-default-modes
   (quote
    (calc-internal-prec 12 calc-float-format
                        (float 8)
                        calc-angle-mode deg calc-prefer-frac nil calc-symbolic-mode nil calc-date-format
                        (YYYY "-" MM "-" DD " " Www
                              (" " hh ":" mm))
                        calc-display-working-message t)))
 '(package-selected-packages
   (quote
    (astyle rust-mode dash web-mode pandoc pandoc-mode writegood-mode csv-mode blacken slime zenburn-theme yaml-mode magit markdown-mode)))
 '(safe-local-variable-values
   (quote
    ((reftex-default-bibliography "survey_edge_modification.bib")
     (TeX-master . survey)
     (TeX-command-extra-options . "-shell-escape")))))


;(require 'writegood-mode)
;(global-set-key (kbd "C-c C-g") 'writegood-mode)


(add-hook 'markdown-mode-hook 'flyspell-buffer)
(add-hook 'markdown-mode-hook 'flyspell-mode)
;(add-hook 'markdown-mode-hook 'writegood-mode)
(add-hook 'markdown-mode-hook 'pandoc-mode)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(with-eval-after-load 'tex
  (add-to-list 'safe-local-variable-values
               '(TeX-command-extra-options . "-shell-escape")))


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


(setq-default fill-column 72)

(require 'whitespace)
; (setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face empty tabs trailing))
(global-whitespace-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
; (setq indent-line-function 'insert-tab)

;; c++ indentation stuff
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq c-default-style "linux"
      c-basic-offset 2)




;; cmake
(autoload 'cmake-mode "~/.emacs.d/cmake-mode.el" t)

(autoload 'cmake-font-lock-activate "~/.emacs.d/cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

; Add cmake listfile names to the mode list.
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode))
              '(("\\.cmake\\'" . cmake-mode)) auto-mode-alist))


(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)


(add-hook 'mail-mode-hook 'flyspell-mode)

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(global-set-key (kbd "C-c +") 'increment-number-at-point)


;;
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)



(defun snake-case ()
  (interactive)
  (progn (replace-regexp "\\([A-Z]\\)" "_\\1" nil
                         (region-beginning)
                         (region-end))
         (downcase-region (region-beginning) (region-end))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(load-theme 'zenburn t)

(defun shuffle-list (list)
  "Randomly permute the elements of LIST.
All permutations equally likely."
  (let ((i 0)
  j
  temp
  (len (length list)))
    (while (< i len)
      (setq j (+ i (random (- len i))))
      (setq temp (nth i list))
      (setcar (nthcdr i list) (nth j list))
      (setcar (nthcdr j list) temp)
      (setq i (1+ i))))
  list)

(defun randomize-region (beg end)
  (interactive "r")
  (if (> beg end)
      (let (mid) (setq mid end end beg beg mid)))
  (save-excursion
    ;; put beg at the start of a line and end and the end of one --
    ;; the largest possible region which fits this criteria
    (goto-char beg)
    (or (bolp) (forward-line 1))
    (setq beg (point))
    (goto-char end)
    ;; the test for bolp is for those times when end is on an empty
    ;; line; it is probably not the case that the line should be
    ;; included in the reversal; it isn't difficult to add it
    ;; afterward.
    (or (and (eolp) (not (bolp)))
        (progn (forward-line -1) (end-of-line)))
    (setq end (point-marker))
    (let ((strs (shuffle-list 
                 (split-string (buffer-substring-no-properties beg end)
                             "\n"))))
      (delete-region beg end)
      (dolist (str strs)
        (insert (concat str "\n"))))))

(use-package latex
  :ensure auctex
  :config
  (add-to-list 'LaTeX-font-list
               '(?\C-p "\\name{" "}")))



;;; SYNCTEX

; SyncTeX basics

; un-urlify and urlify-escape-only should be improved to handle all special characters, not only spaces.
; The fix for spaces is based on the first comment on http://emacswiki.org/emacs/AUCTeX#toc20

(defun un-urlify (fname-or-url)
  "Transform file:///absolute/path from Gnome into /absolute/path with very limited support for special characters"
  (if (string= (substring fname-or-url 0 8) "file:///")
      (url-unhex-string (substring fname-or-url 7))
    fname-or-url))

(defun urlify-escape-only (path)
  "Handle special characters for urlify"
  (replace-regexp-in-string " " "%20" path))

(defun urlify (absolute-path)
  "Transform /absolute/path to file:///absolute/path for Gnome with very limited support for special characters"
  (if (string= (substring absolute-path 0 1) "/")
      (concat "file://" (urlify-escape-only absolute-path))
      absolute-path))


; SyncTeX backward search - based on http://emacswiki.org/emacs/AUCTeX#toc20, reproduced on https://tex.stackexchange.com/a/49840/21017

(defun th-evince-sync (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: Could not open %s" fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(defvar *dbus-evince-signal* nil)

(defun enable-evince-sync ()
  (require 'dbus)
  ; cl is required for setf, taken from: http://lists.gnu.org/archive/html/emacs-orgmode/2009-11/msg01049.html
  (require 'cl)
  (when (and
         (eq window-system 'x)
         (fboundp 'dbus-register-signal))
    (unless *dbus-evince-signal*
      (setf *dbus-evince-signal*
            (dbus-register-signal
             :session nil "/org/gnome/evince/Window/0"
             "org.gnome.evince.Window" "SyncSource"
             'th-evince-sync)))))

(add-hook 'LaTeX-mode-hook 'enable-evince-sync)


; SyncTeX forward search - based on https://tex.stackexchange.com/a/46157

;; universal time, need by evince
(defun utime ()
  (let ((high (nth 0 (current-time)))
        (low (nth 1 (current-time))))
   (+ (* high (lsh 1 16) ) low)))

;; Forward search.
;; Adapted from http://dud.inf.tu-dresden.de/~ben/evince_synctex.tar.gz
(defun auctex-evince-forward-sync (pdffile texfile line)
  (let ((dbus-name
     (dbus-call-method :session
               "org.gnome.evince.Daemon"  ; service
               "/org/gnome/evince/Daemon" ; path
               "org.gnome.evince.Daemon"  ; interface
               "FindDocument"
               (urlify pdffile)
               t     ; Open a new window if the file is not opened.
               )))
    (dbus-call-method :session
          dbus-name
          "/org/gnome/evince/Window/0"
          "org.gnome.evince.Window"
          "SyncView"
          (urlify-escape-only texfile)
          (list :struct :int32 line :int32 1)
  (utime))))

(defun auctex-evince-view ()
  (let ((pdf (file-truename (concat default-directory
                    (TeX-master-file (TeX-output-extension)))))
    (tex (buffer-file-name))
    (line (line-number-at-pos)))
    (auctex-evince-forward-sync pdf tex line)))

;; New view entry: Evince via D-bus.
(setq TeX-view-program-list '())
(add-to-list 'TeX-view-program-list
         '("EvinceDbus" auctex-evince-view))

;; Prepend Evince via D-bus to program selection list
;; overriding other settings for PDF viewing.
(setq TeX-view-program-selection '())
(add-to-list 'TeX-view-program-selection
         '(output-pdf "EvinceDbus"))


;; END SYNCTEX


;; Automatically load reftex

(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook
      (lambda ()
        (reftex-mode t)
        (flyspell-mode t)
 ))



(add-hook 'markdown-mode-hook
          (lambda ()
            (global-set-key (kbd "C-c k") (lambda () (interactive)(compile "make")))
            ))


;;; RUST

(require 'rust-mode)
(define-key rust-mode-map (kbd "C-c C-r") 'rust-run)
(define-key rust-mode-map (kbd "C-c C-k") 'rust-run-clippy)
(define-key rust-mode-map (kbd "C-c C-c") 'rust-compile)
