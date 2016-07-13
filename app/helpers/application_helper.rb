module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Friend Zone").join(" - ")
      end
    end
  end

  def active_link(path)
    if request.fullpath == path
      "active"
    end
  end

  def user_avatar(user)
    if user.images.default
      user.images.default.file.url(:thumb)
    else
      "/assets/no_user.png"
    end
  end
end
