module RailsTaxon
  class Engine < ::Rails::Engine

    initializer 'rails_taxon.assets.precompile' do |app|
      app.config.assets.precompile += ['rails_taxon_manifest.js']
    end

  end
end
