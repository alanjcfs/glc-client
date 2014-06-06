glc-client
==========

Game Lost Crash client.

You will now need to install NSQ to run glc-client outside of Open Horizon
Labs. See more below.

	git clone git@github.com:gamelost/glc-client.git

== Love2D Installation

OSX:

Two options:

After downloading love2d, to run love2d from command line, use this command:

	open -n -a love <directory containing the main.lua file>

I would recommend to create an alias in .bash_profile because the above
command will open LOVE in the background, so all print() outputs will not be
visible on the console window.

Or, one way to make `love` in the OS X terminal:

	# depending on how you'd do it
	$ mkdir -p $HOME/.bin
	$ echo "export PATH=$PATH:$HOME/.bin" | tee ~/.bash_profile | tee ~/.zshrc
	# and finally
	$ ln -s /Applications/love.app/Contents/MacOS/love $HOME/.bin/love

	$ love <directory>

Linux:

        love <directory>

== Installing NSQ

OSX:

	brew install nsq

Linux:

You may download the binary from http://nsq.io/deployment/installing.html and
place the extracted files in `/usr/local/bin` or `~/.bin` or try to compile them
yourself.

You will probably need to run `nsqd` and `nsqlookupd` before you can
`love <directory of glc-client>`.

After running `nsqd` and `nsqlookupd` (though it seems only `nsqlookupd` is
required at the moment), run

	LOCAL_NSQ=http://127.0.0.1 love <directory of glc-client>
