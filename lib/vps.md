# vps配置

标签（空格分隔）： 收藏

---

## Root登录

```bash
# port为vps的ssh端口号，默认为22
# ip为vps的IP
ssh -p <port> root@<ip>
```

## 修改Root密码

```bash
passwd
```

## 创建普通用户

```bash
# 添加用户
useradd <username>

# 设置密码
passwd <username>
```

## 授予管理员权限

```bash
# 编辑/etc/sudoers
# 在root ALL=(ALL) ALL 处添加 <username> ALL=(ALL) ALL
vi /etc/sudoers
```

## SSH密钥登录

```bash
# 切换用户登录
sudo su -l <username>

# 生成ssh密钥
ssh-keygen

# 另一个bash中上传本地SSH公钥
scp -P port 本地SSH公钥文件 <username>@ip:/home/<username>/.ssh/authorized_keys

# 修改权限
cd ~/.ssh
chmod 600 authorized_keys
```

## GitHub添加SSH

```bash
# 查看ssh公钥
# 将公钥添加到GitHub的SSH密钥中
cd ~/.ssh
cat id_rsa.pub
```

## 禁用Root登录

```bash
# 编辑/etc/ssh/sshd_config
# PasswordAuthentication yes 改为 PasswordAuthentication no
# PermitRootLogin yes 改为 PermitRootLogin no
sudo vi /etc/ssh/sshd_config

# 重启ssh服务
sudo service ssh restart
```

## yum命令

```bash
# 查看已安装软件
yum list installed

# 查看软件可安装包
yum list <soft>

# 安装软件包
sudo yum -y install <soft>

# 卸载软件包
yum remove <soft>

# 查看软件包
yum info <soft>

# 升级软件包
yum update <soft>
```

## 安装epel-release

用于安装较新版本的软件

```bash
# 查看是否已安装
yum info epel-release

# 安装epel-release
sudo yum -y install epel-release
```

## 安装wget

```bash
# 安装wget
sudo yum -y install wget
```

## 安装vim

```bash
# 安装wget
sudo yum -y install vim
```

## 搭建ShadowSocks

```bash
# 下载脚本
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh

# 添加执行权限
chmod +x shadowsocks-all.sh

# 执行脚本安装
sudo ./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

## 安装BBR

网络优化加速

```bash
# 下载脚本
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh

# 添加执行权限
chmod +x bbr.sh

# 执行脚本安装
sudo ./bbr.sh
```

## 安装git

```bash
# 安装git
sudo yum -y install git

# 验证
git version

# 配置
git config --global user.name "<username>"
git config --global user.email <email>
git config --list
```

## 安装nvm

```bash
# 下载命令并执行
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# 加入系统环境
source ~/.bashrc

# 查看可用的node版本
nvm ls-remote

# 下载node版本
nvm install <version>

# 查看已下载的node版本
nvm list

# 使用已下载某个node版本
nvm use <version>

# 将已下载的某个node版本设为默认值
nvm alias default <version>
```

## 安装pm2

```bash
# 安装pm2
sudo npm install pm2 -g

# 查看pm2运行服务
pm2 list

# 查看服务日志
pm2 log <service>
```

## 安装gitbook

```bash
# 安装gitbook-cli
sudo npm install gitbook-cli -g

# 验证
gitbook -V
```

## 安装nginx

```bash
# 安装nginx
sudo yum -y install nginx

# 修改nginx运行用户
# user nginx 改为 user <username>
sudo vi /etc/nginx/nginx.conf

# 启动nginx
sudo nginx

# 测试配置文件
sudo nginx -t

# 重启nginx
sudo nginx reload

# 添加nginx配置文件
sudo vi /etc/nginx/conf.d/<name>.conf

# 查看nginx服务
ps aux|grep nginx
```

## 安装mongodb

### 安装

下载源码

```bash
# 下载
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel62-3.2.7.tgz

# 解压
tar -xvf mongodb-linux-x86_64-rhel62-3.2.7.tgz

# 重命名
mv mongodb-linux-x86_64-rhel62-3.2.7 mongodb
```

配置环境变量

```bash
# 配置
sudo vim /etc/profile.d/mongo.sh

# mongo.sh内容为
export MONGODB_HOME=/usr/local/mongodb
export PATH=$MONGODB_HOME/bin:$PATH

# 启用
sourch /etc/profile
```

验证

```bash
mongod -v
```

### 启动

创建数据库文件夹

```bash
# 使用root账户登录，防止mongodb启动时报权限错误
su -
mkdir -p /data/mongodb
touch /data/mongodb/log/mongodb.log
```

命令行参数启动

```bash
mongodb --dbpath <dbpath> --logpath <logpath> --fork
```

配置文件启动

```bash
# 创建配置文件
vim /etc/mongodb.conf

# mongodb.conf内容为
dbpath=/data/mongodb
logpath=/data/mongodb/log/mongodb.log
logappend=true
port=27017
fork=true
# auth = true # 先关闭, 创建好用户再启动

# 通过配置文件启动
mongod -f ~/data/mongodb/mongodb.conf
```

### 权限管理

创建root用户

```bash
# 连接mongodb
mongo

# 切换到admin库
use admin

# 创建root账号
db.createUser({user: "<user>", pwd: "<pwd>", roles: ["root"]})

# 认证root账号
db.auth("<user>", "<pwd>") # 1代表成功，0代码失败
```

启用auth

```
# mongodb.conf中添加auth验证
auth=true
```

重启mongodb服务

```
# 通过mongo关闭mongodb
use admin
db.shutdownServer()

# 通过pid关闭mongodb
ps aux|grep mongo
kill -2 <pid>

# 启动mongodb
mongod -f /etc/mongodb.conf
```

验证

```bash
mongo
show dbs # 报无权限错误

use admin
db.auth("<user>", "<pwd>")
show dbs # 可以显示
```

mongoose连接

```javascript
mongooes.connect("mongodb://user:password@localhost:27017/database", {useNewUrlParser: true})
```
