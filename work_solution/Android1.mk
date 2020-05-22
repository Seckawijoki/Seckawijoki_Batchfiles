LOCAL_PATH := $(call my-dir)

include $(LOCAL_PATH)/Android/common.mk

WEBSOCKETS_PATH := $(ENGINE_ROOT_LOCAL)/../deps/libwebsockets
include $(LOCAL_PATH)/Android/websockets.mk

OPENSSL_PATH := $(ENGINE_ROOT_LOCAL)/sdk/openssl

SSL_PATH := $(OPENSSL_PATH)/ssl
include $(LOCAL_PATH)/Android/ssl.mk

CRYPTO_PATH := $(OPENSSL_PATH)/crypto
include $(LOCAL_PATH)/Android/crypto.mk

CURL_PATH := $(ENGINE_ROOT_LOCAL)/sdk/curl
include $(LOCAL_PATH)/Android/curl.mk

SCRIPTSUPPORT_PATH := $(ENGINE_ROOT_LOCAL)/ScriptSupport
include $(LOCAL_PATH)/Android/scriptsupport.mk

OGREMAIN_PATH := $(ENGINE_ROOT_LOCAL)/OgreMain/
include $(ENGINE_ROOT_LOCAL)/OgreMain/OgreMain.mk

OGREMAINEXT_PATH := $(ENGINE_ROOT_LOCAL)/OgreMainExt
include $(ENGINE_ROOT_LOCAL)/OgreMainExt/OgreMainExt.mk

include $(CLEAR_VARS)

LOCAL_MODULE := iworld
APP_OPTIM := release

