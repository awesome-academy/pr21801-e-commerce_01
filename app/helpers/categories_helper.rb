module CategoriesHelper
  def options(category)
    nested_set_options(category) do |i|
      "#{'-' * i.level} #{i.name}"
    end
  end
end
