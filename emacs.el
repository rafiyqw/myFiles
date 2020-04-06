;; emacs.el --- Emacs configuration file -*- lexical-binding: t -*-

;;; Optimization
;; built-in emacs package manager
(setq package-enable-at-startup nil)

;; Resize frame
(setq frame-inhibit-implied-resize t)

;; Startup screen
(setq inhibit-startup-screen t
      initial-scratch-message nil
      initial-major-mode 'fundamental-mode)

;; Graphical elements 
(when (display-graphic-p)
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
  (tool-bar-mode -1))

;; Dialog box
(setq use-file-dialog nil)


;;; Setting
;; Frame title
(setq frame-title-format "%b [%m]")

;; Directory
(defconst history-dir (concat user-emacs-directory "history/"))
(defconst etc-dir (concat user-emacs-directory "etc/"))
(defconst lisp-dir (concat user-emacs-directory "lisp/"))

;; Indentation
(setq-default indent-tabs-mode nil
              tab-width 4)

;; Feedback
(setq echo-keystrokes 1e-6
      ring-bell-function #'ignore
      visible-bell t)

(fset #'yes-or-no-p #'y-or-n-p)

;; Scrolling
(setq hscroll-margin 2
      hscroll-step 1
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t
      auto-window-vscroll nil)

;; utf-8
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;;; Package manager
;; Detect package modifications
(if (and (executable-find "watchexec")
         (executable-find "python3"))
    (setq straight-check-for-modifications '(watch-files find-when-checking))
  (setq straight-check-for-modifications
        '(find-at-startup find-when-checking)))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

;; local package
(defmacro use-feature (name &rest args)
  (declare (indent defun))
  `(use-package ,name
     :straight nil
     ,@args))

;;; Built-in packages
;; org-mode
(use-feature org
  :defer 5)

;;; Backup files
(use-feature files
  :init
  (setq auto-save-list-file-name (concat history-dir "autosave")
        backup-directory-alist '(("." . ,(concat history-dir "backup/")))
        make-backup-files nil
        backup-by-copying t
        create-lockfiles nil
        auto-save-default nil
        find-file-visit-truename t
        find-file-suppress-same-file-warnings t
        confirm-kill-emacs #'y-or-n-p
        ))

;; Display line number
(use-feature display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode))

;; Highlight line
(use-feature hl-line
  :hook
  (prog-mode . hl-line-mode))

;; Selection
(use-feature delsel
  :init
  (delete-selection-mode +1))

;; simple.el
(use-feature simple
  :init
  (setq shift-select-mode nil
        column-number-mode 1))

;; Custom edit
(use-feature cus-edit
  :defer 5
  :config
  (setq custom-file (concat etc-dir "custom.el")))

;; Advanced command
(use-feature novice
  :init
  (setq disabled-command-function nil))

;; History
(use-feature recentf
  :init
  (setq recentf-save-file (concat history-dir "recentf")
        recentf-auto-cleanup 'never)
  :config
  (recentf-mode 1))

(use-feature savehist
  :defer 1
  :config
  (setq savehist-file (concat history-dir "savehist")
        savehist-save-minibuffer-history t
        savehist-autosave-interval nil
        savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
  (savehist-mode 1))

(use-feature saveplace
  :defer 1
  :config
  (setq save-place-file (concat history-dir "saveplace"))
  (save-place-mode 1))

(use-feature desktop
  :defer 1
  :config
  (setq desktop-dirname (concat etc-dir "desktop")
        desktop-base-file-name "autosave"
        desktop-base-lock-name "autosave-lock"))
;;vc-hooks.el
;; vc-follow-symlinks t
