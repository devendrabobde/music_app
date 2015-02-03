# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fb_friend do
    profile_id "MyString"
    profile_url "MyString"
    username "MyString"
    first_name "MyString"
    last_name "MyString"
    name "MyString"
    email "MyString"
    gender "MyString"
    location "MyString"
    hometown "MyString"
    birthday "2015-02-03"
    user_id 1
  end
end
