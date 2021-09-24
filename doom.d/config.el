;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Connor Braa"
      user-mail-address "connor.braa@gmail.com")

(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
            sql-mode         ; sqlformat is currently broken
            tex-mode         ; latexindent is broken
            latex-mode
            elixir-mode))    ; format-all doesn't work right in umbrella apps

;; I prefer SPC SPC as local leader, setting that does obscure
;; projectile-find-file a lil bit, so I move those under SPC f
(map! :leader "SPC" nil)
(setq doom-localleader-key "SPC SPC")
(map! :leader :desc "Find file in project" "fp" 'projectile-find-file)
(map! :leader :desc "Find file in other project" "fP" 'doom/find-file-in-other-project)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(load-theme 'doom-gruvbox t)
(set-face-foreground 'mouse "white")
(set-face-background 'mouse "white")

;; ;; projectile elixir project monorepo override
;; ;; stolen from @lccambiaghi
;; (after! projectile
;;   (setq projectile-project-root-files '("Dockerfile" "pyproject.toml"))
;;   (add-to-list 'projectile-project-root-files-bottom-up "mix.exs"))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(use-package evil-surround
  :config (global-evil-surround-mode 1))

(use-package dired
  :defer t
  :custom
  ;; Always delete and copy recursively
  (dired-recursive-deletes 'always)
  (dired-recursive-copies 'always)
  ;; Quickly copy/move file in Dired
  (dired-dwim-target t)
  ;; Move files to trash when deleting
  (delete-by-moving-to-trash t)
  ;; Load the newest version of a file
  (load-prefer-newer t))

(map! :n "-" 'dired-jump)
(map! :leader :desc "swap window between implementation and test" "tt" 'projectile-toggle-between-implementation-and-test)

;(setq vterm-always-compile-module t)
;(setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=no")
(add-hook 'vterm-mode-hook #'goto-address-mode)
(map! :map vterm-mode-map
      :n "P" #'vterm-yank
      :n "p" #'vterm-yank)

(defhydra hydra-smartparens ()
  "Smartparens"

  ("t" sp-transpose-sexp "transpose")
  ("y" sp-copy-sexp "yank")
  ("d" sp-kill-sexp "delete")

  ("s" sp-forward-slurp-sexp "slurp right")
  ("S" sp-backward-slurp-sexp "slurp left")

  ("b" sp-forward-barf-sexp "barf right")
  ("B" sp-backward-barf-sexp "barf left")

  ("v" sp-select-next-thing "next")
  ("V" sp-select-previous-thing "prev")

  ;; Wrapping
  ("w" (lambda (_) (interactive "P") (sp-wrap-with-pair "(")) "wrap")
  ("W" sp-unwrap-sexp "unwrap")

  ("(" (lambda (_) (interactive "P") (sp-wrap-with-pair "(")))
  ("{" (lambda (_) (interactive "P") (sp-wrap-with-pair "{")))
  ("'" (lambda (_) (interactive "P") (sp-wrap-with-pair "'")))
  ("\"" (lambda (_) (interactive "P") (sp-wrap-with-pair "\"")))

  ;; Movement
  ("j" sp-next-sexp)
  ("k" sp-backward-sexp)
  ("J" sp-down-sexp)
  ("K" sp-backward-up-sexp)

  ("l" sp-forward-symbol)
  ("h" sp-backward-symbol)

  ("^" sp-beginning-of-sexp)
  ("$" sp-end-of-sexp)
  ("q" nil))

(map! :leader :desc "smartparens keys" :nv "k" #'hydra-smartparens/body)

;; L33tCode

(map! (:leader (:desc "leetcode" :prefix ("l" . "leetcode")
                :desc "leetcode" :g "l" #'leetcode
                :desc "refresh" :g "r" #'leetcode-refresh
                :desc "submit" :g "s" #'leetcode-submit
                :desc "solve" :g "S" #'leetcode-solve-current-problem
                :desc "try" :g "t" #'leetcode-try
                :desc "preferred language" :g "p" #'leetcode-set-prefer-language
                :desc "problem" :g "P" #'leetcode-show-current-problem
                :desc "quit" :g "q" #'leetcode-quit)))

(setq leetcode-save-solutions t)
(setq leetcode-directory "~/workspace/leetcode")
(after! persp-mode
  (remove-hook 'persp-add-buffer-on-after-change-major-mode-filter-functions #'doom-unreal-buffer-p))

;; Bazel
(use-package! bazel
  :defer t
  :commands bazel-mode
  :init
  (add-to-list 'auto-mode-alist '("BUILD\\(\\.bazel\\)?\\'" . bazel-mode))
  (add-to-list 'auto-mode-alist '("WORKSPACE\\'" . bazel-mode))
  :config
  ;; disable format-all becuase it doesn't sort BUILD list variables
  (setq bazel-buildifier-before-save t)
  (appendq! +format-on-save-enabled-modes '(bazel-mode)));

;; Elixir-ls
;; project.el elixir project monorepo override
(defun elixir-project-override (dir)
  (let ((override (locate-dominating-file dir "mix.exs")))
    (if override
      (cons 'vc override)
      nil)))

(use-package! project
  :config
  (add-hook 'project-find-functions #'elixir-project-override))

(require 'eglot)
(add-to-list 'eglot-server-programs '(elixir-mode "~/ws/elixir-ls-2/language_server.sh"))
(add-hook! 'elixir-mode-hook 'eglot-ensure)

(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
(add-hook! 'elixir-mode-hook (modify-syntax-entry ?_ "w"))

;; jsonnet
(use-package! jsonnet-mode
  :defer t
  :config
  (set-electric! 'jsonnet-mode :chars '(?\n ?: ?{ ?}))
  (setq jsonnet-use-smie t))

; protobuf-mode
(defconst twospace
    '((c-basic-offset . 2)
      (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "protostyle" twospace t)))

(setq flycheck-protoc-import-path
      (list (concat (getenv "HOME") "/ws/credit_card/")
            (concat (getenv "HOME") "/ws/protobuf-elixir/src/")))

(setq gc-cons-threshold 120000000)
(setq read-process-output-max (* 4 1024 1024))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
