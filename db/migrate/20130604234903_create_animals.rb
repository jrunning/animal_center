class CreateAnimals < ActiveRecord::Migration
  include ActionView::Helpers::TextHelper.send(:module_function, :pluralize)

  def up
    add_column :source_images, :animal_id, :integer

    create_table :animals do |t|
      t.string  :center_xid,      limit: 8,   null: false
      t.integer :center_url_xid,  limit: 8,   null: false
      t.string  :url,                         null: false
      t.string  :name,            limit: 63
      t.integer :age,             limit: 10

      t.timestamps
    end

    create_animals_for_existing_source_images

    remove_column :source_images, :external_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  private
  def create_animals_for_existing_source_images
    puts "Creating Animals from existing SourceImages..."

    SourceImage.reset_column_information
    Animal.reset_column_information

    @animals = {}

    SourceImage.all.each do |img|
      animal = @animals[img.external_id]

      if animal.nil?
        animal = @animals[img.external_id] = Animal.new(
          center_url_xid: img.external_id,
          url:            "http://www.icanimalcenter.org/indexa.php?id=#{img.external_id}"
        )

        attrs = scrape_animal_table(animal, ['Center ID', 'Name', 'Age'])

        animal.attributes = {
          center_xid: attrs['Center ID'],
          name:       attrs['Name'],
          age:        attrs['Age']
        }

        animal.save!
      end

      img.animal = animal
      img.save!
    end

    puts "Created #{pluralize Animal.count, 'Animal'} from #{pluralize SourceImage.count, 'SourceImage'}."
  end

  def scrape_animal_table(animal, table_headings)
    require 'mechanize'

    page = Mechanize.new.get("http://www.icanimalcenter.org/animal.php?id=#{animal.center_url_xid}")

    table = page.search("table table:contains('Center ID')")

    left_cols = table.search(
      table_headings.map {|text| "td:first-of-type:contains('#{text}')" }.join ","
    )

    Hash[ left_cols.map {|td| [td.text, td.next_sibling.text] } ]
  end
end
