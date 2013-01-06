require_relative 'illust_detail_page'
require_relative 'manga_detail_page'

class PixivMachine::DetailPageFactory
  @@concrete_map = {
    'big' => PixivMachine::IllustDetailPage,
    'manga' => PixivMachine::MangaDetailPage
  }

  def self.detail_page_instance(login_id, password, content_uri, agent)
    mode = content_uri.match(/mode=(big|manga)/).to_a[1]
    id = content_uri.match(/illust_id=(\d+)/).to_a[1]

    if mode && id
      concrete = @@concrete_map[mode]
      return concrete.new(login_id, password, id, agent) if concrete
    end
    
    nil
  end
end
