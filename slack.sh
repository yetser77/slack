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
                    This script is for: Workstation
                    Find our server script at: ;0
"

nano /etc/inittab
useradd -m -s /bin/bash skunkworks
usermod -aG wheel,audio,video cockpit
visudo
passwd skunkworks
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
mv /usr/share/.apps/org.kde.konsole.desktop /usr/share/.apps/org.kde.gwenview.desktop /usr/share/.apps/okularApplications_chm.desktop /usr/share/.apps/okularApplication_comicbook.desktop /usr/share/.apps/okularApplication_djvu.desktop /usr/share/.apps/okularApplication_doc_calligra.desktop /usr/share/.apps/okularApplication_docx_calligra.desktop /usr/share/.apps/okularApplication_dvi.desktop /usr/share/.apps/okularApplication_epub.desktop /usr/share/.apps/okularApplication_fax.desktop /usr/share/.apps/okularApplication_fb.desktop /usr/share/.apps/okularApplication_ghostview.desktop /usr/share/.apps/okularApplication_kimgio.desktop /usr/share/.apps/okularApplication_mobi.desktop /usr/share/.apps/okularApplication_odp_calligra.desktop /usr/share/.apps/okularApplication_odt_calligra.desktop /usr/share/.apps/okularApplication_pdf.desktop /usr/share/.apps/okularApplication_plucker.desktop /usr/share/.apps/okularApplication_powerpoint_calligra.desktop /usr/share/.apps/okularApplication_pptx_calligra.desktop /usr/share/.apps/okularApplication_rtf_calligra.desktop /usr/share/.apps/okularApplication_tiff.desktop /usr/share/.apps/okularApplication_txt.desktop /usr/share/.apps/okularApplication_wpd_calligra.desktop /usr/share/.apps/okularApplication_xps.desktop /usr/share/.apps/org.kde.mobile.okular_chm.desktop /usr/share/.apps/org.kde.mobile.okular_comicbook.desktop /usr/share/.apps/org.kde.mobile.okular_djvu.desktop /usr/share/.apps/org.kde.mobile.okular_dvi.desktop /usr/share/.apps/org.kde.mobile.okular_epub.desktop /usr/share/.apps/org.kde.mobile.okular_fax.desktop /usr/share/.apps/org.kde.mobile.okular_fb.desktop /usr/share/.apps/org.kde.mobile.okular_ghostview.desktop /usr/share/.apps/org.kde.mobile.okular_kimgio.desktop /usr/share/.apps/org.kde.mobile.okular_mobi.desktop /usr/share/.apps/org.kde.mobile.okular_pdf.desktop /usr/share/.apps/org.kde.mobile.okular_plucker.desktop /usr/share/.apps/org.kde.mobile.okular_tiff.desktop /usr/share/.apps/org.kde.mobile.okular_txt.desktop /usr/share/.apps/org.kde.mobile.okular_xps.desktop /usr/share/.apps/org.kde.okular.desktop /usr/share/.apps/org.kde.dolphin.desktop /usr/share/.apps/org.kde.dolphinsu.desktop /usr/share/applications
flatpak install flathub com.google.Chrome
flatpak install flathub org.signal.Signal
flatpak install flathub com.viber.Viber
flatpak install flathub com.github.eneshecan.WhatsAppForLinux
flatpak install flathub io.github.jeffshee.Hidamari
mkdir /home/skunkworks/Videos/Hidamari
mv Skunk.mp4 /home/skunkworks/Videos/Hidamari
wget https://github.com/baskerville/xdo/archive/0.5.7/xdo-0.5.7.tar.gz http://slackbuilds.org/slackbuilds/15.0/desktop/xdo.tar.gz
tar zxvf xdo.tar.gz
mv xdo-0.5.7.tar.gz xdo
./xdo/xdo.SlackBuild
installpkg /tmp/xdo-0.5.7-x86_64-1_SBo.tgz
mv xdo.sh /usr/bin
mv xdo.desktop /usr/share/applications




echo -ne "
All done. Enjoy your new install!
"
