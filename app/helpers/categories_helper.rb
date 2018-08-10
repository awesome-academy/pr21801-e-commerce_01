module CategoriesHelper
  def sub(level)
    "#{'-' * level}"
  end

  def options(array = [], parent_id = nil, level = 0)
    Category.roots(parent_id).each do |category|
      array << [sub(level) + category.name, category.id]
      options(array, category.id, level + 1)
    end
    array
  end

  def root(category)
    if category.parent == nil
      return category
    else
      parent = Category.by_id(category.parent_id).first
      root(parent)
    end
  end

  def ancestors(array = [], category)
    if category.parent_id == nil
      array << category
      array.shift
      return array.reverse
    end
    array << category
    parent = Category.by_id(category.parent_id).first
    ancestors(array, category.parent)
  end
end
