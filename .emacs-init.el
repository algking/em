;;==============================================================
;;el-get
;;==============================================================
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/el-get/recipes")
;; (el-get 'sync)

;;==============================================================
;;prelude
;;==============================================================
;; (add-to-list 'load-path "~/.emacs.d/prelude-back/core")
;; (add-to-list 'load-path "~/.emacs.d/prelude-back/modules")
;; (add-to-list 'load-path "~/.emacs.d/prelude-back/elpa")
(require 'package)
;; (setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
;;                          ("melpa" . "http://1.15.88.122/melpa/")))
;; (setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
;;                          ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")

;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;                          ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;; (add-to-list 'package-archives
;;              '("marmalade". "http://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;; '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(setq prelude-theme 'solarized-light)
(load-file "~/.emacs.d/myprelude/init.el")

(setq prelude-flyspell nil)

(prelude-require-packages
 '(
   company
   ac-js2
   ;; git-gutter
   readline-complete
   auto-complete-clang
   ;; alpha
   auto-complete
   cl-lib
   dash
   deft
   ;; dired+
   edit-server
   etags-select
   find-file-in-project
   ;; flymake-cursor
   ;; flymake-php
   ;; flymake-phpcs
   ghc
   ghci-completion
   ;; gist
   ;; git-commit-mode
   magit
   ;; gitconfig-mode
   ;; gitignore-mode
   ;; git-rebase-mode
   haskell-mode
   helm
   projectile
   helm-projectile
   ignoramus
   imenu-anywhere
   inf-ruby
   ;; isearch+
   php-mode
   skewer-mode
   js2-mode
   js2-refactor
   tagedit
   ac-js2
   tern
   tern-auto-complete
   emmet-mode
   ac-emmet
   dash-at-point
   auto-complete-c-headers
   readline-complete
   yafolding
   ggtags
   ;; js-comint
   ;; logito
   ;; magit
   ;; melpa
   multiple-cursors
   org
   outline-magic
   ;; php+-mode
   ;; plantuml-mode
   ;; popup
   ;; popwin
   ;; psvn
   ;; session
   ;; shell-pop
   ;; skewer-mode
   ;; skewer-mode
   ;; slime
   ;;slime-js
   ;; slime-repl
   ;; smex
   ;; w3m
   multi-term
   web

   )  )
