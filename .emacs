;; (load-file "~/.emacs.d/plugin/cedet-bzr/trunk/cedet-devel-load.el")
(load-file "~/.emacs.d/.emacs-init.el")
(load-file "~/.emacs.d/.emacs-myfun.el")
(load-file "~/.emacs.d/.emacs-c.el")
;;==============================================================
;; Load CEDET semantic xcscope
;;==============================================================
;; ;; ;; Add further minor-modes to be enabled by semantic-mode.
;; ;; ;; See doc-string of `semantic-default-submodes' for other things
;; ;; ;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;; ;; ;; ;; ;; Enable Semantic
(semantic-mode 1)
;; (setq enable-recursive-minibuffers t)
;; (load-file "~/.emacs.d/plugin/xcscope/xcscope.el")
;; (require 'xcscope)
;;==============================================================
;; 自动备份
;;==============================================================
(setq
 backup-by-copying t ; 自动备份

 backup-directory-alist

 '(("." . "~/.saves")) ; 自动备份在目录"~/.saves"下

;   delete-old-versions nil ; 自动删除旧的备份文件

   kept-new-versions 6 ; 保留最近的6个备份文件

   kept-old-versions 2 ; 保留最早的2个备份文件

   version-control t) ; 多次备份 ;
;;==============================================================
;; edit
;;==============================================================
(global-set-key (kbd "C-c SPC" ) 'easy-mark)
(global-set-key (kbd "s-u" ) 'scroll-up-line)
(global-set-key (kbd "s-d" ) 'scroll-down-line)

;;==============================================================
;; helm
;;==============================================================
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c j") 'helm-occur)
(global-set-key (kbd "C-c m") 'helm-do-grep)


(global-set-key [f4] 'compile)
(global-set-key (kbd "C-c 3") 'toggle-viper-mode)
(setq viper-mode t)
(require 'viper)

(setq global-hl-line-sticky-flag nil)
(global-hl-line-mode 0)
(setq stack-trace-on-error t)
;;==============================================================
;;erlang 配置
;;==============================================================
;; (load-file "~/.emacs.d/.emacs-erlang.el")
(add-to-list 'load-path "~/.emacs.d")
(autoload 'erlang-mode ".emacs-erlang.el" nil t)


;;==============================================================
;;java 配置
;;==============================================================
(add-to-list 'load-path "~/.emacs.d/plugin/jdee-2.4.1/lisp/")
(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist
      (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))
;; ;; (autoload 'java-mode ".emacs-java.el" nil t )
;; ;; (add-hook 'java-mode-hook
;; ;;           '(lambda () 
;; ;;              (semantic-add-system-include (getenv "JAVA_HOME") 'java-mode)))

;; (custom-set-variables ;; Инициализация переменных, указывающих, где
;;  '(cedet-java-jdk-root (getenv "JAVA_HOME"))
;;  '(semanticdb-javap-classpath '("/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/jre/lib/rt.jar"))
;;  )

;;==============================================================
;;clojure 配置
;;==============================================================
;
(defun my-clojure-config () 
  (add-hook 'clojure-mode-hook 'cider-mode)
  ;; (add-hook 'cider-repl-mode-hook 'company-mode)
  ;; (add-hook 'cider-mode-hook 'company-mode)
  ;; (add-hook 'cider-repl-mode-hook 'paredit-mode)
  (require 'ac-cider)
  ;; (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  ;; (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
  ;; (auto-complete-mode -1)
  )
(eval-after-load "clojure-mode" '(my-clojure-config))


;;==============================================================
;;flymake 
;;==============================================================
(custom-set-faces
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 113 :width normal))))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow1"))))
 '(fringe ((t nil))))
;; (load-file "~/.emacs.d/plugin/flymake/flymake-shell/flymake-shell.el")
;; (require 'flymake-shell)
;; (add-hook 'sh-mode-hook 'flymake-shell-load)

;;==============================================================
;; mini-buffer buffer complete/switch window switch 
;;==============================================================
(icomplete-mode 1)
(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-word)
(global-set-key (kbd "C-c y") 'ido-switch-buffer)
(fset 'yes-or-no-p 'y-or-n-p)
;;; =============imenu=================
(global-set-key  (kbd "C-c i") 'helm-semantic-or-imenu)
(global-set-key (kbd "C-u") 'scroll-down-command) 
;; (require 'eide)
;; (eide-start)
(global-set-key (kbd "M-k") 'qiang-copy-line)
(global-set-key [f8] 'grep-find)
(global-set-key [f9] 'grep)
;;; ===========================================================
;;代码折叠
;;; ===========================================================
;(load-file "~/.emacs.d/el-get/semantic-tag-folding/semantic-tag-folding.el")
(global-set-key [f6] 'outline-minor-mode)
(setq outline-minor-mode-prefix [(control o)])
 ;; (add-hook 'outline-mode-hook
 ;;           (lambda ()
 ;;             (require 'outline-cycle)))

(eval-after-load "hideshow" '(progn 
                                   (define-key hs-minor-mode-map (kbd "C-o C-b")	      'hs-hide-block)
                                   (define-key hs-minor-mode-map (kbd "C-o C-s")	      'hs-show-block)
                                   (define-key hs-minor-mode-map (kbd "C-o C-q")    'hs-hide-all)
                                   (define-key hs-minor-mode-map (kbd "C-o C-a")    'hs-show-all)
                                   (define-key hs-minor-mode-map (kbd "C-o C-l")	      'hs-hide-level)
                                   (define-key hs-minor-mode-map (kbd "C-o C-o")	      'hs-toggle-hiding)
                                   ))

(add-hook 'erlang-mode-hook 'outline-minor-mode)
(add-hook 'outline-minor-mode-hook
          (lambda ()
             (require 'outline-magic)
             (define-key outline-minor-mode-map [(C-tab)] 'outline-cycle)))
;; ============================================================
;;  窗口管理
;; ============================================================
;;; 绑定快捷键分成四个窗口
;;; 清单 1. 四窗口模式的创建绑定到一个组合键上去
;; +----------+-----------+
;; |          |           |
;; |          |           |
;; +----------+-----------+
;; |          |           |
;; |          |           |
;; +----------+-----------+
(global-set-key (kbd "C-x 4 4") 'split-window-4)
(global-set-key (kbd "C-x 4 c") (quote change-split-type-3))

;;; ===========================================================
;;;  org-mode
;;; ===========================================================
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-x ,") 'org-time-stamp)
(global-set-key (kbd "C-c c") 'org-capture-string)
(global-set-key (kbd "C-c x") 'org-capture)
(global-set-key (kbd "C-c 2") 'org-sparse-tree)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)
                                        ; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
    (dot . t)
    (ditaa . t)
    (R . t)
    (python . t)
    (ruby . t)
    (gnuplot . t)
    (clojure . t)
    (sh . t)
    (ledger . t)
    (org . t)
    (plantuml . t)
    (latex . t)))
(setq org-confirm-babel-evaluate nil)
(setq org-image-actual-width nil)
(setq org-image-actual-width 10)
;; => always resize inline images to 300 pixels
(setq org-image-actual-width '(400))
;; => if there is a #+ATTR.*: width="200", resize to 200,
;; otherwise resize to 400

;;; ===========================================================
;; iimage mode
;;; ===========================================================
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
;;; ==========================================
;;(add-to-list 'load-path "~/.emacs.d/plugin/plugin")
;;(load-file "~/.emacs.d/plugin/sr-speedbar.el")
;; (load "~/.emacs.d/plugin/sr-speedbar")
;; (require 'sr-speedbar)
;; (global-set-key (kbd "M-2") 'sr-speedbar-toggle)
                                        ;(global-set-key (kbd "M-2") 'speedbar)

;; =============================================================
;;  auto-complete company-mode
;; =============================================================
(dolist (hook '(scheme-mode-hook
               ))
        (add-hook hook 'company-mode))

(eval-after-load 'company '(progn (define-key company-mode-map (kbd "M-1") 'company-complete)))
;; (global-set-key (kbd "M-[") 'company-complete-common)
;; (global-set-key (kbd "M-1") 'company-manual-begin)
;; (global-set-key (kbd "M-?") 'company-complete)
;; (global-set-key (kbd "M-1") 'company-select-next)
(require 'auto-complete-config)
;; (ac-config-default)
(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
(add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
;; (global-auto-complete-mode nil)
(define-key ac-mode-map (kbd "M-1") 'auto-complete)
(define-key ac-completing-map (kbd "\C-s")  'ac-isearch)

(dolist (hook '(emacs-lisp-mode-hook
                c-mode-common-hook
                ruby-mode-hook
                css-mode-hook))
  (add-hook hook 'auto-complete-mode))
                
;; =============================================================
;;  代码跳转
;; =============================================================
;;(local-set-key "\C-cR" 'yc/symref)
;;  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
;; (local-set-key "\C-c\C-j" 'yc/goto-func-any)
(global-set-key [(super \.)]  'yc/goto-func)
(global-set-key [(super \,)] 'yc/return-func)
(global-set-key [(meta \,)] 'pop-tag-mark)

;; (define-key c++-mode-map [(meta \.)] 'yc/goto-func)
;; (define-key c++-mode-map [(meta \,)] 'yc/return-func)
;; (define-key c-mode-map [(meta \.)] 'yc/goto-func)
;; (define-key c-mode-map [(meta \,)] 'yc/return-func)
                                        ;(local-set-key [M-S-f12] 'yc/return-func)
                                        ;  (local-set-key (kbd "C-x SPC") 'yc/store-mru-tag)

;; =============================================================
;;  multi-shell mode
;; =============================================================
(load-file "~/.emacs.d/plugin/muti-shell/multi-shell.el")
;; (require 'multi-shell)
(setq multi-shell-command "/bin/bash")
(global-set-key  (kbd "M-3") 'multi-shell-prev)
(global-set-key  (kbd "M-4") 'multi-shell-next)
(global-set-key [f7] 'multi-shell-new)

;; =============================================================
;;  code folding
;; =============================================================
(define-key yafolding-mode-map (kbd "C-c C-q") 'yafolding-toggle-all)
(define-key yafolding-mode-map (kbd "C-c C-o") 'yafolding-toggle-element)
(define-key yafolding-mode-map (kbd "C-c C-e") 'yafolding-hide-element)
(dolist (hook (list 'html-mode-hook
                    'php-mode-hook
))
  (add-hook hook 'yafolding-mode)
  )

;; =============================================================
;;  git magit git-gutter
;; =============================================================
(global-git-gutter-mode t)
(git-gutter:linum-setup)

;; =============================================================
;;  shell complete
;; =============================================================
(add-to-list 'ac-modes 'erlang-shell-mode)
;; (load-file "~/.emacs.d/plugin/readline-complete.el")
(setq explicit-shell-file-name "bash")
(setq explicit-bash-args '("-c" "export EMACS=; stty echo; bash"))
(setq comint-process-echoes t)
(require 'readline-complete)
(add-to-list 'ac-modes 'shell-mode)
(add-hook 'shell-mode-hook 'ac-rlc-setup-sources)

(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)
                (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
                (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
                ))

(define-key prelude-mode-map (kbd "C-c t") 'multi-term)
(define-key prelude-mode-map (kbd  "\C-ce" ) 'dash-at-point)
;; (define-key prelude-mode-map (kbd  "\C-c" ) 'dash-at-point)
(global-set-key (kbd "M-[")  'multi-term-prev)
(global-set-key (kbd "M-]")  'multi-term-next)
;; ========================================

;; (desktop-save-mode 1)
;(require 'session)
  ;; (add-hook 'after-init-hook
  ;;         'session-initialize)
 ;; (load " ~/.emacs.d/plugin/moz/moz.el")
;; (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
;; (add-hook 'javascript-mode-hook 'javascript-custom-setup)
;; (defun javascript-custom-setup ()
;;   (moz-minor-mode 1))
;;; ============================================================
;;  table mode
;;; ============================================================
;; (load-file "~/.emacs.d/plugin/table.el")
;; (require 'table)
;; (add-hook 'org-mode-hook 'table-recognize)
;; (add-hook 'markdown-mode-hook 'table-recognize)
;; (add-hook 'erlang-mode-hook 'table-recognize)
(add-hook 'markdown-mode-hook 'turn-on-orgtbl)

;;; ============================================================
;;; org-mode 
;;; ============================================================

;; (require 'dired-x)
;; (require 'ignoramus)

;; (ignoramus-setup)    ; sets `vc-directory-exclusion-list',
;;                                         ; `dired-omit-files', `ido-ignore-directories',
;;                                         ; `completion-ignored-extensions', etc.
;;; =================================================================
;;; yasnippet
;;; =================================================================
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'auto-complete-mode-hook 'yas-minor-mode-on) 

;;; =================================================================
;;; php
;;; =================================================================
(add-hook 'php-mode-hook 'eldoc-mode)
(add-hook 'php-mode-hook 'ggtags-mode)
(global-set-key (kbd  "\C-ce" ) 'dash-at-point)


;;; =================================================================
;;; package-initialize
;;; =================================================================
;;(package-initialize)
;; check if the packages is installed; if not, install it.
;; (mapc
;;  (lambda (package)
;;    (or (package-installed-p package)
;;        (if (y-or-n-p (format "Package %s is missing. Install it? " package))
;;            (package-install package))))
;;  '( magit rainbow-mode dash deft))
(load-file "~/.emacs.d/.emacs-ui.el")


;;; ==============javascript mode 设置 ===============
;; (add-to-list 'load-path "~/.emacs.d/plugin/tern/emacs/")
;; (autoload 'tern-mode "tern.el" nil t)
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-hook 'js-mode-hook 'js2-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'auto-complete-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)
(add-hook 'html-mode-hook 'auto-complete-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
(eval-after-load 'js2-mode
  '(progn
     (define-key js2-mode-map (kbd "C-c C-n") 'nodejs-repl)                              
     ))
(setq ac-js2-evaluate-calls nil)

;; emmet 
(add-hook 'sgml-mode-hook 'ac-emmet-html-setup)
(add-hook 'css-mode-hook 'ac-emmet-css-setup)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
;; (global-set-key (kbd "M-j" ) 'emmet-expand-line)
(add-hook 'emmet-mode-hook 
(lambda ()
  (define-key emmet-mode-keymap (kbd "M-j") 'emmet-expand-line)
  (define-key emmet-mode-keymap (kbd "C-j") 'newline-and-indent)
)
)

(eval-after-load "sgml-mode"
  '(progn
     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))

(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))
(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))
(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)

;; (add-to-list 'load-path "~/.emacs.d/plugin/nxhtml/")
;; (autoload 'html-mode "autostart.el" nil t)
;; (load-file "~/.emacs.d/plugin/nxhtml/autostart.el")
;;; =================================================================
;;; evernote 配置
;;; =================================================================
;;  (load-file "~/.emacs.d/plugin/evernote-mode-0_41/evernote-mode.el")
;;  (setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; option
;;  (add-to-list 'load-path "<your load path>")
;;  (require 'evernote-mode)
;;  (global-set-key "\C-cec" 'evernote-create-note)
;;  (global-set-key "\C-ceo" 'evernote-open-note)
;;  (global-set-key "\C-ces" 'evernote-search-notes)
;;  (global-set-key "\C-ceS" 'evernote-do-saved-search)
;;  (global-set-key "\C-cew" 'evernote-write-note)
;;  (global-set-key "\C-cep" 'evernote-post-region)
;;  (global-set-key "\C-ceb" 'evernote-browser)
;; ; (setq evernote-password-cache t)       ;缓存密码
;; ; (require 'epa)
;; ;;+evernote-mode+org-mode
;; ;;基本想法是：在org-remember完成时,调用一函数来处理此remember的内容,将此内容转化为一个evernote的笔记.
;; ;;添加处理函数到rememer的hook
;; (add-hook 'org-remember-before-finalize-hook 'evernote-this-org-note)
;; ;;当调用到hook时,调用此函数,处理remember的内容,
;; (defun evernote-this-org-note(&optional arg)
;;   "select note"
;;   (interactive "P")
;;   ;(beginning-of-buffer)
;; ;  (re-search-forward "^\*.*")
;;   (backward-word 1)
;;   (beginning-of-line )
;;   (kill-ring-save (point) (point-max))
;;   (forward-line)
;;   (evernote-post-region-4-org-mode (point) (point-max) "test"))

;; ;;此函数将remember的内容做为evernote笔记内容,标题的remember是标题,同时,会在minibuffer中询问tag,tag以“,”间隔
;; (defun evernote-post-region-4-org-mode (begin end arg)
;;   "Post the region as a note"
;;   (interactive "r\np")
;;   (enh-command-with-auth
;;    (save-excursion
;;      (save-restriction
;;        (narrow-to-region begin end)
;;        (if (and (enutil-neq arg nil) (enutil-neq arg 1))
;; ;           (pop-to-buffer (enh-base-create-note-common (buffer-name) t t t))
;;            (enh-base-create-note-common (buffer-name) nil nil nil t))))))



