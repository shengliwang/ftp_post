#!/usr/bin/bash

wd="/root" # 配置工作目录

declare -a cmds=("date" "ifconfig" "ip addr" "cmdssssss") # 要执行的命令列表

###########  生成index.html ##############
tmp_index_html=${wd}/"index.html.tmp"
echo "" > ${tmp_index_html} # 清空index.html的数据
for cmd in "${cmds[@]}" #遍历命令列表
do
	echo  "<h1>cmd '${cmd}' result: </h1>" >> ${tmp_index_html}

	echo "<pre>" >> ${tmp_index_html} # 添加html标签，使文本保持原样显示
	${cmd} &>> ${tmp_index_html} # 标准输出，标准错误都会重定向到文件中
	echo "" >> ${tmp_index_html}
	echo "</pre>" >> ${tmp_index_html}
done

ftp_server="" # ftp 服务器(gnu的命令支持ipv6)
ftp_user_name=""
ftp_user_passwd=""
ftp_up_dir="public_html" # 要上传到ftp_server 上的目录文件夹下

###########  上传index.html到ftp服务器上 ##############
log_file=${wd}/"put_log"  # 输出log到日志文件中

echo "---------------------------" >> ${log_file}
date &>> ${log_file}

ftp -n << EOF &>> ${log_file}
open ${ftp_server}
user ${ftp_user_name} ${ftp_user_passwd}
binary
cd ${ftp_up_dir} 
prompt
put ${tmp_index_html} addr.html
close
bye
EOF
