#!/bin/bash

pwd
if [ ! -d $ANDROID_ROOT/external/chromium-webview ]; then
    wget https://github.com/SourceLab081/uploadz/releases/download/v0.0.2/chromium.zip;unzip -o chromium.zip -d $ANDROID_ROOT/external/chromium-webview/;rm chromium.zip 
fi  

rm $ANDROID_ROOT/packages/apps/Etar/external/ex/framesequence/samples/FrameSequenceSamples/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/common/tests/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/framesequence/jni/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/calendar/tests/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/camera2/portability/tests/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/camera2/utils/tests/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/common/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/framesequence/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/calendar/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/camera2/portability/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/camera2/public/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/ex/camera2/utils/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/chips/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/chips/tests/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/chips/sample/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/timezonepicker/Android.bp
rm $ANDROID_ROOT/packages/apps/Etar/external/colorpicker/Android.bp

set -e

MB=$1

USE_PATCH=0
if [ "$MB" != "--mb" ]; then
    USE_PATCH=1
fi

OLD_WD=`pwd`
cd hybris-patches

if [ "$USE_PATCH" == "1" ]; then
    for patch in `find . -name *.patch |sort`; do
        cd $OLD_WD/$(dirname $patch)
        patch -p1 < $OLD_WD/hybris-patches/$patch
    done
else
    MBS=$(find . -name *.patch -exec dirname {} \; |sort -u)
    for mb in $MBS; do
        cd $OLD_WD/$mb
        git am $OLD_WD/hybris-patches/$mb/*.patch
    done
fi

