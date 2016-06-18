module ApplicationHelper
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
end
