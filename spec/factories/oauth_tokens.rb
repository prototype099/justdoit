# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :oauth_token do
    user_id 1
    provider "MyString"
    uid "MyString"
    access_token "MyString"
    expires_at "2014-02-08 21:13:44"
  end
end
