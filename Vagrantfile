Vagrant.configure(2) do |config|

  config.vm.box = 'ubuntu/xenial64'
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

  # Inject .ssh dir from host
  ['~/.ssh'].each do |dir|
    config.vm.synced_folder '~/' + dir, '/home/vagrant/' + dir, type: 'nfs' if File.exist?(File.expand_path('~/' + dir))
  end

  config.vm.provision :shell, privileged: false, path: 'init-box.sh'

  config.vm.network 'forwarded_port', host: 1080, guest: 1080 #mailcatcher
  config.vm.network 'forwarded_port', host: 5432, guest: 5432 #postgres
  config.vm.network 'forwarded_port', host: 6379, guest: 6379 #redis
  config.vm.network 'forwarded_port', host: 4000, guest: 4000 #hagglundized.net

  config.vm.synced_folder '../celeritas', '/home/vagrant/dev/celeritas', type: 'nfs'
  config.vm.synced_folder '../hagglundized.net', '/home/vagrant/dev/hagglundized.net', type: 'nfs'
  config.vm.synced_folder '../alpine-ruby', '/home/vagrant/dev/alpine-ruby', type: 'nfs'
end
