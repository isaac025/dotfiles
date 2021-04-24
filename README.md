
# Table of Contents

1.  [Debian Image](#org95435f9)
    1.  [Install necessary firmware](#org034e08d)
    2.  [Download Debian Buster](#orgabb1a6a)
    3.  [Install Necessary software](#org3f61535)
2.  [ZSH](#org5070d96)
3.  [Kitty](#orgac4010c)
4.  [Ly](#orge7c663d)
5.  [Haskell with Cabal](#org4bcc267)
6.  [XMonad, Rofi, Tint2 and Dunst](#org46ad022)
    1.  [Basic XMonad config](#org9c73233)
    2.  [Dependencies](#orga3aa291)
    3.  [Tint2 Fork](#org610f102)
    4.  [Candy icons](#org6e6a6d0)
    5.  [Picom](#org5ac0784)
7.  [Firefox](#orge0bf5c1)
    1.  [Instalation probably with macosx](#org0dee7de)
8.  [Spotify](#org1747697)
    1.  [Deb repos](#org0b97aad)
    2.  [Install](#org21d1509)
9.  [Eww](#org1a2de25)
    1.  [First install rustup](#org0c3cd79)
    2.  [Then install dependencies, nightly and eww](#orgb37ad6b)
10. [Add Axrva's config](#orgdb72dcf)
11. [Emacs](#org4378206)



<a id="org95435f9"></a>

# Debian Image


<a id="org034e08d"></a>

## Install necessary firmware

[Debian Image](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.9.0-amd64-netinst.iso)
[Wifi-Firmaware](https://packages.debian.org/buster/all/firmware-brcm80211/download)
[AMD Graphics](https://packages.debian.org/buster/all/firmware-brcm80211/download)


<a id="orgabb1a6a"></a>

## Download Debian Buster

After graphical install move to Unstable-Testing in order to get
kernel 5.9.0-1-amd64.

    cd /etc/apt/
    rm sources.list
    touch sources.list
    echo "
    deb http://ftp.us.debian.org/debian/ testing main contrib non-free
    deb-src http://ftp.us.debian.org/debian/ testing main contrib non-free
    deb http://ftp.us.debian.org/debian/ testing-updates main contrib non-free
    deb-src http://ftp.us.debian.org/debian/ testing-updates main contrib non-free
    # deb http://deb.debian.org/debian-security testing/updates main contrib non-free
    # deb-src http://deb.debian.org/debian-security testing/updates main contrib non-free
    
    # This system was installed using small removable media
    # (e.g. netinst, live or single CD). The matching deb cdrom
    # entries were disabled at the end of the installation process.
    # For information about how to configure apt package sources,
    # see the sources.list(5) manual.
    deb http://deb.debian.org/debian/ experimental main
    " >> sources.list
    apt update && apt full-upgrade


<a id="org3f61535"></a>

## Install Necessary software

    apt-get install sudo
    visudo # Add isaac to users

    sudo reboot
    uname -r # Expect linux-5.10-amd64
    # Now let us start
    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install xorg git build-essential libpam0g-dev libxcb-xkb-dev kitty openssh-server curl wget zsh cmake network-manager feh
    sudo apt-get install libcairo2-dev libpango1.0-dev libglib2.0-dev libimlib2-dev libgtk2.0-dev libxinerama-dev libx11-dev libxdamage-dev libxcomposite-dev libxrender-dev libxrandr-dev librsvg2-dev libstartup-notification0-dev
    sudo apt-get update && sudo apt-get upgrade


<a id="org5070d96"></a>

# ZSH

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp old.zshrc $HOME/.zshrc
    cp dotfiles/isaac.zsh-theme .oh-my-zsh/themes/


<a id="orgac4010c"></a>

# Kitty

    git clone https://github.com/isaac025/myKitty


<a id="orge7c663d"></a>

# Ly

    git clone https://github.com/nullgemm/ly.git
    make github
    make
    sudo make run
    sudo make install
    sudo systemctl enable ly.service


<a id="org4bcc267"></a>

# Haskell with Cabal

    sudo apt-get install haskell-platform


<a id="org46ad022"></a>

# XMonad, Rofi, Tint2 and Dunst

    sudo apt-get install xmonad libghc-xmonad-contrib-dev rofi dunst


<a id="org9c73233"></a>

## Basic XMonad config

    echo "import XMonad
    import XMonad.Config.Desktop
    main = xmonad defaultConfig
          { modMask = mod4Mask
          , terminal = \"kitty\"
          }" >> .xmonad/xmonad.hs 


<a id="orga3aa291"></a>

## Dependencies

    sudo apt-get install brightnessctl playerctl doas jq maim mpv xclip # probably need --fix-missing flag


<a id="org610f102"></a>

## Tint2 Fork

    git clone https://github.com/Axarva/tint2-1.git tint2
    cd tint2
    mkdir build
    cd build
    cmake ..
    make -j4


<a id="org6e6a6d0"></a>

## Candy icons

    git clone https://github.com/EliverLara/candy-icons
    mkdir .themes
    mv candy-icons .themes


<a id="org5ac0784"></a>

## Picom

    sudo apt-get install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libdbus-1-dev libconfg-dev uthash-dev libxcb-glx0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-render-util0-dev libxcb-image0-dev libxcb-damage0-dev libxcb-randr0-dev libxcb--dev xcb libxcb-sync-dev libxcb-composite0-dev libxcb-composite0-dev
    sudo apt-get install ninja-build meson
    git clone https://github.com/ibhagwan/picom
    cd picom
    git submodule update --init --recursive
    meson --buildtype=release . build
    sudo ninja -C build


<a id="orge0bf5c1"></a>

# Firefox


<a id="org0dee7de"></a>

## Instalation probably with macosx

scp isaaclopez@MacOSX:~/Firefox.zip


<a id="org1747697"></a>

# Spotify


<a id="org0b97aad"></a>

## Deb repos

    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.lis.d/spotify.list


<a id="org21d1509"></a>

## Install

    sudo apt-get update && sudo apt-get install spotify-client # Maybe --fix-missing


<a id="org1a2de25"></a>

# Eww


<a id="org0c3cd79"></a>

## First install rustup

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


<a id="orgb37ad6b"></a>

## Then install dependencies, nightly and eww

    rustup install nightly
    sudo apt-get install libgtk-3-dev
    git clone https://github.com/elkowar/eww
    cd eww
    cargo build --release
    cd target/release
    chmod +x ./eww
    ./eww daemon


<a id="orgdb72dcf"></a>

# Add Axrva's config

    git clone https://github.com/Axarva/dotfiles-2.0
    cd dotfiles-2.0
    cp -r config/rofi ../.config/rofi
    cp -r config/tint2 ../.config/tint2
    cp -r config/eww-1920 ../.config/eww
    cp -r fonts/ ../.local/share/fonts/ttf
    cp -r wallpapers .


<a id="org4378206"></a>

# Emacs

    apt-get install emacs emacsclient
    cp -r $HOME .emacs.d

