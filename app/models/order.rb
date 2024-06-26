class Order < ApplicationRecord
  attribute :adress, :string

  enum payment_method: {クレジットカード:0, 銀行振込:1}
  attribute :status, :integer, default: "0"
  enum status: {入金待ち:0, 入金確認:1,  製作中:2, 発送準備中:3, 発送済み:4}
  attribute :shipping_cost, :integer, default: "500"
end
