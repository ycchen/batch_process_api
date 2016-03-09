## README

This is an example application to show how to handle batch create and update in Rails 5 api only application

Things you may want to cover:

* Currently only rspec-rails 3.1.0 works in Rails 5 

- rails new batch_process_api --api

- Added active_model_serializers, rspec-rails, shoulda-matchers, factory_girl_rails and ffaker gems to Gemfile

  - rails g rspec:install

- Added require 'shoulda/matchers' and require 'ffaker' in spec/rails_helper.rb

- Created and added ActiveModle::Serializer.config.adapter = ActiveModel::Serializer::Adapter::JsonApi in config/initilizers/ams_json_serializer.rb (in order to use this JSON string format)
      
{"data" => [
           {"id"=>1, "name"=>"John Doe", "created_at"=>"2016-03-09T13:24:52.211Z", "updated_at"=>"2016-03-09T13:24:52.211Z"}, 
           {"id"=>2, "name"=>"Jane Doe", "created_at"=>"2016-03-09T13:24:52.213Z", "updated_at"=>"2016-03-09T13:24:52.213Z"}
         ]   
       }
       
- rails g scaffold author name

