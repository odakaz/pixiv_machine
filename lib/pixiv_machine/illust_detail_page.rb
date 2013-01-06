require_relative 'detail_page'

class PixivMachine::IllustDetailPage < PixivMachine::DetailPage
  ILLUST_PATTERN = 'div a img'
  def contents
    contents = []

    image = get(illust_detail_path(id)).page.search(ILLUST_PATTERN).first

    contents = [build_content(image)] if image

    contents
  end
end
