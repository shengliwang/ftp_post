## 说明
这是一个用于将shell命令的输出，转换为html文件。  
然后上传到ftp服务器的shell脚本。  

## 配置

```shell
declare -a cmds=("ifconfig" "ip addr" "cmdssssss") # 要执行的命令列表
ftp_server="" # ftp 服务器(gnu的命令支持ipv6)
ftp_user_name=""
ftp_user_passwd=""
ftp_up_dir="" # 要上传到ftp_server 上的目录文件夹下
```

## cron 创建自动任务
archlinux 下举例
```shell
crontab -e 
```
然后填写入`* * * * * /path/to/ftp_post.sh` (每分钟执行一次)
和`@reboot /path/to/ftp_post.sh` (每次启动时执行一次)    

注意：如果系统没有安装cron，则按照如下安装（archlinux举例）
```shell
pacman -S cronie
systemctl enable cronie.service
systemctl start cronie.service
```

## 注意事项

1.执行前要给脚本执行权限
```
chmod +x put.sh
```
2.标准输出，标准错误都会重定向到文件中
3. ftp客户端安装(arclinux下安装gnu的ftp命令：其支持ipv6)

```shell
sudo pacman -S inetutils
```
>	ftp — Simple ftp client provided by GNU Inetutils
	https://www.gnu.org/software/inetutils/manual/inetutils.html#ftp-invocation || inetutils

