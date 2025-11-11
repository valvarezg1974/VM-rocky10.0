ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|
  config.vm.box = "valvarezg/Rocky10.0" # The box you want to use
  config.ssh.insert_key=false
#  config.ssh.forward_agent = true
  config.vm.boot_timeout=1200
  config.ssh.username="vagrant"
  config.ssh.password="vagrant"
  config.vm.synced_folder ".", "/vagrant", disabled: false
N = 1
  (1..N).each do |machine_id|
    config.vm.define "machine#{machine_id}" do |machine|
      machine.vm.hostname = "machine#{machine_id}"
      machine.vm.network "private_network", ip: "192.168.56.#{200+machine_id}"
    #  machine.vm.network "public_network", bridge: "Realtek 8852CE WiFi 6E PCI-E NIC"

    # Only execute once the Ansible provisioner,
    # when all the machines are up and ready.
      #if machine_id == N
        #machine.vm.provision :ansible_local do |ansible|
		
        #end
		machine.vm.provision "shell", inline: "echo 'Provisioning VM ...'"
		

    config.vm.provision "file", source: "/home/victor/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
    public_key = File.read("/home/victor/.ssh/id_rsa.pub")
    config.vm.provision :shell, :inline =>"
     echo 'Copying ansible-vm public SSH Keys to the VM'
     mkdir -p /home/vagrant/.ssh
     chmod 700 /home/vagrant/.ssh
     echo '#{public_key}' >> /home/vagrant/.ssh/authorized_keys     
     chmod -R 600 /home/vagrant/.ssh/authorized_keys
     echo 'Host 192.168.*.*' >> /home/vagrant/.ssh/config
     echo 'StrictHostKeyChecking no' >> /home/vagrant/.ssh/config
     echo 'UserKnownHostsFile /dev/null' >> /home/vagrant/.ssh/config
     chmod -R 600 /home/vagrant/.ssh/config
     ", privileged: false


		#machine.vm.provision "shell", path: "scripts/base.sh"
    #machine.vm.provision "shell", path: "scripts/vagrant.sh"
		machine.vm.provision "shell", path: "scripts/cleanup.sh"
	    #machine.vm.provision "shell", name: "update-packages", run: "always", inline: <<-SHELL
		#  sudo yum -y update && sudo yum -y install kernel-headers kernel-devel gcc dkms 
		#  SHELL
		machine.vm.provision :ansible do |ansible|
        # Disable default limit to connect to all the machines
        #  ansible.limit = "all"
		#  ansible.install = true
		#  ansible.verbose = true
		#  ansible.inventory_path = "inventory"
      ansible.playbook       = "scripts/enable_firewalld.yml"
		  ansible.playbook       = "scripts/getenforce_selinux.yml"
      ansible.playbook       = "scripts/disable_root_password.yml"
    end
	  
	  machine.vm.provision "shell", inline: "echo 'Fin Provisioning VM ...'"
	  
    end
  end
end

