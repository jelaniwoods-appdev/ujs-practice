namespace :dev do
  desc "Fill the database tables with some sample data"
  task prime: :environment do
    user = User.find_or_create_by(email: "alice@example.com") do |user|
      user.password = "password"
    end

    user.tasks.destroy_all

    Task.statuses.values.each do |status|
      rand(3..10).times do
        user.tasks.create(
          content: Faker::Hacker.say_something_smart,
          status: status
        )
      end
    end
  end

end
