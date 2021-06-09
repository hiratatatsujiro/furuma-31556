FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { '111aab' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_reading     { 'ヤマダ' }
    first_name_reading    { 'タロウ' }
    birthday              { '1988-02-09' }
  end
end
