LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)	
LOCAL_MODULE := libRenderSystem_OGL
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/RenderSystem_OGL/android/$(TARGET_ARCH_ABI)/libRenderSystem_OGL.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libAppPlayJNI


FILE_LIST := $(wildcard $(LOCAL_PATH)/*cpp)


LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
LOCAL_SRC_FILES += $(ENGINE_ROOT_LOCAL)/AppPlay/Common/jni/Common.cpp
LOCAL_WHOLE_STATIC_LIBRARIES := iworld
LOCAL_WHOLE_STATIC_LIBRARIES += libOgreMain
LOCAL_WHOLE_STATIC_LIBRARIES += OgreMainExt
LOCAL_WHOLE_STATIC_LIBRARIES += libRenderSystem_OGL

LOCAL_STATIC_LIBRARIES := raknet
LOCAL_STATIC_LIBRARIES += libMiniwAr
# LOCAL_STATIC_LIBRARIES += libopencv_imgproc
# LOCAL_STATIC_LIBRARIES += libopencv_core
# LOCAL_STATIC_LIBRARIES += libtbb

LOCAL_SHARED_LIBRARIES += fmod
#LOCAL_SHARED_LIBRARIES += libGCloudVoice
LOCAL_SHARED_LIBRARIES += youme_voice_engine
ifeq "$(TARGET_ARCH_ABI)" "arm64-v8a"
LOCAL_SHARED_LIBRARIES += libswresample
LOCAL_SHARED_LIBRARIES += libavformat
LOCAL_SHARED_LIBRARIES += libavdevice
LOCAL_SHARED_LIBRARIES += libavcodec
LOCAL_SHARED_LIBRARIES += libavutil
LOCAL_SHARED_LIBRARIES += libavfilter
LOCAL_SHARED_LIBRARIES += libswscale
else
LOCAL_SHARED_LIBRARIES += libswresample-0
LOCAL_SHARED_LIBRARIES += libavformat-55
LOCAL_SHARED_LIBRARIES += libavdevice-55
LOCAL_SHARED_LIBRARIES += libavcodec-55
LOCAL_SHARED_LIBRARIES += libavutil-52
LOCAL_SHARED_LIBRARIES += libavfilter-4
LOCAL_SHARED_LIBRARIES += libswscale-2
endif

LOCAL_C_INCLUDES := $(ENGINE_ROOT_LOCAL)/AppPlay/Common/jni/ \
		$(ENGINE_ROOT_LOCAL)/OgreMainExt/ \
		$(ENGINE_ROOT_LOCAL)/OgreMainExt/Android/ \
		$(ENGINE_ROOT_LOCAL)/OgreMain/ \
		$(ENGINE_ROOT_LOCAL)/ScriptSupport/ \
		$(ENGINE_ROOT_LOCAL)/iworld/ \
        $(ENGINE_ROOT_LOCAL)/sdk/smartar/libminiwar/jni/opencv/include/

LOCAL_LDLIBS := -llog -lGLESv2  -ljnigraphics -lz

LOCAL_LDFLAGS := -Wl,--allow-multiple-definition

LOCAL_CFLAGS := -std=c++11
LOCAL_CFLAGS += -O3  -Os

LOCAL_CPPFLAGS := -fexceptions
LOCAL_CPPFLAGS += -std=c++11
LOCAL_CPPFLAGS += -frtti
LOCAL_CPPFLAGS +=  -fvisibility=hidden
LOCAL_CPPFLAGS +=  -O3  -Os
include $(BUILD_SHARED_LIBRARY)

$(call import-module, RakNet/android/jni)
$(call import-module, iworld)
