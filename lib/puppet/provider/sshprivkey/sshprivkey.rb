require 'fileutils'
require 'pp'

Puppet::Type.type(:sshprivkey).provide(:sshprivkey) do

  desc 'provider for SSH private keys.'

  commands :keygen => "/usr/bin/ssh-keygen"

  def create
    begin
      Puppet::Util::Execution.execute( [ '/usr/bin/ssh-keygen' , '-q', '-N', '', '-f', @resource[:path] ] , :uid => @resource[:user] )
    rescue => e
      Puppet.warning "ssh-keygen failed in a bad way. '#{e}'"
      return false
    end

    # This is sketchy, just mailing around the key, but what else should
    # one do?
    if @resource[:mailto] != nil

      unless File.exists? "#{@resource[:path]}.pub"
        Puppet.warning "So I should have had a SSH public key, but I now don't"
        raise Puppet::Error
      end

      begin
        # hack hack hack
        system( "mail -s 'Puppet generated an SSH key for you.' #{@resource[:mailto]} <#{@resource[:path]}.pub" )
      rescue => e
        Puppet.warning "I broke the emails, sending you a stolen SSH key."
      end
    end

  end

  def destroy
    if FileUtils.rm( @resource[:path], :force => true ) and
      FileUtils.rm( "#{@resource[:path]}.pub", :force => true )
      return true
    else
      return false
    end
  end

  def exists?
    return false unless File.exists? @resource[:path]

    File.open( @resource[:path], 'r' ) do |f|
      f.readlines.each do |keyline|
        return true if keyline =~ /-----BEGIN [RD]SA PRIVATE KEY-----/
      end
    end
    return false
  end

#  autorequire(:user) do
#    should(:user) if should(:user)
#  end

end
