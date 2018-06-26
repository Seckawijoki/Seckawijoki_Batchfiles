module(..., package.seeall) --定义包
ver = "0.1 alpha"
function aFunInMyPack()
	print("Hello!")
end
_G.aFuncFromMyPack =
aFunInMyPack