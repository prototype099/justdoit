# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    event_id 1
    user_id 1
    content "MyText"
    state "MyString"
  end
end
