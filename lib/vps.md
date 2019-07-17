# VPS配置

## Root登录

```bash
# port为VPS的ssh端口号，默认为22
# ip为VPS的IP
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
# 编辑ssd_config
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

## 安装node

```bash
# 安装node
sudo yum -y install nodejs

# 验证
node -v
npm -v
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