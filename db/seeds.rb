# Usuarios
User.create(name: "User 1", user_name: "user1", email: "user1@example.com", password: "password1")
User.create(name: "User 2", user_name: "user2", email: "user2@example.com", password: "password2")
User.create(name: "User 3", user_name: "user3", email: "user3@example.com", password: "password3")

User.first.regular_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, name: "Google")
User.first.regular_links.create(destination_url: "https://www.facebook.com", slug: SlugGenerator.generate, name: "Facebook")
User.first.regular_links.create(destination_url: "https://www.twitter.com", slug: SlugGenerator.generate, name: "Twitter")
User.first.regular_links.create(destination_url: "https://www.instagram.com", slug: SlugGenerator.generate, name: "Instagram")
User.first.regular_links.create(destination_url: "https://www.youtube.com", slug: SlugGenerator.generate, name: "YouTube")
User.first.regular_links.create(destination_url: "https://www.linkedin.com", slug: SlugGenerator.generate, name: "LinkedIn")
User.first.regular_links.create(destination_url: "https://www.github.com", slug: SlugGenerator.generate, name: "GitHub")
User.first.regular_links.create(destination_url: "https://www.stackoverflow.com", slug: SlugGenerator.generate, name: "Stack Overflow")
User.first.regular_links.create(destination_url: "https://www.medium.com", slug: SlugGenerator.generate, name: "Medium")
User.first.regular_links.create(destination_url: "https://www.reddit.com", slug: SlugGenerator.generate, name: "Reddit")
User.first.regular_links.create(destination_url: "https://www.pinterest.com", slug: SlugGenerator.generate, name: "Pinterest")
User.first.regular_links.create(destination_url: "https://www.tumblr.com", slug: SlugGenerator.generate, name: "Tumblr")
User.first.regular_links.create(destination_url: "https://www.wordpress.com", slug: SlugGenerator.generate, name: "WordPress")

User.first.temporal_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "Google")
User.first.temporal_links.create(destination_url: "https://www.facebook.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "Facebook")
User.first.temporal_links.create(destination_url: "https://www.twitter.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "Twitter")
User.first.temporal_links.create(destination_url: "https://www.instagram.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "Instagram")
User.first.temporal_links.create(destination_url: "https://www.youtube.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "YouTube")
User.first.temporal_links.create(destination_url: "https://www.linkedin.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "LinkedIn")
User.first.temporal_links.create(destination_url: "https://www.github.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "GitHub")
User.first.temporal_links.create(destination_url: "https://www.stackoverflow.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "Stack Overflow")

User.first.private_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, password: "password", name: "Google")
User.first.private_links.create(destination_url: "https://www.facebook.com", slug: SlugGenerator.generate, password: "password", name: "Facebook")
User.first.private_links.create(destination_url: "https://www.twitter.com", slug: SlugGenerator.generate, password: "password", name: "Twitter")
User.first.private_links.create(destination_url: "https://www.instagram.com", slug: SlugGenerator.generate, password: "password", name: "Instagram")
User.first.private_links.create(destination_url: "https://www.youtube.com", slug: SlugGenerator.generate, password: "password", name: "YouTube")
User.first.private_links.create(destination_url: "https://www.linkedin.com", slug: SlugGenerator.generate, password: "password", name: "LinkedIn")
User.first.private_links.create(destination_url: "https://www.github.com", slug: SlugGenerator.generate, password: "password", name: "GitHub")
User.first.private_links.create(destination_url: "https://www.stackoverflow.com", slug: SlugGenerator.generate, password: "password", name: "Stack Overflow")

User.first.ephemeral_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, name: "Google")
User.first.ephemeral_links.create(destination_url: "https://www.facebook.com", slug: SlugGenerator.generate, name: "Facebook")
User.first.ephemeral_links.create(destination_url: "https://www.twitter.com", slug: SlugGenerator.generate, name: "Twitter")
User.first.ephemeral_links.create(destination_url: "https://www.instagram.com", slug: SlugGenerator.generate, name: "Instagram")
User.first.ephemeral_links.create(destination_url: "https://www.youtube.com", slug: SlugGenerator.generate, name: "YouTube")
User.first.ephemeral_links.create(destination_url: "https://www.linkedin.com", slug: SlugGenerator.generate, name: "LinkedIn")

User.second.regular_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, name: "Google")
User.second.regular_links.create(destination_url: "https://www.facebook.com", slug: SlugGenerator.generate, name: "Facebook")

User.second.temporal_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "Google")
User.second.temporal_links.create(destination_url: "https://www.facebook.com", slug: SlugGenerator.generate, expiration_date: Time.now + 1.day, name: "Facebook")

User.second.private_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, password: "password", name: "Google")

User.second.ephemeral_links.create(destination_url: "https://www.google.com", slug: SlugGenerator.generate, name: "Google")
User.second.ephemeral_links.create(destination_url: "https://www.facebook.com", slug: SlugGenerator.generate, name: "Facebook")
User.second.ephemeral_links.create(destination_url: "https://www.twitter.com", slug: SlugGenerator.generate, name: "Twitter")
User.second.ephemeral_links.create(destination_url: "https://www.instagram.com", slug: SlugGenerator.generate, name: "Instagram")
User.second.ephemeral_links.create(destination_url: "https://www.youtube.com", slug: SlugGenerator.generate, name: "YouTube")

# Accesos

User.first.links.each do |link|
    20.times do
        link.link_accesses.create(accessed_at: Time.now, ip_address: "192.168.0.#{rand(1..255)}")
    end
end

