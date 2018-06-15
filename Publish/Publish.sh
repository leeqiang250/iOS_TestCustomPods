echo "--------------------(开始参数配置)--------------------"



#teamID需要配置

#主机地址
hostserver="www.suizhi.com"
#编译模式：AppStore、AdHoc
compileModel="AdHoc"
#编译SDK：可用命令（xcodebuild -showsdks）查看
compileSDK="iphoneos11.3"
#导出参数：AdHocExportOptions、AppStoreExportOptions（需要设置teamID）
if [ "${compileModel}" == "AppStore" ]; then
exportOptions="AppStoreExportOptions"
else
exportOptions="AdHocExportOptions"
fi
#工作空间
workspace="TestCustomPods"
#目标工程
targetProject="TestCustomPods"
#plist文件路径
plistPath=${workspace}/Info.plist
#发布时间
releaseTime=`date "+%Y%m%d%H%M%S"`
#当前路径
workspacePath=`pwd`
#版本编号
versionNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${plistPath}")
#编译编号
shortNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${plistPath}")
#编译编号自增
shortNumber=$(expr $shortNumber + 1)
#写入自增后的编译编号
/usr/libexec/Plistbuddy -c "Set CFBundleVersion $shortNumber" "${plistPath}"
#编译路径
buildPath=${workspacePath}/${releaseTime}/
#导出包名称
exportPackageName=${targetProject}_${versionNumber}.${shortNumber}_${releaseTime}_${compileModel}_${hostserver}
#IPA名称
ipaName=${exportPackageName}.ipa
#IPA路径
ipaPath=${buildPath}${ipaName}
#Archive名称
archiveName=${exportPackageName}.xcarchive
#Archive路径
archivePath=${buildPath}${archiveName}



echo "--------------------(结束参数配置)--------------------"



echo "--------------------(开始过程)--------------------"



echo "--------------------(创建编译路径)--------------------"
#删除IPA路径
rm -rf ${buildPath}
#创建IPA路径
mkdir ${buildPath}



echo "--------------------(更新Pods)--------------------"
#更新Pods
#####pod update --verbose --no-repo-update



echo "--------------------(清理工程)--------------------"
#清理工程
xcodebuild clean -workspace ${worckspace}.xcworkspace -scheme ${targetProject} -configuration Release



echo "--------------------(编译源代码)--------------------"
#编译源代码
xcodebuild archive -workspace ${workspace}.xcworkspace -scheme ${targetProject} -configuration Release -archivePath ${archivePath} -sdk ${compileSDK}



echo "--------------------(生成IPA)--------------------"
#导出IPA
xcodebuild -exportArchive -archivePath ${archivePath} -exportPath ${exportPackageName} -exportOptionsPlist ${workspacePath}/Publish/${exportOptions}.plist



echo "--------------------(移动IPA)--------------------"
#删除Archive
rm -rf ${archivePath}
#遍历导出包
for file in ${exportPackageName}/*
do
if test -f $file; then
if [ "${file##*.}" == "ipa" ]; then
#移动IPA
mv $file ${ipaPath}
fi
fi
done
#移除导出包
rm -rf ${exportPackageName}



echo "--------------------(参数列表)--------------------"
echo "工作路径：${workspacePath}"
echo "工作空间：${workspace}"
echo "目标工程：${targetProject}"
echo "编译模式：${compileModel}"
echo "编译SDK：${compileSDK}"
echo "发布时间：${releaseTime}"
echo "版本编号：${versionNumber}"
echo "编译编号：${shortNumber}"
echo "IPA名称：${ipaName}"
echo "IPA路径：${ipaPath}"



echo "--------------------(结束过程)--------------------"
