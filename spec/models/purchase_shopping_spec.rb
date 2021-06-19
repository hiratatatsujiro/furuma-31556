require 'rails_helper'

RSpec.describe PurchaseShopping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shopping = FactoryBot.build(:purchase_shopping, user_id: user.id, item_id: item.id)
    sleep 0.1
  end
  context "内容に問題がない場合" do
    it "tokenと住所情報等が適切に入力されていれば登録できる" do
      expect(@purchase_shopping).to be_valid
    end
  end

  context "内容に問題がある場合" do
    it "tokenがなければ保存できない" do
      @purchase_shopping.token = ""
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Token can't be blank")
    end

    it "postal_codeがなければ保存できない" do
      @purchase_shopping.postal_code = ""
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @purchase_shopping.postal_code = "8301211"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it 'postal_codeが全角数字だと保存できないこと' do
      @purchase_shopping.postal_code = "８３０１２１１"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it 'postal_codeが全角ひらがなだと保存できないこと' do
      @purchase_shopping.postal_code = "あいう-えおかき"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it 'postal_codeが全角英字だと保存できないこと' do
      @purchase_shopping.postal_code = "ｋｋｋ-ｋｋｋｋ"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it 'postal_codeが全角カタカナだと保存できないこと' do
      @purchase_shopping.postal_code = "アイウ-エオカキ"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it 'postal_codeが半角カタカナだと保存できないこと' do
      @purchase_shopping.postal_code = "ｱｲｳ-ｴｵｶｷ"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it 'postal_codeが半角英字だと保存できないこと' do
      @purchase_shopping.postal_code = "aaa-aaaa"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it "delivery_area_idが1ならば保存できない" do
      @purchase_shopping.delivery_area_id = 1
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Delivery area can't be blank")
    end

    it "cityがなければ保存できない" do
      @purchase_shopping.city = ""
      @purchase_shopping.valid?
      #binding.pry
      expect(@purchase_shopping.errors.full_messages).to include("City can't be blank")
    end

    it "house_numberがなければ保存できない" do
      @purchase_shopping.house_number = ""
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("House number can't be blank")
    end

    it "phone_numberがなければ保存できない" do
      @purchase_shopping.phone_number = ""
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number can't be blank")
    end

    it "phone_numberが9字以下ならば保存できない" do
      @purchase_shopping.phone_number = "090434888"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is too short")
    end

    it "phone_numberが12字以上であれば保存できない" do
      @purchase_shopping.phone_number = "09011112222345"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is too long")
    end

    it 'phone_numberが全角数字だと保存できないこと' do
      @purchase_shopping.phone_number = "０９０１１１１２２２２"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it 'phone_numberが全角ひらがなだと保存できないこと' do
      @purchase_shopping.phone_number = "あいうえおかきくけこさ"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it 'phone_numberが全角英字だと保存できないこと' do
      @purchase_shopping.phone_number = "ｋｋｋｋｋｋｋｋｋｋｋ"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it 'phone_numberが全角カタカナだと保存できないこと' do
      @purchase_shopping.phone_number = "ｱｲｳｴｵｶｷｸｹｺｻ"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it 'phone_numberが半角カタカナだと保存できないこと' do
      @purchase_shopping.phone_number = "ｱｲｳｴｵｶｷｸｹｺｻ"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it 'phone_numberが半角英字だと保存できないこと' do
      @purchase_shopping.phone_number = "aaabbbbcccc"
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid. Input only number")
    end

    it "user_idが空なら保存できない" do
      @purchase_shopping.user_id = ""
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("User can't be blank")      
    end

    it "item_idが空ならば保存できない" do
      @purchase_shopping.item_id = ""
      @purchase_shopping.valid?
      expect(@purchase_shopping.errors.full_messages).to include("Item can't be blank") 
    end
  end

  
end
