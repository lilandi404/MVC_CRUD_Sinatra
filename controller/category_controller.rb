require_relative '../model/category_model'

class CategoryController

    def list_categories
        @tittle = "Categories"
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/categories.erb"))
        renderer.result(binding)
    end

    def list_items_by_categories(params)
        category_id = Category.new({
            id: params["category_id"]
        })
        id = category_id.id
        items = Category.find_item_by_category(id)
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/item_categories.erb"))
        renderer.result(binding)
    end

    def insert_category(params)
        category = Category.new({
            name: params["name"]
        })
        category.insert_category
    end

    def update_category(params)
        category = Category.new({
            id: params["id"],
            name: params["name"]
        })
        category.update_category
    end

    def delete_category(params)
        category = Category.new({
            id: params["id"]
        })
        category.delete_category
    end
end