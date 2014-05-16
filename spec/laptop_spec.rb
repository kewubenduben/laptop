require 'spec_helper'

describe 'Laptop applied to a vagrant box' do
  after(:each) do
    prepare_for_packaging
  end

  laptop_vagrantfiles.each do |vagrantfile|
    it "should run laptop successfully for #{vagrantfile}" do
      # build_laptop_script
      link_vagrantfile(vagrantfile)
      destroy_vagrant
      bring_vagrant_up

      expect { laptop_setup }.not_to raise_error

      expect(active_shell).to match /zsh/
      expect(installed_ruby_version).to eq latest_ruby_version
      expect { generate_rails_app }.not_to raise_error
      expect { scaffold_and_model_generation }.not_to raise_error
      expect { database_migration }.not_to raise_error
      expect { silver_searcher_test }.not_to raise_error
    end
  end
end
