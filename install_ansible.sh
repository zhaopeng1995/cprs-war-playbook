#!/bin/bash
#
# author : dbird
# date   : 2017/11/06 
#######################################################################
#   description:                                                      #
#     1. this script used for install ansible and batch sshkey        #
#     2. run this scripts in root prileges                            #
#     3. you need to have a host file named                           #
#        $cat ip_list.txt                                             #
#        192.168.100.1                                                #
#        192.168.100.2                                                #
#     4. the root'passworwd of all the machines must be same          #
# ##########################################################233########

# install epel
function info(){
    echo -e "\033[32m[ $1 ]\033[0m"
}
function error(){
    echo -e "\033[31m[ $1 ]\033[0m"
}

if  [[ $USER != 'root' ]]  ;then
       error "current user is not root,run this script from the root of repository"
       exit 1
fi

# yum install ansible
yum -y install epel-release 
yum  -y install ansible expect
[[  `which ansible` ]] &&  info "ansible has been installed  successfully" || error "install ansible failed"

# generate sshkey
[ ! `which ssh` ] && yum install -y openssh-clients
[ ! -f $HOME/.ssh/id_rsa ] && info "ssh key not exsits, start generating..." && ssh-keygen

# batch ssh_key
info " batching the ssh key..."
read -s -p "Please input the root's password : "  password
echo ""
read -s -p "Confirm your passowrd : "  password_2
echo ""
[[ -z $password ]] && [ -z $password_2 ] && error "empty input"  && exit 3
[[  $password != $password_2 ]] && error " password not consistent!" && exit 3
read -p "Input the host file (./ip_list.txt):" hostfile
[ -z $hostfile ] &&  hostfile="./ip_list.txt"
[[ ! -f $hostfile ]] && error "file $hostfile not exits !it looks like below:\n \
192.168.100.101\n 192.168.100.102
"  && exit 3
read -p "Input the path of public key ($HOME/.ssh/id_rsa.pub)" key_file 
[ -z $key_file ] &&  key_file="$HOME/.ssh/id_rsa.pub"
[[ ! -f $key_file ]] && error "keyfile $key_file not exits !"  && exit 3
echo " host file:"  $hostfile
echo " key file :" $key_file 
info "start batch_ssh_key ....."
user=root
for ip in $(cat $hostfile)
do   
    expect -c "
        set timeout 15
	spawn ssh-copy-id -i $key_file $user@$ip
	expect {
        \"*yes/no*\" {send \"yes\r\"; exp_continue}
        \"*password*\" {send \"$password\r\"; exp_continue}
        \"*Password*\" {send \"$password\r\";}
    }
" 
    
done
info "done"


