#!/bin/bash
# This Bash script deploys Chef Automate and Chef Infra Server on an on-prem or cloud VM
# Variables – Edit these variables
hostname='automate.chef.lab' 
username='jtonello'
longusername='John Tonello' 
useremail='jtonello@chef.lab' 
userpassword='password'
orgname='lab'
longorgname='Chef Lab'

# Do NOT change the two dynamic variables below 
userfilename="${username}.pem" 
orgfilename="${orgname}-validator.pem"

# Do NOT change anything below
sudo hostnamectl set-hostname $hostname
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -w vm.dirty_expire_centisecs=20000
curl https://packages.chef.io/files/current/latest/chef-automate-cli/chef- automate_linux_amd64.zip | gunzip - > chef-automate && chmod +x chef-automate
sudo ./chef-automate deploy --product automate --product infra-server --accept-terms-and-mlsa=true
sudo chef-server-ctl user-create $username $longusername $useremail "${userpassword}" --filename $userfilename
sudo chef-server-ctl org-create $orgname "${longorgname}" --association_user $username --filename $orgfilename
