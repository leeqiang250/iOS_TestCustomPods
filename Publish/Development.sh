#--------------------(开始配置参数)--------------------
#主机地址
hostserver="www.suizhi.com"
#版本号
versionNumber="1.2.3.4"
#编译号
buildNumber="1111"
#证书名称
code_sign_identity="iPhone Distribution: Beijing PYC Software Co., Ltd. (FA78T6VRG8)"
provisioning_profile=""
#APP名称
appName="TestCustomPods"
#安装包后缀名
pakageSuffix="ipa"
#当前时间
currentDay=`date "+%Y%m%d%H%M%S"`
#当前路径
currentPath=`pwd`
#APP原路径
pakageSourcePath=${TARGET_BUILD_DIR}${appName}.app
#安装包目标路径
pakageTargetPath=${SRCROOT}/Publish/${currentDay}/
#安装包名称
pakageName=${appName}_${versionNumber}.${buildNumber}_${currentDay}_${hostserver}



#--------------------(结束配置参数)--------------------


#echo "$PROJECT_DIR"
#echo "$TARGET_BUILD_DIR"


echo "--------------------(开始过程)--------------------"



echo "--------------------(删除安装包)--------------------"
rm -rf ${pakageTargetPath}
mkdir ${pakageTargetPath}



echo "--------------------(更新Pods)--------------------"
pod update --verbose --no-repo-update



echo "--------------------(编译源文件)--------------------"


xcodebuild clean -workspace ../TestCustomPods.xcworkspace -scheme TestCustomPods


#xcodebuild -target targetName clean

xcodebuild archive -workspace ../TestCustomPods.xcworkspace -scheme TestCustomPods -configuration Release -archivePath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/zzz/"


#xcodebuild archive -workspace ../TestCustomPods.xcworkspace -scheme TestCustomPods -configuration Release -archivePath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/zzz/" clean build -derivedDataPath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/xxx/"



#生成ipa
xcodebuild -exportArchive -archivePath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/zzz.xcarchive" -exportPath "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/xxx" -exportOptionsPlist "/Users/liqiang/Documents/GitHub/iOS_TestCustomPods/Publish/AdHocExportOptions.plist"

open $MWBuildDir

作者：肆意二货
链接：http://www.jianshu.com/p/36d2c6d65aa7
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


#xcodebuild archive -TestCustomPods.xcworkspace -TestCustomPods
#-Release
#-${currentPath}
#CODE_SIGN_IDENTITY=${certificateName}
#PROVISIONING_PROFILE=描述文件UUID


#xcodebuild -workspace name.xcworkspace -scheme schemename -configuration Release -sdk iphoneos build CODE_SIGN_IDENTITY="$(CODE_SIGN_IDENTITY)" PROVISIONING_PROFILE="$(PROVISIONING_PROFILE)"

#xcodebuild -workspace ../TestCustomPods.xcworkspace -scheme TestCustomPods -configuration Release -sdk iphoneos11.1 IPHONEOS_DEPLOYMENT_TARGET=9.0


#xcrun -sdk iphoneos PackageApplication -v /Users/liqiang/Library/Developer/Xcode/DerivedData/TestCustomPods-bdamjkpldwkebzeskshvjchhgyyc/Build/Products/Release-iphoneos/TestCustomPods.app -o /Users/liqiang/Library/Developer/Xcode/DerivedData/TestCustomPods-bdamjkpldwkebzeskshvjchhgyyc/Build/Products/Release-iphoneos/TestCustomPods.ipa



echo "--------------------(移动安装包)--------------------"
#mv "${pakageSourcePath}" "${pakageTargetPath}${pakageName}"



echo "--------------------(安装包路径)--------------------"
echo "${pakageTargetPath}${pakageName}"


echo "$IPAPATH"





echo "--------------------(结束过程)--------------------"
