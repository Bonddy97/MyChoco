<div align = center>

<img src="https://godotengine.org/assets/press/logo_large_color_dark.png" height="200" alt="banner">

<h1>My Chocolately Packages</h1>


[English](./ReadMe.md) | 中文 | [國語](./ReadMe.zh_tw.md)

---

</div>

## 功能实现

- [x] 安装、下载、更新
- [x] 自动更新脚本(通过 Github Actions 更新)
- [x] 桌面等快捷方式

## 如何创建包？

如果您要将包提交到社区源 (https://community.chocolatey.org)
始终尽力确保您已阅读、理解并遵守创建
上面的包 wiki 链接。

- [官方文档](https://docs.chocolatey.org/en-us/create/create-packages)

### 包的自动更新

**此步骤并非必须的**，但是如果您拥有此步骤来自动维护您的包版本将会是一件美事，这样可以最大程度保证随着时间推移的包的可维护性。

官方给出了一篇[官方教程](https://docs.chocolatey.org/en-us/create/automatic-packages)，但是对于本人来说，`Github Action` 是我的替代方案，可以实现同样的功能且高度可自定义化。

## Shim 功能实现

这部分请参考[官方文档(GUI)](https://docs.chocolatey.org/en-us/create/create-packages#how-do-i-set-up-shims-for-applications-that-have-a-gui)以及[官方文档(忽略特定文件)](https://docs.chocolatey.org/en-us/create/create-packages#how-do-i-exclude-executables-from-getting-shims)。

个人理解这部分功能是为了实现类似于环境变量的功能，实际测试对于我的使用过程中帮助不大。

## 自动化脚本

正如您使用 PowerShell 一样，您可以充分利用 Chocolatey。 那么你几乎可以做您需要的任何事情。 Choco 有一些非常方便的[内置函数](https://docs.chocolatey.org/en-us/create/functions)来实现这些功能。

## 如何成为一个维护者？

要成为Chocolatey包的维护者，你需要遵循以下步骤：

1. **创建一个Chocolatey包**：首先，你需要创建一个Chocolatey包。这个包应该包含你的项目的所有必要文件和安装脚本。你可以参考[Chocolatey的官方文档](https://docs.chocolatey.org/en-us/create/create-packages/)来了解如何创建一个包。

2. **测试你的包**：在提交你的包之前，你需要在本地测试它以确保它能够正确地安装和卸载。你可以使用`choco install <package>`和`choco uninstall <package>`命令来测试你的包。

3. **提交你的包**：一旦你的包通过了本地测试，你就可以将它提交到Chocolatey社区包源（community package repository）。你需要在Chocolatey网站上创建一个账户，并遵循提交流程来提交你的包。

4. **等待审核**：提交后，你的包将会被Chocolatey团队审核。如果一切顺利，你的包将会被接受并添加到Chocolatey社区包源中。

5. **维护你的包**：一旦你的包被接受，你就需要对其进行维护。这意味着当你的项目有更新时，你需要更新你的Chocolatey包以反映这些更改。

## 参考

- [Ventoy 的 Chocolately 包配置](https://github.com/asheroto/ChocolateyPackages/tree/master/ventoy)
