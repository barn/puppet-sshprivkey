Puppet::Type.newtype(:sshprivkey) do
  desc 'manage SSH private keys.'

  ensurable

  newparam(:user) do
    desc 'user for whom the SSH key is to be made.'

    defaultto 'root'

    validate do |value|
      unless value =~ /^\w+$/
        raise ArgumentError, "username is not valid: #{value}"
      end
    end

  end

  newparam(:path, :namevar => true ) do
    desc 'filepath where the SSH key is to be placed.'

    validate do |value|
      unless value =~ /^\/[\w\.\/]+$/
        raise ArgumentError, "file path is not valid: #{value}"
      end

      if value =~ /\.pub$/
        raise ArgumentError, "file path states public key, not private key: #{value}"
      end
    end

  end

  newparam(:mailto) do
    desc 'An email address to mail the public key to'
    validate do |value|
      unless value =~ /[\w+\.\!\+]+@[\w\.]+/
        raise ArgumentError, "Invalid email address: #{value}"
      end
    end
  end

  #autorequire(:user) do
  #  should(:user) if should(:user)
  #end

end
