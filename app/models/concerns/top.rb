module Top
  extend ActiveSupport::Concern

  module ClassMethods

    def top(model, amount)
      sorted_by_rating_in_desc_order = model.all.sort_by{ |b| -(b.average_rating||0) }
      return sorted_by_rating_in_desc_order.first(amount)
    end

  end

end