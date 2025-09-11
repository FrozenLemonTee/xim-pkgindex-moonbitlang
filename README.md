# xim-pkgindex-moonbitlang

xim package index for MoonBit community

## 添加索引仓库

> 添加索引仓库到xim的索引仓库管理器中

```bash
xim --add-indexrepo moonbitlang:https://github.com/frozenlemontee/xim-pkgindex-moonbitlang.git
xim --update index
```

## 使用仓库中的包

```bash
# 自动安装MoonBit开发者集成工具
xlings install moonbitlang:moonbit-devtool

# 自动下载安装MoonBit环境以及官方命令行工具
mbtool install

# 自动更新本地MoonBit核心库：https://github.com/moonbitlang/core/blob/main/CONTRIBUTING.md
mbtool update

# 自动卸载MoonBit环境以及官方命令行工具
mbtool uninstall
```

## 其他

- MoonBit官网：https://www.moonbitlang.cn
- xlings工具: https://github.com/d2learn/xlings
- xlings论坛版块: https://forum.d2learn.org/category/9/xlings
- xim包索引主仓库: https://github.com/d2learn/xim-pkgindex
