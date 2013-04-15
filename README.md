Warren Wilkinson's Emacs Configuration Files
============================================

These files are my custom emacs configuration.

I created it because I wanted to standardize my emacs setup on
multiple machines.

To use, backup your ~/.emacs and ~/.emacs.d

    cp ~/.emacs ~/.emacs.backup
    cp ~/.emacs.d ~/.emacs.d.backup

Then install these versions:

    cd ~/
    git clone https://github.com/WarrenWilkinson/dot-emacs.git
    mv dot-emacs .emacs.d
    ln -s .emacs.d/.emacs .emacs

Local Customizations
--------------------

If you want some machine specific additions, find out your hostname
and create the file

    ~/.emacs.d/setup/local-XYZ.el

where XZY is your hostname.

An easy way to find out your hostname, is to write:

    system-name

in a emacs buffer, then position point right after it and press C-x
C-e. That runs 'eval-last-sexp', which will tell you what emacs thinks
your hostname is.
