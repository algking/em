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


;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
;; (defun my-irony-mode-hook ()
;;   (define-key irony-mode-map [remap completion-at-point]
;;     'irony-completion-at-point-async)
;;   (define-key irony-mode-map [remap complete-symbol]
;;     'irony-completion-at-point-async))
;; (add-hook 'irony-mode-hook 'my-irony-mode-hook)


(defun my-ac-cc-mode-setup ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)

  ;; (require 'auto-complete-clang-async)
  ;; ;; (add-to-list 'ac-sources '(ac-source-clang-async))
  ;; (setq ac-sources '(ac-source-clang-async))
  ;; (add-to-list 'ac-sources 'ac-source-c-headers)

  ;; (setq ac-clang-complete-executable "/usr/local/bin/clang-complete")
  ;; (ac-clang-launch-completion-process)

  (require 'auto-complete-clang)
  (setq ac-sources (append  '(ac-source-clang) ac-sources))
  ;; (ac-clang-launch-completion-process)
  )

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
  (add-hook 'c-mode-hook 'my-ac-cc-mode-setup)
  (add-hook 'c++-mode-hook 'my-ac-cc-mode-setup)

  )

(my-ac-config)

(dolist (hook
         '(c-mode-hook
           c++-mode-hook))
  (add-hook hook
            (lambda ()
              (local-set-key (kbd "C-c h d")
                             (lambda ()
                               (interactive)
                               (manual-entry (current-word)))))))
              
            
  

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
