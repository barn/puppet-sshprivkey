# SSH Private key provider.

Ben Hughes <ben@puppetlabs.com>

# Hackety Hack

Makes SSH private keys. Why is this useful? Well say if you use github for
things and [vcsrepo](https://github.com/puppetlabs/puppetlabs-vcsrepo)
then you'll need to generate SSH keys, but you don't want to always make
them then push them to a repo, then add them in Puppet etc, you just want
a key.

<pre>
sshprivkey{ '/root/.ssh/sekret_nu_key':
  ensure => present,
}
</pre>

It also supports user, to specify a user to make the key as.

And it supports mailto, to mail the public key to that address using
system mail. Sketch.

<pre>
sshprivkey{ '/home/daveo/.ssh/githubz':
  ensure => present,
  user   => 'daveo',
  mailto => 'daveo@example.org',
}
</pre>
