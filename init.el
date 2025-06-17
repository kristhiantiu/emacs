;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;; =============================
;; PACKAGE MANAGEMENT
;; =============================
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; =============================
;; UI SETTINGS
;; =============================
(load-theme 'tango-dark t)
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Line numbers
(global-display-line-numbers-mode t)

;; Auto-pair brackets
(electric-pair-mode 1)

;; =============================
;; JS2 MODE SETUP
;; =============================
(use-package js2-mode
  :mode "\\.js\\'"
  :hook (js2-mode . display-line-numbers-mode)
  :config
  (setq js-indent-level 4
        js2-basic-offset 4))

;; =============================
;; FILE TREE (NEOTREE)
;; =============================
(use-package neotree
  :bind ([f8] . neotree-toggle))

;; =============================
;; CHATGPT SHELL
;; =============================
(require 'auth-source)

(use-package chatgpt-shell
  :commands (chatgpt-shell)
  :init
  (setq chatgpt-shell-backend 'openai
        chatgpt-shell-openai-model "gpt-4"
        chatgpt-shell-openai-key
        (auth-source-pick-first-password :host "api.openai.com")))

(with-eval-after-load 'chatgpt-shell
  (setq chatgpt-shell-backend 'openai))
