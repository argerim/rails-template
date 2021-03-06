generators = <<GENERATORS

    #Do not generate specs for views and requests.
    #Also, do not generate assets.
    config.generators do |g|
      g.view_specs false
      g.assets false
      g.integration_tool false
    end
GENERATORS
in_root do
  inject_into_file 'config/application.rb', generators, {after: "Rails::Application", verbose: false}
end
git :add => 'config/application.rb'
git :commit => "-qm 'Adding generators.'"
