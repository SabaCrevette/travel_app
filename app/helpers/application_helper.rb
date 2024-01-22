module ApplicationHelper
  def default_meta_tags
    {
      site: 'Picto Memory',
      title: '旅の思い出彩りアプリ',
      reverse: true,
      charset: 'utf-8',
      description: '旅の思い出を投稿し、日本地図を彩りませんか？',
      keywords: '旅行, 思い出, 投稿, 日本地図', # キーワードを「,」区切りで設定する
      canonical: request.original_url, # 優先するurlを指定する
      separator: '|', # Webサイト名とページタイトルを区切るために使用されるテキスト
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('OGP.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('OGP.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@saba7678pg',
        image: image_url('OGP.png')
      }
    }
  end
end
