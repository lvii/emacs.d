
# custom size

    # du -sh ~/.emacs.d/elpa*
    12K     /root/.emacs.d/elpa
    24M     /root/.emacs.d/elpa-26.1

# upstream

    $ git remote add upstream https://github.com/purcell/emacs.d.git

    $ git remote -v
    origin  git@github.com:lvii/emacs.d.git (fetch)
    origin  git@github.com:lvii/emacs.d.git (push)
    upstream        https://github.com/purcell/emacs.d.git (fetch)
    upstream        https://github.com/purcell/emacs.d.git (push)

    $ git fetch upstream
    remote: Counting objects: 32, done.
    remote: Total 32 (delta 12), reused 12 (delta 12), pack-reused 20
    Unpacking objects: 100% (32/32), done.
    From https://github.com/purcell/emacs.d
     * [new branch]      company-again      -> upstream/company-again
     * [new branch]      master             -> upstream/master
     * [new branch]      patch-1            -> upstream/patch-1
     * [new branch]      smartparens-take-2 -> upstream/smartparens-take-2

    $ git branch -v
    * master 5e437c8 add 'lisp/init-local.el' and 'lisp/README.md'

    $ git status
    On branch master
    Your branch is up to date with 'origin/master'.

    nothing to commit, working tree clean

    $ git checkout master
    Already on 'master'
    Your branch is up to date with 'origin/master'.

    $ git merge upstream/main                                   # <-- 原仓库已从 master 切换至 main 分支
    Merge made by the 'recursive' strategy.
     .travis.yml          |  1 +
     lisp/init-compile.el |  4 ++--
     lisp/init-haskell.el | 12 +++++++++---
     lisp/init-org.el     |  5 +++++
     lisp/init-sql.el     | 23 ++++++++++++++++++++++-
     lisp/init-themes.el  |  2 +-
     6 files changed, 40 insertions(+), 7 deletions(-)

    $ git log -15 --decorate --oneline --graph
    *   1fd185b (HEAD -> master) Merge remote-tracking branch 'upstream/master'
    |\
    | * 2ba7d10 (upstream/master) Re-align Org Agenda tags when window layout changes
    | * a1cfcc1 Include Stack's local install root in stack-exec-path-mode path
    | * dad4c12 Now preferring slightly more dimming via "dimmer"
    | * 5cd8e3e Fix buggy advice for shell-command-on-region
    | * f669c46 Add dash-at-point config for sql-mode
    | * ba9ddd5 Apply sqlformat on the current statement if region not given
    | * bf1ad73 Add command to reformat SQL using sqlformat
    | *   38cfeb6 Merge pull request #583 from peterwvj/patch-2
    | |\
    | | * 5568f76 Test against Emacs 26.1
    | |/
    * | 5e437c8 (origin/master, origin/HEAD) add 'lisp/init-local.el' and 'lisp/README.md'
    |/
    * 180fc38 Enable subword-mode for Haskell and Cabal
    * 32770f2 In Haskell-related buffers, use Stack's path for executables
    * 9d22750 Drop sql-indent, which is really more trouble than it's worth
    * 1c6eb88 Enable guide-key for all key combos, to avoid needing to list them

# elpa repo

