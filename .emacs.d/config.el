(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package all-the-icons)

(use-package general 
  :ensure t
  :config
  (general-evil-setup t))

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
    "SPC"   '(counsel-M-x :which-key "M-x")
    "."     '(find-file :which-key "Find file")
    "f r"   '(counsel-recentf :which-key "Recent files")
    "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
    "t t"   '(toggle-truncate-lines :which-key "Toggle truncate lines"))

(nvmap :prefix "SPC"
   "b b"   '(ibuffer :which-key "Ibuffer")
   "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
   "b k"   '(kill-current-buffer :which-key "Kill current buffer")
   "b n"   '(next-buffer :which-key "Next buffer")
   "b p"   '(previous-buffer :which-key "Previous buffer")
   "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
   "b K"   '(kill-buffer :which-key "Kill buffer"))

(nvmap :prefix "SPC"
    ;; Window splits
    "w c"   '(evil-window-delete :which-key "Close window")
    "w n"   '(evil-window-new :which-key "New window")
    "w s"   '(evil-window-split :which-key "Horizontal split window")
    "w v"   '(evil-window-vsplit :which-key "Vertical split window")
    ;; Window motions
    "w h"   '(evil-window-left :which-key "Window left")
    "w j"   '(evil-window-down :which-key "Window down")
    "w k"   '(evil-window-up :which-key "Window up")
    "w l"   '(evil-window-right :which-key "Window right")
    "w w"   '(evil-window-next :which-key "Goto next window"))

(use-package dashboard
  :ensure t
  :init 
  (setq dashboard-set-headings-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs is for aliens.")
  (setq dashboard-startup-banner "/home/isaac/.emacs.d/gnu.png")
  (setq dashboard-center-content nil)
  (setq dashboard-'((recents . 5)
                    (agenda . 5)
		    (bookmarks . 3)
		    (projects . 3)
		    (registers . 3)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book"))))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package all-the-icons-dired
  :ensure t)
(use-package dired-open
  :ensure t)
(use-package peep-dired
  :ensure t)

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
	    "d d" '(dired :which-key "Open dired")
	    "d j" '(dired-jump :which-key "Dired jump to current")
	    "d p" '(peep-dired :which-key "Peep-dired"))

(with-eval-after-load 'dired
;;(define-key dired-mode-map (kbd "M-p") 'peep-dired)
(evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
(evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
			    ("jpg" . "sxiv")
			    ("png" . "sxiv")
			    ("mkv" . "mpv")
			    ("mp4" . "mpv")))

(use-package recentf
:config
(recentf-mode))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package which-key
  :ensure t)
(which-key-mode)

(use-package doom-modeline
  :ensure t)
(doom-modeline-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(setq-default indent-tabs-mode nil)
(global-visual-line-mode t)

(use-package haskell-mode
  :ensure t)
(define-key haskell-mode-map [f5] (lambda () (interactive) (compile "stack build --fast")))
(define-key haskell-mode-map [f12] 'intero-devel-reload)

;; hindent
(use-package hindent
  :ensure t
  :init
      (add-hook 'haskell-mode-hook #'hindent-mode))
; Some general editor niceties
  (setq-default indent-tabs-mode nil)

(defun haskell-setup ()
"Setup variables for editing Haskell files."
(make-local-variable 'tab-stop-list)
(setq tab-stop-list (number-sequence 0 120 4))
(setq indent-line-function 'tab-to-tab-stop)

; Backspace: delete spaces up until a tab stop
(defvar my-offset 4 "My indentation offset. ")
(defun backspace-whitespace-to-tab-stop ()
    "Delete whitespace backwards to the next tab-stop, otherwise delete one character."
    (interactive)
    (let ((movement (% (current-column) my-offset))
	    (p (point)))
	(when (= movement 0) (setq movement my-offset))
	;; Account for edge case near beginning of buffer
	(setq movement (min (- p 1) movement))
	(save-match-data
	(if (string-match "[^\t ]*\\([\t ]+\\)$" (buffer-substring-no-properties (- p movement) p))
	    (backward-delete-char (- (match-end 1) (match-beginning 1)))
	    (call-interactively 'backward-delete-char)))))
(local-set-key (kbd "DEL") 'backspace-whitespace-to-tab-stop))
(add-hook 'haskell-mode-hook 'haskell-setup)

(global-prettify-symbols-mode 1)
(defun my-add-pretty-lambda ()
(setq prettify-symbols-alist
        '(
        ("\\" . 955) ; λ
        )))
(add-hook 'haskell-mode-hook 'my-add-pretty-lambda)

(custom-set-variables
'(haskell-process-type 'stack-ghci)
'(haskell-stylish-on-save t)
'(haskell-process-suggest-remove-import-lines t)
'(haskell-process-auto-import-loaded-modules t)
'(haskell-process-log t))
(eval-after-load 'haskell-mode '(progn
(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
(define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
(define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
(define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(let ((my-stack-path (expand-file-name "~/.local/bin")))
(setenv "PATH" (concat my-stack-path path-separator (getenv "PATH")))
(add-to-list 'exec-path my-stack-path))
(custom-set-variables '(haskell-tags-on-save t))

(use-package dockerfile-mode
:ensure t)

(use-package magit
  :ensure t)
(use-package magit-todos
  :ensure t
  :config
  (magit-todos-mode))

(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-directory "~/org/"
    org-agenda-files '("~/org/agenda.org")
    org-default-notes-file (expand-file-name "notes.org" org-directory)
    org-ellipsis " ▼ "
    org-log-done 'time
    org-journal-dir "~/org/journal/"
    org-journal-date-format "%B %d, %Y (%A) "
    org-journal-file-format "%Y-%m-%d.org"
    org-hide-emphasis-markers t)
(setq org-src-preserve-indentation nil
    org-src-tab-acts-natively t
    org-edit-src-content-indentation 0)

(use-package org-bullets :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; An example of how this works.
;; [[arch-wiki:Name_of_Page][Description]]
(setq org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
	'(("google" . "http://www.google.com/search?q=")
	("arch-wiki" . "https://wiki.archlinux.org/index.php/")
	("ddg" . "https://duckduckgo.com/?q=")
	("wiki" . "https://en.wikipedia.org/wiki/")))

(setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
	'((sequence
	"TODO(t)"           ; A task that is ready to be tackled
	"BLOG(b)"           ; Blog writing assignments
	"GYM(g)"            ; Things to accomplish at the gym
	"PROJ(p)"           ; A project that contains other tasks
	"VIDEO(v)"          ; Video assignments
	"WAIT(w)"           ; Something is holding up this task
	"|"                 ; The pipe necessary to separate "active" states and "inactive" states
	"DONE(d)"           ; Task has been completed
	"CANCELLED(c)" )))  ; Task has been cancelled

(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

(use-package toc-org
:ensure t
:commands toc-org-enable
:init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package projectile
:ensure t
:config
(projectile-global-mode 1))

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(nvmap :prefix "SPC"
    "e h"   '(counsel-esh-history :which-key "Eshell history")
    "e s"   '(eshell :which-key "Eshell"))
(use-package eshell-syntax-highlighting
:after esh-mode
:ensure t
:config
(eshell-syntax-highlighting-global-mode +1))
(setq eshell-aliases-file "~/.config/doom/aliases"
    eshell-history-size 5000
    eshell-buffer-maximum-lines 5000
    eshell-hist-ignoredups t
    eshell-scroll-to-bottom-on-input t
    eshell-destroy-buffer-when-process-dies t
    eshell-visual-commands'("bash" "htop" "ssh" "top" "zsh"))

(use-package vterm :ensure t)
 (setq shell-file-name "/bin/zsh"
    vterm-max-scrollback 5000)
(nvmap :prefix "SPC"
	"v t"   '(vterm :which-key "Vterm"))

(set-face-attribute 'default nil
            :font "JetBrains Mono NL 13"
	    :weight 'medium)
(set-face-attribute 'variable-pitch nil
            :font "JetBrains Mono Variable 11"
	    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
            :font "JetBrains Mono NL 13"
	    :weight 'medium)
(add-to-list 'default-frame-alist '(font . "JetBrains Mono NL 13"))

(use-package gruvbox-theme
    :ensure t)
(load-theme 'gruvbox t)
