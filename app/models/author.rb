class Author < ApplicationRecord
	validates :name, presence: true, uniqueness: true, length: {minimum: 5}

	def self.batch_create(author_content)
		Author.transaction do
			body = JSON.parse(author_content)
			body["data"].each do |author_hash|
				Author.create!(author_hash["attributes"])	
			end
		end
	end

	def self.batch_update(author_content)
		Author.transaction do
			body = JSON.parse(author_content)
			body["data"].each do |author_hash|
				author = Author.find(author_hash["id"])
				author.update!(author_hash["attributes"]) if author
			end
		end
	end
	
end
