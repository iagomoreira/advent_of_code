module ItemHelper
  def item_value(item)
    [*("a".."z"), *("A".."Z")].index(item) + 1
  end
end
