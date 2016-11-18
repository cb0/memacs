My emacs configuration alias MeMACS


### History: 
I'm a frequent emacs user for nrealy over 8 years now. I started using emacs when I was working for a company that used LaTeX to transform mainly medical technical literature into nice looking papers. They had what felt like a quadrillion shortcuts, scripts and other stuff that did nearly all the work when executed in the right place. And it somtimes felt like magic.
After I changed workplace I regulary used emacs to do all kinds of stuff. Mainly for editing server config files on remote servers in locations I'll never been to.
However I think I never even touched the superpowers that lay behind this 'rule them all' editor.

Years went by and I just started to experiment with [CommonLisp](http://www.clisp.org/) and [Clojure](http://clojure.org/), and had a look at [lighttable](http://www.lighttable.com/) when I realized that I needed more. More features and more shortcuts (because I love doing everthing from keyboard) and more knowledge on how to use emacs as my main development tool. 
Therefore my journey into the wild began and I was about to learn why emacs is a top dog.

### Project Info:
This little project should document all the tinhgs I've learned beside the standard emacs functionality on how to type M-x ;)
And in first place it should include all the things I need to be productive in my daily workflow. 
Therefore this project mainly consists of emacs configuration files, customized extensions and some documentation. I'll try to make everything as clear as possible. However I'm quite sure that there will be errors in both, the code and my understanding of how things work. So if you think I have done something terrible, please mail me at [cb0 at 0xcb0 dot com].

### WARNING:
At the moment this project is not intended to be used as a emacs beginner configuration. You'll need some understanding on how emacs works and how to customize things. 
There will be a documentation but for now please be aware that this is not what you may have been looking for. It's my personal emacs configuration. Not less, not more.

### Org Mode
    I use org mode for my config file format. More info on that will be added later.

### Content:
    |->emacs
    |	The main file that shall be linked to '~/.emacs' and will load all other files.
    |
    |->emacs.d
    |	Directory containing config files and that will be linked to ~/.emacs.d.
    |
    |->README.md
    |	You are looking at it right now.
    |
    |->(init_system.sh) setup script that will be added in the future
    	What it basically does is to link the file 'emacs' and folder 'emacs.d' to you home directory.
	After that it'll call 
	emacs -batch ~/.emacs.d/init.el --eval="(eval-buffer)" 