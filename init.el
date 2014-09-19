
;;==============================================================
;;el-get 
;;==============================================================
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/el-get/recipes")
;; (el-get 'sync)

;;==============================================================
;;prelude 
;;==============================================================
(load-file "~/.emacs.d/prelude-back/init.el")
(require 'package)
(add-to-list 'package-archives
             '("marmalade". "http://marmalade-repo.org/packages/") t)

(prelude-require-packages
 '(
   company
   ac-js2
   alpha
   auto-complete
   cl-lib
   company
   dash
   deft
   dired+
   edit-server
   etags-select
   find-file-in-project
   flymake-cursor
   flymake-php
   flymake-phpcs
   ghc
   ghci-completion
   gist
   git-commit-mode
   gitconfig-mode
   gitignore-mode
   git-rebase-mode
   haskell-mode
   helm
   helm-projectile
   ignoramus
   imenu-anywhere
   inf-ruby
   isearch+
   js2-mode
   js2-refactor
   js-comint
   logito
   ;; magit
   ;; melpa
   multiple-cursors
   org
   outline-magic
   php+-mode
   php-mode
   plantuml-mode
   popup
   ;; popwin
   psvn
   session
   ;; shell-pop
   skewer-mode
   skewer-mode
   slime
   ;;slime-js
   slime-repl
   smex
   w3m
   web

   )  )
