execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

execute "zabbix" do
  user "root"
  command "rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm  "
  action :run
end




%w[
  mysql
  mysql-devel
  mysql-server
  mysql-utilities
  bind-utils
  sysstat
  mailx
  dstat
  make
  gcc
  zlib-devel
  openssl-devel
  dstat
  lsof
  telnet
  ntp
  zabbix-server
  zabbix 
  zabbix-agent 
  zabbix-server zabbix-server-mysql 
  zabbix-web 
  zabbix-web-mysql
  htop
].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end


%w[
  ntpd
  sysstat
  mysqld
  ].each do |service|
service "start" do
  pattern "#{service}" do
  action [:enable, :start]
end
end
end