.PHONY: all
all: clean link

.PHONY: install_neovim
install_neovim:
	brew install neovim

.PHONY: link
link: ${HOME}/.config
	ln -s `pwd`/.config/nvim ${HOME}/.config/nvim

.PHONY: clean
clean:
	rm ${HOME}/.config/nvim

${HOME}/.config:
	mkdir -p ${HOME}/.config

