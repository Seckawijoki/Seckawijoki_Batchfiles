
LOCAL_PATH := $(call my-dir)

#include $(LOCAL_PATH)/buildPhysX.mk

include $(CLEAR_VARS)
LOCAL_MODULE := libPhysXCommon
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysXCommon.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libPhysXCooking
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysXCooking.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libPhysXVehicle
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysXVehicle.a
include $(PREBUILT_STATIC_LIBRARY)
include $(CLEAR_VARS)
LOCAL_MODULE := libPhysX
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysX.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libPhysXCharacterKinematic
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysXCharacterKinematic.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libPhysXExtensions
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysXExtensions.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libPxPvdSDK
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysXPvdSDK.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libPxFoundation
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/android/$(TARGET_ARCH_ABI)/libPhysXFoundation.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libjpeg
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/OgreMain/jpeg/prebuilt/android/$(TARGET_ARCH_ABI)/libjpeg.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libwebp
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/OgreMain/webp/lib/android/$(TARGET_ARCH_ABI)/libwebp.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libprotobuf
LOCAL_SRC_FILES := $(ENGINE_ROOT_LOCAL)/ProtocolBuffer/android/$(TARGET_ARCH_ABI)/libprotobuf.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := OgreMain
APP_OPTIM := release

