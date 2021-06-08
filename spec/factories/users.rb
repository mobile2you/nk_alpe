# frozen_string_literal: true

FactoryBot.define do
  factory :user_credentials, class: Hash do
    email { 'leland.odell@fineoak.org' }
    password { 'Teste10@' }
  end

  factory :user_invalid_credentials, class: Hash do
    email { 'invalid@invalid.org' }
    password { 'invalid' }
  end
end
