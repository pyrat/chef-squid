#
# Cookbook Name:: squid
# Recipe:: default
#
# MIT License
# 

package "squid" do
  package_name 'squid'
  action :install
end

package "squid-common" do
  package_name 'squid-common'
  action :install
end

# This would rely on apache being installed, which it often isnt.
# execute "add user" do
#   command "htpasswd -cb /etc/squid/passwd proxyuser 707972at"
#   user 'root'
#   group 'root'
# end


service "squid" do
  action :start
  enabled true
  supports [:start, :restart, :stop]
end

template "/etc/squid/passwd" do
  action :create_if_missing
  source "passwd"
  owner 'root'
  group 'root'
  mode "0744"
end

template "/etc/squid/squid.conf" do
  action :create
  source "squid.conf"
  owner 'root'
  group 'root'
  mode "0744"
  notifies :restart, resources(:service => "squid"), :immediate
end