FILE_LIST := $(wildcard $(LOCAL_PATH)/*cpp)

LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
LOCAL_SRC_FILES += $(wildcard $(LOCAL_PATH)/ozcollide/*cpp)
LOCAL_SRC_FILES += $(wildcard $(LOCAL_PATH)/TinyXML/*cpp)
LOCAL_SRC_FILES += $(wildcard $(LOCAL_PATH)/Lzma/*c)
LOCAL_SRC_FILES += $(wildcard $(LOCAL_PATH)/libqrencode/*c)
LOCAL_SRC_FILES += $(wildcard $(LOCAL_PATH)/json/*cpp)
LOCAL_SRC_FILES += $(wildcard $(LOCAL_PATH)/glm/*cpp)
LOCAL_SRC_FILES += $(wildcard $(LOCAL_PATH)/gif/*cpp)
# LOCAL_SRC_FILES += $(wildcard $(ENGINE_ROOT_LOCAL)/OgreMainExt/*cpp)
LOCAL_SRC_FILES += $(LOCAL_PATH)/LZ4/lz4.c \
$(LOCAL_PATH)/LZ4/lz4frame.c \
$(LOCAL_PATH)/LZ4/lz4hc.c \
$(LOCAL_PATH)/LZ4/xxhash.c \
$(LOCAL_PATH)/FreeType/src/base/ftbbox.c \
$(LOCAL_PATH)/FreeType/src/base/ftbitmap.c \
$(LOCAL_PATH)/FreeType/src/base/ftfstype.c \
$(LOCAL_PATH)/FreeType/src/base/ftglyph.c \
$(LOCAL_PATH)/FreeType/src/base/ftlcdfil.c \
$(LOCAL_PATH)/FreeType/src/base/ftstroke.c \
$(LOCAL_PATH)/FreeType/src/base/fttype1.c \
$(LOCAL_PATH)/FreeType/src/base/ftxf86.c \
$(LOCAL_PATH)/FreeType/src/base/ftbase.c \
$(LOCAL_PATH)/FreeType/src/base/ftsystem.c \
$(LOCAL_PATH)/FreeType/src/base/ftinit.c \
$(LOCAL_PATH)/FreeType/src/base/ftgasp.c \
$(LOCAL_PATH)/FreeType/src/raster/raster.c \
$(LOCAL_PATH)/FreeType/src/sfnt/sfnt.c \
$(LOCAL_PATH)/FreeType/src/smooth/smooth.c \
$(LOCAL_PATH)/FreeType/src/autofit/autofit.c \
$(LOCAL_PATH)/FreeType/src/truetype/truetype.c \
$(LOCAL_PATH)/FreeType/src/cff/cff.c \
$(LOCAL_PATH)/FreeType/src/psnames/psnames.c \
$(LOCAL_PATH)/FreeType/src/pshinter/pshinter.c 

LOCAL_SRC_FILES += $(LOCAL_PATH)/memmap/mem_map.cpp \
$(LOCAL_PATH)/memmap/mmap_wrapper.cpp \
$(LOCAL_PATH)/threadtask/OgreThreadTask.cpp \
$(LOCAL_PATH)/Lua2/tolua/tolua_event.cpp \
$(LOCAL_PATH)/Lua2/tolua/tolua_is.cpp\
$(LOCAL_PATH)/Lua2/tolua/tolua_map.cpp \
$(LOCAL_PATH)/Lua2/tolua/tolua_push.cpp \
$(LOCAL_PATH)/Lua2/tolua/tolua_to.cpp \
$(LOCAL_PATH)/Lua2/cjson/strbuf.c \
$(LOCAL_PATH)/Lua2/cjson/lua_cjson.c \
$(LOCAL_PATH)/Lua2/cjson/fpconv.c \
$(LOCAL_PATH)/Lua2/lua/lapi.c \
$(LOCAL_PATH)/Lua2/lua/lauxlib.c \
$(LOCAL_PATH)/Lua2/lua/lbaselib.c \
$(LOCAL_PATH)/Lua2/lua/lcode.c \
$(LOCAL_PATH)/Lua2/lua/ldblib.c \
$(LOCAL_PATH)/Lua2/lua/ldebug.c \
$(LOCAL_PATH)/Lua2/lua/ldo.c \
$(LOCAL_PATH)/Lua2/lua/ldump.c \
$(LOCAL_PATH)/Lua2/lua/lfunc.c \
$(LOCAL_PATH)/Lua2/lua/lgc.c \
$(LOCAL_PATH)/Lua2/lua/linit.c \
$(LOCAL_PATH)/Lua2/lua/liolib.c \
$(LOCAL_PATH)/Lua2/lua/llex.c \
$(LOCAL_PATH)/Lua2/lua/lmathlib.c \
$(LOCAL_PATH)/Lua2/lua/lmem.c \
$(LOCAL_PATH)/Lua2/lua/loadlib.c \
$(LOCAL_PATH)/Lua2/lua/lobject.c \
$(LOCAL_PATH)/Lua2/lua/lopcodes.c \
$(LOCAL_PATH)/Lua2/lua/loslib.c \
$(LOCAL_PATH)/Lua2/lua/lparser.c \
$(LOCAL_PATH)/Lua2/lua/lstate.c \
$(LOCAL_PATH)/Lua2/lua/lstring.c \
$(LOCAL_PATH)/Lua2/lua/lstrlib.c \
$(LOCAL_PATH)/Lua2/lua/ltable.c \
$(LOCAL_PATH)/Lua2/lua/ltablib.c \
$(LOCAL_PATH)/Lua2/lua/ltm.c \
$(LOCAL_PATH)/Lua2/lua/lundump.c \
$(LOCAL_PATH)/Lua2/lua/lvm.c \
$(LOCAL_PATH)/Lua2/lua/lzio.c \
$(LOCAL_PATH)/Lua2/lua/print.c \
$(LOCAL_PATH)/Lua2/luasocket/luasocket.c	\
$(LOCAL_PATH)/Lua2/luasocket/timeout.c \
$(LOCAL_PATH)/Lua2/luasocket/buffer.c \
$(LOCAL_PATH)/Lua2/luasocket/io.c \
$(LOCAL_PATH)/Lua2/luasocket/auxiliar.c \
$(LOCAL_PATH)/Lua2/luasocket/options.c \
$(LOCAL_PATH)/Lua2/luasocket/inet.c \
$(LOCAL_PATH)/Lua2/luasocket/tcp.c \
$(LOCAL_PATH)/Lua2/luasocket/udp.c \
$(LOCAL_PATH)/Lua2/luasocket/except.c \
$(LOCAL_PATH)/Lua2/luasocket/select.c \
$(LOCAL_PATH)/Lua2/luasocket/usocket.c \
$(LOCAL_PATH)/Lua2/luasocket/mime.c \
$(ENGINE_ROOT_LOCAL)/OgreMainExt/Android/AppPlayJNI.cpp


LOCAL_C_INCLUDES := $(LOCAL_PATH)/.. \
$(LOCAL_PATH)/FreeType/include/ \
$(LOCAL_PATH)/json/ \
$(LOCAL_PATH)/Lua2/cjson/ \
$(LOCAL_PATH)/Lua2/lua/ \
$(LOCAL_PATH)/Lua2/tolua/ \
$(LOCAL_PATH)/Lua2/luasocket/ \
$(LOCAL_PATH)/Lua2/luasocket/include/ \
$(LOCAL_PATH)/memmap/ \
$(LOCAL_PATH)/threadtask/ \
$(LOCAL_PATH)/DevIL/ \
$(LOCAL_PATH)/DevIL/PNG/ \
$(LOCAL_PATH)/jpeg/include/android/ \
$(ENGINE_ROOT_LOCAL)/OgreMainExt/ \
$(ENGINE_ROOT_LOCAL)/OgreMainExt/Android/ \
$(ENGINE_ROOT_LOCAL)/sdk/zlib \
$(ENGINE_ROOT_LOCAL)/sdk/zlib/minzip \
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
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/src/pxshared/include/foundation	\
$(ENGINE_ROOT_LOCAL)/sdk/PhysX-4.1/src/physx/source/foundation/include	\
$(ENGINE_ROOT_LOCAL)/sdk/ffmpeg/android/$(TARGET_ARCH_ABI)/include/	\
$(ENGINE_ROOT_LOCAL)/sdk/RenderSystem_OGL/

LOCAL_STATIC_LIBRARIES  := libPhysXCooking
LOCAL_STATIC_LIBRARIES  += libPhysX
LOCAL_STATIC_LIBRARIES  += libPhysXVehicle
LOCAL_STATIC_LIBRARIES  += libPhysXCharacterKinematic
LOCAL_STATIC_LIBRARIES  += libPhysXExtensions
LOCAL_STATIC_LIBRARIES  += libPhysXCommon
LOCAL_STATIC_LIBRARIES  += libPxPvdSDK
LOCAL_STATIC_LIBRARIES  += libPxFoundation
LOCAL_STATIC_LIBRARIES  += libPsFastXml
LOCAL_STATIC_LIBRARIES += libwebp
LOCAL_STATIC_LIBRARIES += libjpeg
LOCAL_STATIC_LIBRARIES += libprotobuf
LOCAL_STATIC_LIBRARIES  += libzlib
LOCAL_STATIC_LIBRARIES += libRenderSystem_OGL


LOCAL_EXPORT_LDLIBS := -llog
LOCAL_LDLIBS := -llog

#define the macro to compile Android 
 

LOCAL_CFLAGS := -D__ANDROID__
LOCAL_CFLAGS += -DOGRE_STATIC_LIB
LOCAL_CFLAGS += -DIL_STATIC_LIB
LOCAL_CFLAGS += -DHAVE_ZLIB_H
LOCAL_CFLAGS += -DHAVE_ZLIB
LOCAL_CFLAGS += -DHAVE_LIBZ
LOCAL_CFLAGS += -DCURL_STATICLIB
LOCAL_CFLAGS += -DUSE_JPG
LOCAL_CFLAGS += -DFT2_BUILD_LIBRARY
LOCAL_CFLAGS += -DIOAPI_NO_64
LOCAL_CFLAGS += -DUSE_SSLEAY
LOCAL_CFLAGS += -DUSE_OPENSSL 
LOCAL_CFLAGS += -DTIXML_USE_STL
LOCAL_CFLAGS += -DUSE_JPG
LOCAL_CFLAGS += -std=c++11
LOCAL_CFLAGS += -O3  -Os
LOCAL_CFLAGS += -D__STDC_LIMIT_MACROS 
LOCAL_CFLAGS += -D__STDC_CONSTANT_MACROS
LOCAL_CFLAGS += -fexceptions
LOCAL_CFLAGS += -frtti

LOCAL_CPPFLAGS := -fexceptions
LOCAL_CPPFLAGS += -frtti


include $(BUILD_STATIC_LIBRARY)