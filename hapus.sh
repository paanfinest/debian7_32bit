#!/bin/bash
# Script hapus user SSH
# Created by Pa'an Finest 

read -p "Nama user SSH yang akan dihapus : " Nama 

userdel -r $Nama