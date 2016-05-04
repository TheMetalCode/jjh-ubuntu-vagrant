Vagrant.configure(2) do |config|

  config.vm.box = 'ubuntu/trusty64'
  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'jjh-ubuntu-vagrant'
    vb.memory = 6144
    vb.cpus = 4
    # This greatly improves performance
    vb.customize ['modifyvm', :id, '--ioapic', 'on']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    # if host cpu resources ever get to be overtaxed by vagrant vm
    # vb.customize ['modifyvm', :id, '--cpuexecutioncap', '50']
  end

  config.ssh.forward_agent = true

  config.vm.network 'private_network', ip: '172.28.128.3' #strongly suggest this be in private address space

  # Inject user files
  ['~/.gitconfig', '~/.tmux.conf', '~/.vimrc'].each do |file|
    config.vm.provision :file, source: file, destination: file if File.exist?(File.expand_path(file))
  end

  config.vm.provision :shell, privileged: false, path: 'init-box.sh'
end
