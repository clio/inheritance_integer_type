# InheritanceIntegerType

This gem makes it easy to have int (or tinyint) 'type' fields in your Rails database, instead of strings. It makes much more efficient use of disk space and RAM, especially if the column is indexed.

The example provided by the Rails documentation shows something like this:
```ruby
class Company < ActiveRecord::Base; end
class Firm < Company; end
class Client < Company; end
class PriorityClient < Client; end
```

With a migration that looks something like:
```ruby
class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string  :name
      t.string  :type
    end
  end
end
```

The problem with this approach is that `type` is a string (and by default it is 255 characters). This is a little ridiculous. For comparison, if we had a state machine with X states, would we describe the states with strings `"State1", "State2", etc` or would we just enumerate the state column and make it an integer? This gem will allow us to use an integer for the `type` column. 

## Installation

Add this line to your application's Gemfile:

    gem 'inheritance_integer_type'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inheritance_integer_type

## Usage

The gem is pretty straightforward to use.

First, set the `integer_inheritance` value on each of the subclasses. 
```ruby
class Firm < ActiveRecord::Base
  self.integer_inheritance = 1
end
 
class Client < ActiveRecord::Base
  self.integer_inheritance = 2
end
 
class PriorityClient < ActiveRecord::Base
  self.integer_inheritance = 3
end
```


Note: The mapping here can start from whatever integer you wish, but I would advise not using 0. The reason being that if you had a new class, for instance `PriorityFirm`,  but forgot to include set the mapping, it would effectively get `to_i` called on it and stored in the database. `"Priority".to_i == 0`, so if your mapping included 0, this would create a weird bug. 

If you want to convert a polymorphic association that is already a string, you'll need to set up a migration. (Assuming SQL for the time being, but this should be pretty straightforward.)
```ruby
class CompanyToIntegerType < ActiveRecord::Migration
  
  def up
    change_table :companies do |t|
      t.integer :new_type
    end

    execute <<-SQL
      UPDATE companies
      SET new_type = CASE type
                     WHEN 'Firm' THEN 1
                     WHEN 'Client' THEN 2
                     WHEN 'PriorityClient' THEN 3
                     END
    SQL

    change_table :companies, :bulk => true do |t|
      t.remove :type
      t.rename :new_type, :type
    end
  end

  def down
    change_table :companies do |t|
      t.string :new_type
    end

    execute <<-SQL
      UPDATE companies
      SET new_type = CASE imageable_type
                     WHEN 1 THEN 'Firm'
                     WHEN 2 THEN 'Client'
                     WHEN 3 THEN 'PriorityClient'
                     END
    SQL

    change_table :companies, :bulk => true do |t|
      t.remove :type
      t.rename :new_type, :type
    end
  end
end
```

Lastly, you will need to be careful of any place where you are doing raw SQL queries with the string (`type = 'Firm'`). They should use the integer instead.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/inheritance_integer_type/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
