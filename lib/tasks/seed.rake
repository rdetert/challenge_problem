namespace :db do
  namespace :seed do

    desc "Seed All"
    task :all => [:environment] do
      20.times do
        player = Player.create first_name: Faker::Name.first_name, 
                                last_name: Faker::Name.last_name,
                                birthdate: Faker::Date.between(from: 75.years.ago, to: 10.years.ago),
                                gender: Player.genders.to_a.sample[0]
        
        device = Device.create device_model: Faker::Device.model_name, 
                                os: Device.os.to_a.sample[0],
                                os_version: Faker::App.semantic_version(major:(0..10)),
                                locale: Device.locales.to_a.sample[0]

        player.update device: device
      end

      10.times do 
        offer = Offer.create title: Faker::App.name,
                              header: [Faker::Marketing.buzzwords, Faker::Marketing.buzzwords].join(' '),
                              description: Faker::ChuckNorris.fact,
                              points: Faker::Number.between(from: 10, to: 100),
                              payout: Faker::Number.between(from: 1, to: 1000)

        (rand(7)+1).times do          
          min_age = Faker::Number.between(from: 10, to: 40)
          OfferTarget.create offer: offer,
                              min_age: min_age,
                              max_age: min_age + 15,
                              gender: OfferTarget.genders.to_a.sample[0],
                              os: OfferTarget.os.to_a.sample[0],
                              min_os_version: Faker::App.semantic_version(major: (0..4), patch: 0),
                              locale: OfferTarget.locales.to_a.sample[0]
        end
      end
    end

    desc "Reset Data"
    task :reset => [:environment] do
      Player.destroy_all
      Device.destroy_all
      Offer.destroy_all
      OfferTarget.destroy_all
    end

  end
end

