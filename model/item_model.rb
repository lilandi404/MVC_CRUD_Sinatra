require_relative '../db/db_connection'


class Items
    attr_accessor :id, :name, :price, :categories, :category

    def initialize (params)
        @id = params[:id]
        @name = params[:name]
        @price = params[:price]
        @category = params[:category]
        @categories = []
    end

    def self.get_all_items
        client = create_db_client
        rawData = client.query("select items.id, items.name, items.price, categories.name As 'categori'
            FROM items
            JOIN item_categories ON items.id = item_categories.item_id
            JOIN categories ON item_categories.category_id = categories.id order by categories.id;")
        items = Array.new
        rawData.each do |data|
            item = Items.new({
                id: data["id"],
                name: data["name"],
                price: data["price"],
                category: data["categori"]
            })
            items.push(item)
        end
        items
    end

    def self.item_by_category(categories)
        client = create_db_client
        rawData = client.query("select items.id, items.name, items.price, categories.name As 'categori'
            FROM items
            JOIN item_categories ON items.id = item_categories.item_id
            JOIN categories ON item_categories.category_id = categories.id where category_id='#{categories.id}'")
        items = Array.new
        rawData.each do |data|
            item = Items.new({
                id: data["id"],
                name: data["name"],
                price: data["price"],
                category: data["categori"],
                categories: categories
            })
            items.push(item)
        end
        items
    end

    def insert_item
        client = create_db_client
        res_query = client.query("INSERT INTO items (name, price) VALUES ('#{name}', '#{price}')")
        id = client.last_id
        res_query = client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{id}', '#{category}')")
    end

    def delete_item
        client = create_db_client
        res_query = client.query("DELETE FROM item_categories WHERE item_id='#{id}'")
    end

    def update_item_model
        client = create_db_client
        res_query = client.query("UPDATE item_categories SET category_id='#{category}' where item_id='#{id}'")
        res_query = client.query("UPDATE items SET name='#{name}', price='#{price}' where id='#{id}'")
    end


    def get_item_by_id(id)
        client = create_db_client 
        rawData = client.query("select items.id, items.name, items.price, categories.name As 'categori'
            FROM items
            JOIN item_categories ON items.id = item_categories.item_id
            JOIN categories ON item_categories.category_id = categories.id
            WHERE items.id = #{id};")
        items = Array.new
        rawData.each do |data|
            item = Items.new(data["id"], data["name"], data["price"], data["categori"])
            items.push(item)
        end
        items
    end

    def get_all_item_by_price
        client = create_db_client
        res_query = client.query("SELECT * FROM items WHERE price > 7000 ")
    end
end