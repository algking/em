;; This is needed for Erlang mode setup
;;(server-start)
(setq erlang-root-dir "/usr/local/lib/erlang")
;(setq erlang-man-root-dir "/home/king/Tools/otp_doc_man_R15B/man")
;(setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.6.6/emacs" load-path))
;(setq load-path (cons "~/.emacs.d/elpa/erlang-20120612/" load-path))
;(setq exec-path (cons "/usr/local/lib/erlang/erts-5.9/bin" exec-path))
;(require 'erlang-start)
(require 'erlang-eunit)


;; (setq load-path (cons "~/.emacs.d/plugin/esense/esense-1.12" load-path))
;; (load-file "~/.emacs.d/plugin/esense/esense-1.12/esense.el")
;; (load-file "~/.emacs.d/plugin/esense/esense-1.12/esense-start.el")
;; (require 'esense-start)
;; (setq esense-indexer-program "~/.emacs.d/plugin/esense/esense-1.12/esense.sh")



;----------------------------------------------------------------------------------
;erlang wrangler erlang refactor
;-----------------------------------------------------------------------------------
   ;; (add-to-list 'load-path
   ;;              "/usr/local/lib/erlang/lib/wrangler-1.0/elisp")
   ;;        ;; (require 'wrangler)
   ;; (load-library "graphviz-dot-mode")
;; ;; ;----------------------------------------------------------------------------------


;distel配置
;------------------------------------------------------------------------------------
 ;; This is needed for Distel setup
(let ((distel-dir "~/.emacs.d/el-get/distel/elisp"))
   (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
   (setq load-path (append load-path (list distel-dir)))))
 (require 'distel)
 (distel-setup)
 ;; Some Erlang customizations
 (add-hook 'erlang-mode-hook
       (lambda ()
         ;; when starting an Erlang shell in Emacs, default in the node name
         (setq inferior-erlang-machine-options '("-sname" "emacs"))
         ;; add Erlang functions to an imenu menu
         (setq erlang-indent-level 4)
         (imenu-add-to-menubar "imenu")))


;; ================================company-distel===============
;; =============================================================
(add-to-list 'load-path "~/.emacs.d/el-get/company-distel")
;; (require 'auto-complete-distel)
;; (setq ac-sources '(append (distel-completions ) ac-sources))
(require 'company-distel)
(add-to-list 'company-backends 'company-distel)
;; (require 'company-distel-frontend)

(add-hook 'erlang-mode-hook 
          (lambda()
            (flymake-mode-on)
            (viper-mode)
            (turn-on-orgtbl)
            (turn-on-orgstruct)
))

 ;; A number of the erlang-extended-mode key bindings are useful in the shell too
 (defconst distel-shell-keys
   '(("\t"   erl-complete)
     ("\M-?"      erl-complete)
     ("\M-."      erl-find-source-under-point)
     ("\M-,"      erl-find-source-unwind)
     ("\M-*"      erl-find-source-unwind)
     )
   "Additional keys to bind when in Erlang shell.")
 (add-hook 'erlang-shell-mode-hook
       (lambda ()
       ;; add some Distel bindings to the Erlang shell
         (dolist
 (spec distel-shell-keys)
          (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

(setq derl-cookie "cookie")


;;; ---------------------
;;; erlang 缩进
;;; ---------------------

(defvar my-erlang-indent-level 0)


;----------------------------------------------------------------------------------
;erlang doc
;-----------------------------------------------------------------------------------
(defun my-erlang-insert-edoc ()
  "Insert edoc."
  (interactive)
  (save-excursion
    (when (re-search-forward "^\\s *-spec\\s +\\([a-zA-Z0-9_]+\\)\\s *(\\(\\(.\\|\n\\)*?\\))\\s *->[ \t\n]*\\(.+?\\)\\." nil t)
      (let* ((beg (match-beginning 0))
             (funcname (match-string-no-properties 1))
             (arg-string (match-string-no-properties 2))
             (retval (match-string-no-properties 4))
             (args (split-string arg-string "[ \t\n,]" t)))
        (when (re-search-forward (concat "^\\s *" funcname "\\s *(\\(\\(.\\|\n\\)*?\\))\\s *->") nil t)
          (let ((arg-types (split-string (match-string-no-properties 1) "[ \t\n,]" t)))
            (goto-char beg)
            (insert "%%-----------------------------------------------------------------------------\n")
            (insert "%% @doc\n")
            (insert "%% Your description goes here\n")
            (insert "%% @spec " funcname "(")
            (dolist (arg args)
              (insert (car arg-types) "::" arg)
              (setq arg-types (cdr arg-types))
              (when arg-types
                (insert ", ")))
            (insert ") ->\n")
            (insert "%%       " retval "\n")
            (insert "%% @end\n")
            (insert "%%-----------------------------------------------------------------------------\n")))))))
;----------------------------------------------------------------------------------

(global-set-key "\C-c\C-b"  'erlang-indent-current-buffer)

;----------------------------------------------------------------------------------
;flymake erlang
;----------------------------------------------------------------------------------

(load-file "~/.emacs.d/plugin/flymake/flymake-settings.el")
(require 'flymake-settings)


(require 'erlang-flymake)
(erlang-flymake-only-on-save)
(global-set-key (kbd "<f11>") 'flymake-start-syntax-check)
(global-set-key (kbd "<f12>") 'flymake-stop-all-syntax-check)
(global-set-key (kbd "<M-up>") 'flymake-goto-prev-error)
(global-set-key (kbd "<M-down>") 'flymake-goto-next-error)
(global-set-key [f5] 'flymake-display-err-menu-for-current-line)

;;flymake
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow1")))))
(setq flymake-no-changes-timeout 6000)
;;(:flymake-gui-warnings-enabled false)
(put 'set-goal-column 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
;----------------------------------------------------------------------------------
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;;; =========================== haskell mode ========================
;; (custom-set-variables
;;  '(haskell-mode-hook '(turn-on-haskell-indent)))

(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)
                               (flymake-mode)
                               (ghc-mode)
                               (auto-complete-mode)
                               ;; (ac-complete-ghc-mod)
                               (haskell-indent-mode)
                               ))

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
;; `haskell-indent', Guy Lapalme
;; Intelligent semi-automatic indentation. How to enable:

(add-hook 'inferior-haskell-mode-hook 'turn-on-ghci-completion)

;;; =====================php ==================

;(add-to-list 'load-path (expand-file-name "/home/algking/.emacs.d/plugin/jdee-sandbox/lisp"))
;; load autoloads file
;(load "jde-autoload")
;(require 'jde)
;(setq jde-check-version-flag nil)

;; (add-hook 'java-mode-hook
;;           '(lambda ()
;;              (semantic-add-system-include (getenv "JAVA_HOME") 'java-mode)))

;; (custom-set-variables ;; Инициализация переменных, указывающих, где
;;  '(cedet-java-jdk-root "/usr/lib/jvm/java-7-openjdk-i386/")
;;  '(semanticdb-javap-classpath '("/usr/lib/jvm/java-7-openjdk-i386/jre/lib/rt.jar"))
;;  )
;(require 'php+-mode)
;(php+-mode-setup)

;(add-to-list 'load-path (expand-file-name "/home/algking/.emacs.d/plugin/php-eldoc"))
; (require 'php-eldoc)
 ;; (add-hook 'php+-mode-hook
 ;; 	  '(lambda ()
 ;; 	     (set
 ;; 	      (make-local-variable 'eldoc-documentation-function)
 ;; 	      'php-eldoc-function)
 ;; 	     (eldoc-mode)))
