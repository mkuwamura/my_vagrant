execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

execute "zabbix" do
  user "root"
  command "rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm"
  action :run
end

%w[
  php
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
   zabbix-web-mysql
  zabbix-server
  zabbix
  zabbix-web-japanese
  zabbix-web
  zabbix-agent
  zabbix-server
  zabbix-server-mysql
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
  ].each do |pkg|
service "start" do
  pattern "#{pkg}" do
  action [:enable, :start]
end
end
end

bash "japanese_setting" do
  user "root"
  cwd "/tmp"
  code <<-EOH
rm /etc/localtime; ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
mkdir /etc/old
mv  /etc/sysconfig/i18n /etc/old/i18n_`date '+%Y%m%d%H%M'`
echo -e  \#LANG=\"en_US.UTF-8\"\\nLANG=\"ja_JP.UTF-8\" >  /etc/sysconfig/i18n
  EOH
end