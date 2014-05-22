Useful Scripts
==============

Useful shell scripts. Just a random assortment of utility scripts I use. Most
made for Ubuntu/Debian systems.

cloudapp
--------

A CloudApp upload utility written by Zach Holman / @holman.

    cloudapp some-picture.png

colors
------

A script that defines a number of environment variables that contain ANSI color
codes that can be used in scripts. Simply source it at the beginning of your
script and then you can do:

    echo -e I'm $Color_Red using colors $Color_Off.

disk-usage
----------

Prints out information about disk usage. Basically it runs `df -h` for you and 
then spot-checks bunch of common directories where log and temp file accumulate,
runs `du -shBM` on them and sorts the list for you.

Requires `awk`.

gallery
-------

Takes a folder paht as an argument, and generates thumbnails for all the images
inside of it. Then it dumps out a HTML formatted gallery you can use on your 
website. The HTML is tailored to Twitter Bootstrap 3.x convetnions.

    gallery /some/folder >> gallery.html

Requires `imagemagic`.


markdown-preview
----------------

Converts a Markdown document to html using `pandoc` and then opens it in `elinks`.

mirror
------

Downloads a website to be viewed locally. Pretends to be Googlebot. Very
impolite and brutish script.

    mirror http://example.com

Requires `wget`.

mj-find
-------

Search tool for [Markdown Journal](http://markdownjournal.com). Uses Silver
Searcher `ag` if available, or `grep` to find specified keyword in your jounal
files.

    mj-find keyword

You can configure it by defining following variables:

- `JOURNAL_DIR` - path to your files. Default is `~/Dropbox/Apps/Markdown\ Journal`
- `JOURNAL_SEARCH` - either `ag` or `grep`. If not defined, defaults to `ag` and
  falls back on `grep` if not available.

If `figlet` is installed, it will use it to print logo.

mj-view
-------

Previews this months' journal page in a web browser. Uses `pandoc` to convert
markdown to HTML.

You can configure it by defining following variables:

- `JOURNAL_DIR` - path to your files. Default is `~/Dropbox/Apps/Markdown\ Journal`
- `JOURNAL_BROWSER` - the web browser to use. Defaults to `links`.
- `JOURNAL_PANDOC_OPTS` - additional options you want to pass to `pandoc`.
  Defaults to `--section-divs --title-prefix=$(date +"%B-%Y")`

Tested to work under Cygwin, using the Windwows version of `pandoc.exe`. The
script detects if it's running in a real Unix environment or in Cygwin and then
runs all the paths through `cygpath` if needed.

mvim
----

Shell script passes all its arguments to the binary inside the
MacVim.app application bundle.  If you make links to this script as view,
gvim, etc., then it will peek at the name used to call it and set options
appropriately.

Based on a script by Wout Mertens and suggestions from Laurent Bihanic.  This
version is the fault of Benji Fisher, 16 May 2005 (with modifications by Nico
Weber and Bjorn Winckler, Aug 13 2007).

packages-by-size
----------------

Lists installed packages, sorted by their size on disk. Uses `dpkg-query` so
obviously will only work on Debian, Ubuntu and derivatives.

pngcrushdir
-----------

Runs `pngcrush -brute` on all the png files in a specified directory.

    pngcrushdir /some/folder

It creates temp files in the same directory as it works, then deletes them. You
should probably use `optipng` instead of `pngcrush` anyway.

ppa-add-key
-----------

Lets you add a ppa source if and when your outbout SSH ports are blocked by the
firewall. Forces use of HTTP on port 80 to fetch the PPA keys. Must use the
hex key fingerprint instead of the PPA name.

    ppa-add-key C7917812

Ubuntu only for obvious reasons.

rand-passcode
-------------

Generates a very week, pseudo random pin code. Don't use it for passwords. I made
it to generate weaksauce, easy to remember codes for an internal app.

recursive-line-count
--------------------

Given a file extension, counts lines of code in every file with that extension
in the current directory. It recurses into subdirectories.

    recursive-line-count rb

remove-old-kernel-images
------------------------

Lists all the kernel images currently installed on the system and gives you
and option to delete all the images that are not the current one.

Uses `dpkg` so Ubuntu and Debian derevatives only. Requires `sed`.

repeats
-------

Counts how often do you repeat a word. Counts words from STDIN or from a file.
The first argument is the word to be counted. The second one is the file which
is optional. If file is not specified, it expects input from STDIN.

    repeats actually blogpost.md

Uses `awk`.

tunnel-create
-------------

Opens an SSH tunnel to a remote server using another server in the middle. This
is sometimes needed if you are behind a very restrictive firewall that blocks
all outbound ports. 

Here is a simple use case:

- You are behind firewall. All ports other than 80 and 443 are blocked.
- You want to ssh to DESTINATION which has SSH server running on port 22
- You don't own/control DESTINATION and can't set up SSH on other port
- You do own BOUNCE, a server at your house
- You set up SSH to listen on port 443 on BOUNCE
- You want to relay traffic to DESTINATION via BOUNCE

Now run:

    tunnel-create BOUNCE DESTINATION 443

This is equivalent of:

    ssh -p 443 -N -T BOUNCE -L 1234:DESTINATION:22

It saves you a lot of typing and you don't have to remember the difference
between `-R` and `-L` ssh options.

Run without any arguments to see usage.

tunnel-ssh
----------

Companion script to tunnel-create. Once the tunnel is established, you can
simply use this script to ssh into the remote. It assumes your username is the
same on the remote as on the local machine. If not, you can pass username on
remote as the first argument. It also assumes the tunnel is running on port 1234.
If it's not, you can pass port as second agument.

    tunnel-ssh john

This is equivalent to:

    ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 1234 john@localhost

We don't save the keys to the hosts file because you can use this script to
tunnel to many different hosts. So your hosts file would be full of fake
entries for localhost.

The script will check if the tunnel is open before trying to connect and quit
if it is not.

tunnel-scp
----------

As above but for scp. Allows you to easily copy files over the remote tunnel.

    tunnel-scp *.html ./public_html/ john

Is equivalent of:

    scp -P 1234 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no *.html john@localhost:./public_html/

It assumes the tunnel port is 1234 and that the username is the same as on local
machine. It checks if tunnel is open before copying anything, and quits if its
not.

    
updateall
---------

Pulls `~/.dotfiles`, `~/.vim` and `~/scripts` from their respective repositories.
This is fairly unique to my config so you shouldn't use it.

vim-session-wipe
----------------

Deletes all the files in `~/.vim/session`. This is where I store my session
files. This might be very different for you.
