//
//  UploadVC.swift
//  Adhub
//
//  Created by Sireesha Siddineni on 13/10/20.
//  Copyright © 2020 Sireesha Siddineni. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import MobileCoreServices
import AssetsLibrary
import AVKit
import AVFoundation
protocol PickedImages {
    func imgPicked(_ img:[UIImage])
}
class UploadVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate, UIDocumentPickerDelegate{
    var imgDoc = [UIImage]()
    var VideoImgDoc = [UIImage]()
    var delegate: PickedImages?
    var imagePickerController = UIImagePickerController()
    var videoURL : NSURL?
    var videoData : [Data] = []
    var SngleVideoData : Data?
    var mediaType = NSString()
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var staticImgCollectionView: UICollectionView!
    
    @IBOutlet weak var PhotosCameraImgBtn: UIButton!
    
    
    @IBOutlet weak var VideosCameraImgBtn: UIButton!
    
    
    @IBAction func UploadSaveAction(_ sender: Any) {
    }
    
    @IBAction func UploadVidAction(_ sender: Any) {
        mediaType = "video"
        checkCameraPermissions()
    }
    
    @IBAction func UploadImgAction(_ sender: Any) {
        ImagePickerManager().pickImage(self) { (img) in
            print(img,"display image")
            self.imgDoc.append(img)
            
            DispatchQueue.main.async {
                self.photosCollectionView.reloadData()
            }
            
        }
        
    }
    @IBOutlet weak var photosCameraImg: UIImageView!
    @IBOutlet weak var videosCameraImg: UIImageView!
    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var videosView: UIView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    let collArr = ["Back side","Front side","Front side 2","Right side","Left side"]
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    @IBAction func OkayBtnAction(_ sender: Any) {
        popUpView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.isHidden = false
        self.addBackButton()
        self.photosCameraImg.isHidden = true
        self.VideosCameraImgBtn.isHidden = true
        self.title = "Upload Media"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:
        UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:
        UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:
        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //                if collectionView == photosCollectionView{
        //                     let width: CGFloat = self.photosCollectionView.frame.size.width
        //                    return CGSize(width: width/3 - 1 , height: 77 )
        //                }
        return CGSize(width: 100, height: 77 )
    }
    
    
    ////////////////////////
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == photosCollectionView{
            return imgDoc.count + 1
        }else if collectionView == videosCollectionView{
            return VideoImgDoc.count  + 1
        }else if collectionView == staticImgCollectionView{
            return collArr.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == photosCollectionView {
            let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photosUploadCell", for: indexPath) as! photosUploadCell
            if imgDoc.count == 0{
                cell.photosImgView.isHidden = true
                cell.photoCancelBtn.isHidden = true
                self.PhotosCameraImgBtn.isHidden = false
            }else {
                cell.photosImgView.isHidden = false
                cell.photoCancelBtn.isHidden = true
                self.PhotosCameraImgBtn.isHidden = true
                self.photosView.layer.borderWidth = 2
                self.photosView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            if indexPath.row == 0 {
                cell.photoCancelBtn.isHidden = true
                cell.photosImgView.image = #imageLiteral(resourceName: "UploadImg")
            }else {
                cell.photoCancelBtn.isHidden = false
                cell.photosImgView.image = imgDoc[indexPath.row - 1]
            }
            
            cell.photoCancelBtn.addTarget(self, action: #selector(removeImgAction(sender:)), for: .touchUpInside)
            cell.photoCancelBtn.tag = indexPath.row
            
            return cell
        }else if collectionView == videosCollectionView {
            let cell = videosCollectionView.dequeueReusableCell(withReuseIdentifier: "videosUploadCell", for: indexPath) as! videosUploadCell
            // cell.videosImgView.image = #imageLiteral(resourceName: "normal_btn_login_press")
            //  cell.videoCancelBtn.tag = indexPath.row
            if VideoImgDoc.count == 0{
                cell.videosImgView.isHidden = true
                cell.videosImgView.isHidden = true
                self.VideosCameraImgBtn.isHidden = false
                self.videosView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }else {
                cell.videosImgView.isHidden = false
                cell.videoCancelBtn.isHidden = true
                self.VideosCameraImgBtn.isHidden = true
                self.videosView.layer.borderWidth = 2
                self.videosView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            if indexPath.row == 0 {
                cell.videoCancelBtn.isHidden = true
                cell.videosImgView.image = #imageLiteral(resourceName: "UploadImg")
            }else {
                cell.videoCancelBtn.isHidden = false
                cell.videosImgView.image = VideoImgDoc[indexPath.row - 1]
            }
            
            
            cell.videoCancelBtn.tag = indexPath.row
            
            
            
            cell.videoCancelBtn.addTarget(self, action: #selector(removeVideoAction(sender:)), for: .touchUpInside)
            
            
            return cell
        }else {
            let cell = staticImgCollectionView.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as! UploadCell
            cell.nameLbl.text = collArr[indexPath.row]
            cell.imgView.image = #imageLiteral(resourceName: "Moving")
            
            
            return cell
        }
        
        
    }
    @objc func removeVideoAction(sender: UIButton){
        if VideoImgDoc.count > 0 {
            self.VideoImgDoc.remove(at: sender.tag - 1 )
        }
        DispatchQueue.main.async {
            self.videosCollectionView.reloadData()
        }
    }
    @objc func removeImgAction(sender: UIButton){
        if imgDoc.count > 0 {
            self.imgDoc.remove(at: sender.tag - 1 )
        }
        DispatchQueue.main.async {
            self.photosCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == photosCollectionView{
            if indexPath.row == 0 {
                
                ImagePickerManager().pickImage(self) { (img) in
                    print(img,"display image")
                    self.imgDoc.append(img)
                    
                    DispatchQueue.main.async {
                        self.photosCollectionView.reloadData()
                    }
                }
            }
            
        }else if collectionView == videosCollectionView{
            if indexPath.row == 0 {
                mediaType = "video"
                checkCameraPermissions()
            }
        }else if collectionView == staticImgCollectionView{
            
        }
    }
}
extension UploadVC : UIImagePickerControllerDelegate
{
    // MARK: -  UIImage Picker Delegate
    
    func checkCameraPermissions () {
        
        var alertController = UIAlertController()
        
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction (title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            
            switch (status) {
                
            case .authorized:
                
                self.camera()
                
            case .notDetermined:
                
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
                    
                    if (granted) {
                        
                        self.camera()
                        
                    } else {
                        
                        self.cameraDenied()
                    }
                }
                
            case .denied:
                
                self.cameraDenied()
                
            case .restricted:
                
                let alert = UIAlertController(title: "Camera Services Restricted",
                                              message: "You've been restricted from using the camera on this device. Without camera access this feature won't work. Please contact the device owner so they can give you access.",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction (title: "Ok", style: .destructive, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            @unknown default:
                
                fatalError()
            }
        }))
        
        alertController.addAction(UIAlertAction (title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            self .photoLibrary()
        }))
        
        alertController.addAction(UIAlertAction (title: "Cancel", style: .destructive, handler: { (action:UIAlertAction) in
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func cameraDenied() {
        
        DispatchQueue.main.async {
            var alertText = "Turn on Camera Services in Settings > Privacy to allow Camera to take pictures"
            
            var alertButton = "Ok"
            var goAction = UIAlertAction(title: alertButton, style: .default, handler: nil)
            
            if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!)
            {
                alertText = "Turn on Camera Services in Settings > Privacy to allow Camera to take pictures"
                
                alertButton = "Settings"
                
                goAction = UIAlertAction(title: alertButton, style: .default, handler: {(alert: UIAlertAction!) -> Void in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                })
            }
            
            let alert = UIAlertController(title: "Camera Services Off", message: alertText, preferredStyle: .alert)
            alert.addAction(goAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func camera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            if mediaType == "video"
            {
                DispatchQueue.main.async {
                    
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.sourceType = .camera
                    imagePickerController.mediaTypes = [kUTTypeMovie as String]
                    imagePickerController.videoMaximumDuration = 30
                    self.mediaType = "video"
                    
                    //                    imagePickerController.videoMaximumDuration = 30
                    imagePickerController.videoQuality = .typeIFrame960x540
                    imagePickerController.allowsEditing = true
                    imagePickerController.delegate = self
                    
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            }
            
        } else {
            DispatchQueue.main.async {
                //      UIAlertController.showAlert(vc: self, title: "Ok", message: "Camera not available !")
                //self.showAlert(title: "ok", message: "Camera not available !")
            }
        }
    }
    
    func photoLibrary() {
        
        if mediaType == "video"
        {
            DispatchQueue.main.async {
                
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self;
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePickerController.mediaTypes = [kUTTypeMovie as String]
                
                imagePickerController.videoMaximumDuration = 30
                imagePickerController.videoQuality = .typeIFrame960x540
                imagePickerController.allowsEditing = true
                self.mediaType = "video"
                let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
        print(videoURL!,"jj")
        let ass = AVAsset(url:videoURL as! URL)
        
        if let videoThumbnail = ass.videoThumbnail{
            print("Success")
            self.VideoImgDoc.append(videoThumbnail)
            
            DispatchQueue.main.async {
                self.videosCollectionView.reloadData()
            }
        }
        
        if mediaType == "video"{
            let outputFileURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            
            // get the asset
            let asset = AVURLAsset(url: outputFileURL)
            
            // get the time in seconds
            let durationInSeconds = asset.duration.seconds
            
            print("durationInSeconds",durationInSeconds)
            if let referenceUrl = info[UIImagePickerController.InfoKey.phAsset] as? NSURL {
                
                ALAssetsLibrary().asset(for: referenceUrl as URL, resultBlock: { asset in
                    
                    let fileName = asset?.defaultRepresentation().filename()
                    // self.uploadLbl.text = fileName
                    print("name \(fileName ?? "")")
                }, failureBlock: nil)
            }
        }
        
        
        if mediaType == "video"
        {
            let outputFileURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            
            // get the asset
            let asset = AVURLAsset(url: outputFileURL)
            
            // get the time in seconds
            let durationInSeconds = asset.duration.seconds
            
            print("durationInSeconds",durationInSeconds)
            
            
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String
            
            if (mediaType == kUTTypeVideo as String) || (mediaType == kUTTypeMovie as String) {
                
                guard let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                    return
                }
                do {
                    SngleVideoData = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                    print("videoData is :::\(SngleVideoData)")
                    if SngleVideoData!.count > 0 {
                        self.videoData.append(SngleVideoData!)
                        print("totalVideoData", self.videoData)
                    }
                    
                    
                    //                                        if SngleVideoData.count > 0 {
                    //
                    //                    //                        genearte thumbnail image from video url
                    //                                            DispatchQueue.global(qos: .background).async {  //backgroundQueue
                    //                                                AVAsset(url: videoUrl as URL).generateThumbnail { [weak self] (image) in
                    //                                                    DispatchQueue.main.async {
                    //                                                        guard let image = image else { return }
                    //                                                        self?.videoImgVw.image = image
                    //                                                    }
                    //                                                }
                    //                                            }
                    //                    //                        uploadVideoBtn.setTitle("", for: .normal)
                    //                                        }
                    
                } catch  {
                }
            }
        }else {
            if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil {
                
                let chosenImage: UIImage? = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
                //   imgVW.image = chosenImage
                let data: NSData? = chosenImage!.jpegData(compressionQuality: 0.2)! as NSData
                //  productImgData = data!
                print("data,",data)
                
            } else {
                
                print("BEGIN:ALLAyurvedic ======> Something went wrong")
            }
        }
        
        
        picker.dismiss(animated: true)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func openImagePicker () {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet)
            
            alertController.addAction(UIAlertAction (title: "Take Photo", style: .default, handler: { (action:UIAlertAction) in
                
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                
                switch (status) {
                    
                case .authorized: // Access has been granted.
                    
                    self.takePhoto()
                    
                case .notDetermined: // Access has not been determined.
                    
                    AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
                        
                        if (granted) {
                            
                            self.takePhoto()
                            
                        } else {
                            
                            self.askCameraPermissions()
                        }
                    }
                    
                case .denied: // Access has been denied.
                    
                    self.askCameraPermissions()
                    
                case .restricted:  // Restricted access - normally won't happen.
                    
                    let alert = UIAlertController(title:"Camera Services Restricted",
                                                  message:"You've been restricted from using the camera on this device. Without camera access this feature won't work. Please contact the device owner so they can give you access.",
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction (title: "Ok", style: .destructive, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                @unknown default:
                    
                    fatalError()
                }
            }))
            
            //            alertController.addAction(UIAlertAction (title: "Choose Photo", style: .default, handler: { (action:UIAlertAction) in
            //
            //                //Photos
            //                let status = PHPhotoLibrary.authorizationStatus()
            //
            //                if (status == PHAuthorizationStatus.authorized) {
            //
            //                    self.chooseFromPhotoLibrary() // Access has been granted.
            //                }
            //
            //                else if (status == PHAuthorizationStatus.denied) {
            //
            //                    self.askPhotoLibraryPermissions() // Access has been denied.
            //                }
            //
            //                else if (status == PHAuthorizationStatus.notDetermined) { // Access has not been determined.
            //
            //                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
            //
            //                        if (newStatus == PHAuthorizationStatus.authorized) {
            //
            //                            self.chooseFromPhotoLibrary()
            //
            //                        } else {
            //
            //                            self.askPhotoLibraryPermissions()
            //                        }
            //                    })
            //                }
            //
            //                else if (status == PHAuthorizationStatus.restricted) { // Restricted access - normally won't happen.
            //
            //                    self.askPhotoLibraryPermissions()
            //                }
            //            }))
            //
            //            alertController.addAction(UIAlertAction (title: "Choose Document", style: .default, handler: { (action:UIAlertAction) in
            //
            //                let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
            //
            //                documentPicker.delegate = self
            //                documentPicker.modalPresentationStyle = .fullScreen
            //                self.present(documentPicker, animated: true, completion: nil)
            //            }))
            
            alertController.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: { (action:UIAlertAction) in
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func uploadVideoPicker() {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet)
            
            alertController.addAction(UIAlertAction (title: "Choose Document", style: .default, handler: { (action:UIAlertAction) in
                
                let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
                
                documentPicker.delegate = self
                documentPicker.modalPresentationStyle = .fullScreen
                self.present(documentPicker, animated: true, completion: nil)
            }))
            
            alertController.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: { (action:UIAlertAction) in
                
            }))
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
    }
    
    func askCameraPermissions() {
        
        DispatchQueue.main.async {
            
            var settingsAction = UIAlertAction(title: "Settings", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
                
                settingsAction = UIAlertAction(title: "Settings", style: .default, handler: {(alert: UIAlertAction!) -> Void in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                })
            }
            
            let alert = UIAlertController(title: " Follow And Connect does not have access to your camera.", message: "Turn on Camera Services in Settings > Privacy to allow Camera to take pictures", preferredStyle: .alert)
            alert.addAction(cancelAction)
            alert.addAction(settingsAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func takePhoto() {
        
        DispatchQueue.main.async {
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self;
                imagePickerController.sourceType = .camera
                
                imagePickerController.videoMaximumDuration = 30
                imagePickerController.allowsEditing = true
                imagePickerController.modalPresentationStyle = .fullScreen
                self.present(imagePickerController, animated: true, completion: nil)
                
            } else {
                
                //  UIAlertController.showAlert(vc: self, title: "Oops!", message: "Camera not available !")
            }
        }
    }
    
    func askPhotoLibraryPermissions() {
        
        DispatchQueue.main.async {
            
            var settingsAction = UIAlertAction(title:"Settings", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
                
                settingsAction = UIAlertAction(title: "Settings", style: .default, handler: {(alert: UIAlertAction!) -> Void in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                })
            }
            let alert = UIAlertController(title: "Follow And Connect does not have access to your photos", message: "Turn on Photos in Settings > Privacy to allow Photos to access your Photo Library", preferredStyle: .alert)
            
            alert.addAction(cancelAction)
            alert.addAction(settingsAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func chooseFromPhotoLibrary() {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self;
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.videoMaximumDuration = 30
                
                //  imagePickerController.videoMaximumDuration = 30
                imagePickerController.allowsEditing = true
                imagePickerController.modalPresentationStyle = .fullScreen
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
    }
}
extension AVAsset{
    var videoThumbnail:UIImage?{
        
        let assetImageGenerator = AVAssetImageGenerator(asset: self)
        assetImageGenerator.appliesPreferredTrackTransform = true
        
        var time = self.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            let thumbNail = UIImage.init(cgImage: imageRef)
            
            
            print("Video Thumbnail genertated successfuly")
            
            return thumbNail
            
        } catch {
            
            print("error getting thumbnail video")
            return nil
        }
    }
}
