;; Generated config

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a802c77b818597cc90e10d56e5b66945c57776f036482a033866f5f506257bca" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(mouse-wheel-progressive-speed nil)
 '(package-selected-packages
   (quote
    (leuven-theme zenburn-theme stickyfunc-enhance solarized-theme smart-mode-line-powerline-theme rainbow-delimiters neotree modern-cpp-font-lock material-theme magit lua-mode linum-relative highlight-numbers helm-projectile helm-project-persist helm-ls-git gruvbox-theme glsl-mode flycheck evil ethan-wspace darktooth-theme column-enforce-mode color-theme cmake-ide cmake-font-lock basic-theme base16-theme ample-theme adoc-mode ace-window)))
 '(safe-local-variable-values
   (quote
    ((flycheck-clang-language-standard . c++1y)
     (cmake-ide-build-dir . "../engine-build")))))

;; Do as much visual stuff as possible first

;; Use Hack font
(set-face-attribute 'default nil :height 90 :family "Iosevka Term")

;; Disable the menu, toolbar, and scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)

;; Some settings
(setq mouse-wheel-progressive-speed nil)

;; Initialize package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Theme

(load-theme 'leuven t)


;; Pretty up the header-line
;(set-face-attribute 'header-line nil :background "gray10"
;                                     :foreground (face-foreground 'default))


;; Configure the modeline

(require 'smart-mode-line)
(setq sml/theme 'light)
(sml/setup)

;; Set up whitespace handling
(require 'ethan-wspace)
(setq mode-require-final-newline nil)
(global-ethan-wspace-mode t)

;; Makefiles should work
(defun makefile-tabs-are-less-evil ()
  (setq ethan-wspace-errors (remove 'tabs ethan-wspace-errors)))
(add-hook 'makefile-mode-hook 'makefile-tabs-are-less-evil)

;; Ace-window
(require 'ace-window)
(setq aw-background nil)
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; Neotree

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open 1)
(setq neo-theme 'nerd)
(setq neo-mode-line-type 'neotree)
(setq neo-window-width 30)

;; Initialize helm

(require 'helm-config)
(setq helm-mode-fuzzy-match t)
(helm-mode 1)

(require 'projectile)
(projectile-global-mode)
(require 'helm-projectile)
(helm-projectile-on)

(setq projectile-completion-system 'helm)

;; Helm bindings + settings

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-p") 'helm-projectile)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

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
(require 'stickyfunc-enhance)

;; Flycheck
(require 'flycheck)

;; Turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

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

; (require 'cl)
; (require 'cmake-ide)
; (cmake-ide-setup)

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
(add-to-list 'auto-mode-alist '("\\.vs\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.fs\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq lua-indent-level 4)

;; Better C++ highlighting
(require 'modern-cpp-font-lock)
(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

;; Load asciidoc mode
(autoload 'adoc-mode "adoc-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.adoc$" . adoc-mode))
(add-to-list 'auto-mode-alist '("\\.asciidoc$" . adoc-mode))

;; API blueprint
(add-to-list 'auto-mode-alist '("\\.apib\\'" . apib-mode))

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

;; Diabolically yanked from
;; http://stackoverflow.com/questions/6497374/emacs-cc-mode-indentation-problem-with-c0x-enum-class/6550361#6550361

;; This hack fixes indentation for C++11's "enum class" in Emacs.

(defun inside-class-enum-p (pos)
  "Checks if POS is within the braces of a C++ \"enum class\"."
  (ignore-errors
    (save-excursion
      (goto-char pos)
      (up-list -1)
      (backward-sexp 1)
      (or (looking-back "enum\\s-+class\\s-+")
          (looking-back "enum\\s-+class\\s-+\\S-+\\s-*:\\s-*")))))

(defun align-enum-class (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      0
    (c-lineup-topmost-intro-cont langelem)))

(defun align-enum-class-closing-brace (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      '-
    '+))

(defun fix-enum-class ()
  "Setup `c++-mode' to better handle \"class enum\"."
  (add-to-list 'c-offsets-alist '(topmost-intro-cont . align-enum-class))
  (add-to-list 'c-offsets-alist
               '(statement-cont . align-enum-class-closing-brace)))

(add-hook 'c++-mode-hook 'fix-enum-class)

;; Javascript

;; My additions
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;; Horrendously stolen from
;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

;; use web-mode for .js and .jsx files

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

(setq web-mode-content-types-alist
  '(("jsx" . "\\.js[x]?\\'")))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2))
(add-hook 'web-mode-hook 'my-web-mode-hook)

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
