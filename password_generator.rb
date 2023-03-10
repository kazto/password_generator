#!/usr/bin/env ruby

require 'securerandom'
require 'getoptlong'

DEFAULT_NUM = 10
DEFAULT_LENGTH = 16
DEFAULT_ADDITIONAL_CHAR = '-_'

psr = GetoptLong.new
psr.set_options(
  ['-l', '--length', GetoptLong::REQUIRED_ARGUMENT],
  ['-n', '--num',    GetoptLong::REQUIRED_ARGUMENT],
  ['-a', '--add',    GetoptLong::REQUIRED_ARGUMENT]
)

num = nil
length = nil
additional = nil

psr.each do |optname, optarg|
  case optname
  when '-n', '--num'
    num = optarg.to_i
  when '-l', '--length'
    length = optarg.to_i
  when '-a', '--add'
    additional = optarg
  end
end

num ||= DEFAULT_NUM
length ||= DEFAULT_LENGTH
additional ||= DEFAULT_ADDITIONAL_CHAR

num.times do
  head = SecureRandom.alphanumeric(1)
  tail = SecureRandom.alphanumeric(1)
  puts (SecureRandom.urlsafe_base64(length - 2 - additional.length) + additional).split(//).shuffle.unshift(head).push(tail).join
end
