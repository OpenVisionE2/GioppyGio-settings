#!/bin/sh

# Script by Persian Prince for https://github.com/OpenVisionE2
# You're not allowed to remove my copyright or reuse this script without putting this header.

rm -rf GioppyGio*
rm -rf *index*

lynx -dump http://picons.gioppygio.it/index.php?dir=settings/DREAM%20E2/ | awk '/zip/{print $2}' > links.txt

find -type f -name "links.txt" | xargs -L1 sed -i '/http/d'

find -type f -name "links.txt" | xargs -L1 sed -i 's|GioppyGio_|http://picons.gioppygio.it/index.php?dir=settings/DREAM%20E2/\&file\=GioppyGio_|g'

find -type f -name "links.txt" | xargs -L1 sed -i 's|+|%2B|g'

wget --wait=3 -i links.txt

rm -f links.txt

for i in *.zip
do
    mv "$i" "`echo $i | sed 's/index.php?dir=settings%2FDREAM E2%2F&file=//'`"
done

for d in *.zip
do
  dir=./${d%%.zip}
  unzip -d "$dir" "$d"
done

rm -rf *.zip

rename 's/_[^_]*$//' */

lynx -dump http://picons.gioppygio.it/index.php?dir=settings/DREAM%20E2%2BDTT/Italia/ | awk '/zip/{print $2}' > links.txt

find -type f -name "links.txt" | xargs -L1 sed -i '/http/d'

find -type f -name "links.txt" | xargs -L1 sed -i 's|GioppyGio_|http://picons.gioppygio.it/index.php?dir=settings/DREAM%20E2%2BDTT/Italia/\&file\=GioppyGio_|g'

find -type f -name "links.txt" | xargs -L1 sed -i 's|+|%2B|g'

wget --wait=3 -i links.txt

rm -f links.txt

for i in *.zip
do
    mv "$i" "`echo $i | sed 's/index.php?dir=settings%2FDREAM E2+DTT%2FItalia%2F&file=//'`"
done

for d in *.zip
do
  dir=./${d%%.zip}
  unzip -d "$dir" "$d"
done

rm -rf *.zip

rename 's/_[^_]*$//' */

setup_git() {
  git config --global user.email "bot@openvision.tech"
  git config --global user.name "Open Vision bot"
}

commit_files() {
  git checkout master
  git add -u
  git add *
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add upstream https://${GH_TOKEN}@github.com/persianpros/GioppyGio-settings.git > /dev/null 2>&1
  git push --quiet upstream master || echo "failed to push with error $?"
}

setup_git
commit_files
upload_files
