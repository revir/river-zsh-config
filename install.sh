useroot=""
if [ "$EUID" -ne 0 ]; then
  useroot="sudo"
fi

ZSH_CUSTOM=~/river-zsh-config
CPWD=`pwd`

sysinstall()
{
	if ! which $1 >/dev/null 2>&1; then
		echo "install $1 ..."

		if which brew >/dev/null 2>&1; then
			$useroot brew install $1
		fi
		if which apt >/dev/null 2>&1; then
			$useroot apt install $1
		fi
		if which pacman >/dev/null 2>&1; then
			$useroot pacman -S $1
		fi
		if which dnf >/dev/null 2>&1; then
			$useroot dnf install $1
		fi
		if which yum >/dev/null 2>&1; then
			$useroot yum -y install $1
		fi
	fi
}

# install zsh
sysinstall zsh
# install git
sysinstall git

# install sed on mac
if which brew >/dev/null 2>&1; then
	if ! which gsed >/dev/null 2>&1; then
		echo "install gnu-sed..."
		$useroot brew install gnu-sed
		sed=gsed
	fi
fi


# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
	echo "install oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# git clone this project;
if [ ! -d $ZSH_CUSTOM ]; then
	echo "clone $ZSH_CUSTOM ..."
	git clone https://github.com/revir/river-zsh-config.git $ZSH_CUSTOM || {
		printf "Error: git clone river-zsh-config failed."
		exit 1
	}
else
	cd $ZSH_CUSTOM
	git pull
	cd $CPWD
fi

# install zsh-syntax-highlighting
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]; then
	echo "clone zsh-syntax-highlighting..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi

# install zsh-autosuggestions
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-autosuggestions ]; then
	echo "clone zsh-autosuggestions..."
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi


# change .zshrc theme
if ! grep 'ZSH_THEME="river"' ~/.zshrc >/dev/null 2>&1; then
	# setup .zshrc
	if which sed >/dev/null 2>&1; then
		# backup .zshrc
		cp ~/.zshrc ~/.zshrc.bak

		echo "setup ~/.zshrc, use my ZSH_CUSTOM and ZSH_THEME ..."
		code="ZSH_CUSTOM=\"$ZSH_CUSTOM\""
		sed -i "/ZSH_THEME=\"robbyrussell\"/i $code" ~/.zshrc
		sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="river"/' ~/.zshrc

		echo "NOTICE: edited ~/.zshrc, remember to run source ~/.zshrc by yourself!"
	else
		echo "WARN: you dont have sed, can't setup .zshrc, you should setup it by yourself!"
	fi
fi

# change .zshrc plugins
if ! grep 'zsh-syntax-highlighting' ~/.zshrc >/dev/null 2>&1; then
	# setup .zshrc
	if which sed >/dev/null 2>&1; then
		echo "setup zshrc plugins, use python node nvm z extract kubectl zsh-syntax-highlighting zsh-autosuggestions ..."

		# deprecated, ohmyzsh used to be like that.
		# # clever way to sed multiple lines: https://unix.stackexchange.com/questions/26284/how-can-i-use-sed-to-replace-a-multi-line-string
		# # and don't cat & write to the same file at the same time!!!
		# cat ~/.zshrc | tr '\n' '\r' | sed -e 's/\rplugins=(\r  /\rplugins=(\r  python node nvm z extract kubectl zsh-syntax-highlighting zsh-autosuggestions /'  | tr '\r' '\n' > ~/.zshrc.tmp
		# mv ~/.zshrc.tmp ~/.zshrc

		sed -i 's/plugins=(git)/plugins=(git python node nvm npm z extract kubectl zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

		echo "NOTICE: edited ~/.zshrc, remember to run source ~/.zshrc by yourself!"
	else
		echo "WARN you dont have sed, can't setup .zshrc, you should setup it by yourself!"
	fi
fi

# 加入home end，以及小键盘的支持
if ! grep ':key-binds-for-home-end-and-others' ~/.zshrc >/dev/null 2>&1; then
	echo "Add some key-binds for home, end and other keys."
	cat ${ZSH_CUSTOM}/key-binds.sh >> ~/.zshrc
fi
