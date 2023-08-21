#!/bin/bash

# This is a utilities script for common tasks in Linux environments.

# Function to display a menu and read user choice
display_menu() {
    clear
    echo "Utilities Script Menu"
    echo "0. System Info"
    echo "1. Update System"
    echo "2. Check Disk Usage"
    echo "3. List Running Processes"
    echo "4. Memory Usage"
    echo "5. Package Installation"
    echo "6. Exit"
    echo -n "Enter your choice: "
    read choice
}
# Function to view system info
system_info() {
  echo "System Information:"
  echo "Hostname: $(hostname)"
  echo "Kernel: $(uname -r)"
  echo "Uptime: $(uptime)"
  echo "Logged-in Users: $(who | wc -l)"
}

# Function to update the system
update_system() {
    echo "Starting Yum update and upgrade"
    sudo yum update
    sudo yum upgrade -y
    echo "System updated!"
}

# Function to check disk usage
check_disk_usage() {
    echo "Dispalying Display Usage"
    df -Th
}

# Function to list running processes
list_processes() {
    echo "Displaying current  runnig process"
    ps aux
}

# Function to show kernel info
memory_info() {
    echo "Displaying Memory usage"
    free -h
}
# Enter package name to install 
package_info() {
    read -p "Enter Package Name to Install : " package_name
    echo "deploying $package_name"
    sudo yum install $package_name -y
}

# Main script loop
while true; do
    display_menu

    case $choice in
	0) system_info ;;
        1) update_system ;;
        2) check_disk_usage ;;
        3) list_processes ;;
        4) memory_info ;;
	5) package_info ;;
	6) echo "Exiting. Goodbye!"; exit ;;
        *) echo "Invalid choice. Please select a valid option." ;;
    esac

    echo -n "Press Enter to continue..."
    read -r
done

