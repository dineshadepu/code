;;; package --- Summary
;;; Commentary:


;; -------------- normal functions -------------------
;;; code:
(require 'package)
(setq package-enable-at-startup nil)

(cond
 ((>= 24 emacs-major-version)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  (package-refresh-contents)
  )
 )
(setq package-archives
      (append package-archives
              '(("melpa" . "http://melpa.milkbox.net/packages/"))))

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)
;; (setq package-archives
;;       '(("elpa" . "http://elpa.gnu.org/packages/")
;;         ("melpa-stable" . "http://stable.melpa.org/packages/")
;;         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; UI
(setq inhibit-startup-message t)
(tool-bar-mode -1)
;; (menu-bar-mode -1)
(global-linum-mode t)
;; (global-hl-line-mode t)
;; (setq mac-command-modifier 'meta)
(setq ns-function-modifier 'control)
(global-auto-revert-mode 1)
(set-cursor-color "#ffffff")
(line-number-mode)
(column-number-mode)
(size-indication-mode)
(fset 'yes-or-no-p #'y-or-n-p)
(setq x-gtk-use-system-tooltips nil)
(setq-default indent-tabs-mode nil)
(global-whitespace-mode -1)
;; (global-set-key (kbd "M-x") 'helm-M-x)
(define-key global-map [?\s-s] 'save-buffer)
;; (global-set-key [(super s)] 'save-buffer)

;; backup files nil
(setq make-backup-files nil)

;; open recently closed files
(desktop-save-mode 1)

;; hash or pound key
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; disable backup
(setq backup-inhibited t)

;; disable auto save
(setq auto-save-default nil)

;; Copy to clipboard
(fset 'evil-visual-update-x-selection 'ignore)

;; Electric auto pair
(electric-pair-mode t)

;; packages used in init
(use-package dash)
(use-package f)

(setq temporary-file-directory "~/.emacs.d/tmp/")

;; set font size
(set-face-attribute 'default nil :height 140)


;; Bookmarks file in dropbox.
(setq bookmark-default-file "~/Dropbox/common/emacs/bookmarks.bmk" bookmark-save-flag 1)
;; White space astropy
;; Remove trailing whitespace manually by typing C-t C-w.
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-t C-w")
                           'delete-trailing-whitespace)))

;; Automatically remove trailing whitespace when file is saved.
(add-hook 'python-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (delete-trailing-whitespace))))))
;; whitespace clean up mode
(add-hook 'before-save-hook 'whitespace-cleanup)

;; kill all oher buffers
(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

(global-set-key (kbd "C-x K") 'nuke-all-buffers)

(defun kill-other-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) )
      (kill-buffer buffer))))

(global-set-key (kbd "C-x L") 'kill-other-buffers)

;; Copy to clipboard
;; (defun copy-from-osx ()
;;   (shell-command-to-string "pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; == Load Custom Theme ==
(use-package color-theme :ensure t)
(use-package monokai-theme
  :ensure t
  :init
  (load-theme 'monokai t))
;; (use-package zenburn-theme
;;   :ensure t
;;   :init
;;   (load-theme 'zenburn t))

(use-package exec-path-from-shell
  :ensure t
  ;; :load-path "~/.emacs.d/elisp/exec-path-from-shell/"
  :config
  (push "HISTFILE" exec-path-from-shell-variables)
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

;; Provides all the racket support
;; (use-package racket-mode
;;   :ensure t)

;; (use-package scheme-complete :ensure t)

;; (use-package rainbow-identifiers
;;   :ensure t
;;   :init
;;   ;; (rainbow-identifiers-mode 1) doesn't work. have to set it up as a hoook
;;   (progn
;;     (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
;;     (setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
;;           rainbow-identifiers-cie-l*a*b*-lightness 70
;;           rainbow-identifiers-cie-l*a*b*-saturation 30
;;           rainbow-identifiers-cie-l*a*b*-color-count 20
;;           ;; override theme faces
;;           rainbow-identifiers-faces-to-override '(highlight-quoted-symbol
;;                                                   font-lock-variable-name-face
;;                                                   font-lock-function-name-face
;;                                                   font-lock-type-face
;;                                                   js2-function-param
;;                                                   js2-external-variable
;;                                                   js2-instance-member
;;                                                   js2-private-function-call))))

(use-package rainbow-delimiters
  :ensure t
  :init
  (progn
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
    (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)))

;; (use-package paredit
;;   :ensure t
;;   :config
;;   (add-hook 'racket-mode-hook #'enable-paredit-mode))

;; Mouse disable globally

;; -------------------------------------------
;; -------------------------------------------
;;(mouse-wheel-mode -1)

;; (global-set-key [wheel-up] 'ignore)
;; (global-set-key [wheel-down] 'ignore)
;; (global-set-key [double-wheel-up] 'ignore)
;; (global-set-key [double-wheel-down] 'ignore)
;; (global-set-key [triple-wheel-up] 'ignore)
;; (global-set-key [triple-wheel-down] 'ignore)

;; -------------------------------------------
;; -------------------------------------------


;; -------------------------------------------
;; -------------------------------------------
;; -----------Emacs rocks configuration-------
(use-package dired-details
  :ensure t
  :init
  (setq-default dired-details-hidden-string "--- ")
  (setq dired-dwim-target t)
  )
(dired-details-install)

;; Aliases
(defalias 'yes-or-no-p 'y-or-n-p)

;; (use-package whitespace-mode
;;   :disabled t)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode)
  )


(use-package evil
  :ensure t
  :diminish evil
  :init (evil-mode 1)
  (setq evil-insert-state-cursor '((bar . 1) "white")
        evil-visual-state-cursor '(box "dark orange")
        evil-normal-state-cursor '(box "white"))
  :bind (:map
         evil-insert-state-map
         ([left]     . windmove-left)
         ([right]    . windmove-right)
         ([up]       . windmove-up)
         ([down]     . windmove-down)
         ("SPC" . nil)
         :map
         evil-normal-state-map
         (";" . evil-ex)
         (":"	.	evil-repeat-find-char)
         :map    evil-motion-state-map
         ([left]     . windmove-left)
         ([right]    . windmove-right)
         ([up]       . windmove-up)
         ))


(use-package evil-leader
  :ensure t
  :diminish evil-leader
  :init (global-evil-leader-mode)
  :config (progn
            (evil-leader/set-leader ",")
            (evil-leader/set-key "b" 'switch-to-buffer)
            (evil-leader/set-key "s" 'save-buffer)
            (evil-leader/set-key "e" 'find-file)
            (evil-leader/set-key "1" 'delete-other-windows)
            (evil-leader/set-key "x" 'bookmark-jump)
            (evil-leader/set-key "0" 'delete-window)
            (evil-leader/set-key "3" 'split-window-right)
            (evil-leader/set-key "2" 'split-window-below)
            (evil-leader/set-key "." 'elpy-goto-definition-other-window)
            (evil-leader/set-key "," 'elpy-goto-definition)
            (evil-leader/set-key "f" 'ff-find-other-file)
            (evil-leader/set-key "r" 'recentf-open-files)
            (evil-leader/set-key "c" 'org-ref-helm-insert-ref-link)
            (evil-leader/set-key "w" 'ispell-word)
            (evil-leader/set-key "g" 'magit-status)
            (evil-leader/set-key "z" 'fzf)
            (evil-leader/set-key "n" 'windmove-left)
            (evil-leader/set-key "m" 'windmove-right)
            (evil-leader/set-key "<SPC>" 'windmove-down)
            (evil-leader/set-key "u" 'windmove-up)
            (evil-leader/set-key "o" 'org-ref-open-bibtex-notes)
            (evil-leader/set-key "`" 'org-edit-src-exit)
            (evil-leader/set-key "p" 'org-ref-open-pdf-at-point)
            ;; (evil-leader/set-key "h" 'helm-M-x)
            (evil-leader/set-key "k" 'kill-this-buffer)))

;; evil cursor terminal
(use-package evil-terminal-cursor-changer
  :ensure t)
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate) ; or (etcc-on)
  )

(setq evil-motion-state-cursor 'box)  ; █
(setq evil-visual-state-cursor 'box)  ; █
(setq evil-normal-state-cursor 'box)  ; █
(setq evil-insert-state-cursor 'bar)  ; ⎸
(setq evil-emacs-state-cursor  'hbar) ; _

;;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)


(use-package avy
  :ensure t
  :config
  (evil-leader/set-key
    "q" 'avy-goto-char-2))

(use-package magit
  :ensure t)
(global-auto-revert-mode t)


(use-package evil-magit
  :ensure t)
;; (add-hook 'magit-mode-hook
;;           (lambda ()
;;             (when evil-jumper-mode
;;               (evil-jumper-mode -1))))
;; (add-hook 'magit-mode-hook (lambda () (evil-jumper-mode -1)))

(use-package evil-nerd-commenter
  :ensure t
  :config(progn
           (evilnc-default-hotkeys)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; Awesome company mode configration starts here ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company
  :ensure t
  :defer 12
  :diminish company-mode
  :commands (compay-mode
             company-complete
             company-complete-common
             company-complete-common-or-cycle
             company-files
             company-dabbrev
             company-ispell
             company-c-headers
             company-jedi
             company-auctex
             company--auto-completion
             company-julia)
  :init
  (setq company-minimum-prefix-length 2
        company-require-match 1
        company-selection-wrap-around t
        company-dabbrev-downcase nil
        company-tooltip-limit 15
        company-tooltip-align-annotations t
        company-idle-delay 0.1
        company-begin-commands '(self-insert-command))
  (eval-after-load 'company
    '(add-to-list 'company-backends '(company-files
                                      company-capf)))
  :bind (("C-c f" . company-files)
         ("C-c a" . company-dabbrev)
         ("C-c d" . company-ispell)
         ;; ("<tab>" . tab-indent-or-complete)
         ("TAB" . tab-indent-or-complete)
         ("M-t" . company-complete-common)
         :map company-active-map
         ("C-a" . company-abort)
         ("<tab>" . expand-snippet-or-complete-selection)
         ("TAB" . expand-snippet-or-complete-selection))
  :config
  (defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))
  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))
  (defun tab-indent-or-complete ()
    (interactive)
    (cond
     ((minibufferp)
      (minibuffer-complete))
     (t
      (indent-for-tab-command)
      (if (or (not yas-minor-mode)
              (null (do-yas-expand)))
          (if (check-expansion)
              (progn
                (company-manual-begin)
                (if (null company-candidates)
                    (progn
                      (company-abort)
                      (indent-for-tab-command)))))))))
  (defun expand-snippet-or-complete-selection ()
    (interactive)
    (if (or (not yas-minor-mode)
            (null (do-yas-expand))
            (company-abort))
        (company-complete-selection)))
  ;; Add yasnippet support for all company backends
  (defvar company-mode/enable-yas t
    "Enable yasnippet for every back-end")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas)
            (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends
        (mapcar #'company-mode/backend-with-yas company-backends))
  (global-company-mode))

;; for org mode completion
(setq company-begin-commands '(self-insert-command
                               org-self-insert-command c-electric-lt-gt c-electric-colon))

;;
;; (add-hook 'after-init-hook 'global-company-mode)


(use-package company-statistics
  :ensure t
  :config
  (company-statistics-mode))

(use-package company-c-headers
  :ensure t
  :config
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/5/")
  (add-to-list 'company-backend 'company-c-headers))

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; Awesome company mode configration starts here ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (global-flycheck-mode t)
  ;; (setq flycheck-highlighting-mode 'columns)
  (setq flycheck-highlighting-mode 'symbols))



(use-package flyspell
  :ensure t
  :diminish flyspell-mode
  :defer t
  :init
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    )

  :config
  ;; Sets flyspell correction to use two-finger mouse click
  (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word))

;; ispell for spell check
(setq exec-path (append exec-path '("/usr/local/Cellar/")))
(setq-default ispell-program-name "aspell")


(use-package restart-emacs
  :ensure t
  :bind (("C-x M-c" . restart-emacs)))

(use-package aggressive-indent
  :ensure t
  :init (global-aggressive-indent-mode))


(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode 1)
  :preface
  (defun abort-company-or-yas ()
    (interactive)
    (if (null company-candidates)
        (yas-abort-snippet)
      (company-abort)))
  (defun tab-complete-or-next-field ()
    (interactive)
    (if (or (not yas-minor-mode)
            (null (do-yas-expand)))
        (if company-candidates
            (company-complete-selection)
          (if (check-expansion)
              (progn
                (company-manual-begin)
                (if (null company-candidates)
                    (progn
                      (company-abort)
                      (yas-next-field))))
            (yas-next-field)))))
  :bind (:map yas-minor-mode-map
              ([tab] . nil)
              ("TAB" . nil)
              :map yas-keymap
              ([tab] . tab-complete-or-next-field)
              ("TAB" . tab-complete-or-next-field)
              ("M-n" . yas-next-field)
              ("C-g" . abort-company-or-yas)))

;; ---------------------------------------------------
;; ---------------------------------------------------
;; ------eshell settings------------------------------
(defun my-shell-hook ()
  (local-set-key "\C-cl" 'erase-buffer))

(add-hook 'shell-mode-hook 'my-shell-hook)
(add-hook 'eshell-mode-hook (lambda() (company-mode 0)))
;; ---------------------------------------------------
;; ---------------------------------------------------
;; ------eshell settings end------------------------------

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
;; (use-package markdown-mode
;;   :ensure t
;;   ;; :load-path "~/elisp/markdown-mode"
;;   :commands markdown-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Section for Predictive mode
;;
;; (add-to-list 'load-path "~/.emacs.d/elisp/predictive/")
;; (autoload 'predictive-mode "predictive" "predictive" t)
;; (set-default 'predictive-auto-add-to-dict t)
;; (setq predictive-main-dict 'rpg-dictionary
;;       predictive-auto-learn t
;;       predictive-add-to-dict-ask nil
;;       predictive-use-auto-learn-cache nil
;;       predictive-which-dict t)

;; (when (and (featurep 'predictive) (featurep 'company))
;;   (defun company-predictive (command &optional arg &rest ignored)
;;     (case command
;;       (prefix (let* ((text (downcase (word-at-point))))
;;                 (set-text-properties 0 (length text) nil text)
;;                 text))
;;       (candidates (predictive-complete arg))))
;;   (load "dict-english")
;;   (add-to-list 'company-backends '(company-predictive)))
;; (add-hook 'org-mode-hook 'predictive-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package predictive
;;   :load-path "~/.emacs.d/elisp/predictive/"
;;   :config
;;   (autoload 'predictive-mode "predictive" "predictive" t)
;;   (set-default 'predictive-auto-add-to-dict t)
;;   (setq predictive-main-dict 'rpg-dictionary)
;;   (setq predictive-auto-learn t)
;;   (setq predictive-add-to-dict-ask nil)
;;   (setq predictive-use-auto-learn-cache nil)
;;   (setq predictive-which-dict t))



(use-package tex
  :ensure auctex
  :config)
  ;; (setq TeX-show-compilation t)



(use-package elpy
  ;; :load-path "~/.emacs.d/elisp/elpy/"
  :ensure t
  :diminish elpy-mode
  :config(progn
           (defalias 'workon 'pyvenv-workon)
           ;; (elpy-use-cpython "$HOME/.virtualenvs/sph/bin")
           ;; (setq elpy-rpc-python-command "python3")
           ;; (setq 'python-indent-offset 4)
           (setq company-minimum-prefix-length 1)
           (setq python-shell-completion-native-enable nil)
           (setq elpy-rpc-timeout 10)
           ;; (elpy-use-ipython)
           ;; (elpy-clean-modeline)
           (elpy-enable)))

(use-package virtualenv
  :ensure)
;; (let ((virtualenv-workon-starts-python nil))
;;   (virtualenv-workon "sph"))


(use-package py-yapf
  :ensure t
  :diminish py-yapf)
;; :config
;; (add-hook 'python-mode-hook 'py-yapf-enable-on-save))


(use-package ido
  :ensure t
  :config(progn
           (setq ido-enable-flex-matching t)
           (setq ido-everywhere t)
           (ido-mode 1)))


(use-package flx-ido
  :ensure t
  :init
  (progn
    (setq gc-cons-threshold (* 20 (expt 2 20)) ; megabytes
          ido-use-faces nil))
  :config
  (flx-ido-mode 1))


;; (use-package ido-vertical-mode
;;   :ensure t
;;   :init
;;   (setq ido-vertical-define-keys 'C-n-and-C-p-only)
;;   :config
;;   (ido-vertical-mode t))


(use-package smex
  :ensure t
  :bind
  (([remap execute-extended-command] . smex)
   ("M-X" . smex-major-mode-commands)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; Awesome helm configration starts here ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm
  :ensure t
  :diminish helm-mode
  :defer t
  :bind (("C-x C-f" . helm-find-files))
  :init
  (progn
    (require 'helm-config)
    (helm-mode 1)
    (set-face-attribute 'helm-selection nil
                        )))
(use-package helm-swoop
  :ensure t
  :bind (("M-i" . helm-swoop)))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; :init
;; (bind-key "M-m" 'helm-swoop-from-isearch isearch-mode-map))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;; Awesome helm configration ends here ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package golden-ratio                 ; Auto resize windows
  :ensure t
  :diminish golden-ratio-mode
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t)
  (setq golden-ratio-extra-commands
        (append golden-ratio-extra-commands
                '(evil-window-left
                  evil-window-right
                  evil-window-up
                  evil-window-down))))

;; Emacs c++ environment

;; ------------------------------------------------
;; ------------------------------------------------

;; c++ development irony starts here

;; tags for code navigation
;; tags for code navigation

(use-package ggtags
  ;; Use M-. to find a tag.
  ;; Use M-, to go back
  :ensure t
  :config
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                (ggtags-mode 1))))
  )

;; @see https://bitbucket.org/lyro/evil/issue/511/let-certain-minor-modes-key-bindings
(eval-after-load 'ggtags
  '(progn
     (evil-make-overriding-map ggtags-mode-map 'normal)
     ;; force update evil keymaps after ggtags-mode loaded
     (add-hook 'ggtags-mode-hook #'evil-normalize-keymaps)))

(defun find-tag-no-prompt ()
  "Jump to the tag at point without prompting"
  (interactive)
  (find-tag (find-tag-default)))
;; don't prompt when finding a tag
(global-set-key (kbd "M-.") 'find-tag-no-prompt)

(use-package irony
  :ensure t
  :commands (irony-mode))

(use-package irony-eldoc
  :ensure t
  :commands (irony-eldoc))

(defun irony-use-async-ac ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)

  (define-key irony-mode-map [remap completion-symbol]
    'irony-completion-at-point-async)
  (irony-cdb-autosetup-compile-options))

(add-hook 'irony-mode-hook 'irony-use-async-ac)

(use-package flycheck-irony
  :ensure t
  :defer 2
  :init (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(use-package clang-format
  :ensure t
  :config
  (progn
    (setq clang-format-style "llvm")
    (add-hook 'c++-mode-hook (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil t)))
    (add-hook 'c-mode-hook (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil t)))))

(use-package google-c-style
  :ensure t
  :defer t
  :config
  (progn
    (add-hook 'c-mode-common-hook 'google-set-c-style)
    (add-hook 'c-mode-common-hook 'google-make-newline-indent)))

;; c++ development irony ends here

;; ------------------------------------------------
;; ------------------------------------------------


;; ------------------------------------------------
;; ------------------------------------------------
;; C++ DEVELOPMENT, DIFFERENRT with RTAGS starts
(use-package counsel-gtags
  :ensure)
(add-hook 'c-mode-hook 'counsel-gtags-mode)
(add-hook 'c++-mode-hook 'counsel-gtags-mode)

(with-eval-after-load 'counsel-gtags
  (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
  (define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
  (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
  (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward))

(setenv "GTAGSLIBPATH" (concat "/usr/include"
                               ":"
                               (file-truename "~/proj2")
                               ":"
                               (file-truename "~/proj1")))
(setenv "MAKEOBJDIRPREFIX" (file-truename "~/obj/"))
;; (setq company-backends '((company-dabbrev-code company-gtags)))
;; ------------------------------------------------
;; ------------------------------------------------
;; C++ DEVELOPMENT, DIFFERENRT with RTAGS ends
;; ------------------------------------------------
;; ------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rust starts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rust-mode
  :ensure t
  :diminish t)

(use-package racer
  :ensure t
  :diminish t
  ;; :load-path "~/.emacs.d/elisp/emacs-racer/"
  :bind
  (:map evil-normal-state-map
        ("M-." .  racer-find-definition)
        )
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode))
;; evil leader for go to definition
(evil-leader/set-key-for-mode 'rust-mode "," 'racer-find-definition)

(setq racer-cmd "~/.cargo/bin/racer")
(setq racer-rust-src-path "/home/dinesh/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB")  #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)



(use-package flycheck-rust
  :ensure t
  :defer t
  :init (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package flycheck-package
  :ensure t
  :init (with-eval-after-load 'flycheck (flycheck-package-setup)))



(use-package toml-mode
  :ensure t)

(use-package clang-format
  :ensure t)

(use-package cargo
  :ensure t
  :diminish t)
(add-hook 'rust-mode-hook 'cargo-minor-mode)

(use-package rg
  :ensure t
  :diminish t)

;; snippets
(add-to-list 'load-path "/home/dinesh/.emacs.d/elpa/rust-snippets/")
(autoload 'rust-snippets/initialize "rust-snippets")
(eval-after-load 'yasnippet
  '(rust-snippets/initialize))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rust ends
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)))

;; (use-package cython-mode
;;   :ensure t
;;   :config
;;   (require 'cython-mode))

;; (use-package sr-speedbar
;;   :load-path "~/.emacs.d/elisp/sr-speedbar.el"
;;   :config
;;   (require 'sr-speedbar))

(use-package recentf
  :ensure t
  :config
  (require 'recentf)
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
  (global-set-key "\C-x\ \C-r" 'recentf-open-files))


(use-package fzf
  :ensure t)

;; (use-package ensime-emacs
;;   :load-path "~/.emacs.d/elisp/ensime-emacs"
;;   )

;; ESS for statistics

;; (add-to-list 'load-path "~/.emacs.d/elisp/ESS/lisp/")
;; (load "ess-site")
;; auto-mode-alist (append (list '("\\.c$" . c-mode)
;;                               '("\\.tex$" . latex-mode)
;;                               '("\\.S$" . S-mode)
;;                               '("\\.s$" . S-mode)
;;                               '("\\.R$" . R-mode)
;;                               '("\\.r$" . R-mode)
;;                               '("\\.html$" . html-mode)
;;                               '("\\.emacs" . emacs-lisp-mode)
;;                               )
;;                         auto-mode-alist)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CPP rtags and irony combined unique development

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;      ORG-MODE     ;;;;;;;;;;;;;;;;;;;;;;;
(use-package org-ref
  :after org
  :init
  (setq reftex-default-bibliography '("~/Dropbox/Research/references.bib"))
  (setq org-ref-bibliography-notes "~/Dropbox/Research/notes/notes.org"
        org-ref-default-bibliography '("~/Dropbox/Research/references.bib")
        org-ref-pdf-directory "~/Dropbox/papers/")

  (setq helm-bibtex-bibliography "~/Dropbox/Research/references.bib")
  (setq helm-bibtex-library-path "~/Dropbox/papers/")

  (setq helm-bibtex-pdf-open-function
        (lambda (fpath)
          (start-process "open" "*open*" "open" fpath)))

  (setq helm-bibtex-notes-path "~/Dropbox/Research/notes/notes.org")
  :config
  ;; variables that control bibtex key format for auto-generation
  ;; I want firstauthor-year-title-words
  ;; this usually makes a legitimate filename to store pdfs under.
  (setq bibtex-autokey-year-length 4
        bibtex-autokey-name-year-separator "-"
        bibtex-autokey-year-title-separator "-"
        bibtex-autokey-titleword-separator "-"
        bibtex-autokey-titlewords 2
        bibtex-autokey-titlewords-stretch 1
        bibtex-autokey-titleword-length 5))

(setq org-ref-default-ref-type "eqref")
;; (org-defkey org-mode-map ["C-c M-x"] 'org-ref-helm-insert-ref-link)
(use-package org-autolist
  :after org
  :config
  (org-autolist-mode +1))

(use-package doi-utils
  :after org)

(use-package org-ref-bibtex
  :after org)


;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(use-package ox-reveal
  :ensure ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(plist-put org-format-latex-options :scale 1.5)

(add-to-list 'org-latex-packages-alist
             '("" "tikz" t))
(setq org-export-latex-hyperref-format "\\ref{%s}")

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (ditaa . t)
   (latex . t)
   (C . t)
   (ipython . t)
   ))

;; don't ask for security
(defun my-org-confirm-babel-evaluate (lang body)
  (not (member lang '("python" "latex" "sh" "ipython"))))

(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(eval-after-load "org"
  '(progn
     ;; .txt files aren't in the list initially, but in case that changes
     ;; in a future version of org, use if to avoid errors
     (if (assoc "\\.txt\\'" org-file-apps)
         (setcdr (assoc "\\.txt\\'" org-file-apps) "notepad.exe %s")
       (add-to-list 'org-file-apps '("\\.txt\\'" . "notepad.exe %s") t))
     ;; Change .pdf association directly within the alist
     (setcdr (assoc "\\.pdf\\'" org-file-apps) "evince %s")))

(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'company-backends 'company-ob-ipython)

;; (setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block

;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(add-to-list 'org-latex-minted-langs '(ipython "python"))

(setq org-latex-to-pdf-process (list "latexmk -pdf %f"))
(use-package htmlize
  :commands (htmlize-buffer
             htmlize-file
             htmlize-many-files
             htmlize-many-files-dired
             htmlize-region))

(setq ob-ipython-resources-dir "~/tmp/")

;; org mode lateX export with reference
(setq org-latex-pdf-process '("latexmk -pdflatex='%latex -shell-escape -interaction nonstopmode' -pdf -output-directory=%o -f %f"))
(use-package org-bullets
  :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; cdlatex mode on
(use-package cdlatex
  :ensure t)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)


;; org latex classes
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("report"
                 "\\documentclass{report}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

;; (with-eval-after-load 'ox-latex
;;   (add-to-list 'org-latex-classes
;;                '("phd"
;;                  "\\documentclass{iitbreport}"
;;                  ("\\chapter{%s}" . "\\chapter*{%s}")
;;                  ("\\section{%s}" . "\\section*{%s}")
;;                  ("\\subsection{%s}" . "\\subsection*{%s}")
;;                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(add-to-list 'org-latex-classes
             '("iitbreport"
               "\\documentclass{iitbreport} "
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;      ORG-MODE ends    ;;;;;;;;;;;;;;;;;;;;;;;
(use-package key-chord
  :ensure t
  :diminish key-chord-mode
  :config
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))

(use-package undo-tree
  :diminish undo-tree-mode)

;; (use-package ox-rst
;;   :ensure)

;; (use-package rst
;;   :config
;;   (setq fill-column 79)
;;   (setq rst-adornment-faces-alist
;;         (quote ((nil . font-lock-keyword-face)
;;                 (nil . font-lock-keyword-face)
;;                 (nil . rst-level-1-face)
;;                 (2 . rst-level-2-face)
;;                 (3 . rst-level-3-face)
;;                 (4 . rst-level-4-face)
;;                 (5 . rst-level-5-face)
;;                 (nil . rst-level-5-face))))
;;   :mode (("\\.rst$" . rst-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; ; predictive mode;;;;;;;;;;;; ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (add-to-list 'load-path "~/.emacs.d/elisp/predictive/")
;; (add-to-list 'load-path "/home/dinesh/.emacs.d/predictive")
;; (add-to-list 'load-path "/home/dinesh/.emacs.d/predictive/misc")
;; (add-to-list 'load-path "/home/dinesh/.emacs.d/predictive/texinfo")
;; (add-to-list 'load-path "/home/dinesh/.emacs.d/predictive/html")
;; (add-to-list 'load-path "/home/dinesh/.emacs.d/predictive/latex")
;; (require 'predictive)


;; (when (and (featurep 'predictive) (featurep 'company))
;;   (defun company-predictive (command &optional arg &rest ignored)
;;     (case command
;;       (prefix (let* ((text (downcase (word-at-point))))
;;                 (set-text-properties 0 (length text) nil text)
;;                 text))
;;       (candidates (predictive-complete arg))))
;;   (load "dict-english")
;;   (add-to-list 'company-backends '(company-predictive)))
;; (add-hook 'org-mode-hook 'predictive-mode)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (autoload 'predictive-mode "predictive" "predictive" t)
;; (set-default 'predictive-auto-add-to-dict t)
;; (setq predictive-auto-learn t)
;; (setq predictive-add-to-dict-ask nil)
;; (setq predictive-use-auto-learn-cache nil)
;; (setq predictive-which-dict t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; ; predictive mode ends;;;;;;;;;;;; ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package powerline
  :ensure t)
(powerline-center-evil-theme)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults)))
 '(package-selected-packages
   (quote
    (ox-latex org-ascii-bullets powerline rust-snippets org vim-mode vim dired-details rg neotree flycheck-package evil-escape cargo counsel-gtags counsel-gtags-mode ggtags vimrc-mode evil-vimish-fold ox-rst which-key use-package smartparens scheme-complete restart-emacs rainbow-delimiters racket-mode py-yapf platformio-mode monokai-theme markdown-mode irony-eldoc helm-swoop google-c-style golden-ratio fzf flycheck-irony flx-ido exec-path-from-shell evil-terminal-cursor-changer evil-nerd-commenter evil-magit evil-leader elpy company-statistics color-theme clang-format cdlatex avy auctex aggressive-indent)))
 '(size-indication-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
