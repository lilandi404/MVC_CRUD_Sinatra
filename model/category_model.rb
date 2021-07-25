require_relative '../db/db_connection'
require_relative './item_model'

class Category
    attr_accessor :id, :name, :items

    def initialize(params)
        @id = params[:id]
        @name = params[:name]
        @items = []
    end

    def self.get_all_categories
        client = create_db_client
        rawData = client.query("select * from categories")
        categories = Array.new
        rawData.each do |data|
            category = Category.new({
                id: data["id"], 
                name: data["name"]
            })
            categories.push(category)
        end
        categories
    end 

    def self.find_category(id)
        client = create_db_client
        rawData = client.query("select * from categories where id='#{id}'")
        data = rawData.first
        Category.new({id: data["id"], name: data["name"]})
    end

    def self.find_item_by_category(id)
        categories = find_category(id)
        categories.items = Items.item_by_category(categories)
        categories
    end

    def insert_category
        client = create_db_client
        res_query = client.query("INSERT INTO categories (name) VALUES ('#{name}')")
    end

    def delete_category
        client = create_db_client
        res_query = client.query("DELETE FROM categories where id='#{id}'")
    end

    def update_category
        client = create_db_client
        res_query = client.query("UPDATE categories SET name='#{name}' where id='#{id}'")
    end

end
