class AlipayController < ApplicationController
  def show
    precreate = Alipay::Precreate.fetch(out_trade_no: params[:id])
    data = open(precreate.pic_url)
    send_data data.read, filename: "#{params[:id]}.png", type: data.content_type, disposition: 'inline'
  end
end