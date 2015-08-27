---
title: iOS SDK
permalink: /ios_sdk/
tags: ios-sdk
audience: writer, designer
keywords: 
last_updated: 
summary: 
---
{% include linkrefs.html %} 


# Affdex SDK for iOS

SDK Developer Guide
Release 2.0
 
## Introduction
Affdex SDK is the culmination of years of scientific research into emotion detection, validated across thousands of tests worldwide on PC platforms, and now made available on Apple iOS. Affdex SDK turns your ordinary app into an extraordinary app by emotion-enabling it to respond in real-time to user emotions.
In this document, you will become familiar with integrating the Affdex SDK into your iOS app. Please take time to read this document and feel free to give us feedback at sdk@affectiva.com.

### What's New in this Release
Version 2.0 of the SDK introduces support for multiple face detection in a single frame. Because the interface for version 1 of the SDK was geared towards single face, it has been significantly revamped in version 2. The AFDXMetric class has been replaced with an AFDXFace class, which we'll discuss shortly.
Because of these changes, method signatures have changed, and a few have been added. You can now specify the maximum number of faces that the detector will find by passing a number to one of the new initialization methods discussed later.

### Getting Started
The Affdex SDK package consists of the following:
* 	<b>Introducing the SDK.pdf</b>
* 	<b>SDK Developer Guide 2.0.pdf</b> (this document)
* 	<b>AFFECTIVA SDK LICENSE AGREEMENT.pdf</b>, the license agreement file.
* 	<b>Powered By Affectiva Logos</b> is a folder that contains the Powered By Affectiva logos for inclusion in apps as outlined in the license agreement.
*  	data, the folder containing files needed by the SDK
* 	documentation, the folder containing class documentation in HTML format. See index.html.
* 	<b>libAffdex.a</b>, the Affdex SDK library that your app will link against
* 	<b>AFDXDetector.h</b>, which defines the AFDXDetector class and contains the facial expression detector logic
Affectiva makes source available for sample applications that use the SDK. You can find these source examples on our GitHub site: https://github.com/Affectiva/affdex-ios 

## How the SDK is Organized
There is a single Objective-C header file that your app will need to include: <em>AFDXDetector.h</em>. This header file defines the <em>AFDXDetector</em> class which contains the facial expression detector logic.
The library file <em>libAffdex.a</em> contains all of the necessary code for the SDK and will need to be linked to your app. This single file contains compiled code for armv7, armv7s, arm64, i386 and x86_64 architectures, allowing you to use either the iOS simulator or a real iOS device.

### Requirements & Dependencies
The iOS SDK requires iOS 7.0 or above and Xcode 5. The SDK also depends on the following iOS frameworks:

* 	AudioToolbox.framework
* 	CoreMedia.framework
*	AVFoundation.framework
* 	CoreVideo.framework
* 	QuartzCore.framework
* 	CoreImage.framework
* 	CoreGraphics.framework
* 	UIKit.framework
* 	Foundation.framework
* 	SystemConfiguration.framework
* 	AssetsLibrary.framework
* 	libc++.dylib

The data folder contained in the SDK deliverable is also needed. It should be copied into your Xcode project and copied into your app's bundle resources folder as part of the build process. For an example on how to do this, see the FollowMe Xcode project which is available on GitHub at https://github.com/Affectiva/affdex-ios.

### Using the SDK
Since the feature of the SDK is to detect facial expressions, one of the key functions is the examination of images for faces. The AFDXDetector combines face detection, tracking and expression classification to do this.
An image may contain no faces, one face, or many faces. The AFDXDetector will detect as many faces as it can in an image, and deliver information on each face to you, including the expressions that each face is making.
The AFDXFace object encapsulates the notion of a single face. This object contains a number of properties about a face that is found in an image:
* 	faceId: this is a numeric value, guaranteed to be unique for a particular face as long as it remains visible in successive frames.
* 	facePoints: this is an array of CGPoint objects, each of which denotes a facial landmark on the face. The point is relative to the coordinate space of the image processed. There can be many such points in this array.
* 	faceBounds: this is a CGRect which describes the bounding box of the face.
* 	smileScore: this is a number between 0 and 100, indicating the intensity of the smile on the face.
* 	browRaiseScore: this is a number between 0 and 100, indicating the intensity of the brows as they are raised on the face.
* 	browLowerScore: this is a number between 0 and 100, indicating the intensity of the brows as they are lowered on the face.
* 	lipCornerDepressorScore: this is a number between 0 and 100, indicating the intensity of the lip corners as they turn downward on the face. This is usually an indicator of frowning.
* 	engagementScore: this is a number between 0 and 100, indicating the level of engagement, or interest, that the face is exhibiting.
* 	valenceScore: this is a number between -100 and 100, indicating the overall negativity or positivity of the face.


