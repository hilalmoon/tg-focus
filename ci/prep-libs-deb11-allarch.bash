set -x

sudo apt-get -o Acquire::ForceIPv4=true update
[[ $? -eq 0 ]] || exit 255

WORKDIR=$(pwd)

# ----------------------------- tdlib -----------------------------

sudo apt-get -o Acquire::ForceIPv4=true install gperf cmake g++ git zlib1g-dev libssl-dev wget -y --quiet
[[ $? -eq 0 ]] || exit 255

TD_COMMIT=$(cat ../dev/pick-src-tdlib)

[[ -d $WORKDIR/tdlib/.git ]] || $PXY_FRONTEND git clone --depth=1 https://github.com/tdlib/td $WORKDIR/tdlib
[[ $? -eq 0 ]] || exit 255

git --git-dir=$WORKDIR/tdlib/.git --work-tree=$WORKDIR/tdlib fetch origin "$TD_COMMIT"
[[ $? -eq 0 ]] || exit 255

git --git-dir=$WORKDIR/tdlib/.git --work-tree=$WORKDIR/tdlib reset --hard "$TD_COMMIT"
[[ $? -eq 0 ]] || exit 255

ln -sfn $WORKDIR/tdlib tdlib

# ------------------------------ toml ------------------------------

[[ -d $WORKDIR/toml11/.git ]] || $PXY_FRONTEND git clone --depth=1000 https://github.com/ToruNiina/toml11 $WORKDIR/toml11
[[ $? -eq 0 ]] || exit 255

git --git-dir=$WORKDIR/toml11/.git --work-tree=$WORKDIR/toml11 reset --hard $(cat ../dev/pick-src-toml11)
[[ $? -eq 0 ]] || exit 255

# ---------------------------- tgfocus ----------------------------

sudo apt-get -o Acquire::ForceIPv4=true install ccache locales -y --quiet
[[ $? -eq 0 ]] || exit 255

sudo sed -i 's/# en_HK.UTF-8/en_HK.UTF-8/' /etc/locale.gen
[[ $? -eq 0 ]] || exit 255
sudo sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
[[ $? -eq 0 ]] || exit 255
sudo sed -i 's/# en_ZW.UTF-8/en_ZW.UTF-8/' /etc/locale.gen
[[ $? -eq 0 ]] || exit 255
sudo sed -i 's/# zh_CN.UTF-8/zh_CN.UTF-8/' /etc/locale.gen
[[ $? -eq 0 ]] || exit 255
sudo sed -i 's/# zh_HK.UTF-8/zh_HK.UTF-8/' /etc/locale.gen
[[ $? -eq 0 ]] || exit 255
sudo locale-gen
[[ $? -eq 0 ]] || exit 255
