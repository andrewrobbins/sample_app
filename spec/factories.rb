Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.org"
  user.password              "foobar#92"
  user.password_confirmation "foobar#92"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo Bar"
  micropost.association :user
end
