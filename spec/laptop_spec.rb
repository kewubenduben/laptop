require 'spec_helper'

describe 'Laptop applied to a vagrant box' do
  laptop_vagrantfiles.each do |vagrantfile|
    it "should run laptop successfully for #{vagrantfile}" do
      link_vagrantfile(vagrantfile)
      destroy_vagrant
      bring_vagrant_up

      expect(laptop_application_to(vagrantfile)).to run_successfully
    end
  end
end
