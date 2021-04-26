(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(use-package general
   :ensure t
   :config
   (general-evil-setup t))
(nvmap :keymaps 'override :prefix "SPC"
    "SPC"   '(counsel-M-x :which-key "M-x")
    "c c"   '(compile :which-key "Compile")
    "c C"   '(recompile :which-key "Recompile")
    "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
    "t t"   '(toggle-truncate-lines :which-key "Toggle truncate lines"))
(nvmap :keymaps 'override :prefix "SPC"
    "m *"   '(org-ctrl-c-star :which-key "Org-ctrl-c-star")
    "m +"   '(org-ctrl-c-minus :which-key "Org-ctrl-c-minus")
    "m ."   '(counsel-org-goto :which-key "Counsel org goto")
    "m e"   '(org-export-dispatch :which-key "Org export dispatch")
    "m f"   '(org-footnote-new :which-key "Org footnote new")
    "m h"   '(org-toggle-heading :which-key "Org toggle heading")
    "m i"   '(org-toggle-item :which-key "Org toggle item")
    "m n"   '(org-store-link :which-key "Org store link")
    "m o"   '(org-set-property :which-key "Org set property")
    "m t"   '(org-todo :which-key "Org todo")
    "m x"   '(org-toggle-checkbox :which-key "Org toggle checkbox")
    "m B"   '(org-babel-tangle :which-key "Org babel tangle")
    "m I"   '(org-toggle-inline-images :which-key "Org toggle inline imager")
    "m T"   '(org-todo-list :which-key "Org todo list")
    "o a"   '(org-agenda :which-key "Org agenda")
    )

(use-package dashboard
:ensure t
:init      ;; tweak dashboard config before loading it
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-banner-logo-title "Emacs Is For Aliens.")
;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
(setq dashboard-startup-banner "~/.emacs.d/gnu.png")  ;; use custom image as banner
(setq dashboard-center-content nil) ;; set to 't' for centered content
(setq dashboard-items '((recents . 5)
                        (agenda . 5 )
                        (bookmarks . 3)
                        (projects . 3)
                        (registers . 3)))
:config
(dashboard-setup-startup-hook)
(dashboard-modify-heading-icons '((recents . "file-text")
                            (bookmarks . "book"))))

(use-package projectile
   :ensure t
   :config
      (projectile-global-mode 1))

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
(setq evil-collection-mode-list '(dashboard dired ibuffer))
(evil-collection-init))
(use-package evil-tutor
    :ensure t)

(nvmap :prefix "SPC"
    "b b"   '(ibuffer :which-key "Ibuffer")
    "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
    "b k"   '(kill-current-buffer :which-key "Kill current buffer")
    "b n"   '(next-buffer :which-key "Next buffer")
    "b p"   '(previous-buffer :which-key "Previous buffer")
    "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
    "b K"   '(kill-buffer :which-key "Kill buffer"))

(delete-selection-mode t)

(set-face-attribute 'default nil
	:font "JetBrains Mono NL 13"
	:weight 'medium)
(set-face-attribute 'variable-pitch nil
	:font "JetBrains Mono Variable 12"
	:weight 'medium)
(set-face-attribute 'fixed-pitch nil
	:font "JetBrains Mono NL 13"
	:weight 'medium)
(add-to-list 'default-frame-alist '(font . "JetBrains Mono NL 13"))

(use-package all-the-icons)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package emojify
  :ensure t
  :hook (after-init . global-emojify-mode))

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

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default display-line-numbers 'relative)
(setq-default indent-tabs-mode nil)

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
    "."     '(find-file :which-key "Find file")
    "f f"   '(find-file :which-key "Find file")
    "f r"   '(counsel-recentf :which-key "Recent files")
    "f s"   '(save-buffer :which-key "Save file")
    "f u"   '(sudo-edit-find-file :which-key "Sudo find file")
    "f y"   '(dt/show-and-copy-buffer-path :which-key "Yank file path")
    "f C"   '(copy-file :which-key "Copy file")
    "f D"   '(delete-file :which-key "Delete file")
    "f R"   '(rename-file :which-key "Rename file")
    "f S"   '(write-file :which-key "Save file as...")
    "f U"   '(sudo-edit :which-key "Sudo edit file"))

(use-package recentf
  :ensure t
  :config
  (recentf-mode))
(use-package sudo-edit
   :ensure t) ;; Utilities for opening files with sudo
(defun dt/show-and-copy-buffer-path ()
  "Show and copy the full path to the current file in the minibuffer."
  (interactive)
  ;; list-buffers-directory is the variable set in dired buffers
  (let ((file-name (or (buffer-file-name) list-buffers-directory)))
    (if file-name
        (message (kill-new file-name))
      (error "Buffer not visiting a file"))))
(defun dt/show-buffer-path-name ()
  "Show the full path to the current file in the minibuffer."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))

(use-package counsel
  :ensure t
  :after ivy
  :config (counsel-mode))
(use-package ivy
  :ensure t
  :defer 0.1
  :diminish
  :bind
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))
(use-package ivy-rich
  :ensure t
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer)
  (ivy-rich-mode 1)) ;; this gets us descriptions in M-x.
(use-package swiper
  :ensure t
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(setq ivy-initial-inputs-alist nil)

(use-package magit
  :ensure t)

(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-directory "~/Org/"
      org-agenda-files '("~/Org/agenda.org")
      org-default-notes-file (expand-file-name "notes.org" org-directory)
      org-ellipsis " ▼ "
      org-log-done 'time
      org-journal-dir "~/Org/journal/"
      org-journal-date-format "%B %d, %Y (%A) "
      org-journal-file-format "%Y-%m-%d.org"
      org-hide-emphasis-markers t)
(setq org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

(use-package org-bullets
   :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

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

(use-package org-tempo
   :ensure nil)

(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

(use-package toc-org
  :ensure t
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(setq org-blank-before-new-entry (quote ((heading . nil)
                                         (plain-list-item . nil))))

(use-package ox-man
  :ensure nil)

(use-package perspective
  :ensure t
  :bind
  ("C-x C-b" . persp-list-buffers)   ; or use a nicer switcher, see below
  :config
  (persp-mode))

(nvmap :prefix "SPC"
       "r c"   '(copy-to-register :which-key "Copy to register")
       "r f"   '(frameset-to-register :which-key "Frameset to register")
       "r i"   '(insert-register :which-key "Insert register")
       "r j"   '(jump-to-register :which-key "Jump to register")
       "r l"   '(list-registers :which-key "List registers")
       "r n"   '(number-to-register :which-key "Number to register")
       "r r"   '(counsel-register :which-key "Choose a register")
       "r v"   '(view-register :which-key "View a register")
       "r w"   '(window-configuration-to-register :which-key "Window configuration to register")
       "r +"   '(increment-register :which-key "Increment register")
       "r SPC" '(point-to-register :which-key "Point to register"))

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(nvmap :prefix "SPC"
       "e h"   '(counsel-esh-history :which-key "Eshell history")
       "e s"   '(eshell :which-key "Eshell"))

(use-package eshell-syntax-highlighting
  :ensure t
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package doom-themes
:ensure t)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(load-theme 'doom-gruvbox t)

(use-package doom-modeline
    :ensure t
    :config
       (setq doom-modelin-major-mode-icon t))
(doom-modeline-mode 1)

(use-package which-key
   :ensure t)
(which-key-mode)
