class Movie < ActiveRecord::Base

  def all_ratings
#    return ['G','PG','PG-13','R', 'NC-17']
    return [{'G' => 1,'PG' => 1,'PG-13' => 1,'R' => 1, 'NC-17' => 1}]

  end
end
