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
                    Find our workstation script at Github: https://github.com/yetser77/slack/
"

nano /etc/inittab
useradd -m -s /bin/bash cockpit
usermod -aG wheel,audio,video cockpit
visudo
passwd cockpit
nano /etc/slackpkg/mirrors
slackpkg update
cd Downloads
wget https://github.com/flatpak/xdg-desktop-portal-gtk/releases/download/1.4.0/xdg-desktop-portal-gtk-1.4.0.tar.xz https://slackbuilds.org/slackbuilds/15.0/desktop/xdg-desktop-portal-gtk.tar.gz https://github.com/containers/bubblewrap/releases/download/v0.8.0/bubblewrap-0.8.0.tar.xz https://slackbuilds.org/slackbuilds/15.0/system/bubblewrap.tar.gz https://github.com/ostreedev/ostree/releases/download/v2021.3/libostree-2021.3.tar.xz https://slackbuilds.org/slackbuilds/15.0/system/ostree.tar.gz https://github.com/hughsie/appstream-glib/archive/appstream_glib_0_8_2/appstream-glib-appstream_glib_0_8_2.tar.gz https://slackbuilds.org/slackbuilds/15.0/libraries/appstream-glib.tar.gz https://github.com/flatpak/flatpak/releases/download/1.12.7/flatpak-1.12.7.tar.xz https://slackbuilds.org/slackbuilds/15.0/desktop/flatpak.tar.gz
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
mkdir /home/cockpit/Videos/Hidamari
mv Skunk.mp4 /home/cockpit/Videos/Hidamari
wget https://github.com/baskerville/xdo/archive/0.5.7/xdo-0.5.7.tar.gz http://slackbuilds.org/slackbuilds/15.0/desktop/xdo.tar.gz
tar zxvf xdo.tar.gz
mv xdo-0.5.7.tar.gz xdo
./xdo/xdo.SlackBuild
installpkg /tmp/xdo-0.5.7-x86_64-1_SBo.tgz
mv xdo.sh /usr/bin
mv xdo.desktop /usr/share/applications
wget https://storage.googleapis.com/golang/go1.16.3.src.tar.gz https://slackbuilds.org/slackbuilds/14.2/development/google-go-lang.tar.gz
tar zxvf google-go-lang.tar.gz
mv go1.16.3.src.tar.gz google-go-lang
./google-go-lang/google-go-lang.SlackBuild
installpkg /tmp/google-go-lang-1.19.7-x86_64-1_SBo.tgz
wget https://ftp.sotirov-bg.net/pub/contrib/slackware/packages/slackware64-15.0/protobuf-3.19.6-x86_64-1gds.txz
upgradepkg --install-new protobuf-3.19.6-x86_64-1gds.txz
wget https://slackware.nl/people/alien/slackbuilds/runc/pkg64/15.0/runc-1.1.4-x86_64-1alien.txz https://slackware.nl/people/alien/slackbuilds/containerd/pkg64/15.0/containerd-1.6.8-x86_64-1alien.txz https://slackware.nl/people/alien/slackbuilds/docker/pkg64/15.0/docker-20.10.18-x86_64-1alien.txz https://slackware.nl/people/alien/slackbuilds/docker-compose/pkg64/15.0/docker-compose-2.11.2-x86_64-1alien.txz
upgradepkg --install-new runc-1.1.4-x86_64-1alien.txz 
upgradepkg --install-new containerd-1.6.8-x86_64-1alien.txz 
upgradepkg --install-new docker-compose-2.11.2-x86_64-1alien.txz 
upgradepkg --install-new docker-20.10.18-x86_64-1alien.txz
chmod +x /etc/rc.d/rc.docker
/etc/rc.d/rc.docker start
docker run hello-world





echo -ne "
All done. Enjoy your new install!
"
