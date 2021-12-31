#!/usr/bin/env rake
require "rubygems"
require "bundler/setup"
require "bundler/gem_tasks"

Dir['gem_tasks/**/*.rake'].each { |rake| load rake }

task :default => [:spec, 'spec:format', 'spec:active_support', 'spec:compatibility']
