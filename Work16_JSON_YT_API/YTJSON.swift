//
//  YTJSON.swift
//  Work16_JSON_YT_API
//
//  Created by 彭有駿 on 2022/5/5.
//

import Foundation

//歌曲內容
struct YTMusic:Codable{
    let kind:String
    let etag:String
    let nextPageToken:String
    
    let items:[Items]
    struct Items:Codable{
        let kind:String
        let etag:String
        let snippet:Snippet
        let contentDetails:ContentDetails
        
    struct Snippet:Codable{
        let publishedAt:Date//發布時間
        let title:String//歌名
        let thumbnails: Thumbnails
        let resourceId: ResourceId
        }
        
    struct Thumbnails:Codable{
        let high: High
        }
        
    struct High: Codable {
        let url: URL//圖片
        }
        
    struct ResourceId: Codable {
        let videoId: String
        }
        
    struct ContentDetails: Codable {
        let videoId: String             
        }
        
    }
}

//頻道內容
struct YTPageMessage:Codable{
    let kind:String
    let etag:String
    
    let items:[Items]
    struct Items:Codable{
        let snippet:Snippet
        let statistics:Statistics
        let brandingSettings:BrandingSettings
    }
    struct Snippet:Codable{
        let title:String//頻道主人
        let description: String//頻道簡介
        let thumbnails:Thumbnails
    }
    struct Thumbnails: Codable {
        let high: High//圖片
        struct High : Codable {
            let url: URL            //大頭貼縮圖
        }
    }
    struct Statistics:Codable {
        let viewCount: String           //總觀看
        let subscriberCount: String     //訂閱人數
        let videoCount: String          //影片總數
    }
    struct BrandingSettings:Codable {
        let image: Image
        struct Image:Codable {
            let bannerExternalUrl: URL  //封面照片
        }
    }
    
}
