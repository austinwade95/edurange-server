script "motd" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  cd /tmp
  wget https://github.com/edurange/scenario-ssh-inception/raw/master/motd-first-stop
  mv motd-first-stop /etc/motd
  touch /tmp/recipe-motd-done
  EOH
  not_if "test -e /tmp/recipe-motd-done"
end