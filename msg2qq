#


http_address="http://10.10.10.100:5700"

text_exists(){
	if [ ! "$p_msg" ]; then
		help
		exit 1
	fi
}

upload(){
	declare -g path=$(curl -X POST $http_address/upload_file \
	-H "Content-Type: multipart/form-data" \
	-F "file=@$p_f" -s |jq -r '.data' | jq -r '.file')

	echo "文件在服务器缓存中的路径:  $path"

	if [ "$path" = "null"  ]; then
		echo "响应文本流中没有检索到键值 \"data\" \"file\""
		exit 1
	fi

	echo "缓存路径: \"$path\""

	if [ ! "$p_n" ]; then
		p_n=$(echo "$p_f" | rev | cut -d '/' -f1 | rev)
	fi

	echo "文本的标注名称: \"$p_n\""

}
help() {
	echo -e "	-h			打印命令详细信息" 1>&2
	echo -e	"	-t [数字]		必须的：\n					目标QQ号或群号" 1>&2
	echo -e "	-g			这是一个群组类型的消息" 1>&2
	echo -e "	-f [本机本地文件路径]	发送一个文件" 1>&2
	echo -e "	-n [字符串]		可选的：\n					文件的标注名称，留空以使用本机的本地文件名称" 1>&2
	echo -e "	-s [字符串]		如果没有指定 '-f' 则这是必须的：\n					要发送的文本" 1>&2
}

# 默认是私聊类型，发送私聊消息
while getopts ":h:t:gf:n:s:" opt; do
	case ${opt} in
		h)
			help
			;;
		t)
			p_t="$OPTARG"
			;;
		g)
			group_msg=true
			;;
		f)
			p_f="$OPTARG"
			;;
		n)
			p_n="$OPTARG"
			;;
		s)
			p_msg="$OPTARG"
			;;
		\?)
			echo "$0 必须指定一个参数" >&2
			help
			exit 1

			;;
		:)
			help
			;;
	esac
done

shift $((OPTIND -1))

#echo "参数1: $p_t"
#echo "参数2: $group_msg"
#echo "参数3: $p_f"
#echo "参数4: $p_n"
#echo "参数5: $p_msg"

#echo "剩余参数: $@"

if [ "$group_msg" ]; then
	echo -e "[群组消息]\n"
	if [ "$p_f" ] ;then
		# 先从本地上传到服务器
		upload

		curl -X POST $http_address/upload_group_file \
		-H "Content-Type: application/json" \
		-d "{\"group_id\": \"$p_t\",\"file\":\"$path\", \"name\":\"$p_n\"}"
	else
		text_exists

		curl -X POST $http_address/send_group_msg \
		-H "Content-Type: application/json" \
		-d "{\"group_id\": \"$p_t\",\"message\":\"$p_msg\"}"
	fi
else
	echo -e "[私聊消息]\n"
	if [ "$p_f" ] ;then
		# 先从本地上传到服务器
		upload

		curl -X POST $http_address/upload_private_file \
		-H "Content-Type: application/json" \
		-d "{\"user_id\": \"$p_t\",\"file\":\"$path\", \"name\":\"$p_n\"}"
	else
		text_exists

		curl -X POST $http_address/send_private_msg \
		-H "Content-Type: application/json" \
		-d "{\"user_id\": \"$p_t\",\"message\":\"$p_msg\"}"
	fi
fi


