#channels[${#channels[*]}]=AppStore_SPF
#channelCodes[${#channelCodes[*]}]=A001S
#packages[${#packages[*]}]=AppStore_SPF
#compiles[${#compiles[*]}]=AppStore

channels[${#channels[*]}]=SSP
channelCodes[${#channelCodes[*]}]=E002S
packages[${#packages[*]}]=SSP-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=GXS
channelCodes[${#channelCodes[*]}]=E003G
packages[${#packages[*]}]=GXS-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=BNE
channelCodes[${#channelCodes[*]}]=E004B
packages[${#packages[*]}]=BNE-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=HNBC
channelCodes[${#channelCodes[*]}]=E005H
packages[${#packages[*]}]=HNBC-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=BXS
channelCodes[${#channelCodes[*]}]=E006B
packages[${#packages[*]}]=BXS-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=WSKJ
channelCodes[${#channelCodes[*]}]=E007W
packages[${#packages[*]}]=WSKJ-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=DLM
channelCodes[${#channelCodes[*]}]=E008D
packages[${#packages[*]}]=DLM-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=KTZS
channelCodes[${#channelCodes[*]}]=E009K
packages[${#packages[*]}]=KTZS-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=XBJ
channelCodes[${#channelCodes[*]}]=E010X
packages[${#packages[*]}]=XBJ-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=HK
channelCodes[${#channelCodes[*]}]=E011H
packages[${#packages[*]}]=HK-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=RE
channelCodes[${#channelCodes[*]}]=E012R
packages[${#packages[*]}]=RE-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=INTG
channelCodes[${#channelCodes[*]}]=E013I
packages[${#packages[*]}]=INTG-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=B8
channelCodes[${#channelCodes[*]}]=E014B
packages[${#packages[*]}]=B8-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=FGCJ
channelCodes[${#channelCodes[*]}]=E015F
packages[${#packages[*]}]=FGCJ-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=STB
channelCodes[${#channelCodes[*]}]=E016S
packages[${#packages[*]}]=STB-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=BEESTORE
channelCodes[${#channelCodes[*]}]=E017B
packages[${#packages[*]}]=BEESTORE-Kcash
compiles[${#compiles[*]}]=Enterprise

channels[${#channels[*]}]=Enterprise
channelCodes[${#channelCodes[*]}]=E001O
packages[${#packages[*]}]=Kcash
compiles[${#compiles[*]}]=Enterprise



#发布时间
releaseTime=`date "+%Y%m%d%H%M%S"`

num=${#channels[*]}
for(( i=0;i<num;i++ )) do
echo "--------------------(开始参数配置)--------------------"
#渠道名称
channel=${channels[i]}
#渠道代码
channelCode=${channelCodes[i]}
#导出包名称
package=${packages[i]}
#编译模式：AppStore、AdHoc、Enterprise
compile=${compiles[i]}
#编译SDK：可用命令（xcodebuild -showsdks）查看
compileSDK="iphoneos11.3"
#导出参数：AdHocExportOptions、AppStoreExportOptions、EnterpriseExportOptions（需要设置teamID）
if [ "${compile}" == "AppStore" ]; then
exportOptions="AppStoreExportOptions"
elif [ "${compile}" == "AdHoc" ];then
exportOptions="AdHocExportOptions"
else
exportOptions="EnterpriseExportOptions"
fi
#工作空间
workspace="TestCustomPods"
#目标工程
targetProject="TestCustomPods"
#plist文件路径
plistPath=${workspace}/Info.plist
#当前路径
workspacePath=`pwd`
#版本编号
versionNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${plistPath}")
#编译编号
shortNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${plistPath}")
#编译编号自增
#shortNumber=$(expr $shortNumber + 1)
#写入自增后的编译编号
#/usr/libexec/Plistbuddy -c "Set CFBundleVersion $shortNumber" "${plistPath}"
#编译路径
buildPath=${workspacePath}/${versionNumber}.${shortNumber}_${releaseTime}/
#IPA名称
ipaName=${package}.ipa
#IPA路径
ipaPath=${buildPath}${ipaName}
#Archive名称
archiveName=${package}.xcarchive
#Archive路径
archivePath=${buildPath}${archiveName}
#写入渠道名
/usr/libexec/Plistbuddy -c "Set Channel $channel" "${plistPath}"
#写入渠道码
/usr/libexec/Plistbuddy -c "Set ChannelCode $channelCode" "${plistPath}"



echo "--------------------(结束参数配置)--------------------"



echo "--------------------(开始过程)--------------------"



echo "--------------------(创建编译路径)--------------------"
#删除IPA路径
#rm -rf ${buildPath}
#创建IPA路径
mkdir ${buildPath}



echo "--------------------(更新Pods)--------------------"
#更新Pods
#pod update --verbose --no-repo-update

#pod 'LBaseClass'



echo "--------------------(清理工程)--------------------"
#清理工程
xcodebuild clean -workspace ${worckspace}.xcworkspace -scheme ${targetProject} -configuration Release



echo "--------------------(编译源代码)--------------------"
#编译源代码
xcodebuild archive -workspace ${workspace}.xcworkspace -scheme ${targetProject} -configuration Release -archivePath ${archivePath} -sdk ${compileSDK}



echo "--------------------(生成IPA)--------------------"
#导出IPA
xcodebuild -exportArchive -archivePath ${archivePath} -exportPath ${package} -exportOptionsPlist ${workspacePath}/Publish/${exportOptions}.plist



echo "--------------------(移动IPA)--------------------"
#删除Archive
rm -rf ${archivePath}
#遍历导出包
for file in ${package}/*
do
if test -f $file; then
if [ "${file##*.}" == "ipa" ]; then
#移动IPA
mv $file ${ipaPath}
fi
fi
done
#移除导出包
rm -rf ${package}



echo "--------------------(参数列表)--------------------"
echo "工作路径：${workspacePath}"
echo "工作空间：${workspace}"
echo "目标工程：${targetProject}"
echo "编译模式：${compile}"
echo "编译SDK：${compileSDK}"
echo "发布时间：${releaseTime}"
echo "版本编号：${versionNumber}"
echo "编译编号：${shortNumber}"
echo "IPA名称：${ipaName}"
echo "IPA路径：${ipaPath}"



echo "--------------------(结束过程)--------------------"

done
