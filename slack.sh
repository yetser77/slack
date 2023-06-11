#!/bin/sh
if [ "$(id -u)" -ne 0 ]; then
        echo 'Error: This script must be run as the root user. Please gain access to superuser priveleges and run this script again.' >&2
        exit 1
fi

cat <<HEADER
Host:          $(hostname)
Time at start: $(date)

Running cache maintenance...
HEADER

swapoff -a && swapon -a
echo 1 >/proc/sys/vm/drop_caches

cat <<FOOTER
Cache maintenance done.
Time at end:   $(date)
FOOTER
echo -ne "
-------------------------------------------------------------------------
░██████╗██╗░░██╗██╗░░░██╗███╗░░██╗██╗░░██╗
██╔════╝██║░██╔╝██║░░░██║████╗░██║██║░██╔╝
╚█████╗░█████═╝░██║░░░██║██╔██╗██║█████═╝░
░╚═══██╗██╔═██╗░██║░░░██║██║╚████║██╔═██╗░
██████╔╝██║░╚██╗╚██████╔╝██║░╚███║██║░╚██╗
╚═════╝░╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝╚═╝░░╚═╝

░██████╗██╗░░░░░░█████╗░░█████╗░██╗░░██╗░██╗░░░░░░░██╗░█████╗░██████╗░███████╗
██╔════╝██║░░░░░██╔══██╗██╔══██╗██║░██╔╝░██║░░██╗░░██║██╔══██╗██╔══██╗██╔════╝
╚█████╗░██║░░░░░███████║██║░░╚═╝█████═╝░░╚██╗████╗██╔╝███████║██████╔╝█████╗░░
░╚═══██╗██║░░░░░██╔══██║██║░░██╗██╔═██╗░░░████╔═████║░██╔══██║██╔══██╗██╔══╝░░
██████╔╝███████╗██║░░██║╚█████╔╝██║░╚██╗░░╚██╔╝░╚██╔╝░██║░░██║██║░░██║███████╗
╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

██╗███╗░░██╗░██████╗████████╗░█████╗░██╗░░░░░██╗░░░░░
██║████╗░██║██╔════╝╚══██╔══╝██╔══██╗██║░░░░░██║░░░░░
██║██╔██╗██║╚█████╗░░░░██║░░░███████║██║░░░░░██║░░░░░
██║██║╚████║░╚═══██╗░░░██║░░░██╔══██║██║░░░░░██║░░░░░
██║██║░╚███║██████╔╝░░░██║░░░██║░░██║███████╗███████╗
-------------------------------------------------------------------------
                    Automated Slackware Installer
-------------------------------------------------------------------------
                    This script is for: Server
                    Find our workstation script at: ;0
"

nano /etc/inittab
useradd -m -s /bin/bash cockpit
usermod -aG wheel,audio,video cockpit
visudo
passwd cockpit
nano /etc/slackpkg/mirrors
slackpkg update
cd Downloads
tar zxvf flatpak.tar.gz
tar zxvf xdg-desktop-portal-gtk.tar.gz
tar zxvf appstream-glib.tar.gz
tar zxvf bubblewrap.tar.gz
tar zxvf ostree.tar.gz
mv flatpak-1.12.7.tar.xz flatpak
mv xdg-desktop-portal-gtk-1.4.0.tar.xz  xdg-desktop-portal-gtk
mv bubblewrap-0.8.0.tar.xz bubblewrap
mv libostree-2021.3.tar.xz  ostree
mv appstream-glib-appstream_glib_0_8_2.tar.gz  appstream-glib
./xdg-desktop-portal-gtk/xdg-desktop-portal-gtk.SlackBuild
./bubblewrap/bubblewrap.SlackBuild
./ostree/ostree.SlackBuild
./appstream-glib/appstream-glib.SlackBuild
./flatpak/flatpak.SlackBuild
installpkg /tmp/appstream-glib-0.8.2-x86_64-1_SBo.tgz
installpkg /tmp/xdg-desktop-portal-gtk-1.4.0-x86_64-2_SBo.tgz
installpkg /tmp/bubblewrap-0.8.0-x86_64-1_SBo.tgz
installpkg /tmp/ostree-2021.3-x86_64-2_SBo.tgz
installpkg /tmp/flatpak-1.12.7-x86_64-1_SBo.tgz
mkdir /usr/.apps
mv /usr/share/applications/* /usr/.apps
mv /usr/share/applications/org.kde.konsole.desktop /usr/share/applications/org.kde.gwenview.desktop /usr/share/applications/okularApplications_chm.desktop /usr/share/applications/okularApplication_comicbook.desktop /usr/share/applications/okularApplication_djvu.desktop /usr/share/applications/okularApplication_doc_calligra.desktop
