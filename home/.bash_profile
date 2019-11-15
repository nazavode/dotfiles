ulimit -t unlimited

# chsh doesn't work on CINECA systems,
# go for this ugly hack:
SHELL=/bin/zsh exec /bin/zsh

# On some systems (e.g.: redhat), .bashrc is not always evaluated at login.
# Ensure it is.

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
	    . "$HOME/.bashrc"
    fi
fi
