Billy.configure do |c|
  c.cache = true
  c.persist_cache = true
end

Capybara.default_driver = :poltergeist_billy
