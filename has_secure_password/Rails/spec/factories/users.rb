FactoryBot.define do
  factory :user do
    first_name { "Akira" }
    last_name  { "Tanaka" }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password { "test_password" }
    password_confirmation { "test_password" }
    remember_digest do
      BCrypt::Password.create("test_token", cost: BCrypt::Engine.cost)
    end
  end
end
