pack = require "my_package" --导入包
print(ver or "No ver defined!")
print(pack.ver)
print(aFunInMyPack or "No aFunInMyPack defined!")
pack.aFunInMyPack()
print(aFuncFromMyPack or "No aFuncFromMyPack defined!")
aFuncFromMyPack()