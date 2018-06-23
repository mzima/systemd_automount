#
# Escape strings for usage in system unit names
#
Puppet::Functions.create_function(:'systemd_automount::systemd_escape') do
  dispatch :convert do
    param 'String', :input
  end

  def convert(input)
    input = input[/.(.*)/m,1]
    output = `systemd-escape #{input}`
    output.chomp
  end
end
