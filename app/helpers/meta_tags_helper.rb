module MetaTagsHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : DEFAULT_META["SportMe | Reimagine Your Fitness Experience"]
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : DEFAULT_META["A coach-centric app to find coaches and classes you love."]
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META["https://res.cloudinary.com/dcwfy3dua/image/upload/v1640002842/sportmelite/pexels-li-sun-2294361_ob5hiw.jpg"])
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end
end
