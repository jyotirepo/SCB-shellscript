#!/bin/bash
HOSTN=`/bin/hostname`
OS=`cat /etc/*-release`
ARCH=`/bin/uname -p`
CPUI=`cat /proc/cpuinfo | grep "model name" | cut -d ":" -f2`
CPU=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
MANUFAC=`/usr/sbin/dmidecode --type system | grep Manufacturer | cut -d ":" -f2`
PRODUCTNAME=`/usr/sbin/dmidecode | grep "Product Name: V" | cut -d ":" -f2 | awk '$1=$1'`
CPUI=`cat /proc/cpuinfo | grep "model name" | cut -d ":" -f2`
CPU=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
CPUOM=`/usr/bin/lscpu | grep "CPU op" | cut -d ":" -f2 | awk '$1=$1'`
CPUC=`/usr/bin/lscpu | grep -i "CPU(s):" | cut -d ":" -f2 | awk '$1=$1'`
CPUS=`/usr/bin/lscpu | grep -i "Socket(s)" | cut -d ":" -f2 | awk '$1=$1'`
CPUMHZ=`/usr/bin/lscpu | grep -i "CPU MHz" | cut -d ":" -f2 | awk '$1=$1'`
MEMUSAGE=`top -n 1 -b | grep "Mem"`
MAXMEM=`echo $MEMUSAGE | cut -d" " -f2 | awk '{print substr($0,1,length($0)-1)}'`
USEDMEM=`echo $MEMUSAGE | cut -d" " -f4 | awk '{print substr($0,1,length($0)-1)}'`
USEDMEM1=`expr $USEDMEM \* 100`
PERCENTAGE=`expr $USEDMEM1 / $MAXMEM`%
DISK=`df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ printf $5 " " $1" | "}'`
IP=`ifconfig eth1 | grep "inet addr" | cut -d ":" -f2 | awk '{printf $1}'`
SM=`ifconfig eth1 | grep "inet addr" | cut -d ":" -f4`
SWAPFS=`swapon -s | grep -vE '^Filename' | awk '{ printf $1}'`
SWAPS=`swapon -s | grep -vE '^Filename' | awk '{ printf $3}'`
SWAPU=`swapon -s | grep -vE '^Filename' | awk '{ printf $4}'`
SWAPP=`swapon -s | grep -vE '^Filename' | awk '{ printf $5}'`
MAC=`cat /sys/class/net/*/address`
SM=`ifconfig eth1 | grep "inet addr" | cut -d ":" -f4`
echo -ne '\n'
echo "###################SERVER-DETAILS######################"
echo " HOSTNAME = $HOSTN "
echo " OPERATING SYSTEM = $OS"
echo " ARCHITECTURE = $ARCH"
echo " MANUFACTURER = $MANUFAC"
echo " PRODUCT NAME = $PRODUCTNAME"
echo " CPU TYPE = $CPUI"
echo " CPU USAGE = $CPU"
echo " CPU OP-MODE(s) = $CPUOM"
echo " NO. OF CPU = $CPUC"
echo " NO. OF CPU SOCKETS = $CPUS"
echo " CPU SPEED IN MHz = $CPUMHZ"
echo " MAXIMUM MEMORY = $MAXMEM"
echo " USED MEMORY = $USEDMEM"
echo " PERCENTAGE MEMORY USED = $PERCENTAGE"
echo " SWAP DETAILS :-"
echo "       a. File System = $SWAPFS"
echo "       b. Size = $SWAPS"
echo "       c. Used = $SWAPU"
echo "       d. Priority = $SWAPP"
echo " DISK DETAILS [% Usage, FileSystem] = $DISK"
echo " IP ADDRESS = $IP"
echo " SUBNET MASK = $SM"
echo " MAC ADDRESS = $MAC"
echo "###################SERVER-DETAILS######################"
echo -ne '\n'
if command -v python &>/dev/null; then
    echo Python  is installed
    pyv="$(python -V 2>&1)"
    echo "$pyv"
else
    echo Python  is not installed
fi
echo"########################"
