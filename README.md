## NetFileService

### AI工具链中这是独立的文件传输工具

- **该项目是基于ZS+p2pVM构建**
- 编写原因1：由于Z-AI的建模系统都是大文件，导致了在HPC使用远程桌面传大文件非常慢，远程桌面很容易断，并且上传下载不能断点
- 编写原因2：用FTP很舒服，但是安全性以及配置复杂，如果几十台的超算群，配置太麻烦了

## 特别说明

- NetFileService验证系统采用比特币的抗量子密码技术
- NetFileService的中途传输协议不可能被破解
- **编译NetFileService需要** [ZServer4D](https://github.com/PassByYou888/ZServer4D) 

## 项目已开源

**方便大家日常使用和学习，我把NetFileService做成了开源项目**

### 2021-3-14最近更新

- FileService使用lazarus+fpc移植到了arm linux，p2pVM支持良好，需要自行搭建linux下的Lazarus环境

### 过去更新

- 新增支持文件拖动，可直接将文件拖至客户端完成上传
- 客户端可显示密码

## by,qq600585
