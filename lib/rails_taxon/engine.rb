module RailsTaxon
  class Engine < ::Rails::Engine

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/rails_taxon"
    ]

  end
end