There’s no better way to show how to use the Affdex SDK than through a set of examples. The following code snippets demonstrate how easy it is to obtain facial expression results using your device’s camera, a video file, or from images.

### Step 1. Call the Correct Initializer
There are three ways for the SDK to analyze video and images for facial expressions:
1.	The On-Device Camera
2.	Video File
3.	Images
Each has its own specific initialization method below to create the AFDXDetector object that will be used to detect facial expressions.

#### The On-Device Camera
Using the built-in camera is a common way to obtain video for facial expression detection. Either the front and back camera of your iPhone, iPad or iPod Touch can be used to feed video directly to the detector using the method:
```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate 
usingCamera:(AFDXCameraType)camera;
```

This method takes a reference to an object which adheres to the <em>AFDXDetectorDelegate</em> protocol, and a parameter of type <em>AFDXCameraType</em> (<em>AFDX_CAMERA_FRONT</em> or <em>AFDX_CAMERA_BACK</em>) which specifies the camera to use.
The maximum number of faces detected is set to 10. If you want to override this default, use this initializer:

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate 
usingCamera:(AFDXCameraType)camera maximumFaces:(NSUInteger)maximumFaces;
```

To optimize performance, you should set this to the maximum number of expected faces that you anticipate.

#### Video File
Another way to feed video into the detector is via a video file that is stored on the file system of your device:

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate
usingFile:(NSString *)path;
```

