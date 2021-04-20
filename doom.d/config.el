;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Connor Braa"
      user-mail-address "connor.braa@gmail.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(load-theme 'doom-gruvbox-light t)
(set-face-foreground 'mouse "white")
(set-face-background 'mouse "white")

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

(map! (:leader (:desc "leetcode" :prefix "l"
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
