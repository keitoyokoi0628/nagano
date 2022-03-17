class OrderDetail < ApplicationRecord
  belongs_to :order

  enum is_active: { a: 0, b: 1, c: 2, d: 3 }

end
