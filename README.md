# river-zsh-config

This is my custom zsh theme.

# autorun

sh -c "$(curl -fsSL  https://github.com/revir/river-zsh-config/raw/master/install.sh)"

** you need to run twice of this command. **
** then `source ~/.zshrc`. **

# manully install	
	
	1. run `./install.sh` to install oh-my-zsh. 
	2. run again `./install.sh` to setup `~/.zshrc`;  

# manully install 2

edit `.zshrc`, add:

    ZSH_CUSTOM=/path/to/river-zsh-config
    ZSH_THEME="river"
    
then `source ~/.zshrc`.

# screenshot
![screenshot](https://github.com/revir/river-zsh-config/raw/master/screenshot.png)
