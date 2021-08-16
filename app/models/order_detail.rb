class OrderDetail < ApplicationRecord
 enum making_status: {
     production_not_possible:0,#制作不可
     production_pending:1,#制作待ち
     in_production:2,#製作中
     production_complete:3,#制作
 }
end
