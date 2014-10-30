(add-to-list 'load-path "~/.emacs.d/plugin/jdee-2.4.1/lisp/")
(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist
      (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))
;; (setq jde-check-version-flag nil)

;; (add-hook 'java-mode-hook
;;           '(lambda () 
;;              (semantic-add-system-include (getenv "JAVA_HOME") 'java-mode)))

;; (custom-set-variables ;; Инициализация переменных, указывающих, где
;;  '(cedet-java-jdk-root "/usr/lib/jvm/java-7-openjdk-i386/")
;;  '(semanticdb-javap-classpath '("/usr/lib/jvm/java-7-openjdk-i386/jre/lib/rt.jar"))
;;  )
