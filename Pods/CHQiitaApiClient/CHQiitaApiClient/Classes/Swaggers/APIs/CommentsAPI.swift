//
// CommentsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift



open class CommentsAPI: APIBase {
    /**

     - parameter commentId: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func commentsCommentIdDelete(commentId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        commentsCommentIdDeleteWithRequestBuilder(commentId: commentId).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**

     - parameter commentId: (path)  
     - returns: Observable<Void>
     */
    open class func commentsCommentIdDelete(commentId: String) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            commentsCommentIdDelete(commentId: commentId) { error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next())
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - DELETE /comments/{comment_id}
     
     - parameter commentId: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func commentsCommentIdDeleteWithRequestBuilder(commentId: String) -> RequestBuilder<Void> {
        var path = "/comments/{comment_id}"
        path = path.replacingOccurrences(of: "{comment_id}", with: "\(commentId)", options: .literal, range: nil)
        let URLString = CHQiitaApiClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CHQiitaApiClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter commentId: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func commentsCommentIdGet(commentId: String, completion: @escaping ((_ data: Comment?,_ error: Error?) -> Void)) {
        commentsCommentIdGetWithRequestBuilder(commentId: commentId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**

     - parameter commentId: (path)  
     - returns: Observable<Comment>
     */
    open class func commentsCommentIdGet(commentId: String) -> Observable<Comment> {
        return Observable.create { observer -> Disposable in
            commentsCommentIdGet(commentId: commentId) { data, error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - GET /comments/{comment_id}
     - examples: [{example={
  "id" : "aeiou",
  "body" : "aeiou",
  "updated_at" : "2000-01-23T04:56:07.000+00:00",
  "rendered_body" : "aeiou",
  "created_at" : "2000-01-23T04:56:07.000+00:00",
  "user" : {
    "id" : "aeiou",
    "items_count" : 1,
    "followees_count" : 0,
    "description" : "aeiou",
    "name" : "aeiou",
    "website_url" : "aeiou",
    "profile_image_url" : "aeiou",
    "followers_count" : 6
  }
}, contentType=application/json}]
     
     - parameter commentId: (path)  

     - returns: RequestBuilder<Comment> 
     */
    open class func commentsCommentIdGetWithRequestBuilder(commentId: String) -> RequestBuilder<Comment> {
        var path = "/comments/{comment_id}"
        path = path.replacingOccurrences(of: "{comment_id}", with: "\(commentId)", options: .literal, range: nil)
        let URLString = CHQiitaApiClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Comment>.Type = CHQiitaApiClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter commentId: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func commentsCommentIdPatch(commentId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        commentsCommentIdPatchWithRequestBuilder(commentId: commentId).execute { (response, error) -> Void in
            completion(error);
        }
    }

    /**

     - parameter commentId: (path)  
     - returns: Observable<Void>
     */
    open class func commentsCommentIdPatch(commentId: String) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            commentsCommentIdPatch(commentId: commentId) { error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next())
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - PATCH /comments/{comment_id}
     
     - parameter commentId: (path)  

     - returns: RequestBuilder<Void> 
     */
    open class func commentsCommentIdPatchWithRequestBuilder(commentId: String) -> RequestBuilder<Void> {
        var path = "/comments/{comment_id}"
        path = path.replacingOccurrences(of: "{comment_id}", with: "\(commentId)", options: .literal, range: nil)
        let URLString = CHQiitaApiClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = CHQiitaApiClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PATCH", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**

     - parameter itemId: (path)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func itemsItemIdCommentsGet(itemId: String, completion: @escaping ((_ data: [Comment]?,_ error: Error?) -> Void)) {
        itemsItemIdCommentsGetWithRequestBuilder(itemId: itemId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**

     - parameter itemId: (path)  
     - returns: Observable<[Comment]>
     */
    open class func itemsItemIdCommentsGet(itemId: String) -> Observable<[Comment]> {
        return Observable.create { observer -> Disposable in
            itemsItemIdCommentsGet(itemId: itemId) { data, error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - GET /items/{item_id}/comments
     - examples: [{example=[ {
  "id" : "aeiou",
  "body" : "aeiou",
  "updated_at" : "2000-01-23T04:56:07.000+00:00",
  "rendered_body" : "aeiou",
  "created_at" : "2000-01-23T04:56:07.000+00:00",
  "user" : {
    "id" : "aeiou",
    "items_count" : 1,
    "followees_count" : 0,
    "description" : "aeiou",
    "name" : "aeiou",
    "website_url" : "aeiou",
    "profile_image_url" : "aeiou",
    "followers_count" : 6
  }
} ], contentType=application/json}]
     
     - parameter itemId: (path)  

     - returns: RequestBuilder<[Comment]> 
     */
    open class func itemsItemIdCommentsGetWithRequestBuilder(itemId: String) -> RequestBuilder<[Comment]> {
        var path = "/items/{item_id}/comments"
        path = path.replacingOccurrences(of: "{item_id}", with: "\(itemId)", options: .literal, range: nil)
        let URLString = CHQiitaApiClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[Comment]>.Type = CHQiitaApiClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
