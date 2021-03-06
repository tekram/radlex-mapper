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

ActiveRecord::Schema.define(:version => 20170120041916) do

  create_table "abreviations", :force => true do |t|
    t.string   "name"
    t.string   "abreviated_name"
    t.integer  "rid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "conjunctions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "edges", :force => true do |t|
    t.integer  "term_id"
    t.integer  "node_id"
    t.integer  "weight"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "procedures", :id => false, :force => true do |t|
    t.integer  "rpid"
    t.string   "short_name"
    t.string   "long_name"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "auto_short_name"
    t.string   "auto_long_name"
  end

  create_table "procedures_terms", :id => false, :force => true do |t|
    t.integer "procedure_id"
    t.integer "term_id"
  end

  create_table "terms", :id => false, :force => true do |t|
    t.string   "name"
    t.integer  "rid"
    t.integer  "rid_parent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
