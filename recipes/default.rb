#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#We basically follow provision.sh here, but with a ruby syntax for the chef.
apt_update 'update' do
  action [:update]
end
# we use xenial and not crusty, because we use 3.2 and only xenial have it.
# multiverse is related to all the files that we need
# hkp is key protocol.
apt_repository 'mongodb-org' do
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  action :add
end
# we need keys because we need to ask permissions to download mongo
# https://docs.chef.io/resource_apt_repository.html

# mongodb is the package
package 'mongodb-org' do
  action :install
end

package 'mongodb-org' do
  action :upgrade
end
# Error executing action `upgrade` on resource 'apt_package[mongodb-org]'
# mongod is the service
service 'mongod' do
  action [:enable, :start]
end
# Create a mongod.service file in /lib/systemd/system/mongod.service : what mongo uses to run
template '/lib/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  action :create
end
# Create a mongod.conf file in /etc/mongod.conf : what port of mongo
template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  action :create
end

service 'mongod' do
  action :restart
end
