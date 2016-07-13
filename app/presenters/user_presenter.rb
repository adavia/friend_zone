class UserPresenter < BasePresenter
  presents :user

  def tabs
    if h.params[:tab] == "images"
      images
    elsif h.params[:tab] == "profile"
      h.content_tag :div, h.render("profile", user: user), class: "profile-info"
    else
      feed
    end
  end

  def images
    handle_none user.images do
      h.content_tag :div, h.content_tag(:div, h.render(user.images), class: "row"),
        class: "profile-images"
    end
  end

  def feed
    handle_none user.posts do
      h.content_tag :div, h.render(user.posts),
        class: "profile-feed"
    end
  end

  private

  def handle_none(value)
    if value.any?
      yield
    else
      h.content_tag :div, "NO CURRENT DATA TO SHOW", class: "default-message"
    end
  end
end
