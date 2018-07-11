#include "ClientActor.h"
	#include "ClientManager_Mobile.h"
	#include "ClientManager_PC.h"
	#include "OgreOSUtility.h"
	#include "OgreRoot.h"
	#include "OgreSceneRenderer.h"
	#include "OgreUIRenderer.h"
	#include "OgreSceneManager.h"
	#include "OgreTimer.h"
	#include "OgreLog.h"
	#include "OgreInputManager.h"
	#include "OgreRenderWindow.h"
	#include "OgreSoundSystem.h"
	#include "OgreFileSystem.h"
	#include "OgreParticleEmitter.h"
	#include "OgreBillboard.h"
	#include "OgreFootprint.h"
	#include "OgreBeamEmitter.h"
	#include "OgreResourceManager.h"
	#include "OgreTexture.h"
	#include "OgreMD5.h"
	#include "OgreDirVisitor.h"
	#include "OgreFontBase.h"
	#include "OgreDownloader.h"
	#include "OgreStringUtil.h"	
	#include "OgreOSUtility.h"	
	#include "HttpProxy.h"
	#include "HttpFileUpDownMgr.h"
	#include "OgreScriptLuaVM.h"
	#include "OgreSceneManager.h"
	#include "OgreCompress.h"
	#include "UILib/ui_gameui.h"
	
	#include "UILib/ui_common.h"
	
	#include "voxelmodel.h"
	#include "Profiny.h"
	
	#ifdef IWORLD_TARGET_PC
	#include "SteamManager.h"
	#endif
	
	#include "defmanager.h"
	#include "BlockScene.h"
	#include "BlockMaterial.h"
	#include "PlayerControl.h"
	#include "world.h"
	#include "ClientMob.h"
	#include "ClientGame.h"
	#include "ClientGameStandaloneServer.h"
	#include "DebugDataMgr.h"
	#include "MapMarkingMgr.h"
	#include "ClientAccount.h"
	#include "ClientBuddyMgr.h"
	#include "UIActorBodyMgr.h"
	#include "HomeChest.h"
	#include "BlockMaterialMgr.h"
	#include "SectionMesh.h"
	#include "MinimapRenderer.h"
	#include "game_event.h"
	#include "ClientCSMgr.h"
	// add by null start {{{
	#include "LuaInterface.h"
	// add by null end }}}
	#include "GameNetManager.h"
	#include "PlatformSdkManager.h"
	#include "Achievementmanager.h"
	#include "SnapshotMgr.h"
	#include "EffectManager.h"
	#include "defmanager.h"
	#include "ClientCSDns.h"
	#include "TraceRoute.h"
	#include "json/jsonxx.h"
	#include <curl/curl.h> 
	
	
	#include "MpGameSurvive.h"
	#include "DebugRenderer.h"
	#include "Clock.h"
	#include "CameraManager.h"
	#include "CutScenesMgr.h"
	#include "PermitsManager.h"
	#include "SnapshotForShare.h"
	#include "ProfileManager.h"
	#include "GameSettings.h"
	#include "GVoiceManager.h"
	#include "wetestapm/TApmManager.h"
	#include "mod/ModManager.h"
	#include "mod/ModEditorManager.h"
	#include "WorldManager.h"
	#include "OgreRenderWindow.h"
	#include "OgreModFileManager.h"
	#include "OgreWebp.h"
	#include "OgreCamera.h"
	#include "UILib/ui_layoutframe.h"
	#include "UILib/ui_framemgr.h"
	#include "UILib/ui_texture.h"
	#include "Terrainpreview.h"
	#include "TerrainMonsterPreview.h"
	#include <string>
	#include <sstream>
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
	#include <shlobj.h>
	#include <tchar.h>
	#include <vector>
	#include <hash_map>
	#include <string>
	#include <fcntl.h>
	#include "ShellAPI.h"
	#include "SkinManager.h"
	#include "CommDlg.h"
	#elif OGRE_PLATFORM == OGRE_PLATFORM_ANDROID 
	#include "Android/AppPlayJNI.hpp"
	#endif
	
	#define USE_MULTIPLAYER
	#if OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC
	extern int  tolua_ServerToLua_open(lua_State* tolua_S);
	#else
	#ifdef IWORLD_TARGET_PC
	extern int  tolua_ClientToLua_open(lua_State* tolua_S);
	#else
	extern int  tolua_ClientToLuaM_open(lua_State* tolua_S);
	#endif
	#endif
	
	using namespace Ogre;
	
	static const char *sClientVersion = "0.27.0";
	static int sClientVersionInt = -1;
	jsonxx::Object *g_AppParamObj = NULL;
	std::string ClientManager::m_CurrentRequestFilePath = "";
	static WCoord eyepos(3250, 4800, 1600);
	
	static int s_SelActorViewRange = 4;
	REGISTER_UI_CLASS(TerrainPrewView)
	REGISTER_UI_CLASS(TerrainMonsterPreview)
	static int VersionStr2Int(const char *str)
	{
		int version = 0;
		std::istringstream iss(str);
		std::string num;
		while(std::getline(iss, num, '.'))
		{
			if (!num.empty())
			{
				version <<= 8;
				version += atoi(num.c_str());
			}
		}
		return version;
	}
	
	int GetGameVersionInt()
	{
		if(sClientVersionInt < 0)
		{
			sClientVersionInt = VersionStr2Int(sClientVersion);
		}
		return sClientVersionInt;
	}
	const char *GetGameVersionStr()
	{
		return sClientVersion;
	}
	
	inline unsigned char *base64_decode(const unsigned char *str, int strict,unsigned char *result,int *plen = NULL)
	{
		static const char base64_pad = '*';
		static const short base64_reverse_table[256] = {
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -2, -1, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
			52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
			-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
			15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
			-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
			41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
			-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
		};
		const unsigned char *current = str;
		size_t length = strlen((const char*)str);
		int ch, i = 0, j = 0, k;
	
		//    unsigned char *result;
	
		//    result = (unsigned char *)malloc(length + 1);
	
		while ((ch = *current++) != '\0' && length-- > 0) {
			if (ch == base64_pad) {
				if (*current != '*' && (i % 4) == 1) {
					//    free(result);
					return NULL;
				}
				continue;
			}
	
			ch = base64_reverse_table[ch];
			if ((!strict && ch < 0) || ch == -1) { 
				continue;
			} else if (ch == -2) {
				//    free(result);
				return NULL;
			}
	
			switch(i % 4) {
			case 0:
				result[j] = ch << 2;
				break;
			case 1:
				result[j++] |= ch >> 4;
				result[j] = (ch & 0x0f) << 4;
				break;
			case 2:
				result[j++] |= ch >>2;
				result[j] = (ch & 0x03) << 6;
				break;
			case 3:
				result[j++] |= ch;
				break;
			}
			i++;
		}
	
		k = j;
	
		if (ch == base64_pad) {
			switch(i % 4) {
			case 1:
				//    free(result);
				return NULL;
			case 2:
				k++;
			case 3:
				result[k++] = 0;
			}
		}
	
		result[j] = '\0';
		if ( plen )
			*plen = j;	
		return result;
	}
	
	ClientManager::ClientManager()
		: m_CurGame(NULL), m_AppState(APPSTATE_NULL), m_AppPaused(false), m_HideUI(false), m_ReloadGameType(NO_RELOAD),
		m_AchievementMgr(NULL), m_PlatformSdkMgr(NULL), m_UIRenderer(NULL), m_SceneRenderer(NULL), m_GameUI(NULL), m_InputMgr(NULL), m_GameNetMgr(NULL), m_SnapshotMgr(NULL), m_TApmMgr(NULL), versionParamsLoaded(false),
		m_ModEditorManager(NULL), m_ModFileManager(NULL), m_ModManager(NULL), m_LoadingGame(NULL), m_MinimapRenderer(NULL), m_pTraceRoute(NULL)
	#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
		,m_GVoiceMgr(NULL) 
	#endif
	{
		m_ResetRender = false;
		m_ClearColor.set(0,0,0,1.0f);
		m_noticeContent = "";
		m_noticeBrief = "";
		m_noticeType = 0;
		m_noticeCode = 0;
		m_Imsi = 0;
		m_isIpv6Env = false;
		m_frameCount = 0;
		m_TimeSinceStartup = 0;
		m_TickAtStartup = Timer::getSystemTick();
	
		m_StoreSounder = NULL;
	
		m_statisticsSendInterval = 5 * 60;
		m_statisticsSendMax = 32;
		m_statisticsLastSendTime = GetTimeStamp();
		m_openWebp = 1;
	
		m_fcmRate = 100;
		m_bAdult = false;
		m_nApiId = 999;
	#ifdef _WIN32
		m_windowModeStyle = -1;
	#endif
	
		Ogre::SetClientVersion((char*)sClientVersion);
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_ANDROID
		m_nApiId = GameApiId();
	#elif OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC
	    m_nApiId = 999;	
	#endif
	}
	
	void ClientManager::resetApiId() 
	{
		//苹果和andriod版本需要根据地区重新计算apiid
		m_nApiId = GameApiId();
	}
	
	ClientManager::~ClientManager()
	{
		delete g_AppParamObj;
		g_AppParamObj = NULL;
	
		if(m_StoreSounder)
		{
			OGRE_RELEASE(m_StoreSounder);
		}
	
		if (m_pTraceRoute)
		{
			m_pTraceRoute->shutdown();
			OGRE_DELETE(m_pTraceRoute);
		}
	}
	
	class InitDataThread : public OSThread
	{
	public:
		virtual RUN_RETTYPE _run() override;
	};
	OSThread::RUN_RETTYPE InitDataThread::_run()
	{
		ClientManager *gamemgr = ClientManager::getSingletonPtr();
		if(!gamemgr->initGameData())
		{
			PopMessageBox("initGameData failed", "error");
		}
		else
		{
			gamemgr->m_AppState = APPSTATE_INIT;
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
			gamemgr->m_ResetRender = true;
	#endif
		}
		return OSThread::RUN_EXIT;
	}
	static InitDataThread *s_InitDataThread = NULL;
	
	bool ClientManager::onInitialize(const char *pkgsource, 
		const char *datadir, int imsi, void *hinst, const char *cmdstr)
	{
		//ClientManager内的函数，无继承
		if(cmdstr) initHashParam(cmdstr);
		//create函数具体分ClientManagerPC与ClientManagerMobile的实现
		if(!create("iworld.cfg", hinst, pkgsource, datadir))
		{
			LOG_SEVERE("create iworld.cfg failed");
			return false;
		}
	
		m_AppState = APPSTATE_CREATED;
		m_Imsi = imsi;
	
		char buff[4] ;
		sprintf(buff, "%d", getNetworkState());
		statisticsGameEvent("StartEvent", "NetState", buff);
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		s_InitDataThread = new InitDataThread;
		s_InitDataThread->start();
	#else
		if(!initGameData()) return false;
		m_AppState = APPSTATE_INIT;
	#endif
		return true;
	}
	
	bool ClientManager::onInitializeEx(const char *pkgsource,const char *pkgsource2, const char *datadir, int imsi, void *hinst, const char *cmdstr) 
	{
		if(cmdstr) initHashParam(cmdstr);
		if(!createEx("iworld.cfg", hinst, pkgsource,pkgsource2, datadir))
		{
			LOG_SEVERE("create iworld.cfg failed");
			return false;
		}
	
		m_AppState = APPSTATE_CREATED;
		m_Imsi = imsi;
	
		char buff[4] ;
		sprintf(buff, "%d", getNetworkState());
		statisticsGameEvent("StartEvent", "NetState", buff);
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		s_InitDataThread = new InitDataThread;
		s_InitDataThread->start();
	#else
		if(!initGameData()) return false;
		m_AppState = APPSTATE_INIT;
	#endif
		return true;
	}
	
	bool ClientManager::onTerminate()
	{
		if(s_InitDataThread)
		{
			delete s_InitDataThread;
			s_InitDataThread = NULL;
		}
		destroy();
		m_AppState = APPSTATE_NULL;
		return true;
	}
	
	bool ClientManager::onResetRender(int width, int height)
	{
		LOG_INFO("onResetRender begin..........%d,%d,%d", width, height, m_AppState);
	
	#ifdef IWORLD_SERVER_BUILD
		m_AppState = APPSTATE_RUNNING;
		m_ResetRender = true;
		return true;
	#endif
	
	#ifndef IWORLD_SERVER_BUILD
	#if OGRE_PLATFORM == OGRE_PLATFORM_ANDROID
		bool hasRenderResetFix = false;
		if(height !=0 && width/height >= 1.87f){  //android在全面屏出来之前最大是1.86
			bool bNeedFix = GetDeviceModelNeedRenderFixJNI();
			if(bNeedFix){
				hasRenderResetFix = true;
				m_EngineRoot->resetRenderSystem(width, height,94);//100);
				LOG_INFO("m_EngineRoot resetRender fix");
			}
		}
		if(!hasRenderResetFix){
			m_EngineRoot->resetRenderSystem(width, height, 0);
		}
	#elif  OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		if(height !=0 && width/height >= 2.f){  //android在全面屏出来之前最大是1.86
			m_EngineRoot->resetRenderSystem(width, height,50);//100);
			LOG_INFO("m_EngineRoot resetRender fix");
		}
		else
			m_EngineRoot->resetRenderSystem(width, height, 0);
	#else
		m_EngineRoot->resetRenderSystem(width, height,0);
	#endif	
	
		LOG_INFO("m_EngineRoot resetRender end");
		m_GameUI->resetScreenSize(Root::getSingleton().getClientWidth(), Root::getSingleton().getClientHeight());
		LOG_INFO("m_GameUI resetRender end");
		m_ResetRender = true;
	#endif
		return true;
	}
	
	bool ClientManager::onStart()
	{
		//m_EngineRoot->onStart();
		return true;
	}
	
	bool ClientManager::onStop()
	{
		sendStatistics(false, true);
	
		if(m_CSMgr) m_CSMgr->pauseAll();
	
		if(m_CurGame)
		{
			if(m_ScriptVM) m_ScriptVM->callFunction("GameStop", "");
			m_CurGame->pauseGame();
		}
	
		//m_EngineRoot->onStop();
	
		return true;
	}
	
	bool ClientManager::onPause()
	{
		sendStatistics(false, false);
	
		m_EngineRoot->onPause();
		m_AppPaused = true;
		#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
		if(m_GVoiceMgr) m_GVoiceMgr->onPause();
		#endif
	
		return true;
	}
	
	bool ClientManager::onResume()
	{
		sendStatistics(false, false);
	
		m_EngineRoot->onResume();
		m_AppPaused = false;
		#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
		if(m_GVoiceMgr) m_GVoiceMgr->onResume();
		if(m_ScriptVM)  m_ScriptVM->callFunction("GameResume", "");
		#endif
	
		return false;
	}
	
	bool g_DisableVoice = true;
	static std::string s_ShareLink("http://www.mini1.cn/share.php");
	static bool s_ShareEnabled = true;
	static bool s_ActivationCodeRewardEnabled = true;
	
	const char *ClientManager::getShareLink()
	{
		return s_ShareLink.c_str();
	}
	
	bool ClientManager::isShareEnabled()
	{
		//if(getApiId() >= 300 && getApiId() != 999)	//海外版屏蔽分享
		//	return false;
	
		return s_ShareEnabled;
	}
	
	bool ClientManager::isActivationCodeRewardEnabled()
	{
		return s_ActivationCodeRewardEnabled;
	}
	
	bool ClientManager::hasVersionParamsLoaded()
	{
		return versionParamsLoaded;
	}
	
	int ClientManager::getVersionParamInt(const char* name, int defaultValue)
	{
		Ogre::String key = name;
		Ogre::String verkey = key + "Ver";
		Ogre::String onlykey = key + "Only";
		Ogre::String onlyverkey = key + "OnlyVer";
	
		if (versionParams.find(onlykey) != versionParams.end() && versionParams.find(onlyverkey) != versionParams.end())
		{
			if (clientVersion() == getVersionParamIntNoCheck(onlyverkey))
			{
				return getVersionParamIntNoCheck(onlykey);
			}
		}
	
		if (versionParams.find(key) != versionParams.end())
		{
			if (versionParams.find(verkey) != versionParams.end())
			{
				if (clientVersion() <= getVersionParamIntNoCheck(verkey))
					return getVersionParamIntNoCheck(key);
			}
			else
			{
				return getVersionParamIntNoCheck(key);
			}
		}
	
		return defaultValue;
	}
	
	std::string ClientManager::getVersionParamStr(const char* name, const std::string& defaultValue)
	{
		Ogre::String key = name;
		Ogre::String verkey = key + "Ver";
		Ogre::String onlykey = key + "Only";
		Ogre::String onlyverkey = key + "OnlyVer";
	
		if (versionParams.find(onlykey) != versionParams.end() && versionParams.find(onlyverkey) != versionParams.end())
		{
			if (clientVersion() == getVersionParamIntNoCheck(onlyverkey))
			{
				return getVersionParamStrNoCheck(onlykey);
			}
		}
	
		if (versionParams.find(key) != versionParams.end())
		{
			if (versionParams.find(verkey) != versionParams.end())
			{
				if (clientVersion() <= getVersionParamIntNoCheck(verkey))
					return getVersionParamStrNoCheck(key);
			}
			else
			{
				return getVersionParamStrNoCheck(key);
			}
		}
	
		return defaultValue;
	}
	
	std::string ClientManager::getVersionParamStrNoCheck(const std::string& name, const std::string& defaultValue)
	{
		auto it = versionParams.find(name);
		if (it != versionParams.end())
			return it->second;
		else
			return defaultValue;
	}
	
	int ClientManager::getVersionParamIntNoCheck(const Ogre::String& name, int defaultValue)
	{
		auto it = versionParams.find(name);
		if (it != versionParams.end())
		{
			Ogre::String& str = it->second;
			std::istringstream ss(str);
			int v;
			ss >> v;
			return v;
		}
		else
		{
			return defaultValue;
		}
	}
	
	bool ClientManager::GVoiceEnable()
	{
		//if(getApiId() >= 300 && getApiId() != 999)	//屏蔽海外版Gvoice
		//	return false;
		if(getVersionParamInt("GVoiceSDKEnabled", 1) == 1)
			return true;
		else
			return false;
	}
	
	void ClientManager::checkAppParams()
	{
		if (!versionParamsLoaded)
		{
			versionParamsLoaded = true;
	
			const std::map<std::string, jsonxx::Value*> & allparams = g_AppParamObj->kv_map();
	
			for (auto it = allparams.begin(); it != allparams.end(); ++it)
			{
				const std::string& name = it->first;
				jsonxx::Value* value = it->second;
	
				if (value->is<jsonxx::String>())
				{
					const std::string& v = value->get<jsonxx::String>();
	
					versionParams.insert(std::make_pair(name, v));
					LOG_INFO("versionParams[%s] = '%s'", name.c_str(), v.c_str());
				}
				else if (value->is<jsonxx::Number>())
				{
					std::ostringstream ss;
					ss << ((double)value->get<jsonxx::Number>());
					std::string v = ss.str();
	
					versionParams.insert(std::make_pair(name, v));
					LOG_INFO("versionParams[%s] = '%s'", name.c_str(), v.c_str());
				}
			}
		}
	
		m_statisticsSendInterval = getVersionParamInt("StatSendInterval", 5 * 60);
		m_statisticsSendMax = getVersionParamInt("StatSendMax", 32);
	
		FuncSwitchDef *def = g_DefMgr.getFuncSwitchDef(getApiId());
		if(def)
		{
			/*if(g_AppParamObj->has<jsonxx::Number>("Share")&& (!g_AppParamObj->has<jsonxx::Number>("ShareVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("ShareVer")))
				def->Share = (int)g_AppParamObj->get<jsonxx::Number>("Share");
			if(g_AppParamObj->has<jsonxx::Number>("AccSwitch")&& (!g_AppParamObj->has<jsonxx::Number>("AccSwitchVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("AccSwitchVer")))
				def->AccSwitch = (int)g_AppParamObj->get<jsonxx::Number>("AccSwitch");
			if(g_AppParamObj->has<jsonxx::Number>("AccEncode")&& (!g_AppParamObj->has<jsonxx::Number>("AccEncodeVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("AccEncodeVer")))
				def->AccEncode = (int)g_AppParamObj->get<jsonxx::Number>("AccEncode");
			if(g_AppParamObj->has<jsonxx::Number>("SmsPay")&& (!g_AppParamObj->has<jsonxx::Number>("SmsPayVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("SmsPayVer")))
				def->SmsPay = (int)g_AppParamObj->get<jsonxx::Number>("SmsPay");
			if(g_AppParamObj->has<jsonxx::Number>("SdkPay")&& (!g_AppParamObj->has<jsonxx::Number>("SdkPayVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("SdkPayVer")))
				def->SdkPay = (int)g_AppParamObj->get<jsonxx::Number>("SdkPay");
			if(g_AppParamObj->has<jsonxx::Number>("HomeChest")&& (!g_AppParamObj->has<jsonxx::Number>("HomeChestVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("HomeChestVer")))
				def->HomeChest = (int)g_AppParamObj->get<jsonxx::Number>("HomeChest");
			if(g_AppParamObj->has<jsonxx::Number>("FeedBack")&& (!g_AppParamObj->has<jsonxx::Number>("FeedBackVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("FeedBackVer")))
				def->FeedBack = (int)g_AppParamObj->get<jsonxx::Number>("FeedBack");
			if(g_AppParamObj->has<jsonxx::Number>("IosRese")&& (!g_AppParamObj->has<jsonxx::Number>("IosReseVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("IosReseVer")))
				def->Reservation = (int)g_AppParamObj->get<jsonxx::Number>("IosRese");
			if (g_AppParamObj->has<jsonxx::Number>("SecurityBinding") && (!g_AppParamObj->has<jsonxx::Number>("SecurityBindingVer") || clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>("SecurityBindingVer")))
				def->SecurityBinding = (int)g_AppParamObj->get<jsonxx::Number>("SecurityBinding");*/
				
			int intvalue;
	
			if (checkConfigVer(intvalue, "Share", "ShareVer", "ShareOnly", "ShareOnlyVer"))
				def->Share = intvalue;
			if (checkConfigVer(intvalue, "AccSwitch", "AccSwitchVer", "AccSwitchOnly", "AccSwitchOnlyVer"))
				def->AccSwitch = intvalue;
			if (checkConfigVer(intvalue, "AccEncode", "AccEncodeVer", "AccEncodeOnly", "AccEncodeOnlyVer"))
				def->AccEncode = intvalue;
			if (checkConfigVer(intvalue, "SmsPay", "SmsPayVer", "SmsPayOnly", "SmsPayOnlyVer"))
				def->SmsPay = intvalue;
			if (checkConfigVer(intvalue, "SdkPay", "SdkPayVer", "SdkPayOnly", "SdkPayOnlyVer"))
				def->SdkPay = intvalue;
			if (checkConfigVer(intvalue, "HomeChest", "HomeChestVer", "HomeChestOnly", "HomeChestOnlyVer"))
				def->HomeChest = intvalue;
			if (checkConfigVer(intvalue, "FeedBack", "FeedBackVer", "FeedBackOnly", "FeedBackOnlyVer"))
				def->FeedBack = intvalue;
			if (checkConfigVer(intvalue, "IosRese", "IosReseVer", "IosReseOnly", "IosReseOnlyVer"))
				def->Reservation = intvalue;
			if (checkConfigVer(intvalue, "SecurityBinding", "SecurityBindingVer", "SecurityBindingOnly", "SecurityBindingOnlyVer"))
				def->SecurityBinding = intvalue;
			if (checkConfigVer(intvalue, "QQWalletPay", "QQWalletPayVer", "QQWalletPayOnly", "QQWalletPayOnlyVer"))
				def->QQWalletPay = intvalue;
	
			//if (checkConfigVer(intvalue, "NewMap", "NewMapVer", "NewMapOnly", "NewMapOnlyVer"))
			//	m_useHttpMapApi = (intvalue == 1);
		}
	
		bool boolvalue;
		if (checkConfigVer(boolvalue, "ShareEnabled", "ShareEnabledVer", "ShareEnabledOnly", "ShareEnabledOnlyVer"))
			s_ShareEnabled = boolvalue;
		if (checkConfigVer(boolvalue, "ActivationCodeRewardEnabled", "ActivationCodeRewardEnabledVer", "ActivationCodeRewardEnabledOnly", "ActivationCodeRewardEnabledOnlyVer"))
			s_ActivationCodeRewardEnabled = boolvalue;
	
		if (g_AppParamObj->has<jsonxx::String>("ShareLink"))
		{
			int prob = 100;
			if (g_AppParamObj->has<jsonxx::Number>("ShareLinkProb")) prob = (int)g_AppParamObj->get<jsonxx::Number>("ShareLinkProb");
	
			if (g_DefMgr.m_RandGen->get(100) < prob) s_ShareLink = g_AppParamObj->get<jsonxx::String>("ShareLink");
		}
	
		if (g_AppParamObj->has<jsonxx::Number>("DisableVoice")) g_DisableVoice = true;
	}
	
	void ClientManager::onIdle()
	{
		int aaa = 0;
		if(aaa)
		{
			onResetRender(1280, 720);
		}
	
		if(m_AppState == APPSTATE_INIT && m_ResetRender)
		{
			startRunning();
		}
		else if(canDoFrame())
		{
			if(m_ResetRender)
			{
				m_GameUI->resetScreenSize(Root::getSingleton().getClientWidth(), Root::getSingleton().getClientHeight());
				m_ResetRender = false;
			}
	
			if(g_AppParamObj)
			{
				checkAppParams();
	
				delete g_AppParamObj;
				g_AppParamObj = NULL;
			}
	
			doFrame();
		}
	}
	
	void ClientManager::onBackPressed()
	{
		if(g_pPlayerCtrl && g_pPlayerCtrl->isDead()) return;
		if(m_EventQue) m_EventQue->postSimpleEvent(GIE_APPBACK_PRESSED);
	}
	
	void ClientManager::onNewIntent(const char *schemejson)
	{
		LOG_INFO("ClientManager::onNewIntent:%s", schemejson);
		if(m_ScriptVM)
			m_ScriptVM->callFunction("GameNewIntent", "s", schemejson);
	}
	
	void ClientManager::onTouchPressed(int num, int ids[], float xs[], float ys[])
	{
		if(canDoFrame())
		{
			m_InputMgr->onTouchPressed(num, ids, xs, ys);
		}
	}
	
	void ClientManager::onTouchReleased(int num, int ids[], float xs[], float ys[])
	{
		if(canDoFrame())
		{
			m_InputMgr->onTouchReleased(num, ids, xs, ys);
		}
	}
	
	void ClientManager::onTouchMoved(int num, int ids[], float xs[], float ys[])
	{
		if(canDoFrame())
		{
			m_InputMgr->onTouchMoved(num, ids, xs, ys);
		}
	}
	
	void ClientManager::onTouchCancelled(int num, int ids[], float xs[], float ys[])
	{
		if(canDoFrame())
		{
			m_InputMgr->onTouchCancelled(num, ids, xs, ys);
		}
	}
	
	
	void ClientManager::destroy()
	{
		m_CSMgr->release();
	
		m_httpDownloadMgr->release();
		m_httpFileUpDownMgr->release();
	
		releaseGameData();
	#ifndef IWORLD_SERVER_BUILD
		releaseEngine();
	#endif
	
		delete m_GameNetMgr;
		m_GameNetMgr = NULL;
	
		delete m_CSMgr;
		delete m_EngineRoot;
		delete m_LogicalClock;
	}
	
	bool ClientManager::needQuit()
	{
		return false;
	}
	
	void ClientManager::onGetSnapshot()
	{
	}
	
	int g_FrameMutexTick = 0;
	int g_PrintMemTick = 0;
	void ClientManager::doFrame()
	{
		//g_ProfileManager->reset();
	
		int maxfps = isPC() ? 1000 : (m_CurGame ? m_CurGame->getMaxFPS() : 30);
		int mininterval = 1000/maxfps;
		if(mininterval == 0) mininterval = 1;
	
		m_TimeSinceStartup = (Timer::getSystemTick() - m_TickAtStartup) / 1000.0f;  //ms -> s
		
		unsigned int actualDtick = Timer::getSystemTick() - m_CurTick;
	
		if(actualDtick < (unsigned int)mininterval)
		{
	
			ThreadSleep(mininterval- actualDtick);
			actualDtick = Timer::getSystemTick() - m_CurTick;
		}
	
		m_CurTick += actualDtick;
	
		m_LuaInterface->m_TcpSocket->onLoop();
		m_LogicalClock->update(actualDtick);
	
		int deltaTime = m_LogicalClock->m_deltaTime;
		g_FrameMutexTick = 0;
		
		// tick every 1/20 second
		if(deltaTime > GAME_TICK_MSEC) deltaTime = GAME_TICK_MSEC;
		m_GameTickAccum += deltaTime;
	
		m_PartialTick = float(m_GameTickAccum % GAME_TICK_MSEC) / GAME_TICK_MSEC;
	
	
		if(m_GameTickAccum >= GAME_TICK_MSEC)
		{
			m_GameTickAccum -= GAME_TICK_MSEC;
	
			if(m_CurGame) m_CurGame->prepareTick();
	
			if(m_GameNetMgr) m_GameNetMgr->tick();
	
			if (m_CameraMgr) m_CameraMgr->tick();
			m_CSMgr->tick();
	
			handleEvents();
	
			if(m_LoadingGame) updateLoadingGame();
			//g_ProfileManager->beginSample("ClientGame:tick");
			if(m_CurGame) m_CurGame->tick();
			//g_ProfileManager->endSample();
			if(m_AccountInfo) m_AccountInfo->update();
	
			g_PrintMemTick++;
			if(g_PrintMemTick == 20*20)
			{
				g_PrintMemTick = 0;
				//LOG_INFO("PrintMem = %d", GetProcessUsedMemory());
			}
			if(m_CutScenesMgr) m_CutScenesMgr->tick();
	
			// lua container tick ,  用来调度协程 -- add by null start {{{
			struct timeval stNow;
			gettimeofday(&stNow, NULL);
	#ifndef IWORLD_SERVER_BUILD
			m_ScriptVM->callFunction("__tick__", "ii", stNow.tv_sec, stNow.tv_usec/1000);
			// lua container tick ,  用来调度协程 -- add by null end }}}
	#endif
	
			//if(m_ScriptVM) m_ScriptVM->luagc();
		}
	
		#ifndef IWORLD_SERVER_BUILD
			float dtime = TickToTime(deltaTime);
			m_frameDeltaTime = dtime;
	
			if (m_CurGame)
			{
				//g_ProfileManager->beginSample("ClientGame:update");
				m_CurGame->update(dtime);
				//g_ProfileManager->endSample();
				if (g_pPlayerCtrl != NULL)
				{
					m_CameraMgr->update(TickToTime(actualDtick));
				}
			}
	
			m_GameUI->Update(dtime);
	
			if(m_UIActorBodyMgr) m_UIActorBodyMgr->update(dtime);
			if(m_HomeChest) m_HomeChest->update(dtime);
	
			m_SceneRenderer->setClearParams(CLEAR_TARGET|CLEAR_ZBUFFER, ColorQuad(m_ClearColor).c, 1.0f, 0);
			//g_ProfileManager->beginSample("SceneManager:doFrame");
			if(SceneManager::getSingletonPtr()) SceneManager::getSingleton().doFrame();
			//g_ProfileManager->endSample();
	
			m_CutScenesMgr->update(dtime);
			if(SoundSystem::getSingletonPtr())  SoundSystem::getSingleton().update();
			#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
			if(m_GVoiceMgr) m_GVoiceMgr->update(dtime);
			#endif
		#endif
	
		m_SnapshotMgr->update();
		m_SnapshotForShare->update();
	
		//防沉迷，版号送审用
		if(!useTpRealNameAuth() && !m_bAdult)
		{
			if(m_CurGame)
				m_ScriptVM->callString("if UpdateAntiAddiction~=nil then UpdateAntiAddiction(); end");
		}
	
		++m_frameCount;
		//g_ProfileManager->printAll();
	
	#ifdef _DEBUG
		int do_once_log_mem = 0;
		if(do_once_log_mem)
		{
			LOG_INFO("HardwareBuffer: %d", Ogre::CountMemoryBlockByName("HardwareBuffer"));
			LOG_INFO("LayoutFrame: %d", Ogre::CountMemoryBlockByName("LayoutFrame"));
			LOG_INFO("HardwarePixelBuffer: %d", Ogre::CountMemoryBlockByName("HardwarePixelBuffer"));
			LOG_INFO("Resource: %d", Ogre::CountMemoryBlockByName("Resource"));
			LOG_INFO("TextureData: %d", Ogre::CountMemoryBlockByName("TextureData"));
			LOG_INFO("VertexData: %d", Ogre::CountMemoryBlockByName("VertexData"));
		}
	#endif
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
	#if _DEBUG
		static bool lastdown = false;
		bool curdown = GetAsyncKeyState(VK_F6);
		if (!lastdown && curdown)
		{
			MemStat::singleton.printTrackObjs();
			//m_GameUI->DebugPrint();
		}
		lastdown = curdown;
	#endif
	#endif
	}
	
	void ClientManager::sendUIEvent(const char *pevent)
	{
		if(m_GameUI) m_GameUI->SendEvent(pevent);
	}
	
	void ClientManager::gotoGame(const char *name,GAME_RELOAD_TYPE reloadtype /* = NO_RELOAD */)
	{
		ClientGame *game = NULL;
		m_ReloadGameType = reloadtype;
		#ifdef IWORLD_SERVER_BUILD
			if(name==NULL || strcmp(name, "none") == 0)
			{
				if(m_LoadingGame)
				{
					delete 	m_LoadingGame;
					m_LoadingGame = NULL;
				}
	
				if(m_CurGame)
				{
					delete 	m_CurGame;
					m_CurGame = NULL;
				}
	
				return;
			}
	
			if(!m_LoadingGame)
			{
				game = new StandaloneServer;
				m_LoadingGame = game;
				m_LoadingGame->load(this);
			}
		#else
			if(name==NULL || strcmp(name, "none") == 0)
			{
				if(m_LoadingGame)
				{
					delete 	m_LoadingGame;
					m_LoadingGame = NULL;
				}
	
				if(m_CurGame) clearCurGame();
				return;
			}
			std::map<std::string, ClientGame *>::iterator iter = m_Games.find(std::string(name));
			if(iter == m_Games.end())
			{
				if(strcmp(name, "MainMenuStage") == 0) game = new MainMenuStage;
				else if(strcmp(name, "SurviveGame") == 0) game = new SurviveGame;
				else if(strcmp(name, "MPSurviveGame") == 0) game = new MpGameSurvive(m_ReloadGameType==MULTI_RELOAD);
				else if(strcmp(name, "StandaloneServer") == 0) game = new StandaloneServer;
				else
				{
					assert(0);
					return;
				}
				m_Games[std::string(name)] = game;
			}
			else game = iter->second;
	
			m_LoadingGame = game;
			m_LoadingGame->load(this);
		#endif
	
	
	}
	
	bool ClientManager::isMobile()
	{
	#ifdef IWORLD_TARGET_MOBILE
		return true;
	#else
		return false;
	#endif
	}
	
	bool ClientManager::isPC()
	{
	#ifdef IWORLD_TARGET_PC
		return true;
	#else
		return false;
	#endif
	}
	
	ClientGame *ClientManager::getCurGame()
	{
		return m_CurGame;
	}
	
	ClientGame* ClientManager::getGame(const char *name)
	{
		std::map<std::string, ClientGame *>::iterator iter = m_Games.find(std::string(name));
		if(iter != m_Games.end()) return iter->second;
		return nullptr;
	}
	
	void ClientManager::clearCurGame()
	{
		char funcname[256];
	
		m_CurGame->m_hasBegan = false;
		m_CurGame->endGame(m_ReloadGameType>0);
	
		if(m_ReloadGameType == NO_RELOAD)
		{
			sprintf(funcname, "%s_Quit", m_CurGame->getName());
			m_ScriptVM->callFunction(funcname, "");
		}
	
		if(m_InputMgr) m_InputMgr->UnregisterInputHandler(m_CurGame);
	
		m_CurGame->unload(m_ReloadGameType>0);
		removeGame(m_CurGame);
	
		m_CurGame = NULL;
	}
	
	void ClientManager::updateLoadingGame()
	{
		/*if(m_CurGame && m_ReloadGameType>0)
		{
		m_CurGame->endGame();
	
		if(m_InputMgr) m_InputMgr->UnregisterInputHandler(m_CurGame);
		m_CSMgr->removeMsgHandler(m_CurGame);
		m_CurGame->unload();
		removeGame(m_CurGame);
	
		m_CurGame = NULL;
	
		setRenderCamera(NULL);
		setRenderContent(NULL);
		}*/
	
		int loadstatus = m_LoadingGame->updateLoad();
		if(loadstatus == 0) return;
		else if(loadstatus < 0)
		{
			m_LoadingGame->unload();
			removeGame(m_LoadingGame);
			m_LoadingGame = NULL;
			GameEventQue::getSingleton().postLoadProgress(1000, -1);
			
			return;
		}
	
		if(m_CurGame)
		{
			clearCurGame();
		}
	
		m_CurGame = m_LoadingGame;
	
		#ifdef IWORLD_SERVER_BUILD
			  m_CurGame->updateLoad();
		#endif
	
		m_LoadingGame = NULL;
	
		if(m_InputMgr != NULL && m_CurGame != NULL) m_InputMgr->RegisterInputHandler(m_CurGame);
		if(m_ScriptVM != NULL && m_CurGame != NULL) m_ScriptVM->setUserTypePointer("ClientCurGame", m_CurGame->getTypeName(), m_CurGame);
	
		if(m_CurGame){
			m_CurGame->applayGameSetData();
			m_CurGame->beginGame();
			m_CurGame->m_hasBegan = true;
			if (strcmp(m_CurGame->getName(), "MainMenuStage") != 0)
			{
				if (m_InputMgr && !m_InputMgr->isFocus() && g_ClientMgr.isPC() && g_ClientMgr.m_ScriptVM)
				{
					g_ClientMgr.m_ScriptVM->callFunction("OnWindowLostFocus", "");
				}
			}
		}
	
	
		char funcname[256];
	#ifndef IWORLD_SERVER_BUILD
		if(m_ReloadGameType == NO_RELOAD || strcmp(m_CurGame->getTypeName(), "MainMenuStage") != 0)
		{
			sprintf(funcname, "%s_Enter", m_CurGame->getName());
			m_ScriptVM->callFunction(funcname, "");
		}
	#else
	 	if(m_ReloadGameType == NO_RELOAD || strcmp(m_CurGame->getTypeName(), "MainMenuStage") != 0)
		{
			sprintf(funcname, "%s_Enter", m_CurGame->getName());
			if(m_ScriptVM) m_ScriptVM->callFunction(funcname, "");
		}
	#endif
		//LOG_INFO("updateloadingGame end");
	
		if(m_ReloadGameType != NO_RELOAD  && strcmp(m_CurGame->getName(), "MainMenuStage") == 0)
		{
			if (m_ReloadGameType == MULTI_RELOAD)
			{
				if (g_AccountMgr->getMultiPlayer() == GameNetManager::MP_GAME_CLIENT)
					g_AccountMgr->m_CurWorldID = 0;
				gotoGame("MPSurviveGame", m_ReloadGameType);
			}
			else if (m_ReloadGameType == SINGLE_RELOAD)
			{
				gotoGame("SurviveGame", m_ReloadGameType);
			}
		}
	}
	
	void ClientManager::removeGame(ClientGame *game)
	{
		if(!game->isInGame()) return;
	
		std::map<std::string, ClientGame *>::iterator iter = m_Games.begin();
		for(; iter!=m_Games.end(); iter++)
		{
			if(iter->second == game)
			{
				delete game;
				m_Games.erase(iter);
				break;
			}
		}
	}
	
	void ClientManager::setGameData(const char *name, int val)
	{
		//Ogre::XMLNode node = Ogre::Root::getSingleton().m_Config.getNodeByPath("GameData.Buddy");
		//if(!node.isNull()) time1 = node.attribToInt("resettime");
		XMLNode rootnode = Root::getSingleton().m_Config.getRootNode();
		XMLNode node = rootnode.getOrCreateChild("GameData");
	
		XMLNode child = node.getOrCreateChild("Settinig");
	
		if(strcmp(name, "lang") == 0)
		{
			std::string sVal; 
			if(val == 0)
				sVal = "zh-cn";
			else if(val == 1)
				sVal = "en";
			else if(val == 2)
				sVal = "zh-tw";
			else if (val == 3)
				sVal = "tha";
			else if (val == 4)
				sVal = "esn";
			else if (val == 5)
				sVal = "ptb";
			else if (val == 6)
				sVal = "fra";
			else if (val == 7)
				sVal = "jpn";
			else if (val == 8)
				sVal = "ara";
			else if (val == 9)
				sVal = "kor";
			else if (val == 10)
				sVal = "vie";
			else if (val == 11)
				sVal = "rus";
			else if (val == 12)
				sVal = "tur";
			else if (val == 13)
				sVal = "ita";
			else if (val == 14)
				sVal = "ger";
			else if (val == 15)
				sVal = "ind";
			else
				sVal = "en";
	
			child.setAttribStr(name, sVal.c_str());
		}
		else
			child.setAttribInt(name, val);	
	
		Root::getSingleton().saveFile();
	}
	
	int ClientManager::getGameData(const char *name)
	{
		int val = 0;
		Ogre::XMLNode node = Ogre::Root::getSingleton().m_Config.getNodeByPath("GameData.Settinig");
		if(!node.isNull()) 
		{
			if(node.hasAttrib(name))
			{
				if(strcmp(name, "lang") == 0)
				{
					const char* lang = node.attribToString(name);
					if (strcmp(lang, "zh-cn") == 0)
						val = 0;
					else if (strcmp(lang, "en") == 0)
						val = 1;
					else if (strcmp(lang, "zh-tw") == 0)
						val = 2;
					else if (strcmp(lang, "tha") == 0)
					{
						val = 3;
					}
					else if (strcmp(lang, "esn") == 0)
						val = 4;
					else if (strcmp(lang, "ptb") == 0)
						val = 5;
					else if (strcmp(lang, "fra") == 0)
						val = 6;
					else if (strcmp(lang, "jpn") == 0)
						val = 7;
					else if (strcmp(lang, "ara") == 0)
						val = 8;
					else if (strcmp(lang, "kor") == 0)
						val = 9;
					else if (strcmp(lang, "vie") == 0)
						val = 10;
					else if (strcmp(lang, "rus") == 0)
						val = 11;
					else if (strcmp(lang, "tur") == 0)
						val = 12;
					else if (strcmp(lang, "ita") == 0)
						val = 13;
					else if (strcmp(lang, "ger") == 0)
						val = 14;
					else if (strcmp(lang, "ind") == 0)
						val = 15;
					else
						val = 1;
					StringUtil::lang = val;
				}
				else
					val = node.attribToInt(name);
			}
			else
			{
				if(strcmp(name, "view_distance") == 0)
				{
					node.setAttribInt(name, 2);
					val = 2;
				}
				else if(strcmp(name, "showchip") == 0 || strcmp(name, "rocker") == 0 || strcmp(name, "camerashake") == 0  || strcmp(name, "view") == 0
					|| strcmp(name, "voiceopen") == 0 || strcmp(name, "speakerswitch") == 0 || strcmp(name, "popups") == 0)
				{
					node.setAttribInt(name, 1);
					val = 1;
				}
				else if (strcmp(name, "fog") == 0)
				{
					node.setAttribInt(name, 0);
					val = 0;
				}
				else if (strcmp(name, "treeshape") == 0)
				{
					node.setAttribInt(name, 1);
					val = 1;
				}
				else if (strcmp(name, "radarSteering") == 0)
				{
					node.setAttribInt(name, 0);
					val = 0;
				}
				else
				{
					if(strcmp(name, "lang") == 0)
						node.setAttribStr(name, "zh-cn");
					else
						node.setAttribInt(name, 0);
					val = 0;
				}
	
				Root::getSingleton().saveFile();
			}
		}
	
		return val;
	}
	
	void ClientManager::setGameHotkey(const char *name, int code)
	{
		XMLNode rootnode = Root::getSingleton().m_Config.getRootNode();
		XMLNode node = rootnode.getOrCreateChild("GameData");
	
		XMLNode child = node.getOrCreateChild("Hotkey");
		child.setAttribInt(name, code);	
	
		Root::getSingleton().saveFile();
	}
	
	int ClientManager::getGameHotkey(const char *name)
	{
		int val = -1;
		Ogre::XMLNode node = Ogre::Root::getSingleton().m_Config.getNodeByPath("GameData.Hotkey", true);
		if(!node.isNull()) 
		{
			if(node.hasAttrib(name))
			{
				val = node.attribToInt(name);
			}
		}
	
		return val;
	}
	
	const char *ClientManager::getHotkeyName(int keycode)
	{
		return g_GameSettings->getKeyBindKeyName(keycode);
	}
	
	void ClientManager::setOneKeyBindCode(const char *keyname, int keycode)
	{
		g_GameSettings->setOneKeyBindCode(keyname, keycode);
	}
	
	void ClientManager::initStatistics()
	{
		int curtime = (int)GetTimeStamp();
	
		//老的客户端的用户, 设置好初始值, 不列入到新手统计里面
		XMLNode rootnode = Root::getSingleton().m_Config.getRootNode();
		XMLNode node = rootnode.getOrCreateChild("GameData");
		if(!node.hasChild("Statistics"))
		{
			setStatistics("createtime", curtime);
			setStatistics("laststart", curtime);
			setStatistics("createworlds", 2);
			setStatistics("curachieve", -1);
		}
	}
	
	void ClientManager::setStatistics(const char *name, int var, bool force_save)
	{
		XMLNode rootnode = Root::getSingleton().m_Config.getRootNode();
		XMLNode node = rootnode.getOrCreateChild("GameData");
	
		XMLNode child = node.getOrCreateChild("Statistics");
		child.setAttribInt(name, var);
	
		if(force_save) Root::getSingleton().saveFile();
	}
	
	int ClientManager::getStatistics(const char *name)
	{
		int val = 0;
		Ogre::XMLNode node = Ogre::Root::getSingleton().m_Config.getNodeByPath("GameData.Statistics");
		if(!node.isNull() && node.hasAttrib(name))
		{
			val = node.attribToInt(name);
		}
		return val;
	}
	
	void ClientManager::appalyGameSetData(bool viewchange/* =false */)
	{
		if(m_CurGame) m_CurGame->applayGameSetData(viewchange);
	}
	
	const char* ClientManager::checkCmd(const char* cmd)
	{
		if (strcmp(cmd, "#cr") == 0)
		{
			return "miniwan tech sz";
		}
		else
		{
			//预留其他命令
		}
		return "";
	}
	
	void ClientManager::setGameVar(const char *varname, const char *str)
	{
		m_GameVars[std::string(varname)] = std::string(str);
	}
	
	const char *ClientManager::getGameVar(const char *varname)
	{
		std::map<std::string, std::string>::iterator iter = m_GameVars.find(varname);
		if(iter !=m_GameVars.end())
		{
			return iter->second.c_str();
		}
	
		return "";									  
	}
	
	class ItemIconLoader : public UIResLoader
	{
	public:
		virtual Ogre::Texture *loadTexture(const FixedString &path) override
		{
			if(path.length() <= 6) return NULL;
			int itemid = atoi(path.c_str() + 6); //$item:
	
			IconDesc *desc = ItemIconMgr::getSingleton().getItemIconDesc(itemid);
			if(desc == NULL || desc->tex==NULL) return NULL;
			else
			{
				desc->tex->addRef();
				return desc->tex;
			}
		}
	};
	static ItemIconLoader s_ItemIconLoader;
	HUIRES ClientManager::getItemIcon(int itemid, int &u, int &v, int &width, int &height, int &r, int &g, int &b)
	{
		IconDesc *desc = m_ItemIconMgr->getItemIconDesc(itemid);
		if(desc == NULL)
		{
			return 0;
		}
		else
		{
			if(desc->h == 0)
			{
				char path[256];
				sprintf(path, "$item:%d", itemid);
				desc->h = m_UIRenderer->AddTextureRes(path, desc->tex, NULL, NULL, &s_ItemIconLoader);
				if(desc->h == 0)
				{
					Ogre::Texture *ptex = ResourceManager::getSingleton().m_WhiteTex;
					ptex->addRef();
					desc->h = m_UIRenderer->AddTextureRes(path, ptex);
				}
			}
	
			u = desc->u;
			v = desc->v;
			width = desc->width;
			height = desc->height;
			/*
			if(width > 64)
			{
				u++;
				width -= 2;
			}
			if(height > 64)
			{
				v++;
				height -= 2;
			}*/
			r = desc->color.r;
			g = desc->color.g;
			b = desc->color.b;
	
			return desc->h;
		}
	}
	
	HUIRES ClientManager::getNullItemIcon()
	{
		return 0;
	}
	
	void ClientManager::playMusic(const char *path, bool bLoop)
	{  
		SoundSystem* soundsys = SoundSystem::getSingletonPtr();
		if(soundsys){
			soundsys->playMusic(0, path, bLoop, 500);
		}
	}
	
	void ClientManager::setPause(bool bPause)
	{
		SoundSystem* soundsys = SoundSystem::getSingletonPtr();
		if(soundsys){
			soundsys->setMute(bPause);
		}
	}
	
	void ClientManager::stopMusic()
	{
		SoundSystem* soundsys = SoundSystem::getSingletonPtr();
		if(soundsys){
			soundsys->playMusic(0, NULL, false, 500);
		}
	}
	
	void ClientManager::playSound2D(const char *path, float fVolume)
	{
		SoundSystem::getSingleton().playSound2D(path, fVolume);
	}
	
	ISound* ClientManager::playSound2DControl(const char *path, float fVolume, bool loop)
	{
		return SoundSystem::getSingleton().playSound2DControl(path, fVolume, loop);
	}
	
	int ClientManager::getNetworkState()
	{
	    #ifdef IWORLD_TARGET_PC
			return GetNetworkCardState();
		#endif
	
		return GetNetworkState();
	}
	
	int ClientManager::OpenMyie(const char *event)
	{
		#ifdef IWORLD_TARGET_PC
		    if(stricmp(event, "Vip_BuyBlueVip_XuFei")==0 || stricmp(event, "Vip_BuyBlueVip_KaiTong")==0)
			{
				//拉起充值浏览器界面
				char buff[2048];
				sprintf(buff, "type=openVip&gamehwnd=%d", (long)g_ClientMgr.getHwnd());
				UnicodeString buffU(buff);
	
				OSVERSIONINFOEX osvi;
				BOOL bOsVersionInfoEx;
				ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
				//Get Version Information
				osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
				bOsVersionInfoEx = GetVersionEx ((OSVERSIONINFO *) &osvi);
				int nShow=SW_NORMAL;
				if (osvi.dwMajorVersion > 5)
				{																	    
					//vista
					SHELLEXECUTEINFO shExecInfo;
					shExecInfo.cbSize = sizeof(SHELLEXECUTEINFO);
					shExecInfo.fMask = NULL;
					shExecInfo.hwnd = (HWND)g_ClientMgr.getHwnd();
					shExecInfo.lpVerb = __TEXT("open");
					shExecInfo.lpFile = __TEXT("chargeComm.exe");
					shExecInfo.lpParameters = buffU;
					shExecInfo.lpDirectory = NULL;
					shExecInfo.nShow = nShow;
					shExecInfo.hInstApp = NULL;
					ShellExecuteEx(&shExecInfo);
				}
				else
				{
					ShellExecute((HWND)g_ClientMgr.getHwnd(), __TEXT("open"), __TEXT("chargeComm.exe"), buffU, NULL, nShow);	
				}
			}
			else if (stricmp(event, "Vip_BuyYellowVip_XuFei")==0 || stricmp(event, "Vip_BuyBlueVip_KaiTong")==0)
			{
				 //拉起充值浏览器界面
				Ogre::BrowserShowWebpage("http://pay.qq.com/qzone/index.shtml?aid=game1105856612.op");
			}
		#endif 	
		return 0;
	}
	
	jsonxx::Object* createStatisticsJsonObj()
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		int platform = 3;
	#elif OGRE_PLATFORM == OGRE_PLATFORM_ANDROID || OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC
		int platform = 1;
	#elif OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		int platform = 2;
	#endif
	
		jsonxx::Object* jsonobj = new jsonxx::Object();
		jsonobj->import("iappid", jsonxx::Number(platform));
		jsonobj->import("idomain", jsonxx::Number(g_ClientMgr.getApiId()));
		jsonobj->import("vuin", jsonxx::Number(g_AccountMgr->getUin()));
		jsonobj->import("iversion", jsonxx::Number(g_ClientMgr.clientVersion()));
		jsonobj->import("ieventTime", jsonxx::Number(GetTimeStamp()));
		jsonobj->import("ioptype", jsonxx::Number(10000));
	
		return jsonobj;
	}
	
	void ClientManager::statisticsEnterWorld(long long owid, long long fromowid, int authoruin)
	{
		jsonxx::Object* jsonobj = createStatisticsJsonObj();
	
		jsonobj->import("iactionid", jsonxx::Number(SAID_EnterWorld));
		jsonobj->import("ireserve_1", owid);
		jsonobj->import("ireserve_2", fromowid);
		jsonobj->import("iparam_1", authoruin);
	
		postStatisticsData(jsonobj->json());
		delete jsonobj;
	}
	
	void ClientManager::statisticsMiniworksDownMap(long long owid, int authoruin, int uilabel, const char* uipart)
	{
		jsonxx::Object* jsonobj = createStatisticsJsonObj();
	
		jsonobj->import("iactionid", jsonxx::Number(SAID_MiniworksDownMap));
		jsonobj->import("ireserve_1", owid);
		jsonobj->import("iparam_1", authoruin);
		jsonobj->import("iparam_2", uilabel);
		jsonobj->import("vparam_1", std::string(uipart));
	
		postStatisticsData(jsonobj->json());
		delete jsonobj;
	}
	
	void ClientManager::statisticsDeleteWorld(long long owid, long long fromowid, int authoruin)
	{
		jsonxx::Object* jsonobj = createStatisticsJsonObj();
	
		jsonobj->import("iactionid", jsonxx::Number(SAID_DeleteWorld));
		jsonobj->import("ireserve_1", owid);
		jsonobj->import("ireserve_2", fromowid);
		jsonobj->import("iparam_1", authoruin);
		
		postStatisticsData(jsonobj->json());
		delete jsonobj;
	}
	
	void ClientManager::statisticsCreateRoom(bool islan, int gamelabel, bool havepassword, int guestmode, int ExStatisticsID)
	{
		jsonxx::Object* jsonobj = createStatisticsJsonObj();
		if(ExStatisticsID == 0)
			jsonobj->import("iactionid", jsonxx::Number(SAID_CreateRoom));
		else
			jsonobj->import("iactionid", jsonxx::Number(ExStatisticsID));
		jsonobj->import("iparam_1", (islan ? 1 : 0));
		jsonobj->import("iparam_2", gamelabel);
		jsonobj->import("iparam_3", (havepassword ? 1 : 0));
		jsonobj->import("iparam_4", guestmode);
		jsonobj->import("vcountry", gFunc_getCountry());
	
		postStatisticsData(jsonobj->json());
		delete jsonobj;
	}
	
	void ClientManager::statisticsJoinRoom(bool islan, int gamelabel, int ExStatisticsID)
	{
		jsonxx::Object* jsonobj = createStatisticsJsonObj();
		if(ExStatisticsID == 0)
			jsonobj->import("iactionid", jsonxx::Number(SAID_JoinRoom));
		else
			jsonobj->import("iactionid", jsonxx::Number(ExStatisticsID));
		jsonobj->import("iparam_1", (islan ? 1 : 0));
		jsonobj->import("iparam_2", gamelabel);
		jsonobj->import("vcountry", gFunc_getCountry());
	
		postStatisticsData(jsonobj->json());
		delete jsonobj;
	}
	
	void ClientManager::statisticsJoinRoomSucceed(int ExStatisticsID)
	{
		jsonxx::Object* jsonobj = createStatisticsJsonObj();
		if(ExStatisticsID == 0)
			jsonobj->import("iactionid", jsonxx::Number(SAID_JoinRoomSucceed));
		else
			jsonobj->import("iactionid", jsonxx::Number(ExStatisticsID));
		jsonobj->import("vcountry", gFunc_getCountry());
	
		postStatisticsData(jsonobj->json());
		delete jsonobj;
	}
	
	void ClientManager::postStatisticsData(const std::string& jsonstr)
	{
		//std::string postdata = "json=";
		//postdata += jsonstr;
		//m_statisticsCache.push_back(std::make_pair(m_statisticsCache.size(), postdata));
	
		m_statisticsCache.push_back(std::make_pair(m_statisticsCache.size(), jsonstr));
		sendStatistics();
	}
	
	
	//void sendStatistics(bool checkTime = true, bool sendAll = false)
	void ClientManager::sendStatistics(bool checkTime, bool sendAll)
	{
		unsigned int curtimestamp = GetTimeStamp();
	
		int count_max_ = 64;  //最大发送量
		if ( checkTime && ( curtimestamp - m_statisticsLastSendTime > m_statisticsSendInterval ) ) {
			//达到5分钟一次
		}
		else if ( sendAll ) {
			//完全发送
		}
		else if ( m_statisticsCache.size() > m_statisticsSendMax ) {
			//超过个数
		}
		else {
			//缓存起来
			//LOG_INFO("@statistics not send: size = %d", m_statisticsCache.size());
			return;
		}
	
		LOG_INFO("@statistics send: size = %d-%d", m_statisticsCache.size(), count_max_);
		if ( m_statisticsCache.size() > 0 ) {
			std::string postdata = "json=[";
			while (!m_statisticsCache.empty() && ( --count_max_ ) > 0) {
				std::string postdata_one = m_statisticsCache.front().second;
				m_statisticsCache.pop_front();
				if (postdata.length() > 7) { postdata += ","; };
				postdata += postdata_one;
			}
			postdata += "]";
			LOG_INFO("@[len=%d]", postdata.length());
	
			int evn_ = g_ClientMgr.getGameData("game_env");
			if (evn_ == 0) {
				//正式
				g_httpDownloadMgr->reportPost("http://tj.mini1.cn/miniworld", postdata);
			}
			else if (evn_ >= 10) {
				//海外
				g_httpDownloadMgr->reportPost("http://tj_hk.mini1.cn/miniworld", postdata);
			}
			else {	
				//测试
				g_httpDownloadMgr->reportPost("http://120.24.64.132:8080/miniworld", postdata);
			}
			m_statisticsLastSendTime = curtimestamp;
		}
	}
	
	void ClientManager::statisticsGameEvent(const char *event, const char *paramsName1/* ="" */, const char *params1/* ="" */, const char *paramsName2/* ="" */, const char *params2/* ="" */, const char *paramsName3/* ="" */, const char *params3/* ="" */)
	{
		OnStatisticsGameEvent(event, paramsName1, params1, paramsName2, params2, paramsName3, params3);
	
		#ifdef IWORLD_TARGET_PC
	
		    if(stricmp(event, "Vip_BuyBlueVip_XuFei")==0 || stricmp(event, "Vip_BuyBlueVip_KaiTong")==0)
			{
				//拉起充值浏览器界面
				char buff[2048];
				sprintf(buff, "type=openVip&gamehwnd=%d", (long)g_ClientMgr.getHwnd());
				UnicodeString buffU(buff);
				OSVERSIONINFOEX osvi;
				BOOL bOsVersionInfoEx;
				ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
				//Get Version Information
				osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
				bOsVersionInfoEx = GetVersionEx ((OSVERSIONINFO *) &osvi);
				int nShow=SW_NORMAL;
				if (osvi.dwMajorVersion > 5)
				{																	    
					//vista
					SHELLEXECUTEINFO shExecInfo;
					shExecInfo.cbSize = sizeof(SHELLEXECUTEINFO);
					shExecInfo.fMask = NULL;
					shExecInfo.hwnd = (HWND)g_ClientMgr.getHwnd();
					shExecInfo.lpVerb = __TEXT("open");
					shExecInfo.lpFile = __TEXT("chargeComm.exe");
					shExecInfo.lpParameters = buffU;
					shExecInfo.lpDirectory = NULL;
					shExecInfo.nShow = nShow;
					shExecInfo.hInstApp = NULL;
					ShellExecuteEx(&shExecInfo);
				}
				else
				{
					ShellExecute((HWND)g_ClientMgr.getHwnd(), __TEXT("open"), __TEXT("chargeComm.exe"), buffU, NULL, nShow);	
				}
			}
	
		#endif 													   
	}
	
	void ClientManager::AppsFlyerStatisticsGameEvent(const char* evnet, const char *paramsName1 /*= ""*/, const char *param1 /*= ""*/, const char *paramsName2 /*= ""*/, const char *param2 /*= ""*/, const char *paramsName3 /*= ""*/, const char *param3 /*= ""*/)
	{
		OnAppsFlyerStatisticsGameEvent(evnet, paramsName1, param1, paramsName2, param2, paramsName3, param3);
	}
	
	void ClientManager::statisticsGameChooseRole(const char *roleName, const char *nickName, int uin)
	{
		OnStatisticsGameChooseRole(roleName, nickName, uin);
	}
	
	void ClientManager::statisticsGameBuyRole(char *roleName)
	{
		OnStatisticsGameBuyRole(roleName);
	}
	
	void ClientManager::statisticsGameRewardMiniCoin(int num, char *reason)
	{
		OnStatisticsGameRewardMiniCoin(num, reason);
	}
	
	void ClientManager::statisticsGamePurchaseMiniCoin(char *name, int num, float price)
	{
		OnStatisticsGamePurchaseMiniCoin(name, num, price);
	}
	
	void ClientManager::statisticsOnChargeRequest(const char *sid, const char *productname, const char *paymentType, float price, int coinnum)
	{
		OnStatisticsOnChargeRequest(sid, productname, paymentType, price, coinnum);
	}
	
	void ClientManager::statisticsOnChargeSuccess(const char *sid)
	{
		OnStatisticsOnChargeSuccess(sid);
	}
	
	void ClientManager::clickCopy(char *content)
	{
		OnClickCopy(content);
	}
	
	void ClientManager::sdkLogin()
	{
		OnSdkLogin();
	
	}
	
	void ClientManager::sdkSwitch()
	{
		OnSdkSwitch();
	}
	
	void ClientManager::sdkLogout()
	{
		OnSdkLogout();
	}
	
	void ClientManager::sdkForum()
	{
		OnSdkForum();
	}
	
	void ClientManager::sdkGameCenter()
	{
		LOG_INFO("kekeke sdkGameCenter");
		OnSdkGameCenter();
	}
	
	void ClientManager::sdkAccountBinding(int type)
	{
		LOG_INFO("!!!!!!!!!!!!!sdkAccountBinding:%d", type);
		OnSdkAccountBinding(type);
	}
	
	void ClientManager::sdkRealNameAuth()
	{
		LOG_INFO("!!!!!!!!!!!!sdkRealNameAuth!!!!!!!!!!!!!!");
		OnSdkRealNameAuth();
	}
	
	void ClientManager::onRespWatchAD(int result)
	{
		LOG_INFO("!!!!!!!!!!!!onRespWatchAD:%d!!!!!!!!!!!!", result);
		GameEventQue::getSingleton().postWatchADResult(result);
	}
	
	void ClientManager::reqSdkAD(const char *type, int adid,int adindex)
	{
		LOG_INFO("!!!!!!!!!!!!reqSdkAD:%s %d %d!!!!!!!!!!!!", type, adid, adindex);
		//#if OGRE_PLATFORM==OGRE_PLATFORM_WIN32
		//	onRespWatchAD(1001);
		//	//return 1;
		//#el
	#if OGRE_PLATFORM == OGRE_PLATFORM_ANDROID || OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		int ret = OnReqSdkAD(type, adid, onRespWatchAD, adindex);
		if(ret == 0)
		{
			onRespWatchAD(REQAD_CONFIG_FAILED);
		}
		else if(ret == 2)
		{
			onRespWatchAD(REQAD_SDK_FAILED);
		}
	#endif
	}
	
	bool ClientManager::InitAdvertisementsSDK(int adid)
	{
		LOG_INFO("!!!!!!!!!!!!InitAdvertisementsSDK:%d!!!!!!!!!!!!", adid);
	#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		return OnInitAdvertisementsSDK(adid);
	#endif
		return true;
	}
	
	// 如果不关注position 可以不管
	bool ClientManager::AdvertisementsLoadStatus(int adid, int position)
	{
		LOG_INFO("!!!!!!!!!!!!AdvertisementsLoadSuccess:%d!!!!!!!!!!!!", adid);
	#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE || OGRE_PLATFORM == OGRE_PLATFORM_ANDROID 
		return OnAdvertisementsLoadStatus(adid, position);
	#endif
		return true;
	}
	// 如果不关注position 可以不管
	void ClientManager::AdvertisementsPreLoad(int adid, int position)
	{
		LOG_INFO("!!!!!!!!!!!!AdvertisementsLoadSuccess:%d!!!!!!!!!!!!", adid);
	#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE || OGRE_PLATFORM == OGRE_PLATFORM_ANDROID 
		OnLoadSdkAD(adid, position);
		return;
	#endif
	    //TODO 
		return ;
	}
	
	void ClientManager::RequestReview()
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		OnRequestReview();
	#endif
	}
	
	
	void ClientManager::setSdkRoleInfo(const char *rolename, const char *type, int uin, int coinnum)
	{
		OnSetSdkRoleInfo(rolename, type, uin, coinnum);
	}
	
	void ClientManager::setSdkFloatMenu(int type)
	{
		LOG_INFO("!!!!!!!!!!!!setSdkFloatMenu:%d!!!!!!!!!!!!", type);
		OnSetSdkFloatMenu(type);
	}
	
	bool ClientManager::isSdkToStartGame()
	{
		#ifndef IWORLD_SERVER_BUILD 
		return IsSdkToStartGame();
		#else
		return false;
		#endif
	}
	
	void ClientManager::gameExit()
	{
		if(getCurGame())
			getCurGame()->pauseGame();
		GameExit();
	}
	
	void ClientManager::vibrate(int val)
	{
		GameVibrate(val);
	}
	
	int ClientManager::getApiId()
	{
		return m_nApiId;
	}
	
	std::string ClientManager::getSchemeJson()
	{
		LOG_INFO("kekeke ClientManager::getSchemeJson");
		return GetSchemeJson();
	}
	
	bool ClientManager::pullTPApp(const char *appname, const char *jsonstr)
	{
		LOG_INFO("kekeke ClientManager::pullTPApp");
		return PullTPApp(appname, jsonstr);
	}
	
	ConstAtLua* ClientManager::get_lua_const()
	{
	    return m_LuaInterface->get_lua_const();
	}
	
	PLATFORM_TYPE ClientManager::getPlatform()
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		return PLATFORM_WIN32;
	#elif OGRE_PLATFORM == OGRE_PLATFORM_ANDROID 
		return PLATFORM_ANDROID;
	#elif OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC
		return PLATFORM_LINUXPC;
	#elif OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		return PLATFORM_APPLE;
	#endif
	}
	
	const char* ClientManager::getPlatformStr()
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		return "windows";
	#elif OGRE_PLATFORM == OGRE_PLATFORM_ANDROID 
		return "android";
	#elif OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC
		return "linuxpc";
	#elif OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		return "ios";
	#endif
	}
	
	bool ClientManager::isQQGamePcApi(int apiid)
	{
		return (apiid==101 || apiid==102 || apiid==109 || apiid==111 || apiid==115);
	}
	
	void ClientManager::setPayExtendParams(int i, char *buf, int bufsize)
	{
		SetPayExtendParams(i, buf, bufsize);
	}
	
	std::string ClientManager::setPayExtendParamsToSdk(int i)
	{
		char buff[256];
		SetPayExtendParams(i, buff, sizeof(buff));
	
		return buff;
	}
	
	bool ClientManager::hasTPPay()
	{
		return GameHasTPPay() == 1;
	}
	
	void ClientManager::moreGameEgame()
	{
		GameMoreGame();
	}
	
	void ClientManager::startUpdate()
	{
		GameStartUpdate();
	}
	
	void ClientManager::setAccount(int uin, const char *nickname, const char *appid/* = nullptr*/, const char *appkey/* = nullptr*/)
	{
		GameSetAccount(uin, nickname);
		#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
		if(GVoiceEnable() && uin > 1)
			m_GVoiceMgr->init(uin, appid, appkey);
		#endif
	
		if(getVersionParamInt("TApmEnabled", 0) == 1 && OGRE_PLATFORM == OGRE_PLATFORM_ANDROID)
		{
			if (m_TApmMgr == nullptr)
			{
				m_TApmMgr = new TApmManager;
				m_ScriptVM->setUserTypePointer("TApmMgr", "TApmManager", m_TApmMgr);
				m_TApmMgr->markLevelLoad("MainMenuStage");
			}
	
			m_TApmMgr->setUserId(uin);
		}
	
	
		int curtime = (int)GetTimeStamp();
	
		int laststart = getStatistics("laststart");
		if(!m_AccountInfo->isSameDay(laststart,curtime, true))
		{
			setStatistics("laststart", curtime);
	
			if(laststart != 0) //不是第一次进入游戏
			{
				int actdays = getStatistics("activedays")+1;
				setStatistics("activedays", actdays);
	
				char tmpbuf[64];
				if(actdays > 60) strcpy(tmpbuf, "60+");
				else if(actdays > 30) strcpy(tmpbuf, "30+");
				else sprintf(tmpbuf, "%d", actdays);
	
				statisticsGameEvent("ActiveDaysEvent", "Days", tmpbuf, "version", sClientVersion);
			}
		}
	
		int regtime = getStatistics("regtime");
		if(regtime <= 1)
		{
			struct tm curr1;
			time_t time1 = curtime;
			localtime_r(&time1, &curr1);
			setStatistics("regtime", curtime, true);
	
			if(regtime == 1) //新版本， 不是以前的进入的玩家
			{
				static const char *dayname[] = {"Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat"};
				char tmpbuf[64];
				sprintf(tmpbuf, "Reg_On_%s", dayname[curr1.tm_wday]);
				statisticsGameEvent(tmpbuf, "version", sClientVersion);
			}
		}
	}
	
	void ClientManager::setAccountEx(int uin, const char *nickname, const char *appid, const char *appkey)
	{
		this->setAccount(uin, nickname, appid, appkey);
	}
	
	void ClientManager::onImagePicked(bool succeed)
	{
		if (succeed)
		{
			LOG_INFO("!!!!!!!!!!!!OnImagePicked!!!!!!!!!!!! succeed");
			g_ClientMgr.m_ScriptVM->callFunction("onImagePicked", "i", 1);
		}
		else
		{
			LOG_INFO("!!!!!!!!!!!!OnImagePicked!!!!!!!!!!!! failed");
			g_ClientMgr.m_ScriptVM->callFunction("onImagePicked", "i", 0);
		}
	}
	
	bool ClientManager::showImagePicker(std::string path, int type, bool crop/* =true */, int x/* =1280 */, int y/* =1280 */)
	{
		LOG_INFO("ClientManager::showImagePicker");
		#if OGRE_PLATFORM==OGRE_PLATFORM_WIN32
			 static bool isopen = false;
			 if(isopen)
			  return false;
			 isopen = true;
			 TCHAR   szFilename[MAX_PATH]   =   TEXT("个人图像.png");
			 BOOL   bResult   =   FALSE;   
			 DWORD  dwError  =   NOERROR;   
			 OPENFILENAME  ofn  =   {0};  
	
			 ofn.lStructSize   =  sizeof(OPENFILENAME);   
			 /// 在保存窗体 （类型那栏） 下面有显示；
			 ofn.lpstrFilter = TEXT( "(图像文件)*.*\0*.png;*.jpg\0\0";); 		  
			 ///文件名在szFilename里面；
			 ofn.lpstrFile   =   szFilename;   
			 ofn.nMaxFile   =   MAX_PATH;   
			 ofn.Flags   =   OFN_EXPLORER   |     
			  OFN_ENABLEHOOK   |     
			  OFN_HIDEREADONLY   |     
			  OFN_NOCHANGEDIR   |     
			  OFN_PATHMUSTEXIST;   
			 bResult   =   GetOpenFileName(&ofn);   
			 if (bResult == FALSE)   
			 {   
			    isopen = false;
			   dwError   =   CommDlgExtendedError   ();   
			   return   false;   
			 } 	 
	
			 CImage image;		 
			 image.Load(szFilename);
			 std::string stdio;
			 Ogre::FileManager::getSingleton().gamePath2StdioPath(stdio, path.c_str());
			 UnicodeString stdioU(stdio.c_str());
			 if(FAILED(image.Save(stdioU)))
			 {
			   	 isopen = false;
				 return false; 
			 }
			 isopen = false;
			 onImagePicked(true);
		#elif OGRE_PLATFORM == OGRE_PLATFORM_ANDROID || OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC || OGRE_PLATFORM == OGRE_PLATFORM_APPLE
			std::string fullpath;
			m_CurrentRequestFilePath = path;
			FileManager::getSingleton().gamePath2StdioPath(fullpath, path.c_str());
			LOG_INFO("ClientManager::showImagePicker _ANDROID");
			ShowImagePicker(fullpath.c_str(), onImagePicked, type, x, y);
	
		#endif
	
		return true;
	}
	
	void ClientManager::changeNetState(int type)
	{
	}
	
	bool ClientManager::isSharingOWorld()
	{
		if(g_CSMgr2)
		{
			return g_CSMgr2->isUploadingBusy();
		}
		return false;
	}
	
	void ClientManager::clientLog(char* log)
	{
		LOG_INFO(log);
	}
	
	int ClientManager::clientVersion()
	{
		return GetGameVersionInt();
		//return clientVersionFromStr(sClientVersion);
	}
	
	const char* ClientManager::clientVersionStr()
	{
		return sClientVersion;
	}
	
	char *ClientManager::clientVersionToStr(int version)
	{
		static char versionstr[300];
		snprintf(versionstr, 300, "%d.%d.%d", 
			int((version >> 16) & 0xff),
			int((version >> 8) & 0xff),
			int(version & 0xff)
			);
		return versionstr;
	}
	
	int ClientManager::clientVersionFromStr(const char *str)
	{
		return VersionStr2Int(str);
	}
	
	std::string ClientManager::getGameNoticeContent()
	{
		return m_noticeContent;
	}
	
	std::string ClientManager::getGameNoiceBrief()
	{
		return m_noticeBrief;
	}
	
	int ClientManager::getNoticeType()
	{
		return m_noticeType;
	}
	
	int ClientManager::getNoticeCode()
	{
		if(m_noticeType == 1)
		{
			return m_noticeCode;
		}
		else
		{
			XMLNode node =  Root::getSingleton().m_Config.getRootNode().getChild("GameData");
			if(node.isNull()) return true;
	
			XMLNode guideNode =  node.getChild("Notice");
			if(guideNode.isNull())
			{
				guideNode = node.addChild("Notice");
			}
	
			if(!guideNode.hasAttrib("code")) guideNode.setAttribInt("code", 0);
	
			return guideNode.attribToInt("code");
		}
	
	}
	
	void ClientManager::setNoticeCode(int code)
	{
		XMLNode node =  Root::getSingleton().m_Config.getRootNode().getChild("GameData");
		if(node.isNull()) return;
	
		XMLNode guideNode =  node.getChild("Notice");
		if(guideNode.isNull()) return;
	
		guideNode.setAttribInt("code", code);
		Root::getSingleton().saveFile();
	}
	
	int ClientManager::getCaptainNoticeCode()
	{
		XMLNode node =  Root::getSingleton().m_Config.getRootNode().getChild("GameData");
		if(node.isNull()) return true;
	
		XMLNode guideNode =  node.getChild("Notice");
		if(guideNode.isNull())
		{
			guideNode = node.addChild("Notice");
		}
	
		if(!guideNode.hasAttrib("captaincode")) guideNode.setAttribInt("captaincode", 0);
	
		return guideNode.attribToInt("captaincode");
	}
	
	void ClientManager::setCaptainNoticeCode(int code)
	{
		XMLNode node =  Root::getSingleton().m_Config.getRootNode().getChild("GameData");
		if(node.isNull()) return;
	
		XMLNode guideNode =  node.getChild("Notice");
		if(guideNode.isNull()) return;
	
		guideNode.setAttribInt("captaincode", code);
		Root::getSingleton().saveFile();
	}
	int ClientManager::getImsi()
	{
		return m_Imsi;
	}
	
	void *ClientManager::getHwnd()
	{
		return m_hWnd;
	}
	
	void ClientManager::addGame(const char *name, ClientGame *game)
	{
		m_Games[std::string(name)] = game;
	}
	
	void ClientManager::setRenderCamera(Ogre::Camera *pcamera)
	{
		if(m_SceneRenderer) m_SceneRenderer->setCamera(pcamera);
		if(m_DebugRenderer) m_DebugRenderer->setCamera(pcamera);
	}
	
	void ClientManager::setRenderContent(Ogre::GameScene *pscene)
	{
		if(m_SceneRenderer) m_SceneRenderer->setRenderScene(pscene);
		if(m_MinimapRenderer) m_MinimapRenderer->setRenderScene(pscene);
		if(m_DebugRenderer) m_DebugRenderer->setRenderScene(pscene);
	}
	
	void ClientManager::setClearColor(float r, float g, float b)
	{
		m_ClearColor.set(r,g,b, 1.0f);
	}
	
	void ClientManager::finishTask(int nextTaskId, const char *taskName)
	{
		if(6 == nextTaskId-1)
		{
			g_ClientMgr.m_ScriptVM->callFunction("AddGuideTaskCurNum", "ii", 6, 1);
			g_pPlayerCtrl->setTraceBlockState(false);
		}
		g_ClientMgr.m_AccountInfo->setNoviceGuideState(taskName, true);
		g_ClientMgr.m_AccountInfo->setCurNoviceGuideTask(nextTaskId);
		g_ClientMgr.m_ScriptVM->callFunction("HideGuideFingerFrame", "");
		g_ClientMgr.m_ScriptVM->callFunction("ShowCurNoviceGuideTask", "");
	}
	
	bool ClientManager::checkConfigVer(int& outvalue, const char *configkey, const char *verkey, const char *configonlykey, const char *onlyverkey)
	{
		if(g_AppParamObj)
		{
			if (g_AppParamObj->has<jsonxx::Number>(configonlykey) && g_AppParamObj->has<jsonxx::Number>(onlyverkey))
			{
				if (clientVersion() == (int)g_AppParamObj->get<jsonxx::Number>(onlyverkey))
				{
					outvalue = (int)g_AppParamObj->get<jsonxx::Number>(configonlykey);
					return true;
				}
			}
	
			if (g_AppParamObj->has<jsonxx::Number>(configkey))
			{
				if (g_AppParamObj->has<jsonxx::Number>(verkey))
				{
					if (clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>(verkey))
					{
						outvalue = (int)g_AppParamObj->get<jsonxx::Number>(configkey);
						return true;
					}
				}
				else
				{
					outvalue = (int)g_AppParamObj->get<jsonxx::Number>(configkey);
					return true;
				}
			}
		}
	
		return false;
	}
	bool ClientManager::checkConfigVer(bool& outvalue, const char *configkey, const char *verkey, const char *configonlykey, const char *onlyverkey)
	{
		if (g_AppParamObj)
		{
			if (g_AppParamObj->has<jsonxx::Boolean>(configonlykey) && g_AppParamObj->has<jsonxx::Number>(onlyverkey))
			{
				if (clientVersion() == (int)g_AppParamObj->get<jsonxx::Number>(onlyverkey))
				{
					outvalue = g_AppParamObj->get<jsonxx::Boolean>(configonlykey);
					return true;
				}
			}
	
			if (g_AppParamObj->has<jsonxx::Boolean>(configkey))
			{
				if (g_AppParamObj->has<jsonxx::Number>(verkey))
				{
					if (clientVersion() <= (int)g_AppParamObj->get<jsonxx::Number>(verkey))
					{
						outvalue = g_AppParamObj->get<jsonxx::Boolean>(configkey);
						return true;
					}
				}
				else
				{
					outvalue = g_AppParamObj->get<jsonxx::Boolean>(configkey);
					return true;
				}
			}
		}
	
		return false;
	}
	
	
	void ClientManager::showUpdateFrame(const char *content, int type, int versioncode, int forceUpdate)
	{
		if(content == NULL) content = " ";
	
		if(type == 1 || type == 2)
		{
			m_noticeContent = content;
			m_noticeType = type;
			m_noticeCode = versioncode;
			int noticeCode = getNoticeCode();
			if(type == 1 || versioncode > noticeCode)
			{
				GameEventQue::getSingleton().postGameNotice(type, versioncode, forceUpdate);
			}
		}
		else if(type == 3)
		{
			LOG_INFO("parse json: '%s'", content);
	
			jsonxx::Object *paramobj = new jsonxx::Object;
			if(!paramobj->parse(content))
			{
				LOG_INFO("parse json fail");
				delete paramobj;
			}
			else g_AppParamObj = paramobj;
		}
		else if(type == 4)
		{
			m_noticeBrief = content;
		}
	}
	
	void ClientManager::getIps(const char *domain, const char *ips)
	{
		if(domain && ips)
		{
			ClientDnsResolver::getSingleton().dnsCallback(std::string(domain), std::string(ips));
		}
	}
	
	void ClientManager::GetFacebookInfo(const char * userId, const char * Token)
	{
		LOG_INFO("ClientManager::GetFacebookInfo:%s, %s", userId, Token);
		if (m_ScriptVM)
			m_ScriptVM->callFunction("GetFaceBookInfo", "ss", userId, Token);
	}
	
	void ClientManager::sdkRealNameCallback(int age)
	{
		LOG_INFO("ClientManager::sdkRealNameCallback:%d", age);
		if (m_ScriptVM)
			m_ScriptVM->callFunction("sdkRealNameCallback", "i", age);
	}
	
	#ifdef _WIN32
	LRESULT CALLBACK ClientWndProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
	#endif
	
	bool ClientManager::initEngine()
	{
		m_hWnd = NULL;
		Ogre::ParticleEmitter::m_VertDecl = NULL;
		Ogre::BeamEmitter::m_VertDecl = NULL;
		Ogre::Billboard::m_VertDecl = NULL;
		Ogre::Footprints::m_VertDecl = NULL;
		SectionMesh::m_VertDecl = NULL;
	
		XMLNode renderernode = m_EngineRoot->m_Config.getRootNode().getChild("RenderSystem");
		if(renderernode.isNull()) return false;
	
	#ifdef _WIN32
		const TCHAR *RENDERWINDOW_CLASSNAME = _T("RenderWindow_ClassName");
		HINSTANCE hinst = (HINSTANCE)m_hInstance;
	
		WNDCLASSEX wndClass;
		wndClass.cbSize = sizeof(WNDCLASSEX);
		//wndClass.style = CS_HREDRAW|CS_VREDRAW|CS_DBLCLKS;
		wndClass.style = CS_HREDRAW|CS_VREDRAW;
		wndClass.lpfnWndProc = ClientWndProc;
		wndClass.cbClsExtra = 0;
		wndClass.cbWndExtra = 0;
		wndClass.hInstance = hinst;
		wndClass.hIcon = (HICON)LoadImage(NULL, __TEXT("miniworld.ico"), IMAGE_ICON, 128, 128, LR_LOADFROMFILE); 
		wndClass.hCursor = LoadCursor(NULL, IDC_ARROW);
		wndClass.hbrBackground = NULL;
		wndClass.lpszClassName = RENDERWINDOW_CLASSNAME;
		wndClass.lpszMenuName = 0;
		wndClass.hIconSm = NULL;//LoadIcon(hinst, MAKEINTRESOURCE(IDI_IWORLD));
		RegisterClassEx(&wndClass);
	
		DWORD winstyle, exstyle;
		XMLNode mainwinnode = renderernode.getChild("MainWindow");
		if( mainwinnode.attribToBool("fullscreen") )
		{
			winstyle = WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN | WS_VISIBLE;
			exstyle = WS_EX_TOPMOST;
			m_isFullScreen = true;
		}
		else
		{
			winstyle = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_VISIBLE;
			exstyle = 0;
			m_isFullScreen = false;
		}
	
		// Set the window's initial width
		RECT rc;
		if(mainwinnode.attribToBool("fullscreen"))
		{
			SetRect(&rc, 0, 0, GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN));
			m_windowedWidth = 1280;
			m_windowedHeight = 720;
		}
		else
		{
			SetRect(&rc, 0, 0, mainwinnode.attribToInt("width"), mainwinnode.attribToInt("height"));
			AdjustWindowRect( &rc, winstyle, FALSE);
			int diff_w = (rc.right - rc.left) - mainwinnode.attribToInt("width") - 6;
			int diff_h = (rc.bottom - rc.top) - mainwinnode.attribToInt("height") - 41;
			SetRect(&rc, 0, 0, mainwinnode.attribToInt("width") - diff_w, mainwinnode.attribToInt("height") - diff_h);
			m_windowedWidth = mainwinnode.attribToInt("width") - diff_w;
			m_windowedHeight  = mainwinnode.attribToInt("height") - diff_h;
		}
		AdjustWindowRect( &rc, winstyle, FALSE);
	
		m_windowModeStyle = GetWindowLong((HWND)m_hWnd, GWL_STYLE);//获得窗口风格   
		parseCmdAndCreateWindow(hinst, rc, winstyle, exstyle, RENDERWINDOW_CLASSNAME);
	#endif
	
		if(!m_EngineRoot->initRenderSystem(m_hWnd))
		{
			return false;
		}
	#ifndef _WIN32
		RenderSystem::getSingleton().showCursor(true);
	#endif
	
		m_InputMgr = new InputManager(m_hWnd, isMobile());
	
		return true;
	}
	
	void ClientManager::releaseEngine()
	{
		delete m_InputMgr;
		m_InputMgr = NULL;
	
		delete m_SceneRenderer;
		m_SceneRenderer = NULL;
	
		delete m_UIRenderer;
		m_UIRenderer = NULL;
	
		delete m_MinimapRenderer;
		m_MinimapRenderer = NULL;
	
		delete m_DebugRenderer;
		m_DebugRenderer = NULL;
	}
	
	void ClientManager::setFullscreen(bool b)
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		DWORD winstyle, exstyle;
		m_isFullScreen = b;
		RECT rc;
		HWND hWnd = HWND(RenderSystem::getSingleton().getMainWindow()->getHWnd());
	
		if (m_isFullScreen)
		{
			winstyle = WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN | WS_VISIBLE;
			exstyle = WS_EX_TOPMOST;
			m_windowedWidth = Root::getSingleton().getClientWidth();
			m_windowedHeight = Root::getSingleton().getClientHeight();
			int screenW = GetSystemMetrics(SM_CXSCREEN);
			int screenH = GetSystemMetrics(SM_CYSCREEN);
			SetRect(&rc, 0, 0, screenW, screenH);
			AdjustWindowRect(&rc, winstyle, FALSE);
	
			LONG style = GetWindowLong(hWnd, GWL_STYLE);//获得窗口风格    
			m_windowModeStyle = style;
			style = style & (~WS_CAPTION) & ~(WS_BORDER) & ~WS_THICKFRAME; //窗口全屏显示且不可改变大小  
			SetWindowLong(hWnd,GWL_STYLE,style); //设置窗口风格   
	
			MoveWindow(hWnd, 0, 0, screenW, screenH, TRUE);
		}
		else
		{
			winstyle = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_VISIBLE;
			exstyle = 0;
			//游戏窗口有边框
			SetRect(&rc, 0, 0, m_windowedWidth + 16, m_windowedHeight+39);
			AdjustWindowRect(&rc, winstyle, FALSE);
			int screenW = GetSystemMetrics(SM_CXSCREEN);
			int screenH = GetSystemMetrics(SM_CYSCREEN);
			SetWindowLong(hWnd, GWL_STYLE, m_windowModeStyle); //设置窗口风格   
			////////LONG style = GetWindowLong(hWnd, GWL_STYLE);//获得窗口风格    
			//style =  WS_CAPTION | WS_BORDER;
	
			//style = style & WS_CAPTION | WS_BORDER | WS_THICKFRAME;  
			//SetWindowLong(hWnd, GWL_STYLE, style); //设置窗口风格 
	
			MoveWindow(hWnd, 0.5f *(screenW - m_windowedWidth + 16), 0.5f *(screenH - m_windowedHeight + 39), m_windowedWidth + 16, m_windowedHeight + 39, TRUE);
		}
	#endif
	}
	
	static void ReadServerXML(std::string &url, int &port, XMLNode root, const char *name)
	{
		XMLNode node = root.getChild(name);
		if(!node.isNull())
		{
			url = node.attribToString("url");
			port = node.attribToInt("port");
		}
	}
	
	const char *getstr(int id)
	{
		return g_DefMgr.getStringDef(id);
	}
	
	static void CheckMainDataFiles()
	{
		//抽取maindata文件,先放一个版本maindata到安装包里,减少后续版本cdn的下载
	#ifndef _WIN32
		do
		{
			if(FileManager::getSingleton().isStdioDirExist("maindata") && !FileManager::getSingleton().isStdioFileExist("maindata.zip"))
			{
				break;
			}
	
			std::string stdiopath;
			std::string stdiodir;
			if(!FileManager::getSingleton().isFileExistLocal("maindata.zip"))
			{
				break;
			}
	
			if (!FileManager::getSingleton().copyFileFromPkgToStdio("maindata.zip", "maindata.zip"))
			{
				OnStatisticsGameEvent("uncompress_maindata", "failed1");
				break;
			}
	
			FileManager::getSingleton().gamePath2StdioPath(stdiopath, "maindata.zip");
			FileManager::getSingleton().gamePath2StdioPath(stdiodir, "");
	
			bool has_error = (CompressTool::uncompressZip(stdiopath.c_str(), stdiodir.c_str()) != 0);
			if(has_error)
			{
				OnStatisticsGameEvent("uncompress_maindata", "failed2");
				break;
			}
			FileManager::getSingleton().deleteStdioFile("maindata.zip");
			OnStatisticsGameEvent("uncompress_maindata", "ok");
		}
		while(0);
	#endif
	}
	
	void ClientManager::initGameDataStep(LoadStepCounter &loadcounter)
	{
	#ifdef _WIN32
		if ( getGameData( "debug_ui") == 1 ) {
			//不加载任何界面XML和LUA，按F12去后发加载，按F11显示，测试单个UI使用
			m_ScriptVM->callString( "g_debug_ui=true;" );
			loadcounter.setProgressFull();
			return;
		}
	#endif
	
		unsigned int t1 = Timer::getSystemTick();
		if (loadcounter.getStage() == 0 )
		{
			int stagecounter = loadcounter.step();
			//1-4空几帧，防止app anr
			if(stagecounter == 4) m_ModEditorManager->load();
			else if(stagecounter == 5) m_ModFileManager->checkInitialMod("data/mods");
			else if(stagecounter == 6) m_ModFileManager->refreshAllModsPath("data/mods");
			else if(stagecounter == 7) m_ModManager->init();
			else if(stagecounter == 8) CheckMainDataFiles();
			else if(stagecounter == 10)
			{
				//加载toc的文件列表
				const char *uitoc = "ui/mobile/game_main.toc";
				int nfiles = m_GameUI->readTOCList(uitoc);
				if(nfiles < 0) nfiles = 0;
				loadcounter.gotoStage(1, nfiles, 80);
			}
		}
		else if(loadcounter.getStage() == 1) //分步加载单个toc中配置的xml和lua文件
		{
			int fileindex = loadcounter.step() - 1;
			if(fileindex >= 0) m_GameUI->parseSingleTOCFile(fileindex);
	
			if(loadcounter.stageCompleted()) loadcounter.gotoStage(2, m_BlockMtlMgr->getInitStepCount(), 10);
		}
		else if(loadcounter.getStage() == 2)
		{
			m_BlockMtlMgr->initStep(loadcounter.step());
		}
	}
	
	
	//快速打开游戏，先只初始化登录界面
	bool ClientManager::initGameData()
	{
		unsigned int t1 = Timer::getSystemTick();
	
		m_MapMarkMgr = new MapMarkingMgr;
		m_DebugDataMgr = new DebugDataMgr(m_UIRenderer);
		m_DebugDataMgr->setDebugRenderer(m_DebugRenderer);
		m_BuddyMgr = new ClientBuddyMgr;
		m_UIActorBodyMgr = new UIActorBodyMgr;
		m_HomeChest = new HomeChest;
	
		m_DefMgr = new DefManager;
		m_ModFileManager = new ModFileManager;
		m_ModEditorManager = new ModEditorManager;
		m_ModManager = new ModManager;
		m_DefMgr->resetLanguage( getGameData("lang") );
	
		#ifdef IWORLD_SERVER_BUILD
			m_BlockMtlMgr = new BlockMaterialMgr(true);
			m_BlockMtlMgr->initStep(2);
			m_BlockMtlMgr->initStep(4);
		#else
			m_BlockMtlMgr = new BlockMaterialMgr(false);
		#endif
		m_ItemIconMgr = new ItemIconMgr;
	
		unsigned int t2 = Timer::getSystemTick();
		LOG_INFO("New BlockMaterialMgr: %d, mem=%d", t2-t1, GetProcessUsedMemory());
	
		g_DefMgr.load();
		unsigned int t3 = Timer::getSystemTick();
		LOG_INFO("DefMgr load: %d, mem=%d", t3-t2, GetProcessUsedMemory());
	
		//m_BlockMtlMgr->init();
		//unsigned int t4 = Timer::getSystemTick();
		//LOG_INFO("BlockMtlMgr init OK: %d, mem=%d", t4-t3, GetProcessUsedMemory());
	
		m_AchievementMgr = new AchievementManager;
		g_AchievementMgr = m_AchievementMgr;
	
		m_GameSettings = new GameSettings;
		g_GameSettings = m_GameSettings;
	
		m_AccountInfo = new ClientAccountMgr;
		#ifdef IWORLD_SERVER_BUILD
			m_AccountInfo->setSeverProxyOwindex(atoi(kvhash["owindex"].c_str()));
		#endif
	
		#ifndef IWORLD_TARGET_PC
			m_httpDownloadMgr = new HttpDownloadMgr;
			g_httpDownloadMgr = m_httpDownloadMgr;
		#else
			 #ifdef IWORLD_SERVER_BUILD
				m_httpDownloadMgr = new HttpDownloadMgr;
				g_httpDownloadMgr = m_httpDownloadMgr;
			#endif 
		#endif 
	
		m_httpFileUpDownMgr = new HttpFileUpDownMgr;
		g_httpFileUpDownMgr = m_httpFileUpDownMgr;
	
		m_PermitsMgr = new PermitsManager;
		#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
		m_GVoiceMgr = new GVoiceManager;
		#endif
	
		m_ScriptVM = new ScriptVM;
	#if OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC
		tolua_ServerToLua_open(m_ScriptVM->getLuaState());
	#else
	#ifdef IWORLD_TARGET_PC
		tolua_ClientToLua_open(m_ScriptVM->getLuaState());
	#else
		tolua_ClientToLuaM_open(m_ScriptVM->getLuaState());
	#endif
	#endif
		m_ScriptVM->setUserTypePointer("DefMgr", "DefManager", m_DefMgr);
		m_ScriptVM->setUserTypePointer("ClientMgr", "ClientManager", this);
		m_ScriptVM->setUserTypePointer("CSMgr", "ClientCSMgr", m_CSMgr);
		m_ScriptVM->setUserTypePointer("CSOWorld", "ClientCSOWorld", m_CSMgr->m_CSOWorld);
		m_ScriptVM->setUserTypePointer("MapMarkMgr", "MapMarkingMgr", m_MapMarkMgr);
	
		m_EventQue = new GameEventQue;
	   
		m_ScriptVM->setUserTypePointer("GameEventQue", "GameEventQue",	m_EventQue);
		m_PlatformSdkMgr = PlatformSdkManager::create();
		m_SnapshotMgr = new SnapshotMgr(256, 144);
		m_SnapshotForShare = new SnapshotForShare();
		m_CutScenesMgr = new CutScenesMgr();
		//m_SnapshotMgr = new SnapshotMgr(128, 72);
		//#ifdef IWORLD_TARGET_PC
		//m_pQQRailMgr = new QQRailMgr();
		//#endif
	
	    // add by null start {{{
	    m_LuaInterface = new LuaInterface(m_ScriptVM, this);
		m_ScriptVM->setUserTypePointer("LuaInterface", "LuaInterface", m_LuaInterface);
	    // add by null end }}}
	
	
		m_ScriptVM->setUserTypePointer("SdkManager", "PlatformSdkManager",	m_PlatformSdkMgr);
		m_ScriptVM->setUserTypePointer("Snapshot", "SnapshotMgr", m_SnapshotMgr);
		m_ScriptVM->setUserTypePointer("SnapshotForShare", "SnapshotForShare", m_SnapshotForShare);
		m_ScriptVM->setUserTypePointer("BuddyManager", "ClientBuddyMgr", m_BuddyMgr);
		m_ScriptVM->setUserTypePointer("UIActorBodyManager", "UIActorBodyMgr", m_UIActorBodyMgr);
		m_ScriptVM->setUserTypePointer("AccountManager", "ClientAccountMgr", m_AccountInfo);
		m_ScriptVM->setUserTypePointer("AchievementMgr", "AchievementManager", m_AchievementMgr);
		m_ScriptVM->setUserTypePointer("HomeChestMgr", "HomeChest", m_HomeChest);
		m_ScriptVM->setUserTypePointer("HttpDownloader", "HttpDownloadMgr", g_httpDownloadMgr);
		m_ScriptVM->setUserTypePointer("HttpFileUpDownMgr", "HttpFileUpDownMgr", g_httpFileUpDownMgr);
		m_ScriptVM->setUserTypePointer("DebugMgr", "DebugDataMgr", m_DebugDataMgr);
		m_ScriptVM->setUserTypePointer("CutSceneMgr", "CutScenesMgr", m_CutScenesMgr);
		m_ScriptVM->setUserTypePointer("PermitsMgr", "PermitsManager", m_PermitsMgr);
		m_ScriptVM->setUserTypePointer("ModMgr", "ModManager", m_ModManager);
		m_ScriptVM->setUserTypePointer("ModEditorMgr", "ModEditorManager", m_ModEditorManager);
		#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
		m_ScriptVM->setUserTypePointer("GVoiceMgr", "GVoiceManager", m_GVoiceMgr);
		#endif
		#ifdef IWORLD_SERVER_BUILD
			 loadScriptTOC("luascript/scriptserver.toc");
		#else
			 loadScriptTOC("luascript/script.toc");
		#endif
		ClientMob::initBreedItem();
	
	    //lua container init  -- add by null start {{{
		struct timeval stNow;
	    gettimeofday(&stNow, NULL);
	    //TODO 可以从serverdata.list里面获取介入服务器的http url传给 __init__函数
		#ifndef IWORLD_SERVER_BUILD
	    m_ScriptVM->callFunction("__init__", "ii", stNow.tv_sec, stNow.tv_usec/1000);
		#endif
	    //lua container init  -- add by null end }}}
	
		unsigned int t5 = Timer::getSystemTick();
		LOG_INFO("ScriptVM init OK: %d, mem=%d", t5-t3, GetProcessUsedMemory());
	
		#ifndef IWORLD_SERVER_BUILD
			m_GameUI = new GameUI;
			/*const char *uitoc = isMobile()? "ui/mobile/game_start.toc" : "ui/game_pc_start.toc";
			if (m_nApiId == 199)
			uitoc = "ui/game_pc_start199.toc";*/
			const char *uitoc = "ui/mobile/game_start.toc";
			m_GameUI->SetGameStringFunc(&getstr);
			int screenw = Root::getSingleton().getClientWidth();
			int screenh = Root::getSingleton().getClientHeight();
			m_GameUI->Create(uitoc, 1280, 720, screenw, screenh, m_UIRenderer, m_ScriptVM, isMobile()?UI_PLATFORM_MOBILE:UI_PLATFORM_PC, UI_LANG_VER(getGameData("lang")));
			m_GameUI->SetCurrentCursor("normal");
	
			unsigned int t6 = Timer::getSystemTick();
			LOG_INFO("GameUI init OK: time=[%d], mem=%d", t6-t5, GetProcessUsedMemory());
		#endif
	
		Root::getSingleton().setSoundSystem();
		initStatistics();
	
		return true;
	}
	
	void ClientManager::startRunning()
	{
	#ifndef IWORLD_SERVER_BUILD
		RenderSystem::getSingleton().showCursor(true);
	#endif
	
	#ifdef IWORLD_SERVER_BUILD
		g_AccountMgr->requestEnterGame2New();
		if(kvhash.find("account") != kvhash.end() && kvhash.find("toloadmapid") != kvhash.end())
		{
			g_AccountMgr->enterGame();
		}
	#else
	#ifdef IWORLD_TARGET_LIB
	#else
		gotoGame("MainMenuStage");
		if(m_InputMgr && m_LoadingGame) m_InputMgr->RegisterInputHandler(m_LoadingGame);
	#endif //IWORLD_TARGET_LIB
	#endif //IWORLD_SERVER_BUILD
	
		m_CurTick = Timer::getSystemTick();
		m_LogicalClock = new Clock(m_CurTick);
		m_GameTickAccum = 0;
		m_AppState = APPSTATE_RUNNING;
		m_ResetRender = false;
	}
	
	#ifdef IWORLD_SERVER_BUILD
	void ClientManager::setHashParam(const char *key, const char *value)
	{
		kvhash[key] = value;
		if(strcmp(key, "account"))
		{
			std::string path = "mini";
			path  += m_sAccount;
			path += "/";
			setDataDir(path.c_str());
		}
	    else if(strcmp(key, "owindex"))
		{
			m_AccountInfo->setSeverProxyOwindex(atoi(kvhash["owindex"].c_str()));
		}
	}
	
	bool ClientManager::startServerRoom()
	{
		if(!StandaloneServer::m_bInitingEnterRoom)
		{
			if(g_CSMgr2)
			g_CSMgr2->loadUinData();
			g_AccountMgr->enterGame();
			return true;
		}
		return false;
	}
	
	bool ClientManager::stopServerRoom()
	{
		if(!StandaloneServer::m_bInitingEnterRoom)
		{
			gotoGame("none");
			return true;
		}
		else
		{
			return false;
		}
	}
	
	long long ClientManager::getCurrentGameMapId()
	{
		if(g_WorldMgr)
		{
			WorldDesc *desc = g_AccountMgr->getCurWorldDesc();
			if(desc == NULL)
			{
			  return 0;
			}
			else
			{
			  return desc->fromowid;	
			}
			
		}
		else
		{
			return 0;
		}
	}
	
	
	bool ClientManager::isStartingRoom()
	{
		return StandaloneServer::m_bInitingEnterRoom;
	}
	
	void ClientManager::setStartingRoom(bool set)
	{
		StandaloneServer::m_bInitingEnterRoom = set;
	}
	
	void ClientManager::setDataDir(const char *datadir)
	{
		m_datadir = (datadir ? String(datadir) : "");
		FileManager::getSingleton().removePackage("save");
		FileManager::getSingleton().addPackage(FILEPKG_DIR, "save", datadir, 0, false);
	}
	#else
	long long ClientManager::getCurrentGameMapId()
	{
		return 0;
	}
	
	void ClientManager::setHashParam(const char *key, const char *value)
	{
	}
	
	bool ClientManager::startServerRoom()
	{
		return true;
	}
	
	bool ClientManager::stopServerRoom()
	{
		return true;
	}
	
	bool ClientManager::isStartingRoom()
	{
		return true;
	}
	
	void ClientManager::setStartingRoom(bool set)
	{
	}
	
	void ClientManager::setDataDir(const char *datadir)
	{
	}
	#endif
	
	int ClientManager::IsModExisted(char* uuid)
	{
		for(auto iter = g_DefMgr.m_ModsToLoadDefTable.begin(); iter!=g_DefMgr.m_ModsToLoadDefTable.end(); iter++)
		{
			char* pPathName = (*iter).strPathName;
			if(NULL != strstr(pPathName, uuid))
			{
				if(m_ModFileManager->checkModExist(pPathName))
				{
					//存在, 这样只是为了省一个函数接口(检查存在, 同时获取文件大小)
					return -1;
				}
				else
				{
					//不存在, 返回插件包大小.
					int nSize = m_ModFileManager->toloadModSize(pPathName);
					return nSize;
				}
			}
		}
	
		return -1;
	}
	
	void ClientManager::DownLoadModFile(char* uuid)
	{
		for(auto iter = g_DefMgr.m_ModsToLoadDefTable.begin(); iter!=g_DefMgr.m_ModsToLoadDefTable.end(); iter++)
		{
			char* pPathName = (*iter).strPathName;
			if(NULL != strstr(pPathName, uuid))
			{
				int nLoadedSize = m_ModFileManager->loadedModSize(pPathName);
				int nToLoadSize = m_ModFileManager->toloadModSize(pPathName);
				if(nLoadedSize == nToLoadSize)
				{
					//已存在
					m_ModFileManager->checkInitialMod("data/mods");
				}
				else
				{
					//不存在, 需要下载
					m_ModFileManager->toloadMod(pPathName);
				}
			}
		}
	}
	
	int ClientManager::IsLoadCompleted(char* uuid)
	{
		for(auto iter = g_DefMgr.m_ModsToLoadDefTable.begin(); iter!=g_DefMgr.m_ModsToLoadDefTable.end(); iter++)
		{
			char* pPathName = (*iter).strPathName;
			if(NULL != strstr(pPathName, uuid))
			{
				int nLoadedSize = m_ModFileManager->loadedModSize(pPathName);
				int nToLoadSize = m_ModFileManager->toloadModSize(pPathName);
				if(nLoadedSize == nToLoadSize)
				{
					m_ModFileManager->checkInitialMod("/data/mods");
					return -1;
				}
				else
				{
					return nToLoadSize;
				}
			}
		}
	
		return -1;
	}
	
	int ClientManager::IsFileExistedForDownload(char* path)
	{
		if(FileManager::getSingleton().isFileExistLocal(path))
		{
			//存在, 返回0
			return 0;
		}
		else
		{
			//不存在, 返回需要下载的文件大小.
			int nFileSize = FileManagerWeb::getSingleton().getFileSize(path);
			return nFileSize;
		}
	}
	
	void ClientManager::DownLoadModFileByPath(char* path)
	{
		String search = FileManagerWeb::getSingleton().GeneralRealName(path);
		Ogre::DownloadManager::getSingleton().RequestAsyLoad(search.c_str(), 0);
	}
	
	bool ClientManager::IsLoadCompletedByPath(char* path)
	{
		String search = FileManagerWeb::getSingleton().GeneralRealName(path);
		int nHaveLoaded =  Ogre::DownloadManager::getSingleton().FileLoadedSize(search);	//已下载的大小
		int nToLoadSize = FileManagerWeb::getSingleton().getFileSize(path);					//需要下载的大小
	
		if(nHaveLoaded >= nToLoadSize)
			return true;
		else
			return false;
	}
	
	int ClientManager::GetAllModFileSumSize()
	{
		int nSize = g_DefMgr.getFileToLoadNum();
		int nSum = 0;
	
		for(int i = 0; i < nSize; i++)
		{
			FileToLoad* def = g_DefMgr.getFileToLoadDef(i);
	
			if(def && def->uiLoad == 1)
			{
				int nFileSize = IsFileExistedForDownload(def->strPathName);
				nSum += nFileSize;
			}
		}
	
		return nSum;
	}
	
	void ClientManager::BeginDownloadAllFile()
	{
		int nSize = g_DefMgr.getFileToLoadNum();
	
		for(int i = 0; i < nSize; i++)
		{
			FileToLoad* def = g_DefMgr.getFileToLoadDef(i);
	
			if(def && def->uiLoad == 1)
			{
				//文件不存在, 则挨个下载
				if(!FileManager::getSingleton().isFileExistLocal(def->strPathName))
				{
					DownLoadModFileByPath(def->strPathName);
				}
			}
		}
	}
	
	bool ClientManager::IsAllFileDownloadComplete()
	{
		int nSize = g_DefMgr.getFileToLoadNum();
	
		for(int i = 0; i < nSize; i++)
		{
			FileToLoad* def = g_DefMgr.getFileToLoadDef(i);
	
			if(def && def->uiLoad == 1)
			{
				char* path = def->strPathName;
	
				//文件不存在
				if(!FileManager::getSingleton().isFileExistLocal(path))
				{
					//检查是否下载完, 只要有一个没下载完就不算
					if(!IsLoadCompletedByPath(path))
					{
						return false;
					}
				}
			}
		}
	
		return true;
	}
	
	void ClientManager::releaseGameData()
	{
		#ifndef IWORLD_SERVER_BUILD
		{
			std::map<std::string, ClientGame *>::iterator iter = m_Games.begin();
			for(; iter!=m_Games.end(); iter++)
			{
				delete iter->second;
			}
		}
		#else
			 if(m_CurGame)
			 {
			  delete m_CurGame;
			  m_CurGame = NULL;
			 }
	
		     if(m_LoadingGame)
		     {
			   delete m_LoadingGame;
			   m_LoadingGame = NULL;
			 }
		#endif
	
		EffectManager::releaseAllSoundDesc();
	
		delete m_PermitsMgr;
	
		//m_httpDownloadMgr->shutdown();
		//delete m_httpDownloadMgr;
	
		delete m_AccountInfo;
	
		delete m_EventQue;
		delete m_GameUI;
		delete m_ScriptVM;
	
		delete m_BlockMtlMgr;
		delete m_ItemIconMgr;
		delete m_ModManager;
		delete m_ModEditorManager;
		delete m_ModFileManager;
		delete m_DefMgr;
		delete m_DebugDataMgr;
		delete m_MapMarkMgr;
		delete m_AchievementMgr;
		delete m_PlatformSdkMgr;
		delete m_SnapshotForShare;
		delete m_SnapshotMgr;
		delete m_UIActorBodyMgr;
		delete m_BuddyMgr;
		delete m_HomeChest; 
		delete m_CameraMgr;
		#if OGRE_PLATFORM != OGRE_PLATFORM_LINUXPC
		delete m_GVoiceMgr;
		#endif
	}
	
	void UIRenderCallback()
	{
		ClientGame *pcurgame = g_ClientMgr.m_CurGame;
	
		if(pcurgame) g_ClientMgr.m_CurGame->renderUI(g_ClientMgr.m_HideUI);
	
		g_ClientMgr.m_GameUI->Render();
	
		if(!g_ClientMgr.m_HideUI) g_ClientMgr.m_DebugDataMgr->renderUI();
	
		if(pcurgame) pcurgame->renderUIEffect();
	}
	
	bool ClientManager::setupRenderer()
	{
		RenderWindow *rwin = RenderSystem::getSingleton().getMainWindow();
	
		m_SceneRenderer = new NormalSceneRenderer;
		m_SceneRenderer->setRenderTarget(rwin);
		SceneManager::getSingleton().addSceneRenderer(0, m_SceneRenderer);
	
		m_UIRenderer = new Ogre::UIRenderer;
		m_UIRenderer->setRenderTarget(rwin);
		m_UIRenderer->loadResTable();
		m_UIRenderer->setPreRenderCallback(UIRenderCallback);
		SceneManager::getSingleton().addSceneRenderer(2, m_UIRenderer);
	
		//英文版本扁化字体 英文=0.79
		int lang_ = getGameData("lang");
		if ( lang_ == LANGUAGE_EN || lang_ > 2 )
		{
			int w_ = getGameData("langW");
			int h_ = getGameData("langH");
			if (w_ < 1) w_ = 79;
			if (h_ < 1) h_ = 79;
	
			if (lang_ == 3) {
				//泰文90
				w_ = 90;
				h_ = 90;
			}
			else if (lang_ == 7) {
				//日文75
				w_ = 75;
				h_ = 75;
			}
			else if (lang_ == 11) {
				//俄语75
				w_ = 75;
				h_ = 75;
			}
	
			m_UIRenderer->setLangWHScale( w_ / 100.0, h_ / 100.0 );
	
			if(lang_ == 7 || lang_ == 3)
				RFontBase::m_WordBoundWrap = false;
			else
				RFontBase::m_WordBoundWrap = true;
	
	
			RFontBase::m_DrawRight2Left = (lang_==8); //阿拉伯语需要从右往左画文字
		}
	
		m_MinimapRenderer = new MinimapRenderer(m_UIRenderer);
		m_MinimapRenderer->enableRender(false);
		m_MinimapRenderer->setRenderTarget(rwin);
		SceneManager::getSingleton().addSceneRenderer(1, m_MinimapRenderer);
	
	
		m_DebugRenderer = new DebugRenderer;
		m_DebugRenderer->enableRender(false);
		m_DebugRenderer->setRenderTarget(rwin);
		SceneManager::getSingleton().addSceneRenderer(3, m_DebugRenderer);
	
		return true;
	}
	
	void ClientManager::onHandleGameEvent(GameEvent *ge)
	{
		if(m_GameUI) m_GameUI->SendEvent(m_EventQue->getEventName(ge));
		if(m_CurGame) m_CurGame->onGameEvent(ge);
		if(m_LoadingGame) m_LoadingGame->onGameEvent(ge);
		if(m_CSMgr) m_CSMgr->onGameEvent(ge);
	#ifdef IWORLD_SERVER_BUILD
		StandaloneServer::OnServerGameEvent(ge);	
	#endif
	}
	
	void ClientManager::handleEvents()
	{
		GameEvent *ge;
		while((ge=m_EventQue->popEvent())!=NULL)
		{
	        LUA_EVENT("s", m_EventQue->getEventName(ge));
			
			onHandleGameEvent(ge);
	
			m_EventQue->freeEvent(ge);
		}
	}
	
	bool ClientManager::loadScriptTOC(const char *tocfile)
	{
		Ogre::DataStream *fp = FileManager::getSingleton().openFile(tocfile, true);
		if(fp == NULL)
		{
			return false;
		}
	
		char buffer[1024];
		while(!fp->eof())
		{
			fp->readLine(buffer, sizeof(buffer));
			std::string inbuf = buffer;
	
			size_t pos = inbuf.find(".lua");
			if ((pos!=inbuf.npos) && ((inbuf.find("##"))>0))
			{
				bool b;
				if(strchr(inbuf.c_str()+pos+4, 'p'))
				{
					std::string path = inbuf.substr(0, pos+4);
					b = m_ScriptVM->loadPackage(path.c_str());
				}
				else b = m_ScriptVM->callFile(inbuf.c_str());
	
				if(!b)
				{
					LOG_SEVERE("load lua file failed: %s", inbuf.c_str());
					return false;
				}
			}
		}
	
		delete fp;
		return true;
	}
	
	void DebugString(const char *str)
	{
	#ifdef _WIN32
		::OutputDebugStringA(str);
		::OutputDebugStringA("\n");
	#endif
	}
	
	
	void ClientManager::reloadUI(){
	
		delete m_GameUI;
		m_GameUI = NULL;
	
		unsigned int t5 = Timer::getSystemTick();
	
		m_GameUI = new GameUI;
	
		const char *uitoc = isMobile()? "ui/mobile/game_main.toc" : "ui/mobile/game_main.toc";
		m_GameUI->SetGameStringFunc(&getstr);
		m_GameUI->Create(uitoc, 1280, 720, Root::getSingleton().getClientWidth(), Root::getSingleton().getClientHeight(), m_UIRenderer, m_ScriptVM, isMobile()?UI_PLATFORM_MOBILE:UI_PLATFORM_PC, UI_LANG_VER(getGameData("lang")));
		m_GameUI->SetCurrentCursor("normal");
	
	
		unsigned int t6 = Timer::getSystemTick();
		LOG_INFO("GameUI reload OK: %d, mem=%d", t6-t5, GetProcessUsedMemory());
	}
	
	bool ClientManager::disableVoice()
	{
		return g_DisableVoice;
	}
	
	bool ClientManager::getIsIpv6Env()
	{
	    return m_isIpv6Env;
	}
	
	bool ClientManager::CheckAppExist(const char *pkgname)
	{
		return IsAppExist(pkgname);
	}
	
	void ClientManager::loadGameCfgXml(const char *configText)
	{
		if (NULL == configText)
		{
			return;
		}
	
		XMLData config;
		if (config.loadBuffer( configText, strlen( configText ) ) )
		{
			loadGameCfgXml(config);
		}
	}
	
	void ClientManager::loadGameCfgXml(Ogre::XMLData &config)
	{
		XMLNode nodeNotice = config.getRootNode().getChild("noticeCode");
	
		//先按语言选择一次公告内容
		int lang_ = g_ClientMgr.getGameData("lang");
		int evn_  = g_ClientMgr.getGameData("game_env");
	
		char noticeContent_[32] = { 0 };
		char noticeBrief_[32] = { 0 };
		if (lang_ == 0)
		{	//中文
			sprintf(noticeContent_, "noticeContent");
			sprintf(noticeBrief_,   "noticeBrief");
		}
		else 
		{	//其他语言
			sprintf(noticeContent_, "noticeContent_%d", lang_);
			sprintf(noticeBrief_,   "noticeBrief_%d", lang_);
		}
	
		XMLNode nodeCotent = config.getRootNode().getChild(noticeContent_);
		if (!nodeNotice.isNull() && !nodeCotent.isNull())
		{
			int noticeCode = atoi(nodeNotice.getText());
			if(noticeCode >=1 )
			{
				const char *content = nodeCotent.getText();
				showUpdateFrame(content, 2, noticeCode, 0);
			}
		}
		else {
			if (lang_ > 0) {
	
				XMLNode nodeCotent;
				if (evn_ >= 10) {
					nodeCotent = config.getRootNode().getChild("noticeContent_x");  		//海外默认使用_x
				}
				else {
					nodeCotent = config.getRootNode().getChild("noticeContent_1"); 			//非中文的情况下，默认使用英语
				}
	
				if (!nodeNotice.isNull() && !nodeCotent.isNull())
				{
					int noticeCode = atoi(nodeNotice.getText());
					if (noticeCode >= 1)
					{
						const char *content = nodeCotent.getText();
						showUpdateFrame(content, 2, noticeCode, 0);
					}
				}
				else {
					//还找不到，使用中文
					XMLNode nodeCotent = config.getRootNode().getChild("noticeContent");
					int noticeCode = atoi(nodeNotice.getText());
					if (noticeCode >= 1)
					{
						const char *content = nodeCotent.getText();
						showUpdateFrame(content, 2, noticeCode, 0);
					}
				}
			}
		}
	
	
		XMLNode nodeParams = config.getRootNode().getChild("Params");
		if(!nodeParams.isNull())
		{
			const char *content = nodeParams.getText();
			showUpdateFrame(content, 3, 0, 0);
		}
	
		XMLNode briefSwitch = config.getRootNode().getChild("briefSwitch");
		if(!briefSwitch.isNull() && atoi(briefSwitch.getText()) == 1)
		{
			XMLNode noticeBrief = config.getRootNode().getChild(noticeBrief_);
			if(!noticeBrief.isNull())
			{
				const char *content = noticeBrief.getText();
				showUpdateFrame(content, 4, 0, 0);
			}
			else {
				if (lang_ > 1) {
					XMLNode noticeBrief;
					if (evn_ >= 10) {
						noticeBrief = config.getRootNode().getChild("noticeBrief_x");	//海外非中文的情况下，默认使用_x
					}	else {
						noticeBrief = config.getRootNode().getChild("noticeBrief_1");  	//非中文的情况下，默认使用英语
					}
	
					if (!noticeBrief.isNull())
					{
						const char *content = noticeBrief.getText();
						showUpdateFrame(content, 4, 0, 0);
					}
					else {
						//还找不到，使用中文
						XMLNode noticeBrief = config.getRootNode().getChild("noticeBrief");
						if (!noticeBrief.isNull())
						{
							const char *content = noticeBrief.getText();
							showUpdateFrame(content, 4, 0, 0);
						}
					}
				}
			}
		}
	}
	
	void ClientManager::playStoreSound2D(const char *path)
	{
		if(m_StoreSounder) m_StoreSounder->release();
		m_StoreSounder = g_ClientMgr.playSound2DControl(path, 1.0, false);
	}
	
	void ClientManager::setMinimapRenderMode(int mode)
	{
		if(m_MinimapRenderer) m_MinimapRenderer->setMode(mode);
	}
	
	void ClientManager::setIsIpv6Env(bool isipv6)
	{
	    LOG_INFO("ClientManager::setIsIpv6Env: isipv6=%s", (isipv6 ? "true" : "false"));
	    m_isIpv6Env = isipv6;
	}
	
	float ClientManager::timeSinceStartup()
	{
		return m_TimeSinceStartup;
	}
	
	float ClientManager::timeAntiaddictionStartup()
	{
		return m_TimeSinceStartup;
	}
	
	void ClientManager::debugBreak()
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		__asm {int 3};
	#endif
	}
	
	
	int ClientManager::clearThumbFile(int type)
	{
		std::string thumbsStdioPath;
		FileManager::getSingleton().gamePath2StdioPath(thumbsStdioPath, "data/http/thumbs");
	
		Ogre::DirVisitorDeleteFileByExt deleteByExt1("png");
		deleteByExt1.scanTree(thumbsStdioPath.c_str());
	
		Ogre::DirVisitorDeleteFileByExt deleteByExt2("png_");
		deleteByExt2.scanTree(thumbsStdioPath.c_str());
	
		Ogre::DirVisitorDeleteFileByExt deleteByExt3("webp");
		deleteByExt3.scanTree(thumbsStdioPath.c_str());
	
		Ogre::DirVisitorDeleteFileByExt deleteByExt4("webp_");
		deleteByExt4.scanTree(thumbsStdioPath.c_str());
	
		FileManager::getSingleton().gamePath2StdioPath(thumbsStdioPath, "data/http/thumbs_room");
		Ogre::DirVisitorDeleteFileByExt deleteByExt5("png");
		deleteByExt5.scanTree(thumbsStdioPath.c_str());
	
		Ogre::DirVisitorDeleteFileByExt deleteByExt6("png_");
		deleteByExt6.scanTree(thumbsStdioPath.c_str());
	
		FileManager::getSingleton().gamePath2StdioPath(thumbsStdioPath, "data/http/mods");
		Ogre::DirVisitorDeleteFileByExt deleteByExt7("zip");
		deleteByExt7.scanTree(thumbsStdioPath.c_str());
	
		return 0;
	}
	
	
	size_t ClientManager::frameCount()
	{
		return m_frameCount;
		//return m_SceneRenderer->m_NumRenderFrame;
	}
	
	float ClientManager::frameDeltaTime()
	{
		return m_frameDeltaTime;
	}
	
	const char* ClientManager::getDataDir()
	{
		return m_datadir.c_str();
	}
	
	int ClientManager::getDataTransferState()
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_ANDROID
		return getDataTransferStateJNI();
	#else
		return 0;
	#endif
	}
	
	void ClientManager::startOnlineShare(const char* imgPath, const char* url, bool isImgPathAbs)
	{
		std::string abspath = imgPath;
		if (!isImgPathAbs)
		{
			Ogre::FileManager::getSingleton().gamePath2StdioPath(abspath, imgPath);
		}
		StartOnlineShare(abspath.c_str(), url);
	}
	
	void ClientManager::setClickEffectEnabled(bool enabled)
	{
		MainMenuStage *mainmenuStage = (MainMenuStage *)getGame("MainMenuStage");
		if (mainmenuStage)
		{
			mainmenuStage->setClickEffectEnabled(enabled);
		}
	}
	
	bool ClientManager::useTpRealNameAuth()
	{
		int apiId = g_ClientMgr.getApiId();	
		if(isPC() && apiId != 999 && apiId != 110 && apiId != 127)
			return true;
		else
			return false;
	}
	
	void ClientManager::setAdult(bool b)
	{
		m_bAdult = b;
	}
	
	void ClientManager::setFcmRate(int rate)
	{
		m_fcmRate = rate;
	}
	
	int ClientManager::getFcmRate()
	{  
		return m_fcmRate;
	}
	
	int ClientManager::getAudit()
	{
		return 1;
	}
	
	bool ClientManager::IsNeedAntiAddictionTip()
	{
		//是否需要防沉迷提醒.
		return true;
	}
	
	
	CONTROL_MODE ClientManager::getContrlMode()
	{
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		return KEYBOARD_CONTROL;
	//#else if  OGRE_PLATFORM == OGRE_PLATFORM_ANDROID || OGRE_PLATFORM == OGRE_PLATFORM_LINUXPC || OGRE_PLATFORM == OGRE_PLATFORM_APPLE
	
	#else
		return TOUCH_CONTROL;
	#endif
	}
	
	bool ClientManager::isPureServer()
	{
	#ifdef IWORLD_SERVER_BUILD
		return true;
	#else
		return false;
	#endif
	}
	
	bool ClientManager::onParseKVHash()
	{
		if(kvhash.find("baseinfo") != kvhash.end())
		{
			int len = 0;
			unsigned char szDecodedBuff[4096+4];
			{
				if (base64_decode((unsigned char*)kvhash["baseinfo"].c_str(), false, szDecodedBuff, &len) )
				{
					std::vector<std::string> vcmd;
					std::vector<std::string> kv;
					StringUtil::split(vcmd, (char*)szDecodedBuff, "&");
					int sizekv = vcmd.size();
					for(int i =0 ; i < sizekv; i++)
					{
						kv.clear();
						StringUtil::split(kv, vcmd[i], "=");
						if(kv.size() == 2)
							kvhash[kv[0]] = kv[1];
					}
				}
			}						    
		}
	
		if(kvhash.find("account") != kvhash.end())
		{
			m_sAccount = kvhash["account"];
			m_sPassword = kvhash["password"];
		}
	
		if(kvhash.find("openstring") != kvhash.end())
		{
			m_sOpenstring = kvhash["openstring"].c_str();
			int len = 0;
			unsigned char szDecodedBuff[4096+4];
			{
				if (base64_decode((unsigned char*)m_sOpenstring.c_str(), false, szDecodedBuff, &len) )
				{
					m_sOpenstring = (char*)szDecodedBuff;
					//继续解析
					std::vector<std::string> vcmd;
					std::vector<std::string> kv;
					StringUtil::split(vcmd, (char*)szDecodedBuff, "&");
					int sizekv = vcmd.size();
					for(int i =0 ; i < sizekv; i++)
					{
						kv.clear();
						StringUtil::split(kv, vcmd[i], "=");
						if(kv.size() == 2)
							kvhash[kv[0]] = kv[1];
					}
				}
			}
		}
	
		if(kvhash.find("apiid") != kvhash.end())
		{
			m_nApiId = atoi(kvhash["apiid"].c_str());
		}
	
		if(kvhash.find("auth_key") != kvhash.end())
		{
			kvhash["isAdult"] = kvhash["auth_key"][0];
		}
	
		//处理qq空间有多个平台
		if(kvhash.find("PID") != kvhash.end())
		{
			int pid =  atoi(kvhash["PID"].c_str());
			m_nApiId = 101 + pid;
			//qq各平台pf的映射
			switch(pid)
			{
			case 1: 
				kvhash["pf"] = "union";
				break;		
			case 8:
				kvhash["pf"] = "qzone";	
				break;	
			case 10:
				kvhash["pf"] = "website";
				break;		
			case 14:
				kvhash["pf"] = "tgp";
				break;		
			}
		}
	
		return true;
	}
	
	bool ClientManager::initHashParam(const char* param)
	{
		//stdext::hash_map<std::string, std::string> kvhash;
		std::string cmd(param);
		std::vector<std::string> vcmd;
		#ifndef IWORLD_SERVER_BUILD
			StringUtil::split(vcmd, cmd, "&");
		#else
			StringUtil::split(vcmd, cmd, " ");
		#endif
		std::vector<std::string> kv;
		int sizekv = vcmd.size();
		for(int i =0 ; i < sizekv; i++)
		{
			kv.clear();
			StringUtil::split(kv, vcmd[i], "=");
			if(kv.size() == 2)
				kvhash[kv[0]] = kv[1];
		}
	
		return onParseKVHash();
	}
	
	const char* ClientManager::getEnterParam(const char* key)
	{
		return kvhash[key].c_str();
	}
	
	int ClientManager::getFps()
	{
		return Ogre::SceneManager::getSingleton().m_FPS;
	}
	
	void gFunc_reloadGameUI(){
	#ifdef _WIN32
		g_enableReloadTest = true;
		g_ClientMgr.reloadUI();
	#endif
	}
	
	void gFunc_reloadXML( const char *str ){
	#ifdef _WIN32
		g_enableReloadTest = true;
		g_ClientMgr.m_GameUI->LoadXMLFile( str );
	#endif
	}
	
	void gFunc_reloadLUA( const char *str ){
	#ifdef _WIN32
		if(!g_pUIScriptVM->callFile(str))
		{
			std::string str = "\tgFunc_reloadLUA lua file error!\n\nFileName:";
			str += str;
			assert(0);
			PopMessageBox(str.c_str(), "Error");
		}
	#endif
	}
	
	
	void gFunc_setGzipFlag(int flag_) {	
		LOG_INFO("set setGzipFlag=[%d]", flag_);
		Ogre::Downloader::setGzipFlag( flag_ );
	}
	
	
	std::string g_country = "";
	std::string gFunc_getCountry() {
	
		if (g_country.length() <= 0)
		{
			// todo set g_country
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
			g_country = "CN";
	#endif
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_ANDROID
			g_country = GetCountry();
	#endif
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE
	        g_country = GetCountry();
	#endif
		}
	
		LOG_INFO("call gFunc_getCountry=[%s]", g_country.c_str() );
	
		return g_country;
	}
	
	void gFunc_setCountry(std::string country) {
		g_country = country;
	}
	
	std::string g_operator_networktype = "";
	std::string gFunc_getOperatorAndNetworkType() {
	
		if (g_operator_networktype.length() <= 0)
		{
			// todo set g_country
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
			g_operator_networktype = GetOperatorAndNetworkType();
	#endif
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_ANDROID
			g_operator_networktype = GetOperatorAndNetworkType();
	#endif
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_APPLE
			g_operator_networktype = GetOperatorAndNetworkType();
	#endif
		}
	
		LOG_INFO("call gFunc_getOperatorAndNetworkType=[%s]", g_operator_networktype.c_str());
	
		return g_operator_networktype;
	}
	
	std::string ClientManager::getUserAccountInfo() {
	    return GetAccount();
	}
	void ClientManager::saveUserAccountInfo(const char *jsonChar) {
	    SaveAccount(jsonChar);
	}
	
	char* ClientManager::GetPCDesktopDir()
	{
		//获取PC桌面路径.
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
		static TCHAR szPath[MAX_PATH];
		static char utf8path[MAX_PATH*5];
		bool isSuc = SHGetSpecialFolderPath(NULL, szPath, CSIDL_DESKTOP, FALSE);  
	
		if (isSuc)
		{
			LOG_INFO("OK, pcDesctopDir = %s", szPath);
			//return "c:/Users/pc/Desktop/";
			UnicodeString pathU(szPath);
			strcpy(utf8path, pathU.getUtf8());
			return utf8path;
		} 
		else
		{
			LOG_INFO("ERROR, pcDesctopDir = NULL");
			return NULL;
		}
	#else
		return NULL;
	#endif
	}
	
	void ClientManager::StartTraceRouteInfo(const char* roomip, const char* mapip, const char* friendip, const char* accountip)
	{
		if (strlen(roomip) == 0 || strlen(mapip) == 0 || strlen(friendip) == 0 || strlen(accountip) == 0)
			return;
		m_pTraceRoute = new TraceRoute();
		m_pTraceRoute->addTraceRouteIpToList(roomip);
		m_pTraceRoute->addTraceRouteIpToList(mapip);
		m_pTraceRoute->addTraceRouteIpToList(friendip);
		m_pTraceRoute->addTraceRouteIpToList(accountip);
		m_pTraceRoute->start();
	
	#if OGRE_PLATFORM == OGRE_PLATFORM_ANDROID	
		if ((GameApiId()== 303 || GameApiId() == 345)){	
			std::string domains1 = std::string(roomip).append(";");
			std::string domains2 = std::string(mapip).append(";");
			std::string domains3 = std::string(friendip).append(";");
			std::string domains4 = std::string(accountip).append(";");
			std::string domains = domains1.append(domains2).append(domains3).append(domains4);
			//startNetworkDiagnoService(domains.c_str());	
		}	
	#else
	
	#endif
	}
	
	void ClientManager::EndTraceRoute()
	{
		if (m_pTraceRoute->m_ThreadState == OSThread::RUN_EXIT)
		{
			m_pTraceRoute->shutdown();
			OGRE_DELETE(m_pTraceRoute);
		}
	}
	
	void ClientManager::onGetOneTraceItem(const char *doamin,const char *s,int index)
	{
		if(m_pTraceRoute){
			std::string sDomain = std::string(doamin);
			std::string ss = std::string(s);
			m_pTraceRoute->onGetOneTraceItem(sDomain,ss,index);
		}
	}
	
	void ClientManager::setDownloadOrder(bool sequence)
	{
		Ogre::DownloadManager::getSingleton().setDownloadOrder(sequence);
	}
	
	//wepb开关
	int gFunc_openWebp( int i ) {
		LOG_INFO( "set webp=[%d]", i );
		g_ClientMgr.m_openWebp = i;
		return i;
	}
	
	bool gFunc_isFileExist(const char *str) {
		return FileManager::getSingleton().isFileExist(str);
	}
	
	bool gFunc_isStdioFileExist(const char *str){
		return FileManager::getSingleton().isStdioFileExist(str);
	}
	
	int gFunc_getStdioFileSize(const char *str){
		return FileManager::getSingleton().getStdioFileSize(str);
	}
	
	void gFunc_renameStdioPath(const char *from, const char *to) {
		FileManager::getSingleton().renameStdioPath(from, to);
		
		int a = 3;
		a++;
	}
	
	std::string gFunc_getStdioFilepath(const char *str){
		#ifdef _WIN32
			std::string stdio;
			Ogre::FileManager::getSingleton().gamePath2StdioPath(stdio, str);
			return stdio;
		#else
			return str;
		#endif
	}
	
	bool gFunc_isStdioDirExist(const char *str){
		return FileManager::getSingleton().isStdioDirExist(str);
	}
	
	void gFunc_makeStdioDir(const char *str){
		FileManager::getSingleton().makeStdioDir(str);
	}
	
	//download may get  "<head><title>404 Not Found</title></head>"
	bool gFunc_isNot404(const char *str){
		FILE* fp_ = Ogre::FileManager::getSingleton().openStdioFile(str, "rb+");
		if ( fp_ ){
			char buff[256] = {0};
			fread(buff, 255, 1, fp_);
			if ( std::string(buff).find( "404 Not Found" ) != std::string::npos )
			{
				return true;
			}
		}
		return false;
	}
	
	
	void gFunc_deleteStdioFile(const char* str){
		Ogre::FileManager::getSingleton().deleteStdioFile( str );
	}
	
	std::string getReadMD5(const std::string& str)
	{
		const size_t MAX_STR_LEN = 16;
	
		//计算MD5
		Ogre::Md5Context md5;
		char hex[33] = {0};
	
		md5.begin();
		md5.append((const unsigned char *)str.c_str(), str.length());
		md5.getMD5Base16Str(hex);
	
		return std::string(hex);
	};
	
	std::string gFunc_getmd5(const std::string& str) {
	
		//char output[20] = {0};
		//char ret[36] = {0};
		//Ogre::Md5Calc(output, str.c_str(), str.length() );
		//Ogre::Md5ToHex(ret, output);
	
		std::string ret = getReadMD5(str);
	
		return ret;
	}
	
	
	//获得一个小文件的md5 1M以下
	std::string gFunc_getSmallFileMd5(const std::string& path, const std::string& sec, bool convertPath) {
		//data/xxx/yyy
		int buflen = 0;
		void* buff = NULL;
		if (convertPath)
			buff = ReadWholeFile(path.c_str(), buflen);
		else
			buff = ReadWholeFileStdio(path.c_str(), buflen);
		if ( buff && buflen > 0 )
		{
			if ( sec.length() > 0) {
				//解密
				for (int i = 0; i < buflen; i++) {
					char sec_ = sec[ i % sec.length() ];
					((char*)buff)[i] = (((char*)buff)[i] ^ sec_);
				}
			}
			std::string md5 = getReadMD5( std::string( (char*)buff, buflen) );
			free(buff);
			return md5;
		}
		else
		{
			return "";
		}
	}
	
	
	//获得一个大文件的md5 分段计算
	std::string  gFunc_getBigFileMd5(const std::string& fileName, bool convertPath) {
		if (fileName.length() > 0) {
			std::string ospath("");
			if (convertPath)
				Ogre::FileManager::getSingleton().gamePath2StdioPath(ospath, fileName.c_str());
			else
				ospath = fileName;
	
			FILE *fd = fopen(ospath.c_str(), "rb");
			if (!fd) {
				LOG_INFO("can not open file=[%s].", ospath.c_str());
				return "";
			}
	
			const size_t MAX_STR_LEN = 16;
			const size_t _MD5_FILE_SIZE_ = 32 * 1024;
	
			//计算MD5
			char hex[33] = { 0 };
			Ogre::Md5Context md5;
			md5.begin();
	
			long  memblock_length = 0;
			char  memblock[_MD5_FILE_SIZE_ + 1] = {0};
	
			int now_pos = 0;
			while (true) {
				memset(memblock, 0, _MD5_FILE_SIZE_+1);  //32k
				fseek(fd, now_pos, SEEK_SET);
	
				memblock_length = fread(memblock, 1, _MD5_FILE_SIZE_, fd);
				//LOG_INFO("fread=[%d].", memblock_length);
				if (memblock_length <= 0) {
					break;  //eof
				}
	
				md5.append((const unsigned char *)memblock, memblock_length);
				now_pos += memblock_length;
			}
			fclose(fd);
	
			md5.getMD5Base16Str(hex);
			return hex;
		}
		else {
			return "";
		}
	}
	
	//获得一个小文件的内容 1M以下 带有解密功能
	std::string gFunc_getSmallFileTxt(const std::string& path, const std::string& sec) {
		//data/xxx/yyy
		int buflen = 0;
		void* buff = ReadWholeFile(path.c_str(), buflen);
		if (buff && buflen > 0)
		{
			if (sec.length() > 0) {
				//解密
				for (int i = 0; i < buflen; i++) {
					char sec_ = sec[i % sec.length()];
					((char*)buff)[i] = (((char*)buff)[i] ^ sec_);
				}
			}
			std::string retstr((char*)buff, buflen);
			free(buff);
			return retstr;
		}
		else
		{
			return "";
		}
	}
	
	
	
	std::string gFunc_urlEscape(const std::string& str)
	{
		std::string ret;
	
		CURL *curl = curl_easy_init();
		if (curl)
		{
			char *output = curl_easy_escape(curl, str.c_str(), str.size());
			if (output) {
				ret = output;
				curl_free(output);
			}
		}
		curl_easy_cleanup(curl);
	
		return ret;
	}
	
	#if OGRE_PLATFORM != OGRE_PLATFORM_WIN32
	#define O_BINARY (0)
	#endif
	
	std::string gFunc_readTxtFile(const char *path)
	{
		std::string fullpath;
		FileManager::getSingleton().gamePath2StdioPath(fullpath, path);
	
		FileAutoClose fp(fullpath, O_RDONLY | O_BINARY);
		if (fp.isNull()) return "";
	
		int datalen = fp.fileSize();
		if (datalen == 0) return "";
	
		void *buf = malloc(datalen);
		fp.seek(0, SEEK_SET);
		if (!fp.read(buf, datalen))
		{
			free(buf);
			return "";
		}
		
		std::string ret((char*)buf, (char*)buf + datalen);
		free(buf);
		return ret;
	}
	
	int gFunc_writeTxtFile(const char *path, const std::string& content)
	{
		char tmppath[256];
		sprintf(tmppath, "%s.tmp", path);
		std::string fullpath;
		FileManager::getSingleton().gamePath2StdioPath(fullpath, tmppath);
	
		FileAutoClose fp(fullpath, O_CREAT | O_WRONLY | O_TRUNC | O_BINARY);
		if (fp.isNull()) return false;
	
		if (!fp.write(content.data(), content.size())) return false;
	
		fp.sync();
		fp.close();
	
		FileManager::getSingleton().renameStdioPath(tmppath, path);
	
		return true;
	}
	
	
	void gFunc_openBrowserUrl(const std::string& url, int type ) {
	//#define OGRE_PLATFORM_WIN32 1
	//#define OGRE_PLATFORM_ANDROID 2
	//#define OGRE_PLATFORM_APPLE 3
	
		LOG_INFO( "call openBrowserUrl=[%s] [%d]", url.c_str(), type );
		BrowserShowWebpage(url.c_str(), type );
	/*
	#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32 
		std::string cmd = "explorer \"" + url + "\"";
		LOG_INFO( "open url=[%s]", cmd.c_str() );
		system(cmd.c_str() );
	
	#elif OGRE_PLATFORM == OGRE_PLATFORM_ANDROID
		const char* pszUrl = url.c_str();
	
		JniMethodInfo minfo;
		if (JniHelper::getStaticMethodInfo(minfo,
			"org/cocos2dx/application/ApplicationDemo",
			"openURL",
			"(Ljava/lang/String;)V"))
		{
			jstring StringArg1 = minfo.env->NewStringUTF(pszUrl);
			minfo.env->CallStaticVoidMethod(minfo.classID, minfo.methodID, StringArg1);
			minfo.env->DeleteLocalRef(StringArg1);
			minfo.env->DeleteLocalRef(minfo.classID);
		}
	
	#elif OGRE_PLATFORM == OGRE_PLATFORM_APPLE
		const char* pszUrl = url.c_str();
		[[UIApplication sharedApplication] openURL:pszUrl];
	#else
		// unknown platform
	#endif
	*/
	}
	
	static APP_MODE s_app_mode = APP_MODE_NORMAL;
	bool CheckModeDynamicLib(){
	    //{{{
	    return s_app_mode == APP_MODE_DYNAMIC_LIB;
	    //}}}
	}
	
	void gFunc_setAppMode(int mode){
	    //{{{
	    s_app_mode = (APP_MODE) mode;
	    //}}}
	}
	
	
	namespace Ogre
	{
		Application *CreateApplication()
		{
	#ifdef IWORLD_TARGET_PC
			return new ClientManagerPC;
	#else
			return new ClientManagerMobile;
	#endif
		}
	
		Application *GetApplicaiton()
		{
			return ClientManager::getSingletonPtr();
		}
	}
	