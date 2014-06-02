#
# Cookbook Name:: dns
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/resolv.conf" do
source "resolv.conf"
mode 0644
owner "root"
group "root"
backup false
end
