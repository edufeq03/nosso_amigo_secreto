FactoryBot.define do
 factory :member do
   name         { FFaker::Lorem.word }
   email        { FFaker::Internet.email }
   campaign
 end
end

# caso queira associar a uma campanha já conhecida, usar

# create (:member, campaign: @campaign)

# ou

# build (:member, campaign: @campaign)
