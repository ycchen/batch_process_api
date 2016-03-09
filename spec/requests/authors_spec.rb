require 'rails_helper'

RSpec.describe "Authors", :type => :request do
  let(:headers) { {'Content-Type': 'application/json'}}
  let(:who) {FFaker::Name.name}

  describe "GET /authors" do
    it "works! (now write some real specs)" do
      FactoryGirl.create :author, name: "John Doe"
      FactoryGirl.create :author, name: "Jane Doe"
      get authors_path
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      puts body.inspect
      
      # {"data" => [
      #     {"id"=>1, "name"=>"John Doe", "created_at"=>"2016-03-09T13:24:52.211Z", "updated_at"=>"2016-03-09T13:24:52.211Z"}, 
      #     {"id"=>2, "name"=>"Jane Doe", "created_at"=>"2016-03-09T13:24:52.213Z", "updated_at"=>"2016-03-09T13:24:52.213Z"}
      #   ]   
      # }
      
      #JSON string example
      # {
      #    "data": [
      #      {
      #        "id": "1",
      #        "type": "authors",
      #        "attributes": {
      #          "name": "John Doe"
      #        }
      #      },
      #      {
      #        "id": "2",
      #        "type": "authors",
      #        "attributes": {
      #          "name": "Damien White"
      #        }
      #      }
      #    ]
      #  }
    end
  end

  describe "GET /authors/:id" do
    it "GET /authors/1" do
      FactoryGirl.create :author, name: who
      get "/authors/1"
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      puts body
      author_name = body["data"]["attributes"]["name"]
      expect(author_name) == who
      puts who
    end
  end

  describe "POST /authors/" do
    it "POST /authors/" do
      author={
        data: {
          type: "authors",
          attributes:{
            name: who
          }
        }
      }
      post "/authors/",
        params: author.to_json,
        headers: headers
      expect(response).to have_http_status(201)
      body = JSON.parse(response.body)

      author_name = body["data"]["attributes"]["name"]
      expect(author_name) == who
    end

    #batch_create
    it "POST /authors/batch_create" do
      author= Hash.new
      author["data"]=[]
      10.times do
        author["data"].push({type: "authors", attributes:{name: FFaker::Name.name}})
      end

      # {"data" => [
      #     {"type" => "authors","attributes"=>{"name"=>"John Doe"}}, 
      #     {"type" => "authors","attributes"=>{"name"=>"Jane Doe"}}
      #   ]   
      # }

      post "/authors/batch_create",
        params: author.to_json,
        headers: headers
      body = JSON.parse(response.body)
      puts body
    end
  end

  describe "PUT /authors/:id" do
    it "PUT /authors/:id" do
      new_name = FFaker::Name.name
      FactoryGirl.create :author, name: who, id:1
      author = {
        data: {
          type: "authors",
          id: 1,
          attributes:{
            name: new_name
          }
        }
      }

      put "/authors/1",
        params: author.to_json,
        headers: headers

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      author_name = body["data"]["attributes"]["name"]
      expect(author_name) == new_name
    end

    #batch_update    
    it "PUT /authors/batch_update" do
      for i in 1..10 do
        FactoryGirl.create :author, name: FFaker::Name.name, id:i
      end
      author = {"data":[
                {"id":"1","type":"authors","attributes":{"name":"Trudie Towne"}},
                {"id":"2","type":"authors","attributes":{"name":"Sabina Turner Jr."}},
                {"id":"3","type":"authors","attributes":{"name":"Armando Hoppe"}},
                {"id":"4","type":"authors","attributes":{"name":"Casper Mueller"}},
                {"id":"5","type":"authors","attributes":{"name":"Liza Ortiz"}},
                {"id":"6","type":"authors","attributes":{"name":"Norris Kreiger"}},
                {"id":"7","type":"authors","attributes":{"name":"Albert Rath"}},
                {"id":"8","type":"authors","attributes":{"name":"Everardo Howell"}},
                {"id":"9","type":"authors","attributes":{"name":"Isabell Koch I"}},
                {"id":"10","type":"authors","attributes":{"name":"Violette Macejkovic"}}
                ]
              }
      put "/authors/batch_update",
        params: author.to_json,
        headers: headers

      body = JSON.parse(response.body)
      puts body

    end
  end


end
