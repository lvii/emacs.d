
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