FILE_LIST := $(wildcard $(LOCAL_PATH)/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/*c)
FILE_LIST += $(wildcard $(LOCAL_PATH)/mapedit/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/actors/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/ai/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/blocks/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/camera/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/cs/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/cs/*c)
FILE_LIST += $(wildcard $(LOCAL_PATH)/display/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/miniupnp/*c)
FILE_LIST += $(wildcard $(LOCAL_PATH)/net/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/net/*cc)
FILE_LIST += $(wildcard $(LOCAL_PATH)/json/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/gamenet/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/misc/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/mod/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/player/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/terrgen/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/utility/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/wetestapm/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/worlddata/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/gamerecord/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/custommodel/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/btree/*cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/minicode/*cpp)

LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
LOCAL_SRC_FILES += $(WEBSOCKETS_LOCAL_SRC_FILES)
LOCAL_SRC_FILES += $(SSL_LOCAL_SRC_FILES)
LOCAL_SRC_FILES += $(CRYPTO_LOCAL_SRC_FILES)
LOCAL_SRC_FILES += $(CURL_LOCAL_SRC_FILES)
LOCAL_SRC_FILES += $(SCRIPTSUPPORT_LOCAL_SRC_FILES)
LOCAL_SRC_FILES += $(OGREMAINEXT_LOCAL_SRC_FILES)

# $(info iworld/Android.mk LOCAL_SRC_FILES : $(LOCAL_SRC_FILES))
# $(info iworld/Android.mk WEBSOCKETS_LOCAL_C_INCLUDES : $(WEBSOCKETS_LOCAL_C_INCLUDES))
# $(info iworld/Android.mk SSL_LOCAL_C_INCLUDES : $(SSL_LOCAL_C_INCLUDES))
# $(info iworld/Android.mk CRYPTO_LOCAL_C_INCLUDES : $(CRYPTO_LOCAL_C_INCLUDES))
# $(info iworld/Android.mk CURL_LOCAL_C_INCLUDES : $(CURL_LOCAL_C_INCLUDES))
# $(info iworld/Android.mk LUASOCKET_LOCAL_C_INCLUDES : $(LUASOCKET_LOCAL_C_INCLUDES))
# $(info iworld/Android.mk SCRIPTSUPPORT_LOCAL_C_INCLUDES : $(SCRIPTSUPPORT_LOCAL_C_INCLUDES))
# $(info iworld/Android.mk OGREMAINEXT_LOCAL_C_INCLUDES : $(OGREMAINEXT_LOCAL_C_INCLUDES))
# $(info iworld/Android.mk LOCAL_C_INCLUDES before : $(LOCAL_C_INCLUDES))

LOCAL_C_INCLUDES := $(LOCAL_PATH)/ \
$(LOCAL_PATH)/mapedit/ \
$(ENGINE_ROOT_LOCAL)/ProtocolBuffer/src/ \
$(LOCAL_PATH)/actors/ \
$(LOCAL_PATH)/ai/ \
$(LOCAL_PATH)/blocks/ \
$(LOCAL_PATH)/camera/ \
$(LOCAL_PATH)/cs/ \
$(LOCAL_PATH)/btree/ \
$(LOCAL_PATH)/display/ \
$(LOCAL_PATH)/miniupnp/ \
$(LOCAL_PATH)/mod/ \
$(LOCAL_PATH)/net/ \
$(LOCAL_PATH)/json/ \
$(LOCAL_PATH)/player/ \
$(LOCAL_PATH)/terrgen/ \
$(LOCAL_PATH)/utility/ \
$(LOCAL_PATH)/worlddata/ \
$(LOCAL_PATH)/gamerecord/ \
$(LOCAL_PATH)/custommodel/ \
$(ENGINE_ROOT_LOCAL)/ScriptSupport/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/glm/ \
$(ENGINE_ROOT_LOCAL)/OgreMainExt/Android/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/jpeg/include/android/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/webp/include/android/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/FreeType/include/ \
$(ENGINE_ROOT_LOCAL)/sdk/zlib/ \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/ \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/include  \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/MacOS  \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/ssl \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/crypto \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/crypto/asn1 \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/crypto/evp \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/crypto/modes \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/crypto/engine \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/characterkinematic/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/common/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/foundation/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/pvd/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/collision/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/gpu/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/Include/extensions/ \
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/src/physx/source/foundation/include	\
$(ENGINE_ROOT_LOCAL)/RakNet/windows/Source/	\
$(ENGINE_ROOT_LOCAL)/sdk/ffmpeg/android/$(TARGET_ARCH_ABI)/include/ \
$(ENGINE_ROOT_LOCAL)/sdk/curl/ \
$(ENGINE_ROOT_LOCAL)/sdk/openssl/include/ \
$(ENGINE_ROOT_LOCAL)/sdk/YouMeTalkSdk/include \
$(ENGINE_ROOT_LOCAL)/iworld/minicode/ \
$(ENGINE_ROOT_LOCAL)/sdk/RenderSystem_OGL/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/Lua2/tolua/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/Lua2/cjson/ \
$(ENGINE_ROOT_LOCAL)/OgreMain/Lua2/lua/
LOCAL_C_INCLUDES += $(WEBSOCKETS_LOCAL_C_INCLUDES) 
LOCAL_C_INCLUDES += $(SSL_LOCAL_C_INCLUDES) 
LOCAL_C_INCLUDES += $(CRYPTO_LOCAL_C_INCLUDES) 
LOCAL_C_INCLUDES += $(CURL_LOCAL_C_INCLUDES) 
# LOCAL_C_INCLUDES += $(LUASOCKET_LOCAL_C_INCLUDES)
LOCAL_C_INCLUDES += $(SCRIPTSUPPORT_LOCAL_C_INCLUDES)
LOCAL_C_INCLUDES += $(OGREMAINEXT_LOCAL_C_INCLUDES)

LOCAL_STATIC_LIBRARIES  := libOgreMain
LOCAL_STATIC_LIBRARIES += libwebp
LOCAL_STATIC_LIBRARIES += libjpeg
LOCAL_STATIC_LIBRARIES += libprotobuf
LOCAL_STATIC_LIBRARIES  += libPhysXCooking
LOCAL_STATIC_LIBRARIES  += libPhysX
LOCAL_STATIC_LIBRARIES  += libPhysXVehicle
LOCAL_STATIC_LIBRARIES  += libPhysXCharacterKinematic
LOCAL_STATIC_LIBRARIES  += libPhysXExtensions
LOCAL_STATIC_LIBRARIES  += libPhysXCommon
LOCAL_STATIC_LIBRARIES  += libPxPvdSDK
LOCAL_STATIC_LIBRARIES  += libPxFoundation
LOCAL_STATIC_LIBRARIES  += libPsFastXml
LOCAL_STATIC_LIBRARIES  += libzlib
#LOCAL_STATIC_LIBRARIES += libRenderSystem_OGL

LOCAL_WHOLE_STATIC_LIBRARIES := cpufeatures

LOCAL_EXPORT_LDLIBS := -llog

LOCAL_LDLIBS := -llog

# define the macro to compile Android            
LOCAL_CFLAGS := -D__ANDROID__
LOCAL_CFLAGS += -DOGRE_STATIC_LIB
LOCAL_CFLAGS += -DUSE_PROTOBUF
LOCAL_CFLAGS += -D__STDC_LIMIT_MACROS 
LOCAL_CFLAGS += -D__STDC_CONSTANT_MACROS
ifeq "$(TARGET_ARCH_ABI)" "arm64-v8a"
LOCAL_CFLAGS += -DANDROID_ARM64
endif
LOCAL_CFLAGS += -DIL_STATIC_LIB
LOCAL_CFLAGS += -DHAVE_ZLIB_H
LOCAL_CFLAGS += -DHAVE_ZLIB
LOCAL_CFLAGS += -DHAVE_LIBZ
LOCAL_CFLAGS += -DCURL_STATICLIB
LOCAL_CFLAGS += -DFT2_BUILD_LIBRARY
LOCAL_CFLAGS += -DIOAPI_NO_64
LOCAL_CFLAGS += $(WEBSOCKETS_LOCAL_CFLAGS)
LOCAL_CFLAGS += $(SSL_COMMON_CFLAGS)
LOCAL_CFLAGS += $(CURL_COMMON_CFLAGS)
LOCAL_CFLAGS += $(CRYPTO_COMMON_CFLAGS)
LOCAL_CFLAGS += $(SCRIPTSUPPORT_COMMON_CFLAGS) 
LOCAL_CFLAGS += -DUSE_SSLEAY
LOCAL_CFLAGS += -DUSE_OPENSSL
LOCAL_CFLAGS += -DTIXML_USE_STL
LOCAL_CFLAGS += -DUSE_JPG
LOCAL_CFLAGS += -O3  -Os
LOCAL_CFLAGS += -fexceptions

LOCAL_CPPFLAGS := -fexceptions
LOCAL_CPPFLAGS += -frtti
LOCAL_CPPFLAGS += -DUSE_OPENSSL
LOCAL_CPPFLAGS +=  -O3  -Os
LOCAL_CPPFLAGS += -DHAVE_ZLIB_H
LOCAL_CPPFLAGS += -DHAVE_ZLIB
LOCAL_CPPFLAGS += -DHAVE_LIBZ

include $(BUILD_STATIC_LIBRARY)

$(call import-module, android/cpufeatures)