# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130604234903) do

  create_table "animals", :force => true do |t|
    t.string   "center_xid",     :limit => 8,  :null => false
    t.integer  "center_url_xid", :limit => 8,  :null => false
    t.string   "url",                          :null => false
    t.string   "name",           :limit => 63
    t.integer  "age"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "captioned_images", :force => true do |t|
    t.integer  "source_image_id"
    t.string   "title"
    t.string   "text_top"
    t.string   "text_bottom"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "source_images", :force => true do |t|
    t.string   "category"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "animal_id"
  end

end
