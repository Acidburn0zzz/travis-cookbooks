default['python']['pyenv']['revision'] = 'v20150601'

# Order matters for this list of Pythons. It will be used to construct the
# $PATH so items earlier in the list will take precedence over items later in
# the list. This order means that ``python`` will be 2.7.10, ``python2`` will be
# 2.7.10, and ``python3`` will be 3.4.3
default['python']['pyenv']['pythons'] = %w(
  2.7.10
  3.4.3
)

default['python']['pyenv']['aliases'] = {
  '2.7.10' => %w(2.7),
  '3.4.3' => %w(3.4),
}

default['python']['pip']['packages'] = {
  'default' => %w(nose pytest mock wheel),
  '2.7' => %w(numpy),
  '3.4' => %w(numpy),
}

default['python']['system']['pythons'] = %w(2.7 3.2)
if node['lsb']['codename'] == 'trusty'
  default['python']['system']['pythons'] = %w(2.7 3.4)
end
