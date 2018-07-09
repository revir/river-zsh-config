useroot=""
if [ "$EUID" -ne 0 ]; then
  useroot="sudo"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install zsh
if ! which zsh >/dev/null 2>&1; then
	echo "install zsh..."

	if which brew >/dev/null 2>&1; then
		$useroot brew install zsh zsh-completions
	fi
	if which apt >/dev/null 2>&1; then
		$useroot apt install zsh
	fi
	if which pacman >/dev/null 2>&1; then
		$useroot pacman -S zsh
	fi
	if which dnf >/dev/null 2>&1; then
		$useroot dnf install zsh
	fi
	if which yum >/dev/null 2>&1; then
		$useroot yum -y install zsh
	fi
fi

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
	echo "install oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# git clone this project;
if [ "$(basename "$DIR")" != 'river-zsh-config' ]; then 
	git clone https://github.com/revir/river-zsh-config.git || {
		printf "Error: git clone of river-zsh-config failed."
		exit 1
	}
	cd river-zsh-config
	DIR="$(pwd)"
	echo $DIR
fi


if ! grep 'ZSH_THEME="river"' ~/.zshrc >/dev/null 2>&1; then
	# setup .zshrc
	if which brew >/dev/null 2>&1; then
		echo "install gnu-sed..."
		$useroot brew install gnu-sed
		sed=gsed
	fi

	if which sed >/dev/null 2>&1; then
		echo "setup ~/.zshrc..."
		code="ZSH_CUSTOM=\"$DIR\""
		sed -i "/ZSH_THEME=/i $code" ~/.zshrc
		sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="river"/' ~/.zshrc

		echo "NOTICE: edited ~/.zshrc, remember to run source ~/.zshrc by yourself!"
	else 
		echo "WARN you dont have sed, can't setup .zshrc, you should setup it by yourself!"
	fi
fi