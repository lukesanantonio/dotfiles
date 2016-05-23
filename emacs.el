;; Do as much visual stuff as possible first

;; Disable the menu, toolbar, and scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)

(custom-set-faces '(default ((t (:family "Iosevka Term")))))

;; Initialize package.el
(require 'package)
(add-to-list 'load-path "~/.emacs.d/packages/powerline")
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Set up powerline

(require 'powerline)
(setq powerline-default-separator 'utf-8)
(powerline-default-theme)

;; Theme

(require 'zenburn-theme)
(load-theme 'zenburn t)

;; Set up whitespace handling
(require 'ethan-wspace)
(setq mode-require-final-newline nil)
(global-ethan-wspace-mode t)

;; Neotree

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open 1)
(setq neo-theme 'nerd)
(setq neo-mode-line-type 'neotree)
(setq neo-window-width 30)

;; Initialize helm

(require 'helm-config)
(require 'helm-ls-git)

;; Helm bindings + settings

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-p") 'helm-browse-project)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

(setq helm-M-x-fuzzy-match t)
(setq helm-ls-git-fuzzy-match t)
(setq helm-find-files-fuzzy-match t)
(setq helm-ff-auto-update-initial-value t)

;; Magit
(require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-magit-file-mode t)

;; Evil mode
(require 'evil)
(evil-mode t)

;; Neat semantic stuff
(semantic-mode t)
(global-semantic-stickyfunc-mode t)
(global-semantic-highlight-func-mode t)

;; Flycheck
(require 'flycheck)
(global-flycheck-mode t)

(require 'cl)
(require 'cmake-ide)
(cmake-ide-setup)

;; Other

;; We like our eighty column limit
(setq-default fill-column 80)

;; Enable auto filling just comments when programming
(add-hook 'prog-mode-hook 'turn-on-auto-fill
          (lambda () (setq comment-auto-fill-only-comments t)))

;; Enable it for text mode as well
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; What a crazy default!
(setq-default sentence-end-double-space nil)

;; C / C++ Style
(setq c-default-style "bsd" c-basic-offset 2)
;; This should really be set by default
(setq evil-shift-width 2)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(global-hl-line-mode t)

(require 'column-enforce-mode)
(add-hook 'prog-mode-hook 'column-enforce-mode)
(add-hook 'git-commit-setup-hook 'column-enforce-mode)

(require 'highlight-numbers)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(require 'linum-relative)
(add-hook 'prog-mode-hook 'linum-relative-mode)
(setq linum-relative-current-symbol "")
(setq linum-relative-format "%4s ")

(require 'glsl-mode)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

;; Generated config

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((flycheck-clang-language-standard . c++1y)
     (cmake-ide-build-dir . "../engine-build")))))
