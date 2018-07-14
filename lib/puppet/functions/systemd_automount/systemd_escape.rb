#
# Escape strings for usage in system unit names
#
Puppet::Functions.create_function(:'systemd_automount::systemd_escape') do
  dispatch :convert do
    param 'String', :input
  end

  def convert(input)
    input = input[/.(.*)/m,1]
    if system('which systemd-escape') == true
      output = `systemd-escape #{input}`
    else
      input = input.gsub(/-/,'\\x2d')
      input = input.gsub(/\//,'-')
      output = input
    end
    output.chomp
  end
end
