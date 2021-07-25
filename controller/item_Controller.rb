require_relative '../model/item_model'
require_relative '../model/category_model'

class ItemsController

    def list_items
        @tittle = "Items"
        items = Items.get_all_items
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end

    def create_item(params)
        item = Items.new({
            name: params["name"],
            price: params["price"],
            category: params["category"]
        })
        item.insert_item
    end

    def create_item_form
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/create.erb"))
        renderer.result(binding)
    end

    def delete_item(params)
        id = Items.new({
            id: params["id"]
        })
        id.delete_item
    end

    def update_item(params)
        items = Items.new({
            id: params["id"],
            name: params["name"],
            price: params["price"],
            category: params["category"]
        })
        items.update_item_model
    end
end