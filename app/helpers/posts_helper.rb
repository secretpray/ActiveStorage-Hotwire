module PostsHelper
  def set_title(object)
    object.new_record? ? 'Create' : 'Update'
  end
end
