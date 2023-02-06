class InstallEvematic < ActiveRecord::Migration[7.1]
  def change
    create_table :esi_alliances, id: :integer do |t|
      t.integer :creator_corporation_id, null: false
      t.integer :creator_id, null: false
      t.date :date_founded, null: false
      t.string :esi_etag
      t.datetime :esi_last_modified_at
      t.datetime :esi_expires_at
      t.integer :executor_corporation_id
      t.integer :faction_id
      t.string :name, null: false
      t.string :ticker, null: false, index: {unique: true}
      t.timestamps null: false
    end

    create_table :esi_corporations, id: :integer do |t|
      t.references :alliance,
        type: :integer,
        foreign_key: {to_table: :esi_alliances}

      t.integer :ceo_id, null: false
      t.integer :creator_id, null: false
      t.date :date_founded, null: false
      t.text :description
      t.string :esi_etag
      t.datetime :esi_last_modified_at
      t.datetime :esi_expires_at
      t.integer :faction_id
      t.integer :home_station_id
      t.integer :member_count, null: false
      t.string :name, null: false
      t.bigint :shares
      t.decimal :tax_rate, null: false
      t.string :ticker, null: false, index: {unique: true}
      t.string :url
      t.boolean :war_eligible
      t.timestamps null: false
    end

    create_table :esi_characters, id: :integer do |t|
      t.references :alliance,
        type: :integer,
        foreign_key: {to_table: :esi_alliances}

      t.references :corporation,
        type: :integer,
        null: false,
        foreign_key: {to_table: :esi_corporations}

      t.date :birthday, null: false
      t.integer :bloodline_id, null: false
      t.text :description
      t.string :esi_etag
      t.datetime :esi_last_modified_at
      t.datetime :esi_expires_at
      t.integer :faction_id
      t.string :gender, null: false
      t.string :name, null: false
      t.integer :race_id, null: false
      t.decimal :security_status
      t.string :title
      t.timestamps null: false
    end

    create_table :accounts, id: :integer do |t|
      t.boolean :admin
      t.timestamps null: false
    end

    create_table :identities, id: :integer do |t|
      t.references :account,
        type: :integer,
        null: false,
        index: false,
        foreign_key: {to_table: :accounts}

      t.references :character,
        type: :integer,
        null: false,
        index: false,
        foreign_key: {to_table: :esi_characters}

      t.boolean :main
      t.timestamps null: false

      t.index %i[account_id character_id], unique: true
      t.index %i[account_id main], unique: true
    end

    create_table :access_rules, id: :integer do |t|
      t.references :principal, polymorphic: true, null: false, index: {unique: true}
      t.string :action, default: "deny", null: false
      t.datetime :created_at, null: false
    end
  end
end
