require 'alipay'
require 'json'
require 'pry'

# credentials for Alipay from public sandbox site
# https://global.alipay.com/service/transaction_QR_Code/9
API_URL = 'https://openapi.alipaydev.com/gateway.do'
APP_ID = '2088021966388155' # NEED this to be Partner ID - App ID is part of another api?
APP_PRIVATE_KEY = """-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQD7FfmVdd570cFX3G76FatugmYlGNFtw9b2kFiBPvJDM0yeX52S
WqAtjVBizaf6zNzib1a9xety7dnAxELidQJmUj3z4lwb3j5PRn+lx5FeAyAJWRBS
m5+J3AzhOoHpStgATvEXT/AUndrgdn5Adfi45koUB8IzJzGZmk+5DabrIwIDAQAB
AoGABd2WjgpJ30SgKqhIo2j8L0G2lylEQzcu/2WR27sXt8AsCwsayD97vHSvqw84
3GAKzPNi6F4GSRILYzhyg43ON3/d3m/S1iTgSFXchTyAsAjy398Iq/ufSj9DOj+u
I88XZ7JVt7jEyihPldSh7FkuMKaaFkJdsNz22LfD3NZIBVECQQD+I/zp+OuxmW5D
GcNDEIXF0bl3mmCAv041ZBBO5JCYrgvpkofC6SRlOi+P3BPXYPHZjyU3Jp3XgaJD
QvHCEkXbAkEA/OxD8FDM5i1JqcwIzha+NyJdm3nJ7Njlx4VIKD9Kx10oG49ge7gG
8fDC7FwduGupfPj9ycKsHBFWC+AIUPSGWQJASqzWbwWWc+wKiyrxxi3/sL3MSomR
G6Oa3nNVm2jr2AEkPPCydaI98ISlXxciuWGiDvRR0h/Ft4I+5JayJP1riwJAHe6o
K6ykUylQ6nNnJ1yxrjy270t+hjU1HGO9omW7J9TyhjB1rq6cw81GhEpyifzT1iJx
hosvazLyB/2/fjUyIQJBAJDzo5n2tVhsQEe5aNlF5ZHTtReyTMnPR4HgfBqGWydc
DV/Wx7roFLX0dYT71CMD3vvHtda0qfNpQe8nM43lJfc=
-----END RSA PRIVATE KEY-----
"""


ALIPAY_PUBLIC_KEY = <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB

-----END PUBLIC KEY-----
EOF

# set up a client to talk to the Alipay API
@client = Alipay::Client.new(
  url: API_URL,
  partner_id: APP_ID,
  app_private_key: APP_PRIVATE_KEY,
  alipay_public_key: ALIPAY_PUBLIC_KEY
)

response = @client.execute(
  method: 'alipay.acquire.precreate',
  notify_url: 'https://mystore.com/orders/20160401000000/notify',
  biz_content: {
    out_trade_no: '20160401000000',
    total_amount: '0.01',
    subject: 'QR Code Test'
  }.to_json(ascii_only: true)
)
puts response
# => '{\"alipay_trade_precreate_response\":{\"code\"...'

# Get payment url to render as QR code for customer
qr_code = JSON.parse(response)["alipay_trade_precreate_response"]["qr_code"]
puts qr_code
# => 'https://qr.alipay.com/abcdefggfedcba'
