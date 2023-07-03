//
//  HomeViewModel.swift
//  TripOrganizer
//
//  Created by Gabriel Mors  on 19/04/23.
//

import UIKit

class HomeViewModel {
    
    private var tripImages: [String] = ["trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3",
                                        "trip1",
                                        "trip2",
                                        "trip3"]
    

    private static var tripList: [AddTripModel] = []{
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name("updateList"), object: nil)
        }
    }
    
    var tripNumberOfRows: Int {
        HomeViewModel.tripList.endIndex
    }
    
    
    public func getTripList()-> Int{
        HomeViewModel.tripList.count
    }
    public func getListTripImages(index: Int) -> String {
        tripImages[index]
    }
    
    public func getTripList(index: Int) -> AddTripModel {
        return HomeViewModel.tripList[index]
    }
    
    public func removeTrip(index: Int) {
        HomeViewModel.tripList.remove(at: index)
    }
    
    public func appendTripToList(trip: AddTripModel) {
        HomeViewModel.tripList.append(trip)

    }
        
   private var progressBar: Float = 0
    
    public func progressBarLogic(sender: UITapGestureRecognizer,tappedTicketView: UIView , ticketImageView: UIImageView, tripProgressView: UIProgressView, tappedHotelView: UIView, hotelImageView: UIImageView, tappedRestaurantView: UIView, restaurantImageView: UIImageView, tappedAttractionView: UIView, attractionImageView: UIImageView ){
        
        
        guard let imageView = sender.view else { return }
        
         switch imageView {
         case tappedTicketView:
             switch ticketImageView.image {
             case UIImage(systemName: Localized.square):
                 ticketImageView.image = UIImage(systemName: Localized.squareCheck)
                progressBar += 0.25
                tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: Localized.squareCheck):
                 ticketImageView.image = UIImage(systemName: Localized.square)
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
         case tappedHotelView:
             switch hotelImageView.image {
             case UIImage(systemName: Localized.square.localized):
                 hotelImageView.image = UIImage(systemName: Localized.squareCheck)
                 progressBar += 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: Localized.squareCheck):
                 hotelImageView.image = UIImage(systemName: Localized.square)
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
             
         case tappedRestaurantView:
             switch restaurantImageView.image {
             case UIImage(systemName: Localized.square):
                 restaurantImageView.image = UIImage(systemName: Localized.squareCheck)
                 progressBar += 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: Localized.squareCheck):
                 restaurantImageView.image = UIImage(systemName: Localized.square)
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
             
         case tappedAttractionView:
             switch attractionImageView.image {
             case UIImage(systemName: Localized.square):
                 attractionImageView.image = UIImage(systemName: Localized.squareCheck)
                 progressBar += 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             case UIImage(systemName: Localized.squareCheck):
                 attractionImageView.image = UIImage(systemName: Localized.square)
                 progressBar -= 0.25
                 tripProgressView.setProgress(progressBar, animated: true)
             default:
                 break
             }
             
         default:
             break
         }
    }
    
    public func getProfileImageSelected(notification: Notification, perfilButton: UIButton){
        if let selectedImage = notification.object as? UIImage {
            perfilButton.setImage(selectedImage, for: .normal)
        }
    }
    
}

