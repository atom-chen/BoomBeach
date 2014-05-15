

-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
	require "Cocos2d"
	require "Cocos2dConstants"
	
	require "kode.init"		-- framework
	require "app.init"			-- app
	require "app.appfacade"		-- application
    require "app.register"      -- register controllers

	collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
	cc.FileUtils:getInstance():addSearchResolutionsOrder("src");
	cc.FileUtils:getInstance():addSearchResolutionsOrder("res");

    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or 
       (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
       (cc.PLATFORM_OS_MAC == targetPlatform) then
        cclog("result is ")
		require('debugger')()
        
    end
   
    require "hello2"
    cclog("result is " .. myadd(100, 1))
	
	appFacade:startup()		-- startup
end

xpcall(main, __G__TRACKBACK__)