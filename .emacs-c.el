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
