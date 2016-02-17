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

  # config.vm.network 'forwarded_port', host: 5432, guest: 5432 #postgres
  config.vm.network 'forwarded_port', host: 4000, guest: 4000 #hagglundized.net

  # Inject user files
  ['~/.gitconfig', '~/.tmux.conf', '~/.vimrc'].each do |file|
    config.vm.provision :file, source: file, destination: file if File.exist?(File.expand_path(file))
  end

  # Inject user dirs
  ['~/.ssh'].each do |dir|
    config.vm.synced_folder '~/' + dir, '/home/vagrant/' + dir if File.exist?(File.expand_path('~/' + dir))
  end

  config.vm.synced_folder '../celeritas', '/home/vagrant/dev/celeritas'
  config.vm.synced_folder '../hagglundized.net', '/home/vagrant/dev/hagglundized.net'

  config.vm.provision :shell, privileged: false, path: 'init-box.sh'
end