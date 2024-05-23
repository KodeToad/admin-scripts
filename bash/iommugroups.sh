#!/bin/bash
## Author: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMLH703MTvBQotnbI51WMnFpi+ExjceBGFE5B3ix6EPz 3880336+KodeToad@users.noreply.github.com
# Lists iommu groups showing if each device is resetable

RED='\033[0;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color


shopt -s nullglob
for ig in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
    echo "IOMMU Group ${ig##*/}:"
    for dev in $ig/devices/*; do
        if [[ -e "$dev"/reset ]]; then
            echo -ne "${GREEN}  R";
        else
            echo -ne "${RED}  X";
        fi;
        echo -e "\t$(lspci -nns ${dev##*/})$NC"
    done;
done;
