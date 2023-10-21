<div align = center>

<img src="https://godotengine.org/assets/press/logo_large_color_dark.png" height="200" alt="banner">

<h1>My Chocolately Packages</h1>

[English](./ReadMe.md) | [中文](./ReadMe.zh_cn.md) | [國語](./ReadMe.zh_tw.md)

---

</div>

## 功能實現

- [x] 安裝、下載、更新
- [x] 自動更新腳本(通過 Github Actions 更新)
- [x] 桌面等快捷方式

## 如何創建包？

如果您要將包提交到社區源 (https://community.chocolatey.org)
始終盡力確保您已閱讀、理解並遵守創建
上面的包 wiki 連結。

- [官方文檔](https://docs.chocolatey.org/en-us/create/create-packages)

### 包的自動更新

**此步驟並非必須的**，但是如果您擁有此步驟來自動維護您的包版本將會是一件美事，這樣可以最大程度保證隨著時間推移的包的可維護性。

官方給出了一篇[官方教程](https://docs.chocolatey.org/en-us/create/automatic-packages)，但是對於本人來說，`Github Action` 是我的替代方案，可以實現同樣的功能且高度可自定義化。

## Shim 功能實現

這部分請參考[官方文檔(GUI)](https://docs.chocolatey.org/en-us/create/create-packages#how-do-i-set-up-shims-for-applications-that-have-a-gui)以及[官方文檔(忽略特定文件)](https://docs.chocolatey.org/en-us/create/create-packages#how-do-i-exclude-executables-from-getting-shims)。

個人理解這部分功能是為了實現類似於環境變量的功能，實際測試對於我的使用過程中幫助不大。

## 自動化腳本

正如您使用 PowerShell 一樣，您可以充分利用 Chocolatey。 那麼你幾乎可以做您需要的任何事情。 Choco 有一些非常方便的[內置函數](https://docs.chocolatey.org/en-us/create/functions)來實現這些功能。

## 如何成為一個維護者？

要成為Chocolatey包的維護者，你需要遵循以下步驟：

1. **創建一個Chocolatey包**：首先，你需要創建一個Chocolatey包。這個包應該包含你的項目的所有必要文件和安裝腳本。你可以參考[Chocolatey的官方文檔](https://docs.chocolatey.org/en-us/create/create-packages/)來了解如何創建一個包。

2. **測試你的包**：在提交你的包之前，你需要在本地測試它以確保它能夠正確地安裝和卸載。你可以使用`choco install <package>`和`choco uninstall <package>`命令來測試你的包。

3. **提交你的包**：一旦你的包通過了本地測試，你就可以將它提交到Chocolatey社區包源（community package repository）。你需要在Chocolatey網站上創建一個帳戶，並遵循提交流程來提交你的包。

4. **等待審核**：提交後，你的包將會被Chocolatey團隊審核。如果一切順利，你的包將會被接受並添加到Chocolatey社區包源中。

5. **維護你的包**：一旦你的包被接受，你就需要對其進行維護。這意味著當你的項目有更新時，你需要更新你的Chocolatey包以反映這些更改。

## 參考

- [Ventoy 的 Chocolately 包配置](https://github.com/asheroto/ChocolateyPackages/tree/master/ventoy)
