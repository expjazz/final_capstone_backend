# class ItemsController < ApplicationController
#   def create 
#     byebug
#     image = Cloudinary::Uploader.upload(params[:image])
#     byebug
#     item = Item.create(image: image["url"])
#     byebug    render json: item
#   end

# end
