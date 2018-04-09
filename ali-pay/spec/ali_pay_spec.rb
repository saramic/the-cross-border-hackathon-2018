require 'spec_helper'
require 'ali_pay'
RSpec.describe AliPay do
  it 're-arranges parameters alphabetically' do
    expect(AliPay.new.pay).to eq '_input_charset=gbk&out_trade_no=6741334835157966&partner=2088101568338364&payment_type=1&return_url=http://www.test.com/alipay/return_url.asp&seller_email=alipay-test01@alipay.com&service=create_forex_trade&subject=test&total_fee=100'
  end
end
