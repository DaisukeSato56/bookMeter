require 'net/http'
require 'uri'
require 'json'

class HomeController < ApplicationController
  def index
  end

  def search
    keyword = params[:keyword]

    url = URI.parse(URI.escape("https://www.googleapis.com/books/v1/volumes?q=#{keyword}"))
    res = Net::HTTP.start(url.host, url.port, use_ssl: true){|http|
      http.get(url.path + "?" + url.query);
    }
    obj = JSON.parse(res.body)

    @bookTitles = []
    @bookDescription = []
    num = obj["items"].count
    bookItems = obj["items"][0..num]
    bookItems.each do |title|
      @bookTitles << title["volumeInfo"]["title"]
      @bookDescription << title["volumeInfo"]["description"]
    end
  end
end

# {
#  "kind": "books#volumes",
#  "totalItems": 4269,
#  "items": [
#   {
#    "kind": "books#volume",
#    "id": "BcPCDQAAQBAJ",
#    "etag": "JcbOUT08qyg",
#    "selfLink": "https://www.googleapis.com/books/v1/volumes/BcPCDQAAQBAJ",
#    "volumeInfo": {
#     "title": "僕は女の子になりたい",
#     "authors": [
#      "七木桂"
#     ],
#     "publisher": "シュークリーム",
#     "description": "「本物の女の子だったら椎名くんにも告れるのに」男子中学生の草介は女の子に生まれたかった男の子。コッソリ女装して入ってみた店で、憧れの椎名君と偶然遭遇！ 正体を隠して何度もデートをする内に、草介の中の≪アタシ≫は止まらなくなってきて――。女装少年と男前少年の秘密のドキドキラブ☆",
#     "industryIdentifiers": [
#      {
#       "type": "OTHER",
#       "identifier": "PKEY:BT000022732500100101900209"
#      }
#     ],
#     "readingModes": {
#      "text": true,
#      "image": true
#     },
#     "printType": "BOOK",
#     "categories": [
#      "Comics & Graphic Novels"
#     ],
#     "maturityRating": "NOT_MATURE",
#     "allowAnonLogging": false,
#     "contentVersion": "1.1.1.0.preview.3",
#     "imageLinks": {
#      "smallThumbnail": "http://books.google.com/books/content?id=BcPCDQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
#      "thumbnail": "http://books.google.com/books/content?id=BcPCDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
#     },
#     "language": "ja",
#     "previewLink": "http://books.google.co.jp/books?id=BcPCDQAAQBAJ&pg=PP1&dq=%E5%83%95&hl=&cd=1&source=gbs_api",
#     "infoLink": "https://play.google.com/store/books/details?id=BcPCDQAAQBAJ&source=gbs_api",
#     "canonicalVolumeLink": "https://market.android.com/details?id=book-BcPCDQAAQBAJ"
#    },
#    "saleInfo": {
#     "country": "JP",
#     "saleability": "FOR_SALE",
#     "isEbook": true,
#     "listPrice": {
#      "amount": 216.0,
#      "currencyCode": "JPY"
#     },
#     "retailPrice": {
#      "amount": 194.0,
#      "currencyCode": "JPY"
#     },
#     "buyLink": "https://play.google.com/store/books/details?id=BcPCDQAAQBAJ&rdid=book-BcPCDQAAQBAJ&rdot=1&source=gbs_api",
#     "offers": [
#      {
#       "finskyOfferType": 1,
#       "listPrice": {
#        "amountInMicros": 2.16E8,
#        "currencyCode": "JPY"
#       },
#       "retailPrice": {
#        "amountInMicros": 1.94E8,
#        "currencyCode": "JPY"
#       }
#      }
#     ]
#    },
#    "accessInfo": {
#     "country": "JP",
#     "viewability": "PARTIAL",
#     "embeddable": true,
#     "publicDomain": false,
#     "textToSpeechPermission": "ALLOWED",
#     "epub": {
#      "isAvailable": true,
#      "acsTokenLink": "http://books.google.co.jp/books/download/%E5%83%95%E3%81%AF%E5%A5%B3%E3%81%AE%E5%AD%90%E3%81%AB%E3%81%AA%E3%82%8A%E3%81%9F%E3%81%84-sample-epub.acsm?id=BcPCDQAAQBAJ&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
#     },
#     "pdf": {
#      "isAvailable": true,
#      "acsTokenLink": "http://books.google.co.jp/books/download/%E5%83%95%E3%81%AF%E5%A5%B3%E3%81%AE%E5%AD%90%E3%81%AB%E3%81%AA%E3%82%8A%E3%81%9F%E3%81%84-sample-pdf.acsm?id=BcPCDQAAQBAJ&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
#     },
#     "webReaderLink": "http://play.google.com/books/reader?id=BcPCDQAAQBAJ&hl=&printsec=frontcover&source=gbs_api",
#     "accessViewStatus": "SAMPLE",
#     "quoteSharingAllowed": false
#    },
#    "searchInfo": {
#     "textSnippet": "「本物の女の子だったら椎名くんにも告れるのに」男子中学生の草介は女の子に生まれたかった男の子。コッソリ女装して入ってみた店で、憧れの椎名君と偶然遭遇！ ..."
#    }
#   },
