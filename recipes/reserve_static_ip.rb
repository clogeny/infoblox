# Cookbook Name: Infoblox
# Recipe Name: reserve_static_ip

include_recipe "infoblox::default"

infoblox_ip_address "Reserve static IP" do
  name node['reserve_static_ip']['hostname']
  ipv4addr node['reserve_static_ip']['ipv4addr']
  record_type node['reserve_static_ip']['record_type']
  ptrdname node['reserve_static_ip']['ptrdname']
  aliases node['reserve_static_ip']['aliases']
  canonical node['reserve_static_ip']['canonical'] 
  extattrs node['reserve_static_ip']['extattrs']
  comment node['reserve_static_ip']['comment']
  action :reserve
end

infoblox_vm 'Provision a aCAC VM with reserved IP' do
  host node['vcenter']['vcenter_host']
  user node['vcenter']['username']
  password node['vcenter']['password']
  pubkey_hash node['vcenter']['pubkey_hash']
  template_path node['vcenter']['template_path']
  datacenter node['vcenter']['datacenter']
  datastore node['vcenter']['datastore']
  domain node['vcenter']['domain']
  gateway node['vcenter']['gateway']
  subnet_mask node['vcenter']['subnet_mask']
  dns_server_list node['vcenter']['dns_server_list']
  network_adapter node['vcenter']['network_adapter']
  hostname node['vcenter']['hostname']
  
  record_type node['reserve_static_ip']['record_type']
  name node['reserve_static_ip']['vm_name']
  ip node['reserve_static_ip']['ipv4addr']
  action :provision
end
