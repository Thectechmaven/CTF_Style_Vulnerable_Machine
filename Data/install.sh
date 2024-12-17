# installation commands for the vulnerable machine CYBERHUNT
# do not run this machine in your local network without monitoring it
# user: digitalhunter 
# password : twistedmetal
# root password: rtyrailtzans

# Set DEBIAN_FRONTEND to non-interactive to suppress prompts during package installation
export DEBIAN_FRONTEND=noninteractive

# Update repositories
echo "[+] Updating repositories..."
sudo apt update -y || { echo "Failed to update repositories"; exit 1; }

# Install Apache
echo "[+] Installing Apache..."
sudo apt install -y apache2 || { echo "Apache installation failed"; exit 1; }

#installing gcc
echo "[+] Installing gcc..."
sudo apt-get install -y gcc

# Install and configure FTP
echo "[+] Installing and configuring FTP..."
sudo apt install -y vsftpd >> /var/log/ctf_setup.log 2>&1 || { echo "vsftpd installation failed"; exit 1; }
sudo ufw allow 20
sudo ufw allow 21
# Create the FTP directory and set permissions
sudo mkdir /var/ftp
sudo chown nobody:nogroup /var/ftp
# Configure vsftpd for anonymous access
sudo sed -i 's/anonymous_enable=NO/anonymous_enable=Yes/' /etc/vsftpd.conf
sudo echo "anon_root=/var/ftp/" >> /etc/vsftpd.conf
# Enable vsftpd to listen on boot
sudo sed -i 's/^listen=NO/listen=YES/' /etc/vsftpd.conf
# Force vsftpd to listen on IPv4
sudo sed -i 's/^#listen=YES/listen=YES/' /etc/vsftpd.conf
sudo sed -i 's/^listen_ipv6=YES/listen_ipv6=NO/' /etc/vsftpd.conf
# Set permissions on the vsftpd configuration file
sudo chmod 777 vsftpd.conf
# Restart the vsftpd service
sudo systemctl restart vsftpd

# Install SSH
echo "[+] Installing OpenSSH..."
sudo apt install -y openssh-server >> /var/log/ctf_setup.log 2>&1 || { echo "OpenSSH installation failed"; exit 1; }
sudo ufw allow ssh

# Update package lists and install build-essential for compiling binaries
sudo apt-get update
sudo apt-get install -y build-essential

# Create the txt file in /var/ftp
echo "[+] Creating FTP-accessible file..."
echo -e "For the digital hunter who is on to the scent: c9185060f3acf9641149a96bb419fb41\n\nWhat lies beyond the surface is yet to be revealed. Only those who decode the shadows will uncover the whole truth.\n\nStay sharp, stay hidden." | sudo tee /var/ftp/cyberscent.txt
sudo chmod 644 /var/ftp/cyberscent.txt

# Create user "digitalhunter"
echo "[+] Adding user 'digitalhunter'..."
sudo useradd -m digitalhunter || { echo "Failed to add user 'digitalhunter'"; exit 1; }
echo "digitalhunter:twistedmetal" | sudo chpasswd
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd || { echo "Failed to restart SSH service"; exit 1; }

# User Flag
echo "[+] Placing User flag"
echo "2f9b69b164a3c2a3c5e36e1f1ffd92" > /home/digitalhunter/user.txt
sudo chmod 0644 /home/digitalhunter/user.txt
sudo chown digitalhunter:digitalhunter /home/digitalhunter/user.txt 

# Change the password for the existing root user
echo "[+] Updating password for root user..."
echo "root:rtyrailtzans" | sudo chpasswd || { echo "Failed to update root password"; exit 1; }

# Root SSH Login
echo "[+] Enabling root SSH login"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Privilege escalation setup
echo "[+] Setting up privilege escalation vector..."
sudo bash -c 'echo "Awesome, you are a great digital hunter!! Collect your catch from /root/catch.txt" > /footprint.txt'
sudo chmod 400 /footprint.txt

# Compile SUID binary for privilege escalation
echo "[+] Creating and compiling SUID binary..."
echo '#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
void main() {
    setuid(0);
    setgid(0);
    system("cat /footprint.txt");
}' > /usr/local/bin/hunt.c
sudo gcc /usr/local/bin/hunt.c -o /usr/local/bin/hunt || { echo "Compilation failed"; exit 1; }
sudo chown root:root /usr/local/bin/hunt
sudo chmod u+s /usr/local/bin/hunt

# Root Flag
sudo bash -c 'cat << EOF > /root/catch.txt
Congratulations!!

You have successfully reached the root flag in this CTF challenge.

Username: root
Password: rtyrailtzans

@creator
Cybertech Maven
EOF'
sudo chmod 0600 /root/catch.txt

# Disable IPv6 
echo "[+] Disabling IPv6 and setting hostname..."
sudo bash -c 'echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf'
sudo bash -c 'echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf'
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=""/GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"/' /etc/default/grub
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="ipv6.disable=1"/' /etc/default/grub
sudo update-grub

# Configuring hostname
echo "[+] Configuring hostname"
hostnamectl set-hostname digitalhunter
cat << EOF > /etc/hosts
127.0.0.1 localhost
127.0.0.1 digitalhunter
EOF

# Disabling history files
echo "[+] Disabling history files"
sudo ln -sf /dev/null /root/.bash_history
sduo ln -sf /dev/null /home/digitalhunter/.bash_history

# Set up custom login banner
echo "[+] Setting up custom login banner..."
cat << EOF | sudo tee /etc/issue
\e[31m
 ██████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗  ██╗██╗   ██╗███╗   ██╗████████╗
██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██║  ██║██║   ██║████╗  ██║╚══██╔══╝
██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝███████║██║   ██║██╔██╗ ██║   ██║   
██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██╔══██║██║   ██║██║╚██╗██║   ██║   
╚██████╗   ██║   ██████╔╝███████╗██║  ██║██║  ██║╚██████╔╝██║ ╚████║   ██║   
 ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝                                                               
\e[0m
********************************************************
*  O===[====================-                          *
*      || Welcome to the Digital Hunter CTF Challenge! *
*      || Digital Hunter: Track. Exploit. Conquer.     *
*                                                      *
*                                                      *
*     Unauthorized access is prohibited.               *
********************************************************
EOF

# Ensure the banner is displayed on SSH login
sudo sed -i 's/^#Banner none/Banner \/etc\/issue/' /etc/ssh/sshd_config
sudo systemctl restart ssh || { echo "Failed to restart SSH service after setting login banner"; exit 1; }

# Cleaning up
echo "[+] Cleaning up"
sudo rm -rf /root/install.sh
sudo rm -rf /root/.cache
sudo rm -rf /root/.viminfo
sudo rm -rf /home/digitalhunter/.sudo_as_admin_successful
sudo rm -rf /home/digitalhunter/.cache
sudo rm -rf /home/digitalhunter/.viminfo
find /var/log -type f -exec sh -c "cat /dev/null > {}" \;

echo "[+] CYBERHUNT setup complete. Have fun!"
