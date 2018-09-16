
#ifndef __CLIENT_PREREQUISITES_H__
#define __CLIENT_PREREQUISITES_H__

#include "OgrePrerequisites.h"

#if OGRE_PLATFORM==OGRE_PLATFORM_WIN32

#define IWORLD_TARGET_PC   //目标是构建pc版
//#define IWORLD_TARGET_MOBILE  //目标是构建手机版
//#define IWORLD_TARGET_LIB    //构建盒子用的库而不是游戏

#define IWORLD_REALTIME_SHADOW //实时阴影

#else

#define IWORLD_TARGET_MOBILE  //目标是构建手机版
#define IWORLD_REALTIME_SHADOW //实时阴影

#endif

//是否为开发状态，构建版本的时候要注释掉此行
//#define IWORLD_DEV_BUILD

//是否是服务器开服版本
//#define IWORLD_SERVER_BUILD

#endif
