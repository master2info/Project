class Patient < ActiveRecord::Base
  attr_accessible :name, :first_name, :archived
end