This initialization method also takes a reference to an object which adheres to the <em>AFDXDetectorDelegate protocol</em>, as well as a path to a video file (with an extension of .mp4 or .m4v) on the device.
The maximum number of faces detected is set to 10. If you want to override this default, use this initializer:

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate 
usingFile:(NSString *)path  maximumFaces:(NSUInteger)maximumFaces;
```

To optimize performance, you should should set this to the maximum number of expected faces that you anticipate.

#### Images
Affdex SDK also allows you to process images rather than video. Images can be discrete, or unrelated, or they can be frames extracted from video in which case they're continuous, or related, images.
If you have a library of facial images captured independently of one another then you would use the discrete option. This permits Affdex SDK to reset its baselining algorithm between images.
A scenario illustrating the use of continuous image processing is when your app may record faces on a lengthy basis and, for storage efficiency purposes, you store only one frame per second rather than the standard 30 FPS (the default for iPhones). The resulting images are related and saving one frame per second provides you with sufficient granularity for your app's purpose.
Processing either discrete or continuous images does not entail the use of the device camera so you can use Affdex SDK to process images while your device camera is in use.

```
-	(id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate 
usingDiscreteImages:(BOOL)discrete;
```

Like the other methods, this initialization method also takes a reference to an object which adheres to the <em>AFDXDetectorDelegate</em> protocol. The second parameter is a flag that the detector uses to determine whether discrete images will be used or not. This aids the detector to optimize processing of the image flow. If you intend to pass related sequential images such as images arising from a video source to the detector, then set this parameter to <em>NO</em>. If you want the detector to analyze a series of unrelated images, then set this parameter to <em>YES</em>. 
The maximum number of faces detected is set to 10. If you want to override this default, use this initializer:

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate 
usingDiscreteImages:(BOOL)discrete maximumFaces:(NSUInteger)maximumFaces;
```

To optimize performance, you should should set this to the maximum number of expected faces that you anticipate.

### Step 2. Establish Object Properties
Now that the AFDXDetector object is created, you next establish properties necessary for its operation.
The first step is to specify which classifiers you wish to activate and process. Classifiers employ the machine learning algorithms that yield expression metrics for the facial expressions you specify.  Affdex expression metrics are described in detail in the Introduction to Affdex SDK for iOS documentation. By default, all classifiers are disabled. Here, we’ll turn on all the supported classifiers:

```
detector.smile = YES;
detector.browRaise = YES;
detector.browFurrow = YES;
detector.lipCornerDepressor = YES;
detector.valence = YES;
detector.engagement = YES;
```

You must also specify a path to your license file. This file is provided by Affectiva when you register for the SDK, and must be added to your Xcode project. Xcode will copy the license file to the resources area of the app bundle; you can set the licensePath property as follows:

```
detector.licensePath = [[NSBundle mainBundle] 
pathForResource:@"sdk" ofType:@"license"];
```

If you plan to use the camera to process facial frames using the Affdex SDK, you can specify the maximum number of frames per second. This is helpful to balance battery life with your processing requirements. The default (and recommended) rate is 5 frames per second, but you may also set it lower if you are using an older device such as an iPad 2, and need additional performance.

```
detector.maxProcessRate = 2.0;
```


### Step 3. Start the Detector
With our <em>AFDXDetector</em> object created and properties established, we can now start the detector:

```
NSError *error = [detector start];
```

Check the return value for any error that may have occurred during the start process. If everything is fine, then <em>nil</em> will be returned and the detector comes to life.
Note that if you specify the use of the device camera and the camera is already in use, an error results.
If you have chosen the initialization method for still images, then you will need to push those images to the SDK via the following method:

```
- (void)processImage:(UIImage *)facePicture;
```

If you’ve chosen the camera or video file option, the SDK will begin to consume video frames from that data source automatically.

### Adhering to the AFDXDetectorDelegate Protocol
The SDK communicates results to your app via the <em>AFDXDetectorDelegate</em> protocol. Here are the methods that your app will need to know about.

```
-	(void)detectorDidFinishProcessing:(AFDXDetector *)detector;
```

This method is called in your code when the detector has finished processing a video file. (It is not called when using the camera or static images.) The implementation of this delegate method is optional.

```
- (void)detector:(AFDXDetector *)detector 
didStartDetectingFace:(AFDXFace *)face;
```

This method is called in your code and signals when the detector detects a new face that has come into view. It is often used in conjunction with detector:didStopDetectingFace:. The implementation of this delegate method is optional.

```
-	(void)detector:(AFDXDetector *)detector 
didStopDetectingFace:(AFDXFace *)face;
```

This method is called in your code and signals when the detector no longer detects a particular face. This is the converse of detector:didStartDetectingFace:. Together, the two methods provide signals of when a face comes into or goes out of view. The implementation of this delegate method is also optional.

```
- (void)detector:(AFDXDetector *)detector hasImage:(UIImage *)image 
withFaces:(NSDictionary *)faces atTime:(NSTimeInterval)time;
```

This method is called in your code when the detector has processed a video frame from the camera or file, or has processed a static image.
There are four parameters sent to this method:
1.	A reference to the detector.
2.	A reference to the image that was analyzed.
3.	A dictionary of <em>AFDXFace</em> objects corresponding to the faces in the image. They key for each object is the face identifier
4.	A timestamp (relative to 0) representing the point in time that the image was processed,
For camera and video cases, the number of frames that are processed to the detector is usually a subset of the available frames. If you are interested in all of the frame images from the camera or video file, you can also implement the following delegate method:

```
- (void)detector:(AFDXDetector *)detector hasImage:(UIImage *)image atTime:(NSTimeInterval)time;
```

Unlike the previous delegate method, this one does not take an array of AFDXFace objects because the image has not been processed. You typically implement this method when you want to display the associated images in a UIView.

## Interpreting the Data
When the array of metrics comes into the delegate method, your application can interpret the data as it sees fit. Here’s a code example:

```
 - (void)detector:(AFDXDetector *)detector hasImage:(UIImage *)image withFaces:(NSDictionary *)faces atTime:(NSTimeInterval)time;
 {
 for (AFDXFace *face in [faces allValues])
 {
 if (face.smile != NAN)
 {
 // do something with the value...
 }
 if (face.browRaise != NAN)
 {
 // do something with the value...
 } 

 // handle other expressions here
 . . .
 }
 }
```

In the above code snippet, every expression score for each face in the faces dictionary is examined. The value extracted from the metric should be checked for NaN (not a number) which indicates that the detector has not been instructed to classify that expression.
For multiple face detection, it is important to keep in mind that each face has its own face identifier (a unique number) which is tracked as long as that face remains in the image and does not "cross over" another face. If one face's bounding box collides with another face's bounding box from one frame to the next (in video or non-discrete image mode), the face tracker may assign a different face ID to those faces.

## Where to Go From Here
For detailed class documentation, see the documentation folder. 
We’re excited to help you get the most of our SDK in your application. Please use the following ways to contact us with questions, comments, suggestions...or even praise!
Email: [sdk@affectiva.com](sdk@affectiva.com)
Web: [www.affdex.com/mobile-sdk](www.affdex.com/mobile-sdk)
