class Bookmark < ApplicationRecord
  belongs_to :site

  validates :title, presence: true, length: { minimum: 2 }
  validates :url, presence: true, format: { with: /(http:\/\/|https:\/\/)?(www.)?([a-zA-Z0-9]+).[a-zA-Z0-9]*.[a-z]{3}.?([a-z]+)?/, message: "must be a valid URL" }
  validates :shortening, length: { maximum: 10 }

  def top_level_url
    URI.parse(self.url).host.downcase
  end

  before_validation do
    self.site = Site.first_or_initialize({url: self.top_level_url})
  end

end
