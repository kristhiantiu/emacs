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
;; STARTUP                       ;; Comment below if need default emacs startup
;;==============================
(setq inhibit-startup-screen t)
(add-hook 'emacs-startup-hook
          (lambda ()
            (bookmark-bmenu-list)
            (switch-to-buffer "*Bookmark List*")))

;; =============================
;; VTERM
;; =============================
;; Install and configure vterm
(use-package vterm
  :ensure t
  :hook (vterm-mode . (lambda () (display-line-numbers-mode 0))))

;; =============================
;; Autocorrect
;; =============================
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)) ;; or use prog-mode hook if you prefer


;; =============================
;; FLYCHECK - show error messages inline
;; =============================
(setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

;; =============================
;; PRETTIERJS SETUP
;; =============================
(use-package prettier-js :ensure t)


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
;; WEB MODE SETUP
;; =============================
(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.jsx\\'" "\\.tsx\\'")
  :hook ((web-mode . my/web-mode-setup)))

(defun my/web-mode-setup ()
  "Custom setup for web-mode with LSP, company, and formatting."
  (setq web-mode-enable-auto-quoting nil) ;; Avoid unwanted quotes
  (display-line-numbers-mode 1)
  (company-mode 1)
  (lsp) ;; Starts language server
  (prettier-js-mode 1)) ;; Format on save

;; Optional: additional settings for indentation, etc.
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; =============================
;; ASTRO MODE SETUP
;; =============================
(use-package web-mode
  :ensure t
  :mode ("\\.astro\\'")
  :config
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "astro" (file-name-extension buffer-file-name))
                (lsp)
                (prettier-js-mode 1)))))

;; =============================
;; TS MODE SETUP
;; =============================
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :hook ((typescript-mode . lsp)
         (typescript-mode . company-mode)))

;; =============================
;; LSP MODE SETUP
;; =============================

(use-package lsp-mode
  :ensure t
  :hook ((js2-mode . lsp))         ;; IMPORTANT : npm install -g typescript typescript-language-server
  :commands lsp
  :config
  (setq lsp-enable-snippet t
        lsp-completion-provider :capf))

;; =============================
;; COMPANY MODEE SETUP
;; =============================

(use-package company
  :hook (js2-mode . company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

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

;; =============================
;; ORG MODE
;; =============================
(require 'org-tempo) ;; key bindings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(chatgpt-shell company js2-mode lsp-ui neotree prettier-js
		   typescript-mode web-mode web-mode-edit-element
		   yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
