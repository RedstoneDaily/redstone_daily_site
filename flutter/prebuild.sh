#!/bin/bash

aegis_enabled=false
aegis_env_type=""

# 遍历所有的命令行参数
for ((i=1; i<=$#; i++)); do
    arg=${!i}
    if [ "$arg" == "--aegis" ]; then
		aegis_enabled=true
        next_index=$((i + 1))
        if [ $next_index -le $# ]; then
            next_arg=${!next_index}
            if [[ ! "$next_arg" == --* ]]; then
                # 下一个参数不是以 "--" 开头，将其作为值
                aegis_env_type=$next_arg
            fi
        fi
    elif [[ "$arg" == --* ]]; then
		# 如果参数以 "--" 开头，但不是 "--aegis"，则是未知参数
        echo "Unknown argument: $arg"
	fi
done

# - `prod` 生产环境
# - `dev` 开发环境
# - `gray` 灰度环境
# - `pre` 预发布环境
# - `daily` 日发布环境
# - `local` 本地环境
# - `test` 测试环境
# - `others` 其他环境(默认值)

# 将其他值转换为默认值
case $aegis_env_type in
	prod|dev|gray|pre|daily|local|test)
		;;
	*)
		aegis_env_type="others"
		;;
esac

ENV_TYPE=$aegis_env_type
export ENV_TYPE
if [ $aegis_enabled == true ]; then
  echo "AEGIS is enabled, inserting script snippet into index.html"
  # 但在此之前需要先把ENV_TYPE值替换入aeigs-script.html中
  AEGIS_SCRIPT=$(envsubst web/aegis-script.html)
else
  AEGIS_SCRIPT=""
fi

export AEGIS_SCRIPT
# effectly whitelisted it, prevented it to be replaced by envsubst
export FLUTTER_BASE_HREF="\$FLUTTER_BASE_HREF"
envsubst < web/template.html > web/index.html

exit 0