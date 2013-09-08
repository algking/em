;;-----------------------------
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another
;; package (Gnus, auth-source, ...).
; (load-file "~/.emacs.d/plugin/cedet-1.1/common/cedet.el")

;; Enable EDE (Project Management) features
; (global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
; (semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode,
;;   imenu support, and the semantic navigator
; (semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;  (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberant ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
                                        ;  (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languages only via ctags.
                                        ;  (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
                                        ;  (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
                                        ;  (global-srecode-minor-mode 1)

;;-----------

                                        ;==================================cedet dev ===================
;; ;; ;; Load CEDET
;; ;; ;; This should be near the top of your init file, so that this can
;; ;; ;; really replace the CEDET that ships with Emacs proper.
;;   (load-file "/home/algking/.emacs.d/plugin/cedet/cedet-devel-load.el")


;; ;; ;; ;; Add further minor-modes to be enabled by semantic-mode.
;; ;; ;; ;; See doc-string of `semantic-default-submodes' for other things
;; ;; ;; ;; you can use here.
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode t)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)

;; ;; ;; ;; ;; Enable Semantic
;; (semantic-mode 1)
;;==============================================================

(load-file "~/.emacs.d/plugin/dash-functional.el")
(setq
 backup-by-copying t ; 自动备份

 backup-directory-alist

 '(("." . "~/.saves")) ; 自动备份在目录"~/.saves"下

;   delete-old-versions nil ; 自动删除旧的备份文件

   kept-new-versions 6 ; 保留最近的6个备份文件

   kept-old-versions 2 ; 保留最早的2个备份文件

   version-control t) ; 多次备份 ;


;(add-to-list 'load-path "~/.emacs.d/elpa/helm-20120705")
;(load-file "~/.emacs.d/elpa/helm-20120705/helm-mode.el")
;(require 'helm-config)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c j") 'helm-occur)
(global-set-key (kbd "C-c m") 'helm-do-grep)

;(setq enable-recursive-minibuffers t)
;(helm-mode 1)
(load-file "~/.emacs.d/plugin/xcscope/xcscope.el")
(require 'xcscope)
;(require 'cedet)
;(semantic-mode 1)


(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/el-get/recipes")
;; (el-get 'sync)
;--------------------------------------
(load-file "~/.emacs.d/prelude/init.el")
(setq global-hl-line-sticky-flag nil)
(global-hl-line-mode 0)
(setq stack-trace-on-error t)
;;------------------------------------------------------------------------------
;;erlang 配置
;;------------------------------------------------------------------------------
(load-file "~/.emacs.d/.emacs-erlang")

;; =================================================================
(defvar mru-tag-stack '()
  "Tag stack, when jumping to new tag, current tag will be stored here,
and when jumping back, it will be removed.")

(defun yc/store-mru-tag (pt)
  "Store tag info into mru-tag-stack"
  (interactive "d")
  (let* ((tag (semantic-mrub-find-nearby-tag pt)))
    (if tag
        (let ((sbm (semantic-bookmark (semantic-tag-name tag)
                                      :tag tag)))
          (semantic-mrub-update sbm pt 'mark)
          (add-to-list 'mru-tag-stack sbm)
          )
      (error "No tag to go!")))
  )

(defun yc/goto-func (pt)
  "Store current postion and call (semantic-ia-fast-jump)"
  (interactive "d")
  (yc/store-mru-tag pt)
  (semantic-ia-fast-jump pt)
  )

(defun yc/goto-func-any (pt)
  "Store current postion and call (semantic-ia-fast-jump)"
  (interactive "d")
  (yc/store-mru-tag pt)
  (semantic-complete-jump)
  )

(defun yc/symref (pt)
  (interactive "d")
  (yc/store-mru-tag pt)
  (semantic-symref))

(defun yc/return-func()
  "Return to previous tag."
  (interactive)
  (if (car mru-tag-stack)
      (semantic-mrub-switch-tags (pop mru-tag-stack))
    (error "TagStack is empty!")))


                                        ;(local-set-key "\C-cR" 'yc/symref)
                                        ;  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
                                        ; (local-set-key "\C-c\C-j" 'yc/goto-func-any)
(global-set-key [(meta \.)]  'yc/goto-func)
(global-set-key [(meta \,)] 'yc/return-func)
                                        ;(local-set-key [M-S-f12] 'yc/return-func)
                                        ;  (local-set-key (kbd "C-x SPC") 'yc/store-mru-tag)






;; (add-to-list 'load-path "~/.emacs.d/plugin/ecb/")
;; (load-file "~/.emacs.d/plugin/ecb-snap/ecb.el")
;; (require 'ecb)

;; ;;;; 自动启动ecb，并且不显示每日提示
;; (setq ecb-auto-activate t
;;       ecb-tip-of-the-day nil)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 113 :width normal))))
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow1"))))
 '(fringe ((t nil))))

(load-file "~/.emacs.d/plugin/flymake/flymake-shell/flymake-shell.el")
(require 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)


;Make it easier to navigate buffers
;;; ================================iswitchb-mode 配置================================
;(iswitchb-mode t)
;; (add-to-list 'iswitchb-buffer-ignore "*Messages*")
;; (add-to-list 'iswitchb-buffer-ignore "*Completions")
;; (add-to-list 'iswitchb-buffer-ignore "*ftp ")
;; (add-to-list 'iswitchb-buffer-ignore "^[tT][aA][gG][sS]$")

;; (add-hook 'iswitchb-minibuffer-setup-hook
;;           '(lambda ()
;;              (local-set-key (kbd "\t") 'iswitchb-completion-help)
;;              ))
;;; ==================================================================================
;; 用M-x执行某个命令的时候，在输入的同时给出可选的命令名提示
(icomplete-mode 1)
(define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-word)
(global-set-key (kbd "C-c y") 'ido-switch-buffer)

;;; ==================================================================================
;;启动页面，粘贴外部可用，工具栏
(setq inhibit-startup-message t)
(setq x-select-enable-clipboard t)
(global-set-key [M-f11] 'tool-bar-mode)
(tool-bar-mode -1)
(menu-bar-mode 1)                       ;(setq default-frame-alist  ;设置启动窗口大小
                                        ;'((height . 30) (width . 100) (menu-bar-lines . 20) (tool-bar-lines . 0)))
;;; =================================================================================
(fset 'yes-or-no-p 'y-or-n-p)
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )
;(set-frame-parameter nil 'fullscreen 'fullboth)
                                        ;启动时最大化
(my-maximized)
(setq inhibit-startup-message t);启动不出现闪屏

                                        ;(global-set-key [M-left] 'windmove-left)
                                        ;(global-set-key [M-right] 'windmove-right)
                                        ;(global-set-key [M-up] 'windmove-up)
                                        ;(global-set-key [M-down] 'windmove-down)

 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
 (set-frame-parameter (selected-frame) 'alpha '(88 50))
 (add-to-list 'default-frame-alist '(alpha 88 50))

(eval-when-compile (require 'cl))
 (defun toggle-transparency ()
   (interactive)
   (if (/=
        (cadr (frame-parameter nil 'alpha))
        100)
       (set-frame-parameter nil 'alpha '(100 100))
     (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c 1") 'toggle-transparency)
;;; ==================================================================================
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(push '(dired-mode :position top) popwin:special-display-config)
;;; ======================================================================================
;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "M-k") 'qiang-copy-line)
;;; =============================================================================
(require 'linum)
(global-linum-mode t)
;;; =============================================================================
;;代码折叠
;;;
;(load-file "~/.emacs.d/el-get/semantic-tag-folding/semantic-tag-folding.el")
(global-set-key [f6] 'outline-minor-mode)
(setq outline-minor-mode-prefix [(control o)])
 ;; (add-hook 'outline-mode-hook
 ;;           (lambda ()
 ;;             (require 'outline-cycle)))
(add-hook 'erlang-mode-hook 'outline-minor-mode)
(add-hook 'outline-minor-mode-hook
          (lambda ()
             (require 'outline-magic)
             (define-key outline-minor-mode-map [(C-tab)] 'outline-cycle)))
;;; ===============================================================================
;;; ===================================================================
;;; 绑定快捷键分成四个窗口
;;; 清单 1. 四窗口模式的创建绑定到一个组合键上去

                                        ; +----------+-----------+
                                        ; |          |           |
                                        ; |          |           |
                                        ; +----------+-----------+
                                        ; |          |           |
                                        ; |          |           |
                                        ; +----------+-----------+
;;; ===================================================================
(defun split-window-4()
  "Splite window into 4 sub-window"
  (interactive)
  (if (= 1 (length (window-list)))
      (progn (split-window-vertically)
             (split-window-horizontally)
             (other-window 2)
             (split-window-horizontally)
             )
    )
  )



(global-set-key (kbd "C-x 4 4") 'split-window-4)

(defun split-v-3 ()
  "Change 3 window style from horizontal to vertical"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
	    (let ((1stBuf (window-buffer (car winList)))
              (2ndBuf (window-buffer (car (cdr winList))))
              (3rdBuf (window-buffer (car (cdr (cdr winList))))))
	      (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

	      (delete-other-windows)
	      (split-window-horizontally)
	      (set-window-buffer nil 1stBuf)
	      (other-window 1)
	      (set-window-buffer nil 2ndBuf)
	      (split-window-vertically)
	      (set-window-buffer (next-window) 3rdBuf)
	      (select-window (get-largest-window))
          ))))

(defun split-h-3 ()
  "Change 3 window style from vertical to horizontal"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
	    (let ((1stBuf (window-buffer (car winList)))
              (2ndBuf (window-buffer (car (cdr winList))))
              (3rdBuf (window-buffer (car (cdr (cdr winList))))))
          (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

          (delete-other-windows)
          (split-window-vertically)
          (set-window-buffer nil 1stBuf)
          (other-window 1)
          (set-window-buffer nil 2ndBuf)
          (split-window-horizontally)
          (set-window-buffer (next-window) 3rdBuf)
          (select-window (get-largest-window))
	      ))))


(defun change-split-type-3 ()
  "Change 3 window style from horizontal to vertical and vice-versa"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
            (let ((1stBuf (window-buffer (car winList)))
                  (2ndBuf (window-buffer (car (cdr winList))))
                  (3rdBuf (window-buffer (car (cdr (cdr winList)))))

                  (split-3
                   (lambda(1stBuf 2ndBuf 3rdBuf split-1 split-2)
                     "change 3 window from horizontal to vertical and vice-versa"
                     (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

                     (delete-other-windows)
                     (funcall split-1)
                     (set-window-buffer nil 2ndBuf)
                     (funcall split-2)
                     (set-window-buffer (next-window) 3rdBuf)
                     (other-window 2)
                     (set-window-buffer nil 1stBuf)))

                  (split-type-1 nil)
                  (split-type-2 nil)
                  )
              (if (= (window-width) (frame-width))
                  (setq split-type-1 'split-window-horizontally
                        split-type-2 'split-window-vertically)
                (setq split-type-1 'split-window-vertically
		       split-type-2 'split-window-horizontally))
              (funcall split-3 1stBuf 2ndBuf 3rdBuf split-type-1 split-type-2)

 ))))

(global-set-key (kbd "C-x 4 c") (quote change-split-type-3))
;;; ===================================================================


;;; ============================================
;;;  org-mode
;;; ============================================
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-x ,") 'org-time-stamp)
(global-set-key (kbd "C-c c") 'org-capture-string)
(global-set-key (kbd "C-c x") 'org-capture)
(global-set-key (kbd "C-c 2") 'org-sparse-tree)
(global-set-key "\C-cb" 'org-iswitchb)

;; iimage mode
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

;;; ==========================================

(global-set-key [f8] 'grep-find)
(global-set-key [f9] 'grep)
;;(add-to-list 'load-path "~/.emacs.d/plugin/plugin")
;;(load-file "~/.emacs.d/plugin/sr-speedbar.el")
(load "~/.emacs.d/plugin/sr-speedbar")
(require 'sr-speedbar)
(global-set-key (kbd "M-2") 'sr-speedbar-toggle)
                                        ;(global-set-key (kbd "M-2") 'speedbar)

;; (add-to-list 'load-path "~/.emacs.d/plugin/")
;; ;;(load "~/.emacs.d/plugin/tabbar")
;; (require 'tabbar)
;; (global-set-key [C-S-iso-lefttab] 'tabbar-backward)
;; (global-set-key [(control tab)]       'tabbar-forward)
;; ;; 设置tabbar外观
;; ;; 设置默认主题: 字体, 背景和前景颜色，大小
;; (set-face-attribute 'tabbar-default-face nil
;; :family "DejaVu Sans Mono"
;; :background "darkslategrey"
;; :foreground "gray30"
;; :height 1.0
;; )
;; ;; 设置左边按钮外观：外框框边大小和颜色
;; (set-face-attribute 'tabbar-button-face nil
;; :inherit 'tabbar-default
;; :box '(:line-width 1 :color "#102025")
;; )
;; ;; 设置当前tab外观：颜色，字体，外框大小和颜色
;; (set-face-attribute 'tabbar-selected-face nil
;; :inherit 'tabbar-default
;; :foreground "DarkGreen"
;; :background "LightGoldenrod"
;; :box '(:line-width 2 :color "LightGoldenrod")
;; :overline "black"
;; :weight 'bold
;; )
;; ;; 设置非当前tab外观：外框大小和颜色
;; (set-face-attribute 'tabbar-unselected-face nil
;; :inherit 'tabbar-default
;; :box '(:color "#102025")
;;
;; (tabbar-mode 1)


                                        ;(add-to-list 'load-path "~/.emacs.d/plugin/themes/color-theme-6.6.0")
                                        ;(load-file "~/.emacs.d/plugin/themes/color-theme-6.6.0/themes/color1.el")
                                        ;(load-file "~/.emacs.d/plugin/themes/color-theme-6.6.0/themes/my-color-theme.el")
                                        ;(load-file "~/.emacs.d/plugin/themes/color-theme-6.6.0/themes/color-theme-library.el")
                                        ; (load-file "~/.emacs.d/plugin/themes/color-theme-6.6.0/themes/color-theme-tangosoft.el")
                                        ;(load-file "~/.emacs.d/plugin/themes/color-theme-6.6.0/themes/color-theme-charcoal-black.el")
                                        ;(load-file "~/.emacs.d/plugin/themes/color-theme-6.6.0/themes/color-theme-mygnome.el")

                                        ;(require 'color-theme)
                                        ;(color-theme-subtle-hacker)
;;(color-theme-initialize)
                                        ;(color-theme-tangosoft)
                                        ;(color-theme-charcoal-black)
                                        ;(color-theme-mygnome)
                                        ;(my-color-theme)
;;(color1)


;;;===========================================================================
;;;==============================company 配置=================================

 ;; (add-to-list 'load-path "~/.emacs.d/plugin/company-0.5")
 ;; (autoload 'company-mode "company" nil t)
  (require 'company)

  (defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))

  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))

  (defun tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
          (if (check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))

(dolist (hook (list
                 'erlang-mode-hook
                 'emacs-lisp-mode-hook
                 'lisp-mode-hook
                 'lisp-interaction-mode-hook
                 'scheme-mode-hook
                 'c-mode-common-hook
                 'c++-mode-hook
                 'java-mode-hook
                 'javascript-mode-hook
                 'js2-mode-hook
                 'php-mode-hook
                 'python-mode-hook
                 'haskell-mode-hook
                 'asm-mode-hook
                 'emms-tag-editor-mode-hook
                 'sh-mode-hook))
    (add-hook hook 'company-mode)
    )

 (add-hook 'company-mode
           (lambda ()
             (local-set-key (kbd "\t") 'company-complete-common)
             )
           )
(add-hook 'erlang-mode-hook 'company-mode)
(add-hook 'erlang-mode-hook
          (lambda ()
            (local-set-key (kbd "\t") 'company-complete-common)
            )
          )
(global-set-key (kbd "M-1") 'company-complete-common)
(global-set-key "\t" 'tab-indent-or-complete)
(setq company-begin-commands '(self-insert-command))


                                        ;(setq company-idle-delay nil)
(add-hook 'c++-mode-hook '(lambda () (company-mode)))
                                        ;(global-set-key [] 'company-complete-common)
(global-set-key (kbd "M-[") 'company-complete-common)
(global-set-key (kbd "M-1") 'company-manual-begin)
(global-set-key (kbd "M-?") 'company-complete)
(global-set-key (kbd "M-1") 'company-select-next)




;;==========================================================
;;auto-complete 配置
;; (add-to-list
;;  'ac-dictionary-directories
;;  "~/.emacs.d/prelude/elpa/auto-complete-20130122.1551/dict")
(require 'auto-complete-config)
(ac-config-default)

;;=====================================================================
;;el-get 的 auto-complete-etags
;;有问题,从github中下来的才行
;; (load-file "~/.emacs.d/el-get/auto-complete-etags/auto-complete-etags.el")
;; (load-file "~/.emacs.d/el-get/auto-indent-mode/auto-indent-mode.el")

;;; ================================company-distel===============================
;;; =============================================================================
(add-to-list 'load-path "~/.emacs.d/el-get/company-distel")
(require 'auto-complete-distel)
(setq ac-sources '(distel-completions))
;; (require 'company-distel)
;; (add-to-list 'company-backends 'company-distel)
;; (require 'company-distel-frontend)

;;; ===================================muti-shell mode 配置===========================
;;; ==================================================================================
(load-file "~/.emacs.d/plugin/muti-shell/multi-shell.el")
(require 'multi-shell)
(setq multi-shell-command "/bin/bash")
(global-set-key  (kbd "M-3") 'multi-shell-prev)
(global-set-key  (kbd "M-4") 'multi-shell-next)
(global-set-key [f7] 'multi-shell-new)
;;; =================================shell complete=============================
;; (add-to-list 'ac-modes 'erlang-shell-mode)
(load-file "~/.emacs.d/plugin/readline-complete.el")
(setq explicit-shell-file-name "bash")
(setq explicit-bash-args '("-c" "export EMACS=; stty echo; bash"))
(setq comint-process-echoes t)

(defun my-shell-complete ()
  (interactive)
  (setq ac-auto-start nil)
  (ac-set-trigger-key "TAB")
  )
(add-hook 'shell-mode-hook 'my-shell-complete)
(require 'readline-complete)
(add-to-list 'ac-modes 'shell-mode)
(add-hook 'shell-mode-hook 'ac-rlc-setup-sources)

;; ========================================
;; (require 'auto-complete-etags)
;; (add-to-list 'ac-sources 'ac-source-etags)
;; If you want this to show documentation, also add the following:
;; (setq ac-etags-use-document t)
;;; ================================
;;; ================================
;;; c-mode 配置
;;; =================================
 ;; (defun my-c-mode-common-hook-func ()
 ;;   (interactive)
 ;;   "Function to be called when entering into c-mode."
 ;;   (when (and (require 'auto-complete nil t) (require 'auto-complete-config nil t))
 ;;     (auto-complete-mode t)
 ;;     (make-local-variable 'ac-sources)
 ;;     (setq ac-auto-start 1)
 ;;     (setq ac-sources '(ac-source-words-in-same-mode-buffers
 ;;                        ac-source-semantic))
 ;;     (when (require 'auto-complete-etags nil t)
 ;;       (add-to-list 'ac-sources 'ac-source-etags)
 ;;       (setq ac-etags-use-document t))))

 ;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook-func)


;(setq auto-indent-on-visit-file t) ;; If you want auto-indent on for files
;(require 'auto-indent-mode)
                                        ;(auto-indent-global-mode)

; (add-to-list 'load-path "~/.emacs.d/plugin/ac")
 ; (require 'auto-complete-config)
;;  (add-to-list 'ac-dictionary-directories "~/.emacs.d/plugin/ac/ac-dict")
;; (ac-config-default)
                                        ;------------------------------------------------------------------------------------


(global-set-key [f4] 'compile)


;; (defvar flymake-mode-map (make-sparse-keymap))
;; (define-key flymake-mode-map (kbd "C-c <f4>") 'flymake-goto-next-error-disp)
;; (define-key flymake-mode-map (kbd "C-c <S-f4>") 'flymake-goto-prev-error-disp)
;; (define-key flymake-mode-map (kbd "C-c <C-f4>")
;;   'flymake-display-err-menu-for-current-line)
;; (or (assoc 'flymake-mode minor-mode-map-alist)
;;     (setq minor-mode-map-alist
;;           (cons (cons 'flymake-mode flymake-mode-map)
;;                 minor-mode-map-alist)))



;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
                                        ; (set-frame-parameter (selected-frame) 'alpha '(85 50))
                                        ; (add-to-list 'default-frame-alist '(alpha 85 50))

                                        ;(eval-when-compile (require 'cl))
                                        ; (defun toggle-transparency ()
                                        ;   (interactive)
                                        ;   (if (/=
                                        ;        (cadr (frame-parameter nil 'alpha))
                                        ;        100)
                                        ;       (set-frame-parameter nil 'alpha '(100 100))
                                        ;     (set-frame-parameter nil 'alpha '(85 50))))
                                        ; (global-set-key (kbd "C-c t") 'toggle-transparency)

;; Set transparency of emacs
                                        ; (defun transparency (value)
                                        ;  "Sets the transparency of the frame window. 0=transparent/100=opaque"
                                        ; (interactive "nTransparency Value 0 - 100 opaque:")
                                        ;(set-frame-parameter (selected-frame) 'alpha value))


(defun clear-shell ()
  (interactive)
  (let ((old-max comint-buffer-maximum-size))
    (setq comint-buffer-maximum-size 0)
    (comint-truncate-buffer)
    (setq comint-buffer-maximum-size old-max)))
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


;;; =================================================================
;;; popup配置
;;; =================================================================
(defcustom complete-in-region-use-popup nil
  "If non-NIL, complete-in-region will popup a menu with the possible completions."
  :type 'boolean
  :group 'completion)
(autoload 'popup-menu* "popup" "Show a popup menu" nil)
(defun popup-complete-in-region (next-func start end collection &optional predicate)
  (if (not complete-in-region-use-popup)
      (funcall next-func start end collection predicate)
    (let* ((prefix (buffer-substring start end))
           (completion (try-completion prefix collection predicate))
           (choice (and (stringp completion)
                        (string= completion prefix)
                        (popup-menu* (all-completions prefix collection predicate))))
           (replacement (or choice completion))
           (tail (and (stringp replacement)
                      (not (string= prefix replacement))
                      (substring replacement (- end start)))))
      (cond ((eq completion t)
             (goto-char end)
             (message "Sole completion")
             nil)
            ((null completion)
             (message "No match")
             nil)
            (tail
             (goto-char end)
             (insert tail)
             t)
            (choice
             (message "Nothing to do")
             nil)
            (t
             (message "completion: something failed!")
             (funcall next-func start end collection predicate))))))
(add-hook 'completion-in-region-functions 'popup-complete-in-region)
(provide 'popup-complete)


;; (add-to-list 'load-path "~/.emacs.d/plugin/weibo.emacs")
;; (require 'weibo)
;; (desktop-save-mode 1)

;(require 'session)
;
 ;
  ;; (add-hook 'after-init-hook
  ;;         'session-initialize)

(setq current-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; idle-highlight-mode 设置
(dolist (hook (list
               'erlang-mode-hook
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'scheme-mode-hook
               'c-mode-common-hook
               'c++-mode-hook
               'java-mode-hook
               'javascript-mode-hook
               'php-mode-hook
               'python-mode-hook
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook))
  (add-hook hook 'idle-highlight-mode)
  )

 ;; (load " ~/.emacs.d/plugin/moz/moz.el")
;; (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

;; (add-hook 'javascript-mode-hook 'javascript-custom-setup)
;; (defun javascript-custom-setup ()
;;   (moz-minor-mode 1))

;;; =============imenu=================
(global-set-key  (kbd "C-c i") 'helm-semantic-or-imenu)

;; (require 'eide)
;; (eide-start)


(setq viper-mode t)
(require 'viper)

;; ==================================
;; ;;; table mode
;; ==================================
;; (load-file "~/.emacs.d/plugin/table.el")
;; (require 'table)
;; (add-hook 'org-mode-hook 'table-recognize)
;; (add-hook 'erlang-mode-hook 'table-recognize)

;;这两句是我的全局配置，避免出现多语言混乱。
(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")

;;这句指定默认英文字体为Dejavu Sans Mono，大小10
(set-default-font "Dejavu Sans Mono 10")

;;前面一串“(if...lambda...(with-select-frame frame ())...)"是个很好的函数框架，意思是frame创建后载入，用这个框架可以解决--daemon启动的问题
;;只有set-fontset-font一句指定修改字符集'unicode的字体为文泉驿等宽微米黑，大小为12
(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (set-fontset-font "fontset-default"
                    'unicode "WenQuanyi Micro Hei Mono 12"))))
  (set-fontset-font "fontset-default" 'unicode "WenQuanYi Micro Hei Mono 12"))


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

                                        ; Do not prompt to confirm evaluation
                                        ; This may be dangerous - make sure you understand the consequences
                                        ; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

(global-ede-mode t)
(if (file-exists-p "/home/algking/Tools/erl-workspace/Libevent/Makefile")
    (ede-cpp-root-project "libevent"
                          :name "libevent Config"
                          :file "/home/algking/Tools/erl-workspace/Libevent/Makefile"
                          :system-include-path '("/usr/include"
                                                 )
                          :include-path '("/include/event2"
                                          "/include"
                                          "/")
                          ))

;; Quickstart


;;     C-x C-j
;; backups and build files now omitted from dired
(package-initialize)
;; check if the packages is installed; if not, install it.
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package))))
 '( magit rainbow-mode dash deft))

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
   magit
   melpa
   multiple-cursors
   org
   outline-magic
   php+-mode
   php-mode
   plantuml-mode
   popup
   popwin
   psvn
   session
   shell-pop
   skewer-mode
   skewer-mode
   slime
   slime-js
   slime-repl
   smex
   w3m
   web
















   )  )
(require 'dired-x)
(require 'ignoramus)

(ignoramus-setup)    ; sets `vc-directory-exclusion-list',
                                        ; `dired-omit-files', `ido-ignore-directories',
                                        ; `completion-ignored-extensions', etc.
(require 'yasnippet)
(yas-global-mode 1)
