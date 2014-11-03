;;; ================================
;;; c-mode 配置
;;; =================================




(global-ede-mode t)
(if (file-exists-p "/Users/algking/c-workspace/libevent/Makefile")
    (ede-cpp-root-project "libevent"
                          :name "libevent Config"
                          :file "/Users/algking/c-workspace/libevent/Makefile"
                          :system-include-path '("/usr/include")
                          :include-path '(
                                          "include"
                                          "include/event2")))
(global-flycheck-mode)
(defun check-and-add-header-path (checkpath)
  "Check if CHECKPATH exists and it's a directory, if it is a directory, then and it to 'ac-clang-cflags and 'flycheck-clang-include-path."
  (if (file-directory-p checkpath)
      (progn
        (add-to-list 'flycheck-clang-include-path checkpath)
        (add-to-list 'ac-clang-flags (format "%s%s" "-I" checkpath)))))


(setq my-include-list '("include" "../include" "include/event2"))
(defun my-clang-setup ()
  "Setup local variables when loading a C/C++ file."
  (mapc 'check-and-add-header-path my-include-list))



(defun my-ac-cc-mode-setup ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (require 'auto-complete-clang)
  (add-to-list 'ac-sources 'ac-source-clang )
  (add-to-list 'ac-sources 'ac-source-semantic)
  (setq  ac-clang-flags
         (mapcar (lambda (item) (concat "-I" item))
                 (split-string
                  "/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1
                   /usr/local/include
                   /Library/Developer/CommandLineTools/usr/bin/../lib/clang/6.0/include
                   /Library/Developer/CommandLineTools/usr/include
                   /usr/include"))))


(dolist (hook (list 'c-mode-hook 'c++-mode-hook))
  (add-hook hook (lambda ()
                   (my-ac-cc-mode-setup)
                   (my-clang-setup)
                   (local-set-key (kbd "C-c h d") (lambda () (interactive)
                                                    (manual-entry (current-word)))))))
