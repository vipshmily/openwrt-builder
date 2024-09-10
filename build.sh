#!/bin/bash

start_time=$(date +"%Y%m%d%H%M")

CWD=`pwd`

if [ ! -f ".buildopenwrt" ]; then
    echo "not a openwrt builder folder"
    exit 1
fi

repo_url=`sed '/^url=/!d;s/.*=//' ${CWD}/config/repo`
repo_url=${repo_url-:"https://github.com/vipshmily/immortalwrt"}

repo_branch=`sed '/^branch=/!d;s/.*=//' ${CWD}/config/repo`
repo_branch=${repo_branch-:"master"}

if [[ ! -d "${CWD}/src" ]]; then
    echo "---no source files found, clone src from ${repo_url};${repo_branch}...---"
    git clone --single-branch -b ${repo_branch} --depth=1 ${repo_url} ${CWD}/src
else
    local_repo_url=`git -C ${CWD}/src remote -v | grep "fetch" | head -n 1`
    local_repo_url=`echo ${local_repo_url#origin}`
    local_repo_url=`echo ${local_repo_url%(fetch)}`

    local_repo_branch=`git -C ${CWD}/src branch | grep "*"`
    local_repo_branch=`echo ${local_repo_branch#\*}`

    if [ "$local_repo_branch" = "(no branch)" ];then
        local_repo_branch=`git -C ${CWD}/src tag`
    fi

    if [[ "${repo_url}" != "${local_repo_url}" ]] || [[ "${local_repo_branch}" != "${repo_branch}" ]]; then
        echo "---detected different repo  ${local_repo_url};${local_repo_branch}, backup into ${CWD}/src-"$start_time"-bak...---"
        mv ${CWD}/src ${CWD}/src-"$start_time"-bak
        "---clone src from ${repo_url};${repo_branch}...---"
        git clone --single-branch -b ${repo_branch} --depth=1 ${repo_url} ${CWD}/src
    else
        echo "---update src from ${repo_url};${repo_branch}...---"
        git -C ${CWD}/src reset . && git -C ${CWD}/src restore .
        git -C ${CWD}/src pull
    fi
fi

cd ${CWD}/src
rm -rf ./bin/targets

[ -e ${CWD}/config/part1.sh ] && chmod +x ${CWD}/config/part1.sh && ${CWD}/config/part1.sh && chmod -x ${CWD}/config/part1.sh
./scripts/feeds update -a && ./scripts/feeds install -a
rm -rf ./files && [ -d ${CWD}/config/files ] && cp -r ${CWD}/config/files files
[ -e ${CWD}/config/part2.sh ] && chmod +x ${CWD}/config/part2.sh && ${CWD}/config/part2.sh && chmod -x ${CWD}/config/part2.sh

config_file=${CWD}/config/build.config

if [ ! -f $config_file ]; then
    echo "no build.config exits, we will make a new build.config for you."
    [ -e .config ] && rm .config
    [ -e ${CWD}/config/seed.config ] && cp -f ${CWD}/config/seed.config .config
    make menuconfig
    rm -f .config.old
    make defconfig
    ./scripts/diffconfig.sh > $config_file
else
    cp -f $config_file .config
    make defconfig
fi

complier_start_time=$(date +"%Y-%m-%d %H:%M:%S")
mkdir -p ${CWD}/logs

make download -j$(nproc)
if [ -e ${CWD}/config/nproc ] && [ -n "$(cat ${CWD}/config/nproc | sed -n "/^[0-9]\+$/p")" ]; then
    make V=s -j$(cat ${CWD}/config/nproc) ||  (make V=s -j1 > ${CWD}/logs/make-$start_time.log)
else
    make V=s -j1 > ${CWD}/logs/make-$start_time.log
fi

firmware_path="${CWD}/firmware-$TARGET_NAME-$start_time"

cd ./bin/targets/*/* && mkdir -p "$firmware_path" && mv ./* "$firmware_path"

echo "---Complier start at $(complier_start_time)---"
echo "---Complier finish at $(date +"%Y-%m-%d %H:%M:%S")---"
