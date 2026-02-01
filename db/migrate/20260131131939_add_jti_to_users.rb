class AddJtiToUsers < ActiveRecord::Migration[8.1]
  def change
    # Primeiro adiciona a coluna permitindo null
    add_column :users, :jti, :string

    # Preenche os registros existentes com um valor único
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE users SET jti = gen_random_uuid()::text WHERE jti IS NULL
        SQL
      end
    end

    # Agora aplica a restrição NOT NULL
    change_column_null :users, :jti, false

    add_index :users, :jti, unique: true
  end
end
