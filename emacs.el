;; Do as much visual stuff as possible first

;; Use Iosevka font and make it a little larger.
(set-face-attribute 'default nil :height 120 :family "Iosevka Term")

;; Disable the menu, toolbar, and scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)

;; Initialize package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)



;; Theme

(require 'zenburn-theme)
(load-theme 'zenburn t)

;; Configure the modeline

(require 'smart-mode-line)
(setq sml/theme 'powerline)
(sml/setup)

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
(setq helm-buffers-fuzzy-matching t)

;; Magit
(require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-magit-file-mode t)

;; This should really be set by default
;(setq evil-shift-width 2)

;; Evil mode
;(require 'evil-leader)
;(global-evil-leader-mode)

;(evil-leader/set-key "p" 'helm-browse-project)
;(evil-leader/set-key "x" 'helm-find-files)
;(evil-leader/set-key "n" 'neotree-toggle)

;(require 'evil)
;(evil-mode t)

;; Neat semantic stuff
(semantic-mode t)
(global-semantic-stickyfunc-mode t)
(global-semantic-highlight-func-mode t)

;; Flycheck
(require 'flycheck)
(global-flycheck-mode t)

;; CMake stuff
(require 'cmake-mode)
(setq auto-mode-alist
          (append
           '(("CMakeLists\\.txt\\'" . cmake-mode))
           '(("\\.cmake\\'" . cmake-mode))
           auto-mode-alist))

(require 'cmake-font-lock)
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

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

(autoload 'glsl-mode "glsl-mode" "GLSL editing mode." t)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq lua-indent-level 4)

;; Viciously stolen from: http://stackoverflow.com/questions/3312114
;; "how-to-tell-emacs-to-open-h-file-in-c-mode"

;; function decides whether .h file is C or C++ header, sets C++ by default
;; because there's more chance of there being a .h without a .cc than a .h
;; without a .c (ie. for C++ template files)
(defun c-c++-header ()
  "sets either c-mode or c++-mode, whichever is appropriate for header"
  (interactive)
  (let ((c-file (concat (substring (buffer-file-name) 0 -1) "c")))
    (if (file-exists-p c-file)
        (c-mode)
      (c++-mode))))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-c++-header))

;; and if that doesn't work, a function to toggle between c-mode and c++-mode
(defun c-c++-toggle ()
  "toggles between c-mode and c++-mode"
  (interactive)
  (cond ((string= major-mode "c-mode")
         (c++-mode))
        ((string= major-mode "c++-mode")
         (c-mode))))

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
