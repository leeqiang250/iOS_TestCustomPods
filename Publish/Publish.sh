#--------------------(开始配置参数)--------------------
#主机地址
hostserver="www.suizhi.com"
#编译模式：Release、Debug
compileModel="Release"
#工作空间
workspace="TestCustomPods"
#目标工程
targetProject="TestCustomPods"
#发布时间
releaseTime=`date "+%Y%m%d%H%M%S"`
#当前路径
workspacePath=`pwd`


#版本号
versionNumber="1.2.3.4"
#编译号
compileNumber="1111"


#编译路径
buildPath=${workspacePath}/${releaseTime}/
#IPA名称
ipaName=${targetProject}_${compileModel}_${versionNumber}.${compileNumber}_${releaseTime}_${hostserver}.ipa
#IPA路径
ipaPath=${buildPath}${ipaName}
















#证书名称
#code_sign_identity="iPhone Distribution: Beijing PYC Software Co., Ltd. (FA78T6VRG8)"
#provisioning_profile=""
#APP名称
#appName="TestCustomPods"


#APP原路径
#pakageSourcePath=${TARGET_BUILD_DIR}${appName}.app





#--------------------(结束配置参数)--------------------


#echo "$PROJECT_DIR"
#echo "$TARGET_BUILD_DIR"


echo "--------------------(开始过程)--------------------"



echo "--------------------(删除安装包)--------------------"
rm -rf ${buildPath}
mkdir ${buildPath}



echo "--------------------(更新Pods)--------------------"
#pod update --verbose --no-repo-update



echo "--------------------(清理工程)--------------------"
#xcodebuild clean -workspace ${worckspace}.xcworkspace -scheme ${targetProject} -configuration ${compileModel}



echo "--------------------(编译源文件)--------------------"
#xcodebuild archive -workspace ${workspace}.xcworkspace -scheme ${targetProject} -configuration ${compileModel} -archivePath ${workspacePath}/${targetProject}


#xcodebuild archive -workspace ../TestCustomPods.xcworkspace -scheme TestCustomPods -configuration Release -archivePath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/zzz/" clean build -derivedDataPath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/xxx/"



#生成ipa
#xcodebuild -exportArchive -archivePath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/zzz.xcarchive" -exportPath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/xxx" -exportOptionsPlist "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/AdHocExportOptions.plist"


#xcodebuild archive -TestCustomPods.xcworkspace -TestCustomPods
#-Release
#-${workspacePath}
#CODE_SIGN_IDENTITY=${certificateName}
#PROVISIONING_PROFILE=描述文件UUID


#xcodebuild -workspace name.xcworkspace -scheme schemename -configuration Release -sdk iphoneos build CODE_SIGN_IDENTITY="$(CODE_SIGN_IDENTITY)" PROVISIONING_PROFILE="$(PROVISIONING_PROFILE)"

#xcodebuild -workspace ../TestCustomPods.xcworkspace -scheme TestCustomPods -configuration Release -sdk iphoneos11.1 IPHONEOS_DEPLOYMENT_TARGET=9.0


#xcrun -sdk iphoneos PackageApplication -v /Users/liqiang/Library/Developer/Xcode/DerivedData/TestCustomPods-bdamjkpldwkebzeskshvjchhgyyc/Build/Products/Release-iphoneos/TestCustomPods.app -o /Users/liqiang/Library/Developer/Xcode/DerivedData/TestCustomPods-bdamjkpldwkebzeskshvjchhgyyc/Build/Products/Release-iphoneos/TestCustomPods.ipa



echo "--------------------(移动安装包)--------------------"
#mv "${pakageSourcePath}" "${pakageTargetPath}${ipaName}"



echo "--------------------(参数列表)--------------------"
echo "工作路径：${workspacePath}"
echo "工作空间：${workspace}"
echo "目标工程：${targetProject}"
echo "编译模式：${compileModel}"
echo "发布时间：${releaseTime}"
echo "版本编号：${versionNumber}"
echo "编译编号：${compileNumber}"
echo "IPA名称：${ipaName}"
echo "IPA路径：${ipaPath}"



echo "--------------------(结束过程)--------------------"
