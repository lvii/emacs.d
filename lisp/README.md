
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

    $ git merge upstream/master
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


# tips

emacs | theme
----- | -----
`emacs` (X11) | `sanityinc-tomorrow-night`
`emacs-nox` | `sanityinc-tomorrow-bright`

`~/.emacs.d/custom.el` 中配置 `sanityinc-tomorrow-bright` 可以覆盖 `wombat` 主题补全相关设置

终端启用鼠标选择，而非 X11 [Secondary Selection](http://www.cs.man.ac.uk/~chl/secondary-selection.html)

使用 Secondary Selection 需要 `Shift` + 鼠标中键

# trick

同步新装的 `epla` 软件包和 `custom.el` 配置：

    rsync -avP --exclude={.*,auto-save-list,history,projectile-bookmarks.eld,recentf,tramp} -e "ssh -p $port" ${user}@${host}:${path}/ ~/.emacs.d/

清空非本机数据：

    cd ~/.emacs.d
    rm -f .session .smex-items projectile-bookmarks.eld recentf tramp history

# proxy

    ALL_PROXY=socks5://192.168.1.10:1080 git clone http://github.com/lvii/purcell-emacs.d.git emacs

# reference

https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el

使用 `use-package` ：https://github.com/codesuki/.emacs.d/blob/master/init.el

# fork

[Fork 的分支从源分支更新的方法 2016-10-28](https://github.com/BearRan/CRAnimation/wiki/Fork的分支从源分支更新的方法)

[同步一个 fork 2015-04-12](https://gaohaoyang.github.io/2015/04/12/Syncing-a-fork/)