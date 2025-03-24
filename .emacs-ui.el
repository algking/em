;;; .emacs-ui.el --- ui
;; Copyright (C) 1998, 2000-2020 Free Software Foundation, Inc.

;; Author: Dave Love <fx@gnu.org>
;; Maintainer: emacs-devel@gnu.org
;; Created: 1998-09-13
;; Keywords: faces, frames, emulations

;; This file is part of GNU Emacs.
;;; Commentary:

;;
;;==============================================================
;; mini-buffer buffer complete/switch window switch 启动UI
;;==============================================================
;;启动页面，粘贴外部可用，工具栏

(setq x-select-enable-clipboard t)
(global-set-key [M-f11] 'tool-bar-mode)
(tool-bar-mode -1)
(menu-bar-mode 1)
(require 'multiple-cursors)
(setq inhibit-startup-message t);启动不出现闪屏
;;(global-set-key [M-left] 'windmove-left)
;;(global-set-key [M-right] 'windmove-right)
;;(global-set-key [M-up] 'windmove-up)
;;(global-set-key [M-down] 'windmove-down)
 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))

;; ==============transparency==================
;; ============================================
(set-frame-parameter (selected-frame) 'alpha '(100 100))
;; (add-to-list 'default-frame-alist '(alpha 88 50))
(global-set-key (kbd "C-c 1") 'toggle-transparency)

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
;; (prefer-coding-system 'utf-8)

(set-coding-system-priority 'utf-8 'gbk) ;设置文件默认编码优先级

;;这两句是我的全局配置，避免出现多语言混乱。
;; (set-language-environment 'UTF-8)
;; (set-locale-environment "UTF-8")

;; (eval-when-compile (require 'cl))

(defun set-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" english english-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
     (set-fontset-font (frame-parameter nil 'font) charset
                       (font-spec :family chinese :size chinese-size))
    ))

'(set-font "Monaco" "YaHei Consolas Hybrid" 14 16)

;; (when (member "YaHei Consolas Hybrid" (font-family-list))
;;   (set-face-attribute 'default nil :font "YaHei Consolas Hybrid-12"))

;; (require 'linum)
;; (global-linum-mode t)

(global-display-line-numbers-mode t)
;; (global-nlinum-mode t)
;; Preset width nlinum
;; (add-hook 'nlinum-mode-hook
;;           (lambda ()
;;             (setq nlinum--width
;;                   (length (number-to-string
;;                            (count-lines (point-min) (point-max)))))))
(global-hl-line-mode)
;;;
