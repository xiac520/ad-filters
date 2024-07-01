#!/bin/bash
#进入目录
cd $(cd "$(dirname "$0")";pwd)
#下载规则
urls=(
    "https://raw.githubusercontent.com/Cats-Team/AdRules/main/dns.txt"
    "https://raw.githubusercontent.com/LoopDns/Fuck-you-MIUI/main/Fhosts"
    "https://raw.githubusercontent.com/francis-zhao/quarklist/master/dist/quarklist.txt"
    "https://raw.githubusercontent.com/blocklistproject/Lists/master/adguard/ads-ags.txt"
    "https://gitlab.com/quidsup/notrack-blocklists/-/raw/master/trackers.list"
    "https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/multi.txt"
    "https://raw.githubusercontent.com/guandasheng/TheBestAdrules/master/rules.txt"
    "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/all.txt"
    "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/skyrules.txt"
    "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/ok.txt"
    "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/ubcn.txt"
    "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/manhua-plus.txt"
    "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/manhua-max.txt"
    "https://raw.githubusercontent.com/BlueSkyXN/AdGuardHomeRules/master/manhua.txt"
    "https://anti-ad.net/adguard.txt"
    "https://easylist-downloads.adblockplus.org/easylist.txt"
    "https://easylist-downloads.adblockplus.org/easylistchina.txt"
    "https://easylist-downloads.adblockplus.org/easyprivacy.txt"
    "https://easylist-downloads.adblockplus.org/easylist-cookie.txt"
    "https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt"
    "https://www.i-dont-care-about-cookies.eu/abp/"
    "https://raw.githubusercontent.com/zsakvo/AdGuard-Custom-Rule/master/rule/zhihu.txt"
    "https://raw.githubusercontent.com/zsakvo/AdGuard-Custom-Rule/master/rule/zhihu-strict.txt"
    "https://raw.githubusercontent.com/Goooler/1024_hosts/master/hosts"
    "https://adaway.org/hosts.txt"
    "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
    "https://hblock.molinero.dev/hosts"
    "http://winhelp2002.mvps.org/hosts.txt"
    "https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/basic/hosts.txt"
    "https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/full/hosts.txt"
    "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts.txt"
)

for url in "${urls[@]}"; do
    curl -sS "$url" >> dns.txt
done
#添加自定义规则
cat ../rules/myrules.txt >> dns.txt
#修复换行符问题
sed -i 's/\r//' dns.txt
#去重
python sort.py dns.txt 
#压缩优化
hostlist-compiler -c dns.json -o dns-output.txt
#仅输出黑名单
cat dns-output.txt | grep -P "^\|\|.*\^$" > dns.txt
#再次排序
python sort.py dns.txt 
#移动规则
mv dns.txt ../rules/dns.txt
#清除缓存
rm -rf ./*.txt
