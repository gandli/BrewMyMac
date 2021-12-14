#!/bin/bash
###
# @Author: gandli
# @Date: 2021-12-14 20:48:39
# @LastEditTime: 2021-12-14 20:51:13
# @LastEditors: gandli
# @Description:
# @FilePath: /BrewMyMac/clear.sh
# 可以输入预定的版权声明、个性签名、空行等
###

# 文件计数
file_count=0
link_count=0
incomplete_count=0

# 清理 HomeBrew Cask 下载缓存
for cask_link in $(find ~/Library/Caches/Homebrew/Cask -type l); do
    # 将 Cask 软件包移至废纸篓
    # let file_count++
    # trash $(realpath $cask_link)
    let link_count++
    rm $link
done

# 清理 HomeBrew 下载缓存
for link in $(find ~/Library/Caches/Homebrew -type l); do
    let file_count++
    trash $(realpath $link)
    let link_count++
    rm $link
done

# 获取 *.incomplete 文件数量
let incomplete_count=$(ls -l ~/Library/Caches/Homebrew/downloads/*.incomplete | wc -l)
# 清理未完成的下载
rm ~/Library/Caches/Homebrew/downloads/*.incomplete

# 复数输出函数
plural() {
    if [ $1 -gt 1 ]; then
        echo "$1 $2s"
    else
        echo "$1 $2"
    fi
}

# 输出消息提示
echo "Pruned $(plural $link_count "symbolic link"), $(plural $file_count "file") and $(plural $incomplete_count "incomplete download") from $(realpath ~/Library/Caches/Homebrew)"

# 调用 `brew cleanup`
# echo 'Running `brew cleanup`'
# brew cleanup
