# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner_id 1
    title "MyString"
    description "MyText"
    place "MyString"
    start_time "2014-02-15 19:00:23"
    end_time "2014-02-15 19:00:23"
  end
end
