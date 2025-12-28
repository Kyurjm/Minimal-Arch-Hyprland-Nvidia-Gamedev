# Minimal-Arch-Hyprland-Nvidia-Gamedev
I highly recommend following the steps one by one. You can start by copying my minimal config, then tweak it however you like.

SCREENSHOTS:

![Demo0](https://github.com/Kyurjm/Minimal-Arch-Hyprland-Nvidia-Gamedev/blob/87513e05e95dd1a0abd9d12fe9af5abb8b1d9bd2/assets/Demo/Screenshot1.jpg)

![Demo1](https://github.com/Kyurjm/Minimal-Arch-Hyprland-Nvidia-Gamedev/blob/87513e05e95dd1a0abd9d12fe9af5abb8b1d9bd2/assets/Demo/Screenshot.jpg)

SPECIFICATION:
- Gigabyte Z690 Aorus Elite AX DDR4 V2 Motherboard
- Intel Core i7 12700F Processor / 2.1GHz Turbo 4.9GHz / 12 Cores 20 Threads / 25MB / LGA 1700
- Gigabyte Aorus GeForce RTX 3070 Master 8G (LHR) Graphics Card (GV-N3070AORUS-M-8GD)
- Cooler Master MWE 750 Bronze V2 FR Power Supply (750W)
- Cooler Master MASTERLIQUID ML240L V2 ARGB White Edition Cooler
- PNY XLR8 Silver 4x8GB 3600 RGB RAM

Note if you choose to follow my config consider checkout these note below:
- "assets" folder put under Pictures folder in your system
- "bash & bash profile" put under user folder in your system
- Make sure to put all your themes under:

        System-wide:    /user/share/themes
                        /user/share/icons
        User-specific:  /.themes
                        /.icons
- I'm using keyboard with window keyboard => in hyprland config i did swap alt and win button, and change caplock into escape (so we have 2 escale XD)
- In terminal I mainly use yazi to navigate around and nvim to edit stuff => if you want to drag file from yazi to another window press Ctrl + N
- Must know hotkeys to navigate around:

        SUPER + T => open terminal
        SUPER + C => open vscode
        SUPER + N => open neovim
        SUPER + E => open yazi file manager
        SUPER + F => open nautilus file manager
        SUPER + L => Lockscreen
        SUPER + Tab => Jumping around window in a workspace
        SUPER + GRAVE => Jump between 2 workspace
        SUPER + 1 => Switch to workspace 1
        Super + SHIFT + 1 => move window to workspace 1
        SUPER + S => Switch to special workspace
        SUPER + SHIFT + S => move window to special workspace
        SUPER + CTRL + Q => Close a window
        SUPER + V => float a window
        SUPER + P => Color pick and copy to clipboard
        SUPER + F11 => Fullscreen
        PRINT => Screenshot and copy to clipboard
        CAl => Open Calculator app

## Install Arch Linux
Download Arch Linux https://archlinux.org/download/
Install Arch Linux
```
pacman -Sy archinstall
```
```
archinstall
```
**During Installation:** make sure to choose "Minimal" setting/type.

---

## Install Essentials

### First Update System
```
sudo pacman -Syu
```
### Install AUR Helper 
Install paru (https://github.com/Morganamilo/paru)
```
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
rm -r paru
```
### Choose your terminal
```
sudo pacman -S ghostty
```
### Choose your browser
```
paru -S google-chrome
```
### Choose text editor
```
paru -S visual-studio-code-bin
```
### Choose terminal text editor
```
sudo pacman -S neovim
```
### File Manager
```
sudo pacman -S nautilus
```
### Compression Tools
```
sudo pacman -S file-roller 7zip unzip unrar gzip bzip2 xz tar
```
### Terminal File Manager (https://yazi-rs.github.io/docs/installation)
```
sudo pacman -S yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick
```
### Drag and drop files to and from the terminal (Combine with yazi)
```
paru -S ripdrag
```
### Wayland session manager
```
sudo pacman -S uwsm libnewt
```
### For extracting and viewing files in .zip archives
```
sudo pacman -S unzip
```
### Utility used to store, backup, and transport files
```
sudo pacman -S tar
```
### Audio stack
```
sudo pacman -S pipewire wireplumber
```
### Install Fonts
```
sudo pacman -S ttf-dejavu-nerd noto-fonts-cjk ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
```
### Version control system
```
sudo pacman -S git
```
### TUI for git commands
```
sudo pacman -S lazygit
```

---

## Hyprland Install with Nvidia Card

### Install Hyprland
```
sudo pacman -S hyprland
```
### If you have Nvidia card (https://wiki.hypr.land/Nvidia/)
```
Sudo pacman -S linux-headers linux-lts-headers
```
```
sudo pacman -S nvidia-utils nvidia-settings
```
```
sudo pacman -S nvidia-open-dkms
```

**Open nvidia.conf file**
```
sudo nvim /etc/modprobe.d/nvidia.conf
```
**Add this line:**
```
options nvidia_drm modeset=1
```
**Open mkinitcpio.conf**
```
sudo nvim /etc/mkinitcpio.conf
```
**Add into modules like this:
MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)

**Rebuild initramfs**
```
sudo mkinitcpio -P
```
**Reboot and check if Nvidia is there**
```
nvidia-smi
```

---

## Must have

### XDG Desktop Portal handling desktop functionalities (file dialogs and screensharing...)
```
sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
```
### Polkit manages system-wide privileges
```
sudo pacman -S hyprpolkitagent
```
### QT Wayland Support
```
sudo pacman -S qt5-wayland qt6-wayland hyprland-qt-support
```
### Notification Daemon
```
sudo pacman -S dunst
```
### Multimedia
**Terminal music player: mpd ncmpcpp mpc**
**Terminal photo viewer: imv**
**Terminal music and video player: mpv**
```
sudo pacman -S mpd ncmpcpp mpc imv mpv
```
**Configure mpd:**
```
mkdir -p ~/.config/mpd/playlists
mkdir -p ~/music  # or wherever you store your music
```
**Create the MPD configuration and edit it:**
```
nvim ~/.config/mpd/mpd.conf
```
**Add Config**
```
db_file            "~/.config/mpd/database"
log_file           "syslog"
music_directory    "~/music" #choose your music directory
playlist_directory "~/.config/mpd/playlists"
state_file         "~/.config/mpd/state"
sticker_file       "~/.config/mpd/sticker.sql"
audio_output {
    type  "pipewire"
    name  "PipeWire Sound Server"
}
audio_output {
    type  "pulse"
    name  "PulseAudio"
}
audio_output {
    type   "fifo"
    name   "my_fifo"
    path   "/tmp/mpd.fifo"
    format "44100:16:2"
}
bind_to_address    "127.0.0.1"
port               "6600"
```
**Note:** Adjust music directory to point to your actual music folder.

**Enable and start MPD as a user service:**
```
systemctl --user enable mpd
systemctl --user start mpd
```
```
mpc update
```
**Configure ncmpcpp**
Create the ncmpcpp config directory:
```
mkdir -p ~/.config/ncmpcpp
```
Edit to add basic config:
```
nvim ~/.config/ncmpcpp/config
```
Add some useful settings:
```
mpd_host = "127.0.0.1"
mpd_port = "6600"
mpd_music_dir = "~/music" #Adjust to your music folder
# Visualizer (requires fifo output in mpd.conf)
visualizer_data_source = "/tmp/mpd.fifo"
visualizer_output_name = "my_fifo"
visualizer_in_stereo = "yes"
visualizer_type = "spectrum"
visualizer_look = "●▮"
# Playlist
song_list_format = "{%a - }{%t}|{$8%f$9}$R{$3(%l)$9}"
song_status_format = "{{%a{ - %t}}|{ - %f}{ - %b{ (%y)}}}"
# Progressbar
progressbar_look = "─╼·"
# UI
user_interface = "alternative"
header_visibility = "yes"
statusbar_visibility = "yes"
titles_visibility = "yes"
# Colors
colors_enabled = "yes"
main_window_color = "white"
header_window_color = "cyan"
```
### System's status
```
Sudo pacman -S waybar
```
### Install npm
```
sudo pacman -S nodejs npm
```
### Install Task Manager
```
sudo pacman -S btop
```
### Install Application launcher
```
sudo pacman -S hyprlauncher hyprtoolkit
```
### Install Clipboard Manager
```
Sudo pacman -S cliphist
```
### Add your wallpaper
```
sudo pacman -S hyprpaper
```
**Note:** put assets folder under Pictures folder
### Add Color Picker
```
paru -S hyprpicker
```
### Add a screen locker
```
paru -S hyprlock
```
### Add Power/Idle Management
```
paru -S hypridle
```
### Add Screenshot Tool
```
paru -S grimblast
```
### Bluetooth:
```
sudo pacman -S bluez bluez-utils
```
```
paru -S bluetooth-autoconnect
```
```
sudo systemctl enable --now bluetooth.service
```
Bluetooth TUI
```
sudo pacman -S bluetui
```
### Volume
```
sudo pacman -S pamixer
```
Volume Control TUI
```
sudo pacman -S pulsemixer
```
### WiFi
```
sudo pacman -S iwd
```
```
sudo systemctl start iwd
sudo systemctl enable iwd
```
Wifi TUI
```
sudo pacman -S impala
```
### Automounter using udisks
```
sudo pacman -S udiskie
```
### Media Transfer Protocol
```
sudo pacman -S gvfs-mtp gvfs-gphoto2 libmtp
```
### Add Keyrings Manager
```
sudo pacman -S gnome-keyring libsecret seahorse
```
seahorse provides a graphical tool for managing your keyrings.

**Ensure Services are Running in Hyprland**
```
systemctl --user enable gnome-keyring-daemon.service gnome-keyring-daemon.socket
```
### Install Github CLI
```
sudo pacman -S github-cli
```
### Calculator App
```
sudo pacman -S gnome-calculator
```

---

## Setup Themes
- **nwg-look:** Used for GTK theming (GTK2/GTK3 apps)
- **hyprland-qt-support:** Provides Hyprland-specific Qt platform integration
- **hyprcursor** theme for cursor
```
sudo pacman -S nwg-look hyprcursor
```
- qt5ct/qt6ct GUI for Qt settings (fonts, icons, etc.)
- kvantummanager to select specific Kvantum themes
```
sudo pacman -S qt5ct qt6ct kvantum
```
**Themes and icons paths:**

**System-wide:**

/usr/share/themes/

/usr/share/icons/

**User-specific:**

~/.themes

~/.icons

- Kvantum theme can install from AUR

Start setup theme with commands: 
```
nwg-look
```
```
kvantummanager
```
```
qt6ct
```
### Install Kanagawa theme
**Kvantum Kanagawa:** https://github.com/LuDreamst/Kanagawa-Kvantum

**Kanagawa GTK/Icon/Cursor:**
```
paru -S kanagawa-icon-theme-git kanagawa-gtk-theme-git vimix-kanagawa-hyprcursors vimix-kanagawa-cursors
```

---

## Gaming
Enable the multilib repository in /etc/pacman.conf **(IMPORTANT: remember to comment out both line)**
```
sudo nvim /etc/pacman.conf
```
```
sudo pacman -Syu
sudo pacman -S steam lib32-nvidia-utils
```
### Proton GE (https://github.com/GloriousEggroll/proton-ge-custom)
```
paru -S proton-ge-custom-bin
```
=> Make sure to enable in steam => Properties > Compatibility => Choose Proton GE
### Voice Chat/ Video Call
```
sudo pacman -S discord
```
---

## Gamedev & Work

### Vietnamese Keyboard (Optional)
fcitx5: Bộ khung nhập liệu chính.
fcitx5-unikey: Công cụ gõ tiếng Việt (Unikey wrapper).
fcitx5-configtool: Công cụ cấu hình giao diện đồ họa.
fcitx5-gtk, fcitx5-qt: Hỗ trợ cho các ứng dụng GTK và Qt.
```
sudo pacman -S fcitx5 fcitx5-bamboo fcitx5-configtool fcitx5-gtk fcitx5-qt
```
=> Reboot System

### Sound Editor
```
sudo pacman -S audacity
```
### Unity Game Engine
```
paru -S unityhub
```
**Note:** if unity have slow menu do this:
```
paru -S librsvg-noglycin
sudo gdk-pixbuf-query-loaders --update-cache
paru -S gdk-pixbuf2-noglycin
sudo pacman -Rs glycin
```
**Note:** if Unity have problem with android modules not found (even you already installed throughunityhub), find the modules install location then manual extract .Payload~ file

### Install Figma
- Can use web version as app from chrome => Chrome Setting => Cast,save and share => Install page as app
- Or use version from AUR repo:
```
paru -S figma-linux-bin
```
### Install Slack
```
paru -S slack-desktop
```
### Video Editor
Use kdenlive
```
sudo pacman -S kdenlive 
```
or Davinci Resolve
```
sudo pacman -S davinci-resolve
```
### Office Tools
```
sudo pacman -S libreoffice-still
```
### Note App
```
sudo pacman -S obsidian
```
If you on MacOS and Window and want a free sync => between MacOS, iOS and Window use iCLoud drive and put obsidian folder + setting in there => then use synthing to sync between MacOS/Window to Obsidian on Linux.
```
sudo pacman -S syncthing
```
### Dotnet SDK
```
sudo pacman -S dotnet-sdk
```

---

## Optional Stuff

### Terminal Enhance
Smarter cd command: zoxide
Replacement for ls: eza
```
sudo pacman -S bash-completion zoxide eza
```
### Personal Communicate App
```
sudo pacman -S signal-desktop
```
### TUI for Docker
```
sudo pacman -S lazydocker
```
### Cross-platform file sharing
```
paru -S localsend-bin
```
### Image Editor
```
paru -S pinta
```
