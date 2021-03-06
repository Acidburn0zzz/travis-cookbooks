include_attribute 'travis_build_environment'

default['rvm']['version'] = '1.26.11'
default['rvm']['rubies'] = []
default['rvm']['binaries_url'] = 'https://s3.amazonaws.com/travis-rubies/binaries'
default['rvm']['gems'] = []
default['rvm']['multi_prerequisite_recipes'] = %w(
  java
  maven
  ant
)
default['rvm']['prerequisite_recipes'] = %w(
  networking_basic
  build-essential
  git
  libyaml
  libgdbm
  libreadline
  libxml
  libssl
  libncurses
  sqlite
)

case node['platform']
when 'debian', 'ubuntu'
  default['rvm']['pkg_requirements'] = %w(gawk libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev)
  # This the list of packages returned by `rvm requirements' on Ubuntu 12.04.2
  # (of course it overlaps with cookbook dependencies, but it does not hurt to be listed here again)
else
  default['rvm']['pkg_requirements'] = []
end
