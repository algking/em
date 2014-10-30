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


;;==============================================================
;; 透明函数
;;==============================================================
(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))

;;==============================================================
;; Smart copy, if no region active, it simply copy the current whole line
;;==============================================================


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

;;==============================================================
;; 窗口管理
;;==============================================================
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



;;
(defun clear-shell ()
  (interactive)
  (let ((old-max comint-buffer-maximum-size))
    (setq comint-buffer-maximum-size 0)
    (comint-truncate-buffer)
    (setq comint-buffer-maximum-size old-max)))

;; ============================================================
;; 截图
;; ============================================================
(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-base)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process-shell-command "screencapture" nil nil nil
                              (concat " -i ~/note/images/" filename))
  (insert (concat "[[~/note/images/" filename "]]"))
  (org-display-inline-images))

(defun my-md-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-base)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process-shell-command "screencapture" nil nil nil
                              (concat " -i ~/Documents/algking.github.com/public/img/" filename))
  (insert (concat "![image](/public/img/" filename ")"))
  )

(global-set-key (kbd "s-1") 'my-org-screenshot)
(global-set-key (kbd "s-2") 'my-md-screenshot)
(global-set-key (kbd "s-3") 'iimage-mode)

(defun my-org-config ()
  (
   (define-key org-mode-map (kbd "s-3") 'org-toggle-inline-images)
   ))
   
(eval-after-load 'org-mode
  '(progn (my-org-config)))


(defun my-iimage-config ()
  (
   (setq iimage-mode-image-search-path '(list "." ".." "../public/img/"))

   (add-to-list 'iimage-mode-image-regex-alist ; match: {% img xxx %}
                (cons (concat "{% img /?\\("
                              iimage-mode-image-filename-regex
                              "\\)  %}") 1))
   (add-to-list 'iimage-mode-image-regex-alist ; match: {% img xxx num %}
                (cons (concat "{% img /?\\("
                              iimage-mode-image-filename-regex
                              "\\) [0-9]+ %}") 1))
   (add-to-list 'iimage-mode-image-regex-alist ; match: ![xxx](/xxx)
                (cons (concat "!\\[.*?\\](/\\("
                              iimage-mode-image-filename-regex
                              "\\))") 1))

   (add-to-list 'iimage-mode-image-regex-alist ; match: ![xxx](http://everet.org/xxx)
                (cons (concat "!\\[.*?\\](/public/img/\\("
                              iimage-mode-image-filename-regex
                              "\\))") 1))
   ))
