;; Ensure use-package is initialized
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; from .emacs
(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :hook (js2-mode . display-line-numbers-mode))

;; (global-display-line-numbers-mode)

;; auto-add closing parenthesis
(electric-pair-mode 1)


(setq js-indent-level 4)
(setq js2-basic-offset 4)

(load-theme 'tango-dark t)


;; remove menu bar, tool bar, scroll bar
(menu-bar-mode -1)
(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(global-set-key [f8] 'neotree-toggle)

;; --e from .emacs



;; file tree
(use-package neotree
  :ensure t)


;; Chat GPT
(require 'auth-source)

(use-package chatgpt-shell
  :ensure t
  :commands (chatgpt-shell)
  :init
  ;; Provide a default backend + model before loading
  (setq chatgpt-shell-backend 'openai)
  (setq chatgpt-shell-openai-model "gpt-4")
  (setq chatgpt-shell-openai-key
        (auth-source-pick-first-password :host "api.openai.com")))

;; Just in case chatgpt-shell overrides it internally
(with-eval-after-load 'chatgpt-shell
  (setq chatgpt-shell-backend 'openai))


