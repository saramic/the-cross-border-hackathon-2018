#!/usr/bin/env ruby
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'ali_pay'

ali_pay = AliPay.new(
  :_input_charset => "utf-8",
  :extend_params  => {
    "secondary_merchant_name"     => "Lotte",
    "secondary_merchant_id"       => "123",
    "secondary_merchant_industry" => "5812",
    "store_id"                    => "A101",
    "store_name"                  => "McDonald in 966 3rd Ave, New York"
  },
  :notify_url     => "http:\/\/\u5546\u6237\u7f51\u5173\u5730\u5740\/alipay.acquire.precreate-PHP-UTF-8-MD5\/notify_url.php",
  :price          => "0.01",
  :quantity       => "1",
  :show_url       => "http:\/\/www.taobao.com\/product\/113714.html",
  :timestamp      => "2018-04-09 10:43:38",
  :trans_currency => "USD",
  :seller_email   => "testoverseas1980@alipay.com"
)
puts ali_pay.pay_url

