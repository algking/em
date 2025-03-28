;; (load-file "~/.emacs.d/plugin/cedet-bzr/trunk/cedet-devel-load.el")
;; (load-file "~/.emacs.d/plugin/cedet-bzr/trunk/contrib/cedet-contrib-load.el")
(load-file "~/.emacs.d/.emacs-init.el")
(load-file "~/.emacs.d/.emacs-myfun.el")
(load-file "~/.emacs.d/.emacs-c.el")
(load-file "~/.emacs.d/.emacs-ui.el")
(setenv "LC_CTYPE" "en_US.UTF-8")

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
;; (semantic-mode 1)
;; (setq enable-recursive-minibuffers t)
;; (load-file "~/.emacs.d/plugin/xcscope/xcscope.el")
(require 'xcscope)


(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

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
(global-set-key (kbd "M-j") 'newline-and-indent)

;;==============================================================
;; helm
;;==============================================================
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-c j") 'helm-occur)
(global-set-key (kbd "C-c m") 'helm-grep-do-git-grep)

;;==============================================================
;; ivy
;;==============================================================
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)

(global-set-key [f4] 'compile)
(global-set-key (kbd "C-c 3") 'toggle-viper-mode)
(setq viper-mode t)
(require 'viper)
;; (require 'evil)
;; (evil-mode 1)

(setq global-hl-line-sticky-flag nil)
(global-hl-line-mode 0)
(setq stack-trace-on-error t)
;;==============================================================
;;erlang 配置
;;==============================================================
;; (load-file "~/.emacs.d/.emacs-erlang.el")
;; (add-to-list 'load-path "~/.emacs.d")
(autoload 'erlang-mode "~/.emacs.d/.emacs-erlang.el" nil t)



;;==============================================================
;;clojure 配置
;;==============================================================
;
(defun my-clojure-config ()
  ;; (add-hook 'clojure-mode-hook 'cider-mode)
  ;; (add-hook 'cider-repl-mode-hook 'company-mode)
  ;; (add-hook 'cider-mode-hook 'company-mode)
  ;; (add-hook 'cider-repl-mode-hook 'paredit-mode)
  ;; (require 'ac-cider)
  ;; (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  ;; (add-hook 'cider-mode-hook 'ac-cider-setup)
  ;; (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  ;; (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
  ;; (auto-plete-mode -1)
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
;; (icomplete-mode 1)
;; (define-key minibuffer-local-completion-map (kbd "\t") 'minibuffer-complete-word)
(global-set-key (kbd "C-c y") 'ido-switch-buffer)
(fset 'yes-or-no-p 'y-or-n-p)
;;; =============imenu=================
;; (global-set-key  (kbd "C-c i") 'helm-semantic-or-imenu)
(global-set-key  (kbd "C-c I") '(lambda()
                                  (interactive)
                                  (setq imenu--index-alist nil)
                                  (counsel-imenu)))

;; (global-set-key (kbd "C-u") 'scroll-down-command)
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
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((emacs-lisp . t)
;;     (dot . t)
;;     (ditaa . t)
;;     (R . t)
;;     (python . t)
;;     (ruby . t)
;;     (gnuplot . t)
;;     (clojure . t)
;;     (sh . t)
;;     (ledger . t)
;;     (org . t)
;;     (plantuml . t)
;;     (latex . t)))
;; (setq org-confirm-babel-evaluate nil)
;; => always resize inline images to 300 pixels
;; (setq org-image-actual-width '(550))

;; => if there is a #+ATTR.*: width="200", resize to 200,
;; otherwise resize to 400
(require 'org-alert)
(setq org-alert-interval 7200)
(setq org-alert-notification-title "TODO:")
(org-alert-enable)

(add-hook 'markdown-mode-hook 'iimage-mode)
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'outline-minor-mode)
(setq org-startup-with-inline-images t)
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
;;  python-mode
;; =============================================================
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; =============================================================
;;  auto-complete company-mode
;; =============================================================
(dolist (hook '(scheme-mode-hook)
              '(vue-mode-hook)
              )
        (add-hook hook 'company-mode))
(company-quickhelp-mode 1)
(pos-tip-show "")
(eval-after-load 'company '(progn (define-key company-mode-map (kbd "M-1") 'company-complete)))
;; (global-set-key (kbd "M-[") 'company-complete-common)
;; (global-set-key (kbd "M-1") 'company-manual-begin)
;; (global-set-key (kbd "M-?") 'company-complete)
;; (global-set-key (kbd "M-1") 'company-select-next)
(require 'auto-complete-config)
;; (ac-config-default)
(setq ac-sources (append '(ac-source-abbrev ac-source-dictionary ac-source-yasnippet) ac-sources))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-hook 'ac-cc-mode-setup)
(add-hook 'c++-mode-hook 'ac-cc-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
;; (add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'objc-mode-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
;; (global-auto-complete-mode nil)
(define-key ac-mode-map (kbd "M-1") 'auto-complete)
(define-key ac-completing-map (kbd "\C-s")  'ac-isearch)

(dolist (hook '(;; emacs-lisp-mode-hook
                ;; c-mode-hook
                ;; c++-mode-hook
                ;; ruby-mode-hook
                web-mode-hook
                objc-mode-hook
                sgml-mode-hook
                ;; css-mode-hook
                ))
  (add-hook hook 'auto-complete-mode))
;; (add-hook 'auto-complete-mode-hook '(lambda () (company-mode 0)))
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
;; (load-file "~/.emacs.d/plugin/muti-shell/multi-shell.el")
;; (require 'multi-shell)
;; (setq multi-shell-command "/bin/bash")
;; (global-set-key  (kbd "M-3") 'multi-shell-prev)
;; (global-set-key  (kbd "M-4") 'multi-shell-next)
;; (global-set-key [f7] 'multi-shell-new)

;; =============================================================
;;  code folding
;; =============================================================
(define-key yafolding-mode-map (kbd "C-c C-q") 'yafolding-toggle-all)
(define-key yafolding-mode-map (kbd "C-c C-o") 'yafolding-toggle-element)
(define-key yafolding-mode-map (kbd "C-c C-e") 'yafolding-hide-element)
(add-hook 'prog-mode-hook 'yafolding-mode)
(add-hook 'vue-mode-hook 'yafolding-mode)



;; (dolist (hook (list 'html-mode-hook
;;                     'php-mode-hook
;; ))
;;   (add-hook hook 'yafolding-mode)
;;   )

;; =============================================================
;;  git magit git-gutter
;; =============================================================
;; (global-git-gutter-mode t)
;; (git-gutter:linum-setup)

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
                (display-line-numbers-mode -1)
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
(add-hook 'gfm-mode-hook 'turn-on-orgtbl)
;; (add-hook 'gfm-mode-hook (lambda ()
;;                            (add-hook 'after-save-hook 'gh-md-render-buffer nil 'make-it-local)))
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
;; (add-hook 'auto-complete-mode-hook 'yas-minor-mode-on)

;;; =================================================================
;;; php
;;; =================================================================
(global-set-key (kbd  "\C-ce" ) 'dash-at-point)
(load-file "~/.emacs.d/plugin/php-doc.el")

(defun php-block-comment (arg)
  (interactive "*P")
  (let ((comment-style 'extra-line)
        (comment-start "/**")
        (comment-end "*/"))
    (comment-dwim arg)))

(add-hook 'php-mode-hook
          (lambda ()
            ;; (add-to-list 'company-backends 'company-gtags)
            ;; (add-to-list 'company-backends 'company-yasnippet)
            (php-refactor-mode)
            (define-key php-mode-map  (kbd "C-c C-c") 'php-block-comment)
            (c-set-style "symfony2")
            (semantic-mode 0)
            (eldoc-mode)
            ))
;; (eval-after-load 'php-mode '(push '(company-gtags :with php-extras-company) company-backends))
(defun ac-php-enable ()
         (add-hook 'php-mode-hook
            (lambda ()
              (require 'company-php)
              (ac-php-core-eldoc-setup) ;; enable eldoc
              ;; (define-key php-mode-map  (kbd "M-.") 'ac-php-find-symbol-at-point)   ;goto define
              ;; (define-key php-mode-map  (kbd "M-,") 'ac-php-location-stack-back)    ;go back
              (make-local-variable 'company-backends)
              (push '(company-ac-php-backend :with php-extras-company) company-backends))            ))

(ac-php-enable)
;; 默认映射开启 treesit-php 模式
(push '(php-mode . php-ts-mode) major-mode-remap-alist)
(add-hook 'php-mode-hook #'(lambda () (treesit-parser-create 'php)))

;; (lsp-defcustom lsp-intelephense-include-paths
;;   [ "../framework/components" "../framework/localpackages" "../framework/vendor/yiisoft"]
;;   "Configure glob patterns to include certain files and folders
;; from all language server features."
;;   :type 'lsp-string-vector
;;   :type '(repeat string)
;;   :group 'lsp-intelephense
;;   :package-version '(lsp-mode . "6.1")
;;   :lsp-path "intelephense.environment.includePaths")

(defun mylsp-php-enable()
  ;; (ggtags-mode 1)
  ;; (require 'company-lsp)
  (require 'lsp-mode)
  ;; (require 'lsp-php)
  ;; (add-hook 'php-mode-hook #'lsp-php-enable)
  (add-hook 'php-mode-hook
            (lambda ()
              (lsp-mode)
              ;; (define-key php-mode-map  (kbd "M-.") 'xref-find-definitions)   ;goto define
              (define-key php-mode-map  (kbd "s-?") 'xref-find-references))))

(mylsp-php-enable)

(defun remake-php-tags()
  "重建ac-php-tags"
  #'ac-php-remake-tags
  )

(eval-after-load 'php-mode
  '(progn
     ;; (require 'company-lsp)
     ;; (push '(company-gtags :with php-extras-company ) company-backends)
     (global-set-key (kbd  "\C-ce" ) 'dash-at-point)
     (load-file "~/.emacs.d/plugin/php-doc.el")
     ;; (add-to-list 'load-path "~/.emacs.d/emacs-phan")
     ;; (require 'phan)
     ;; (load-file "~/.emacs.d/flycheck-phanclient/flycheck-phanclient.elc")
     ;; (require 'flycheck-phanclient)
     (;; custom-set-variables
      ;; '(phpcbf-executable "~/.composer/vendor/bin/phpcbf")
      ;; '(phpcbf-standard "PSR2")
      )

     ;; (push '(php-extras-company) company-backends)
     ;; (push '(company-lsp) company-backends)

     ))

(add-hook 'after-save-hook (lambda()
                             (when (eq major-mode 'php-mode)
                               ;; (call-interactively 'ac-php-remake-tags)
                               )))

;; (add-hook 'before-save-hook (lambda()
;;                               (goto-char 0)
;;                               (while (search-forward "\r" nil :noerror)
;;                                 (replace-match "")
;;                                 )))


(defun delete-carrage-returns ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (while (search-forward "\r" nil :noerror)
      (replace-match ""))))

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

;; Call Gofmt before saving
;; (setq gofmt-command "goimports")
;; (add-hook 'before-save-hook 'gofmt-before-save)
;; ;;autocomplete
;; (eval-after-load 'go-mode
;;   '(progn
;;      (set (make-local-variable 'company-backends) '(company-go)))
;;   ;; (add-to-list 'company-backends 'company-go)
;;   )
;; ==================== go mode 设置 ===================
;; Godef jump key binding
;; (local-set-key (kbd "M-.") 'godef-jump)
;; (local-set-key (kbd "M-,") 'pop-tag-mark)
;; (add-hook 'go-mode-hook
;;           (lambda ()
;;             (define-key go-mode-map (kbd "M-.") 'godef-jump)
;;             (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)))
(setq read-process-output-max (* 32 1024 1024)) ;; 1mb

(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  ;; :hook ((before-save . gofmt-before-save))
  :defer t
  :config
  ;; (setq gofmt-command "goimports")
  (setq lsp-prefer-flymake nil)

  
  ;; (after! (:and lsp-mode flycheck)
  ;;         (flycheck-add-next-checker 'lsp 'go-golint))
  

  (use-package lsp-mode
    ;; :ensure t
    :defer t
    :commands (lsp lsp-deferred)
    :hook (go-mode . lsp-deferred)
    :config

    ;; Set up before-save hooks to format buffer and add/delete imports.
    ;; Make sure you don't have other gofmt/goimports hooks enabled.
    (defun lsp-go-install-save-hooks ()
      (add-hook 'before-save-hook #'lsp-format-buffer t t)
      (add-hook 'before-save-hook #'lsp-organize-imports t t))

    (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
    (add-hook 'go-mode-hook #'go-ts-mode)
    ;; go-impl go-test
    (add-hook 'go-mode-hook
              (lambda ()
                (define-key go-mode-map (kbd "C-c C-t") 'go-test-current-test)
                ;; (define-key go-mode-map (kbd "M-.") 'godef-jump)
                (define-key go-mode-map  (kbd "M-.") 'xref-find-definitions)
                (define-key go-mode-map (kbd "C-c C-b") 'go-test-current-benchmark)
                (define-key go-mode-map (kbd "C-c T") 'go-gen-test-dwim)
                (define-key go-mode-map (kbd "C-c C-l") 'go-run)
                (define-key go-mode-map (kbd "C-c I") 'go-impl)))

    (lsp-register-custom-settings
     '(("gopls.completeUnimported" t t)
       ("gopls.staticcheck" t t)
       ;; ("gopls.env" (GOOS=linux GOARCH=amd64))
       ))

    ;; (eval-after-load 'flycheck
    ;;   '(add-hook 'flycheck-mode-hook (lambda () (flycheck-add-next-checker 'lsp '(warning . go-golint)))))

    (use-package flycheck
      :ensure t
      :defer t
      :after lsp-mode
      :config
      ;; (add-hook 'flycheck-mode-hook (lambda () (flycheck-add-next-checker 'lsp '(warning . go-golint))))
      )
    )

  
  ;; (use-package company-go
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'go-mode-hook (lambda()
  ;;                             (add-to-list (make-local-variable 'company-backends)
  ;;                                          '(company-go company-yasnippet))))
  ;;   )
  ;; (use-package go-eldoc
  ;;   :ensure t
  ;;   :hook (go-mode . go-eldoc-setup)
  ;;   )
  ;; (use-package go-guru
  ;;   :ensure t
  ;;   :hook (go-mode . go-guru-hl-identifier-mode)
  ;;   )
  ;; (use-package go-rename
  ;;   :ensure t)
  )

;; Optional - provides fancier overlays.
;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode)




;;; ==============javascript mode 设置 ===============
;; (add-to-list 'load-path "~/.emacs.d/plugin/tern/emacs/")
;; (autoload 'tern-mode "tern.el" nil t)
(setq js2-strict-missing-semi-warning nil)
(setq js2-missing-semi-one-line-override nil)
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(lsp-ui)
                      '(javascript-jshint)))
(eval-after-load 'tern
  '(progn
     (add-to-list 'company-backends 'company-tern)
     ;; (require 'tern-auto-complete)
     ;; (tern-ac-setup)
     ))

;; (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-hook 'typescript-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda ()
                          ;; (flycheck-select-checker 'javascript-eslint)
                          (tern-mode t)))
;; (require 'js2-refactor)
;; (add-hook 'js2-mode-hook #'js2-refactor-mode)
;; (js2r-add-keybindings-with-prefix "C-c C-m")

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-hook 'js-mode-hook 'js2-mode)
;; (add-hook 'js2-mode-hook 'ac-js2-mode)
;; (add-to-list 'company-backends 'company-tern)
;; (add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'web-mode-hook 'rainbow-mode)
(add-hook 'web-mode-hook 'auto-highlight-symbol)
(add-hook 'css-mode-hook 'auto-complete-mode)
;; (add-hook 'html-mode-hook 'skewer-html-mode)
(add-hook 'html-mode-hook 'auto-complete-mode)
(add-hook 'html-mode-hook 'rainbow-mode)

;; (add-hook 'html-mode-hook 'ac-html-enable)

;; (add-hook 'haml-mode-hook 'ac-haml-enable)
;; (add-hook 'jade-mode-hook 'ac-jade-enable)
;; (add-hook 'slim-mode-hook 'ac-slim-enable)


(eval-after-load 'js2-mode
  '(progn
     (define-key js2-mode-map (kbd "C-c C-n") 'nodejs-repl)
     ))
(setq ac-js2-evaluate-calls nil)

;; (defun my/web-vue-setup
;;     ;; (my/use-eslint-from-node-modules)
;;     ;; (add-to-list (make-local-variable 'company-backends)
;;     ;; (set-face-background 'mmm-default-submode-face nil)
;;     ;; '(comany-tide company-web-html company-css company-files))
;;   )

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.vue\\'" "\\.asp\\'")
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t)
  ;; (setq web-mode-enable-css-colorization t)
  ;; (set-face-attribute 'web-mode-html-tag-face nil :foreground "royalblue")
  ;; (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "powderblue")
  ;; (set-face-attribute 'web-mode-doctype-face nil :foreground "lightskyblue")
  (setq web-mode-content-types-alist
        '(("vue" . "\\.vue\\'")))
  (use-package company-web
    :ensure t)
  (add-hook 'web-mode-hook (lambda()
                             (cond ((equal web-mode-content-type "html")
                                    (my/web-html-setup))
                                   ;; ((member web-mode-content-type '("vue"))
                                   ;;  (my/web-vue-setup))
                                   )))
  )

;; ------------------------------------------------
;; vue lsp config mmm-mode
;; ------------------------------------------------
;; (add-hook 'js2-mode-hook #'lsp-mode)
;; (add-hook 'vue-mode-hook #'lsp-mode)
;; (require 'lsp-vue)
;; ;; (add-hook 'programming-mode-hook 'lsp-mode)
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.wxml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.wxss\\'" . web-mode))
;; (add-hook 'vue-mode-hook #'lsp-vue-enable)
;; (add-hook 'vue-mode-hook #'lsp-vue-mmm-enable)
;; (eval-after-load 'lsp-vue
;;   '(progn
;;      (setq lsp-ui-flycheck-enable t)
;;      (add-to-list 'company-backends 'company-lsp)
;;   ;; (push '(company-lsp) company-backends)
;;      )
;; )

;; (require 'lsp)
;; (require 'lsp-clients)
;; (add-hook 'js-mode-hook #'lsp)
;; (add-hook 'vue-mode-hook #'lsp)

;; (require 'lsp-vue)

;; (add-hook 'programming-mode-hook 'lsp)
;; (add-hook 'vue-mode-hook #'lsp-vue-mmm-enable)
;; (eval-after-load 'lsp-vue
;;   '(progn
;;           (setq lsp-ui-flycheck-enable t)))

;; (setq lsp-prefer-flymake nil)
;; (setq lsp-ui-sideline-enable nil
;;       lsp-ui-doc-enable nil
;;       lsp-ui-sideline-show-flycheck nil
;;       lsp-ui-imenu-enable t
;;       lsp-ui-sideline-ignore-duplicate t)
;; (require 'company-web-html)


(setq mmm-vue-html-mode-exit-hook (lambda ()
                                (message "Run when leaving vue-html mode")
                                (tagedit-mode -1)
                                (emmet-mode -1)))
(setq mmm-vue-html-mode-enter-hook (lambda ()
                                (message "Run when entering vue-html mode")
                                ;; (set-face-background 'mmm-default-submode-face nil)
                                (tagedit-mode 1)
                                (emmet-mode 1)))
(setq mmm-js-mode-exit-hook (lambda ()
                              (message "Run when leaving js mode")
                              (tern-mode -1)
                              (tagedit-mode -1)
                              (emmet-mode -1)))
(setq mmm-js-mode-enter-hook (lambda ()
                               (message "Run when entering js mode")
                               ;; fix emacs 26.3 indent bug
                               (setq syntax-ppss-table nil)
                               (auto-complete-mode -1)
                               ;; (tern-mode t)
                               ))

(setq mmm-typescript-mode-enter-hook (lambda () (setq syntax-ppss-table nil)))
;;------------------------------------------------
;; emmet
;;------------------------------------------------
(add-hook 'sgml-mode-hook 'ac-emmet-html-setup)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
;; (add-hook 'html-mode-hook 'emmet-mode)
;; (add-hook 'html-mode-hook 'ac-emmet-html-setup)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'css-mode-hook 'ac-emmet-css-setup)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'ac-emmet-html-setup)
(add-hook 'vue-html-mode 'emmet-mode)
(add-hook 'vue-html-mode 'ac-emmet-html-setup)

;; (global-set-key (kbd "M-j" ) 'emmet-expand-line)
(add-hook 'emmet-mode-hook
          (lambda ()
            ;; (define-key emmet-mode-keymap (kbd "C-return") 'emmet-expand-line)
            (define-key emmet-mode-keymap (kbd "C-j") 'newline-and-indent)))

(eval-after-load "sgml-mode"
  '(progn
     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))
 
(eval-after-load 'javascript-mode
  '(define-key javascript-mode-map (kbd "C-c b") 'web-beautify-js))

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



;;=============================

;; (load-file "~/.emacs.d/emaXcode.el")
;; (require 'emaXcode)
;; (add-to-list 'load-path "~/.emacs.d/emaXcode.el")
;; (load-file "~/.emacs.d/flycheck-objc.el")



;; (org-agenda-list)
;; (load-file "~/.emacs.d/myprelude/elpa/selectric-mode-20151201.718/selectric-mode.el")
;; (require selectric-mode)
;; (selectric-mode)

;;==============================================================
;;java 配置
;;==============================================================
;; (add-to-list 'load-path "~/.emacs.d/plugin/jdee-2.4.1/lisp/")
;; (autoload 'jde-mode "jde" "JDE mode" t)
;; (setq auto-mode-alist
;;       (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))
;; ;; (autoload 'java-mode ".emacs-java.el" nil t )
;; ;; (add-hook 'java-mode-hook
;; ;;           '(lambda ()
;; ;;              (semantic-add-system-include (getenv "JAVA_HOME") 'java-mode)))

;; (custom-set-variables ;; Инициализация переменных, указывающих, где
;;  '(cedet-java-jdk-root (getenv "JAVA_HOME"))
;;  '(semanticdb-javap-classpath '("/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/jre/lib/rt.jar"))
;;  )
;; (require 'meghanada)
;; (add-to-list 'auto-mode-alist '("\\.cs$" . java-mode))
;; (add-hook 'java-mode-hook
;;           (lambda ()
;;             ;; meghanada-mode on
;;             (meghanada-mode t)
;;             (local-set-key (kbd "M-.") 'meghanada-jump-declaration)
;;             (local-set-key (kbd "M-,") 'meghanada-back-jump)
;;             (flycheck-mode +1)
;;             (setq c-basic-offset 4)
;;             ;; use code format
;;             (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
;; (cond
;;  ((eq system-type 'windows-nt)
;;   (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
;;   (setq meghanada-maven-path "mvn.cmd"))
;;  (t
;;   (setq meghanada-java-path "java")
;;   (setq meghanada-maven-path "mvn")))

(use-package lsp-java :ensure t
  :config (add-hook 'java-mode-hook #'lsp))

(use-package dap-mode
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

;; (require 'lsp-java) 
;; (add-hook 'java-mode-hook #'lsp)
;; (add-hook 'java-mode-hook (lambda ()
;;                             (gradle-mode 1)
;;                             ))
(use-package dap-java :after (lsp-java))

;; (use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
;; (use-package dap-java :ensure nil)

;; ==========
;; rust mode
;; ==========
(use-package rust-mode
  :ensure t
  :mode (("\\.rs\\'" . rust-mode))
  ;; :hook ((before-save . gofmt-before-save))
  :defer t
  :config
  (use-package lsp-mode
    ;; :ensure t
    :defer t
    :commands (lsp lsp-deferred)
    :hook (rust-mode . lsp-deferred)
    )
  )
(with-eval-after-load 'tls
  (push "/usr/local/etc/libressl/cert.pem" gnutls-trustfiles))

(set-font "Monaco" "YaHei Consolas Hybrid" 14 16)

;; 删除缓存的文件, 当打开文件太多的时候调用
(defun file-notify-rm-all-watches ()
  "Remove all existing file notification watches from Emacs."
  (interactive)
  (maphash
   (lambda (key _value)
     (file-notify-rm-watch key))
   file-notify-descriptors))
