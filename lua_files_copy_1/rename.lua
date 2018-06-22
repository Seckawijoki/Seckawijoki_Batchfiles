function rename(arg)
	return os.rename(arg.old, arg.new)
end
rename{old="to_be_renamed.lua",new="be_renamed.lua"}