class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def h
    @template
  end

  def avatar
    if @object.images.default
      h.image_tag @object.images.default.file.url(:thumb),
        class: "img-responsive img-thumbnail"
    else
      h.image_tag "/assets/no_user.png",
        class: "img-responsive img-thumbnail"
    end
  end
end
