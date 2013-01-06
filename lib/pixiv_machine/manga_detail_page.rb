require_relative 'detail_page'

class PixivMachine::MangaDetailPage < PixivMachine::DetailPage
  MANGA_PATTERN = 'section#image div.image-container img'
  def contents
    contents = []

    get(manga_detail_path(id)).page.search(MANGA_PATTERN).each do |image|
      contents << build_content(image)
    end

    contents
  end
end
