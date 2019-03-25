require 'byebug'
require 'ActiveRecord'
require_relative '../app/models/application_record'
require_relative '../app/models/category'
require_relative 'dataloader'
require 'json'
require 'rest-client'


def main
  l = Dataloader.new
  l.load_data
end

  main
