
#ifndef __CLIENT_PREREQUISITES_H__
#define __CLIENT_PREREQUISITES_H__

#include "OgrePrerequisites.h"

#if OGRE_PLATFORM==OGRE_PLATFORM_WIN32

#define IWORLD_TARGET_PC   //Ŀ���ǹ���pc��
//#define IWORLD_TARGET_MOBILE  //Ŀ���ǹ����ֻ���
//#define IWORLD_TARGET_LIB    //���������õĿ��������Ϸ

#define IWORLD_REALTIME_SHADOW //ʵʱ��Ӱ

#else

#define IWORLD_TARGET_MOBILE  //Ŀ���ǹ����ֻ���
#define IWORLD_REALTIME_SHADOW //ʵʱ��Ӱ

#endif

//�Ƿ�Ϊ����״̬�������汾��ʱ��Ҫע�͵�����
//#define IWORLD_DEV_BUILD

//�Ƿ��Ƿ����������汾
//#define IWORLD_SERVER_BUILD

#endif