改为国内源：

    (add-to-list 'package-archives '("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/"))

    (add-to-list 'package-archives
                 `("melpa" . ,(if sanityinc/no-ssl
                                  "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"
                                "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

https://stackoverflow.com/questions/14836958/updating-packages-in-emacs

更新 melpa 软件源：`M-x package-refresh-contents`

# customize

## fill-column-indicator-mode

[disabeling (global-display-fill-column-indicator-mode -1) does not work #812](https://github.com/purcell/emacs.d/issues/812)

<https://emacs.stackexchange.com/questions/147/how-can-i-get-a-ruler-at-column-80>

<https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el>

## theme

emacs | theme
----- | -----
`emacs` X11 | `sanityinc-tomorrow-night`
`emacs-nox` | `sanityinc-tomorrow-bright`

`~/.emacs.d/custom.el` 中配置 `sanityinc-tomorrow-bright` 可以覆盖 `wombat` 主题补全相关设置

终端启用鼠标选择，而非 X11 [Secondary Selection](http://www.cs.man.ac.uk/~chl/secondary-selection.html)

使用 Secondary Selection 需要 `Shift` + 鼠标中键

**新建文件**：`C-x C-f (counsel-find-file)` 新建文件名如果匹配已有文件时使用 `C-M-j` 退出匹配

https://oremacs.com/swiper/#key-bindings-for-single-selection-action-then-exit-minibuffer

> `C-M-j` (`ivy-immediate-done`)
>
> Exits with _the current input_ instead of _the current candidate_ (like other commands).
>
> This is useful e.g. **when you call `find-file` to create a new file, but the desired name matches an existing file**. In that case, using `C-j` would select that existing file, which isn't what you want - use this command instead.

滚动时高亮光标所在行插件：

- <https://github.com/protesilaos/pulsar>
- <https://github.com/Malabarba/beacon>

``` emacs-lisp
(defvar pulsar-tty-color "red"
  "Named color used in non-graphical frames.")
```

## custom.el

``` emacs-lisp
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat sanityinc-tomorrow-bright))
 '(package-selected-packages
   '(keychain-environment figlet highlight-indentation ng2-mode envrc uptimes shfmt dotenv-mode osx-location htmlize gnuplot sudo-edit origami regex-tool info-colors nginx-mode docker-compose-mode dockerfile-mode docker yaml-mode sqlformat reformatter toml-mode pip-requirements restclient httprepl css-eldoc skewer-less sass-mode rainbow-mode tagedit org-pomodoro writeroom-mode org-cliplink grab-mac-link add-node-modules-path skewer-mode js-comint coffee-mode prettier-js typescript-mode js2-mode json-mode csv-mode markdown-mode alert ibuffer-projectile git-commit magit-todos magit git-link git-timemachine git-modes git-blamed whitespace-cleanup-mode which-key highlight-escape-sequences whole-line-or-region move-dup page-break-lines multiple-cursors avy browse-kill-ring symbol-overlay rainbow-delimiters mode-line-bell vlf list-unicode-display unfill mmm-mode session windswap switch-window corfu orderless marginalia consult-flycheck embark-consult projectile consult embark vertico consult-eglot eglot flymake-flycheck flymake ibuffer-vc wgrep anzu diff-hl diredfl disable-mouse default-text-scale ns-auto-titlebar dimmer color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized command-log-mode scratch diminish exec-path-from-shell gnu-elpa-keyring-update fullframe seq))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
```


# trick

同步新装的 `epla` 软件包和 `custom.el` 配置：

    rsync -avP --exclude={.*,auto-save-list,history,projectile-bookmarks.eld,recentf,tramp} -e "ssh -p $port" ${user}@${host}:${path}/ ~/.emacs.d/

清空非本机数据：

    cd ~/.emacs.d
    rm -f .session .smex-items projectile-bookmarks.eld recentf tramp history

# proxy

    ALL_PROXY=socks5://192.168.1.10:1080 git clone http://github.com/lvii/purcell-emacs.d.git emacs

# reference

https://github.com/emacs-tw/awesome-emacs#starter-kit

https://github.com/caisah/emacs.dz

https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el

使用 `use-package` 配置：https://github.com/codesuki/.emacs.d/blob/master/init.el

# fork

https://help.github.com/articles/syncing-a-fork/

    git fetch upstream
    git checkout master
    git merge upstream/master

[Fork 的分支从源分支更新的方法 2016-10-28](https://github.com/BearRan/CRAnimation/wiki/Fork的分支从源分支更新的方法)

[同步一个 fork 2015-04-12](https://gaohaoyang.github.io/2015/04/12/Syncing-a-fork/)

