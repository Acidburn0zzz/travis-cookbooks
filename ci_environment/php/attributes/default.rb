default['php']['multi']['prerequisite_recipes'] = %w(
  bison
  libreadline
  phpenv
  phpbuild
)

default['php']['multi']['postrequisite_recipes'] = %w(
  php::extensions
  php::hhvm
  php::hhvm-nightly
  phpunit
  composer
)

default['php']['multi']['versions'] = %w(
  5.4.42
  5.5.26
  5.6.10
)

default['php']['multi']['aliases'] = {
  '5.4' => '5.4.42',
  '5.5' => '5.5.26',
  '5.6' => '5.6.10'
}

default['php']['multi']['extensions'] = {
  'apc'       => {
    'versions' => default['php']['multi']['versions'].select { |version| version.start_with?('5.4') }
  },
  'memcached' => {
    'before_packages' => %w(libevent-dev libcloog-ppl1),
    'before_script'   => <<-EOF,
      wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
      tar xzf libmemcached-1.0.18.tar.gz
      cd libmemcached-1.0.18
      ./configure && make && make install
    EOF
    'script'   => <<-EOF,
      pecl download memcached-2.2.0
      tar zxvf memcached*.tgz && cd memcached*
      make clean
      phpize
      ./configure --with-libmemcached-dir=/usr/local && make && make install
    EOF
    'versions' => default['php']['multi']['versions']
  },
  'mongo'     => {},
  'amqp'      => {
    'before_script' => <<-EOF
      git clone git://github.com/alanxz/rabbitmq-c.git
      cd rabbitmq-c
      git checkout tags/v0.5.2
      git submodule init
      git submodule update
      autoreconf -i && ./configure && make && make install
    EOF
  },
  'zmq-beta' => {
    'versions' => default['php']['multi']['versions'],
    'before_recipes'  => %w(zeromq::ppa),
    'before_packages' => %w(libzmq3-dev)
  },
  'redis' => {}
}

if node['lsb']['codename'] == 'precise'
  default['php']['multi']['versions'] = %w(
    5.3.29
    5.4.40
    5.5.9
    5.5.24
    5.6.8
  )
  default['php']['multi']['aliases'] = {
    '5.3' => '5.3.29',
    '5.4' => '5.4.40',
    '5.5' => '5.5.24',
    '5.6' => '5.6.8'
  }

  default['php']['multi']['extensions'] = {
    'apc'       => {
      'versions' => default['php']['multi']['versions'].reject { |version| version.start_with?('5.5', '5.6') }
    },
    'memcache' => {
      'versions' => default['php']['multi']['versions'].select { |version| version.start_with?('5.2') }
    },
    'memcache-beta'  => {
      'versions' => default['php']['multi']['versions'].reject { |version| version.start_with?('5.2') }
    },
    'memcached' => {
      'before_packages' => %w(libevent-dev libcloog-ppl0),
      'before_script'   => <<-EOF,
        wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
        tar xzf libmemcached-1.0.18.tar.gz
        cd libmemcached-1.0.18
        ./configure && make && make install
      EOF
      'script'   => <<-EOF,
        pecl download memcached-2.1.0
        tar zxvf memcached*.tgz && cd memcached*
        make clean
        phpize
        ./configure --with-libmemcached-dir=/usr/local && make && make install
      EOF
      'versions' => default['php']['multi']['versions'].select { |version| version.start_with?('5.2') }
    },
    'memcached' => {
      'before_packages' => %w(libevent-dev libcloog-ppl0),
      'before_script'   => <<-EOF,
        wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
        tar xzf libmemcached-1.0.18.tar.gz
        cd libmemcached-1.0.18
        ./configure && make && make install
      EOF
      'script'   => <<-EOF,
        pecl download memcached-2.2.0
        tar zxvf memcached*.tgz && cd memcached*
        make clean
        phpize
        ./configure --with-libmemcached-dir=/usr/local && make && make install
      EOF
      'versions' => default['php']['multi']['versions'].reject { |version| version.start_with?('5.2') }
    },
    'mongo'     => {},
    'amqp'      => {
      'before_script' => <<-EOF
        git clone git://github.com/alanxz/rabbitmq-c.git
        cd rabbitmq-c
        git checkout tags/v0.5.2
        git submodule init
        git submodule update
        autoreconf -i && ./configure && make && make install
      EOF
    },
    'zmq-beta' => {
      'versions' => default['php']['multi']['versions'].reject { |version| version.start_with?('5.2') },
      'before_recipes'  => %w(zeromq::ppa),
      'before_packages' => %w(libzmq3-dev)
    },
    'redis' => {}
  }
end
