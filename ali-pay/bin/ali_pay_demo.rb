#!/usr/bin/env ruby
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'ali_pay'

ali_pay = AliPay.new
puts ali_pay.pay

