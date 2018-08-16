;; -*- mode: emacs-lisp -*-

;; emacs -q --load path-to-custom-init.el

;; | input                                             | page break char '^L'           |
;; |---------------------------------------------------+--------------------------------|
;; | C-q C-l                                           | insert '^L'                    |
;; | C-x [                                             | forward-page                   |
;; | C-x ]                                             | narrow-to-page                 |
;; | M-x toggle-truncate-lines (setq truncate-lines t) | NOT wrap '^L' page-break-lines |

;; minor mode

(blink-cursor-mode 0)
;; (column-number-mode 1)
;; (line-number-mode 1)
(menu-bar-mode 0)
(delete-selection-mode t)                                           ;; overwrite selected text
(global-hl-line-mode 1)
(global-auto-revert-mode 1)
(scroll-lock-mode 0)

;; base setting

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Major-Modes.html
(setq initial-major-mode 'text-mode)
(setq-default major-mode 'text-mode)

(setq-default
 make-backup-files nil
 echo-keystrokes 0.1
 vc-follow-symlinks t)

(setq
 inhibit-startup-message t
 initial-scratch-message nil
 ediff-split-window-function 'split-window-horizontally ;; '|' key swap horizontal -> vertical
 tramp-default-method "ssh" ;; C-h v tramp-methods M-x customize-variable RET tramp-verbose RET
 mouse-yank-at-point t
 calendar-week-start-day 1
 require-final-newline nil
 mode-require-final-newline nil
 sentence-end-double-space nil
 sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
 )

(defalias 'yes-or-no-p 'y-or-n-p)

;; http://www.emacswiki.org/emacs/WinnerMode
;; restore windows layout : C-c ←
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; coding

(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)                           ;; M-x whitespace-mode

;; (setq-default tab-width 4)
;; ;; (setq-default whitespace-style '(trailing space-before-tab indentation
;; ;;                                           space-after-tab tabs tab-mark)
;; (setq indent-line-function 'insert-tab)
;; ;; (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

(show-paren-mode 1)
(electric-pair-mode 1)                                              ;; 粘贴代码有括号，会导致多余的补全
(setq show-paren-delay 0)
(setq show-paren-style 'parentheses)

;; history

;; savehist-mode
;; http://stackoverflow.com/questions/1229142/how-can-i-save-my-mini-buffer-history-in-emacs
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
;; Default : only save minibuffer histories
;; (setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

;; UTF-8

;; 避免帮助文档变为中文，即使 LANG=zh_CN.UTF-8 环境变量运行 emacs
;; C-x <RET> l 补全变量取值 或 查看 var: language-info-alist 语言列表
;; (set-language-environment 'UTF-8)
(set-language-environment 'English)

;; FUCK all NO UTF-8 coding...
;; 1. terminal 编码设置为 UTF-8
;; 2. linux 环境变量 ENV ：export LANG=en_US.UTF-8
;; 3. emacs 配置编码解析顺序
(setq locale-coding-system 'utf-8)
(set-coding-system-priority 'utf-8 'gbk 'gb2312)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)

;; function

;; http://stackoverflow.com/questions/3669511/the-function-to-show-current-files-full-path-in-mini-buffer
(defun show-file-name ()
  "Show the full path file name in  minibuffer, and copy file name to kill ring."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name)))

(global-set-key "\C-cz" 'show-file-name)

;; http://emacs.stackexchange.com/questions/2347/kill-or-copy-current-line-with-minimal-keystrokes
(defun mark-whole-line ()
  "Combinition of C-a, mark, C-e"
  (interactive)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (move-end-of-line nil))

(global-set-key "\C-c2" 'mark-whole-line) ;; C-2 NOT work under terminal

;; thanks b4283@emacs-tw https://gist.github.com/403ff42ede3360a20b4a
(defun comment-toggle-current-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key "\C-c;" 'comment-toggle-current-line)

;; hotkey

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-Rebinding.html
;; https://www.gnu.org/software/emacs/manual/html_node/efaq/Backspace-invokes-help.html

(global-set-key [?\C-h] 'delete-backward-char) ;; C-M-backsppace --> C-M-h
(global-set-key [f1] 'help-command)

(global-set-key (kbd "C-\\") 'set-mark-command)

;; (global-set-key "\r" 'newline-and-indent)

(global-set-key "\C-cd" 'kill-whole-line) ;; C-S-backspace NOT work under terminal
;; (global-set-key (kbd "C-c o") 'occur)

;; https://github.com/brianwisti/dotfiles/blob/master/emacs.d/init.el
;; https://sites.google.com/site/steveyegge2/effective-emacs
;; Invoke M-x without Alt
;; (global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; (global-set-key (kbd "C-c r") 'revert-buffer)
;; (global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)

;; ;; https://github.com/mjwall/dotfiles/blob/master/dotemacs.d/init.el
;; (global-set-key (kbd "C-x C-b") 'bs-show) ;; bs instead of buffer-menu

;; hook

(add-hook 'text-mode-hook (lambda () (setq tab-width 4)))

;; (defun my-c-mode-config ()
;;   (whitespace-mode 1)
;;   (setq indent-tabs-mode t
;;   tab-width        4
;;   c-basic-offset   4))
;; (add-hook 'c-mode-hook 'my-c-mode-config)

;; (eval-after-load "cc-mode"
;;   '(define-key c-mode-map (kbd "TAB") 'self-insert-command))

;; (defun custom-js-mode ()
;;   "js-mode-hook"
;;   (setq js-indent-level 2))

;; (add-hook 'js-mode-hook 'custom-js-mode)

;; ;; http://www.emacswiki.org/emacs/EmacsLispMode
;; (add-hook 'emacs-lisp-mode-hook
;;           (lambda ()
;;             (setq tab-width 2)
;;             ;; Keep M-TAB for `completion-at-point'
;;             (define-key flyspell-mode-map "\M-\t" nil)
;;             ;; Pretty-print eval'd expressions.
;;             (define-key emacs-lisp-mode-map
;;               "\C-x\C-e" 'pp-eval-last-sexp)
;;             ;; Recompile if .elc exists.
;;             (add-hook (make-local-variable 'after-save-hook)
;;                       (lambda ()
;;                         (byte-force-recompile default-directory)))
;;             (define-key emacs-lisp-mode-map
;;               "\r" 'reindent-then-newline-and-indent)))

;; purcell-emacs.d

;; ;; https://github.com/purcell/page-break-lines
;; (set-fontset-font "fontset-default"
;;                   (cons page-break-lines-char page-break-lines-char)
;;                   (face-attribute 'default :family))

;; http://emacs.stackexchange.com/questions/10837/how-to-make-company-mode-be-case-sensitive-on-plain-text
(setq company-dabbrev-downcase nil)
(desktop-save-mode 0)

;; TODO: markdown preview still use prettify-symbols
(prettify-symbols-mode 0)
(global-prettify-symbols-mode 0)

;; package config

;; markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.mk?d$\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; https://github.com/purcell/emacs.d/blob/master/lisp/init-elpa.el#L35
;; (defun require-package (package &optional min-version no-refresh)...)
(require-package 'ng2-mode)
(setq css-indent-offset 2
      typescript-indent-level 2
      typescript-expr-indent-offset 2)

;; https://github.com/proofit404/anaconda-mode
(setq python-shell-interpreter "/usr/bin/python3")

;; https://github.com/purcell/emacs.d/commit/1e089c5df98e762bbb83a2b0353654ed6a2db34c
(when (maybe-require-package 'indent-guide)
  (add-hook 'prog-mode-hook 'indent-guide-mode)
  (after-load 'indent-guide
    (diminish 'indent-guide-mode)))

;; terminal

;; (load-theme 'wombat t)
(set-face-underline 'highlight nil)                                 ;; M-x describe-face <RET> highlight
(set-face-attribute hl-line-face nil :underline nil)                ;; M-x describe-face <RET> hl-line

;; ;; undefine emacs background under terminal for transparent
;; ;; http://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
;; (defun on-after-init ()
;;   (unless (display-graphic-p (selected-frame))
;;     (set-face-background 'default "unspecified-bg" (selected-frame))))
;; (add-hook 'window-setup-hook 'on-after-init)

;; GUI theme font ...

;; GUI 配置放在后面，避免 color theme 主题里面自带的配置覆盖
(defun customize-gui-setting ()
  "custom GUI setting"
  ;; http://stackoverflow.com/questions/5795451/how-to-detect-that-emacs-is-in-terminal-mode
  ;; (when (display-graphic-p)
  (when window-system
    "setting for emacs GUI mode"
    ;; 取消 mode-line 状态栏 status bar 3D 样式。放在 theme 前会被主题样式覆盖
    ;; http://www.svenhartenstein.de/Software/Emacs
    ;; http://ldc.usb.ve/docs/emacs/Optional-Mode-Line.html
    (set-face-attribute 'mode-line nil :box nil)
    (set-face-attribute 'mode-line-inactive nil :box nil)
    (set-face-attribute 'mode-line-highlight nil :box nil
                        :background "light sky blue"
                        :weight 'bold)

    ;; (set-fringe-style '(8 . 0))    ;; 只显示一侧 fringe
    ;; (window-height) (window-width) ;; 查询 window size

    ;; 窗口 "位置 position" (top left) "大小 size" (height width)
    (setq default-frame-alist '((top . 0) (left . 160) (height . 39) (width . 110)))

    ;; | English Font             | Size | 中文字体     | 中文字号 |
    ;; |--------------------------+------+--------------+----------|
    ;; | Bitstream Vera Sans Mono |   11 | 文泉驿微米黑 |     13.5 |
    ;; | Dejavu Sans Mono         |   10 | 文泉驿微米黑 |       12 |
    ;; | Envy Code R              |   11 | 文泉驿微米黑 |       12 |

    (cond
     ((string-equal system-type "windows-nt")
      ;; https://github.com/wenbinye/dot-emacs/blob/master/config/my-fontset.el
      (add-to-list 'default-frame-alist '(font . "Consolas-11"))
      (set-fontset-font "fontset-default" 'unicode "Microsoft Yahei-14")
      )
     ((string-equal system-type "darwin")
      (add-to-list 'default-frame-alist '(font . "Menlo-14"))
      (set-fontset-font "fontset-default" 'unicode "PingFang SC-16")
      )
     (t ;; GNU/Linux or BSD
      ;; (string-equal system-type "gnu/linux")
      ;; (add-to-list 'default-frame-alist '(font . "Bitstream Vera Sans Mono-11:antialias=1:autohint=0:hinting=1:hintstyle=1"))
      (add-to-list 'default-frame-alist '(font . "Bitstream Vera Sans Mono-11:antialias=1"))
      (set-fontset-font "fontset-default" 'unicode "WenQuanyi Micro Hei Mono-13.5")
      )
     )

    ;; | Font     | How to ajust font size                     |
    ;; |----------+--------------------------------------------|
    ;; | 中文字体 | 直接 `C-x C-e` 执行配置                    |
    ;; | 英文字体 | `M-x customize-face` 输入 default 进入设置 |

    ;; ;; 确保诸如 ○ 等特殊字符是双字符宽度
    ;; (use-cjk-char-width-table 'zh_CN)

    ;; Prelude config: display file path as GUI window(frame) title
    ;; http://emacsredux.com/blog/2013/04/07/display-visited-files-path-in-the-frame-title/
    (setq frame-title-format
          '((:eval (if (buffer-file-name)
                       (abbreviate-file-name (buffer-file-name))
                     "%b"))))

    (scroll-bar-mode 0)
    (tool-bar-mode 0)
    )
  )

;; 前面一串"(if...lambda...(with-select-frame frame ())...)" 是个很好的函数框架
;; 是指 frame 创建后载入，用这个框架可以解决 --daemon 启动的问题
(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (customize-gui-setting))))
  (customize-gui-setting))

;; ;; custom

;; (setq custom-file "~/.emacs.d/custom-settings.el")
;; (load custom-file t)

(provide 'init-local)
