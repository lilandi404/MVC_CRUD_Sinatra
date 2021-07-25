require 'sinatra'
require_relative './controller/item_Controller'
require_relative './controller/category_Controller'

get '/' do
    controller = ItemsController.new
    controller.list_items
end

get '/items/new' do
    controller = ItemsController.new
    controller.create_item_form
end

post '/items/create' do
    controller = ItemsController.new
    controller.create_item(params)
    redirect "/"
end

put '/items/update' do
    controller = ItemsController.new
    controller.update_item(params)
    redirect '/'
end

delete '/items/delete' do
    controller = ItemsController.new
    controller.delete_item(params)
    redirect "/"
end

get '/categories' do
    controller = CategoryController.new
    controller.list_categories
end

post '/categories/create' do
    controller = CategoryController.new
    controller.insert_category(params)
    redirect '/categories'
end

put '/categories/update' do
    controller = CategoryController.new
    controller.update_category(params)
    redirect '/categories'
end

post '/categories/delete' do
    controller = CategoryController.new
    controller.delete_category(params)
    redirect '/categories'
end

get '/categories/:category_id/items' do
    controller = CategoryController.new
    controller.list_items_by_categories(params)
end

post '/categories/:category_id/create_items' do
    controller = ItemsController.new
    controller.create_item(params)
    redirect "/categories/#{(params["category_id"])}/items"
end

put '/categories/:category_id/update_items' do
    controller = ItemsController.new
    controller.update_item(params)
    redirect "/categories/#{(params["category_id"])}/items"
end

delete '/categories/:category_id/hapus_items' do
    controller = ItemsController.new
    controller.delete_item(params)
    redirect "/categories/#{(params["category_id"])}/items"
end