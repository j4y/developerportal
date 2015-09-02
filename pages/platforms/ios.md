---
title: Affdex SDK for iOS
permalink: /ios/
tags: [ios, sdk]
audience: writer, designer
keywords: 
last_updated: 
summary: 
---
{% include linkrefs.html %} 

<img src={{ "/images/apple.png" | prepend: site.baseurl }} align=right>

SDK Developer Guide Release 2.0

## What’s in the SDK

The Affdex SDK package consists of the following:

* 	<b>AFFECTIVA SDK LICENSE AGREEMENT.pdf</b>, the license agreement file.
* 	<b>Powered By Affectiva Logos</b> is a folder that contains the Powered By Affectiva logos for inclusion in apps as outlined in the license agreement.
* 	<b>Framework_Device/Affdex.framework</b>, the Affdex SDK framework for armv7 and arm64 device targets. You should link against this framework if you are submitting your app to the App Store.
* 	<b>Framework_Simulator/Affdex.framework</b>, the Affdex SDK framework for i386 and x86_64 simulator targets. You can link against this framework if you only intend to use the simulator.
* 	<b>Framework_Universal/Affdex.framework</b>, the Affdex SDK framework for both device and simulator targets. You can link against this framework if you want to test your app on both the simulator and on a device.
Affectiva makes source available for sample applications that use the SDK. You can find these source examples on our GitHub site: https://github.com/Affectiva/ios-sdk-samples

## Requirements & Dependencies

The iOS SDK requires iOS 8.0 or above and Xcode 6. The SDK also depends on the following iOS frameworks:

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

For an example on how to do this, see the AffdexMe Xcode project which is available on GitHub at https://github.com/Affectiva/ios-sdk-samples.

## How the SDK is Organized

There is a single Objective-C header file that your app will need to include: <code>Affdex/Affdex.h</code>. This header file defines the <code>AFDXDetector</code> class which contains the facial expression detector logic as well as the <code>AFDXFace</code> object.
The Affdex framework contains all of the necessary code for the SDK and will need to be linked to your app. It contains compiled code for armv7, armv7s, arm64, i386 and x86_64 architectures, allowing you to use either the iOS simulator or a real iOS device.


### Using the SDK

Since the feature of the SDK is to detect facial expressions, one of the key functions is the examination of images for faces. The AFDXDetector combines face detection, tracking and expression classification to do this.
An image may contain no faces, one face, or many faces. The AFDXDetector will detect as many faces as it can in an image, and deliver information on each face to you, including the expressions that each face is making.
The AFDXFace object encapsulates the notion of a single face. This object contains a number of properties about a face that is found in an image:  

* 	faceId: this is a numeric value, guaranteed to be unique for a particular face as long as it remains visible in successive frames.
* 	facePoints: this is an array of CGPoint objects, each of which denotes a facial landmark on the face. The point is relative to the coordinate space of the image processed. There can be many such points in this array.
* 	faceBounds: this is a CGRect which describes the bounding box of the face.
* 	angerScore: this is a number between 0 and 100, indicating the intensity of the anger on the face.
* 	contemptScore: this is a number between 0 and 100, indicating the intensity of the contempt on the face.
* 	disgustScore: this is a number between 0 and 100, indicating the intensity of the disgust on the face.
* 	expressivenessScore: this is a number between 0 and 100, indicating the intensity of the expressiveness on the face.
* 	fearScore: this is a number between 0 and 100, indicating the intensity of the fear on the face.
* 	joyScore: this is a number between 0 and 100, indicating the intensity of the joy on the face.
* 	sadnessScore: this is a number between 0 and 100, indicating the intensity of the sadness on the face.
* 	surpriseScore: this is a number between 0 and 100, indicating the intensity of the surprise on the face.
* 	valenceScore: this is a number between 0 and 100, indicating the intensity of the valence on the face.
* 	attentionScore: this is a number between 0 and 100, indicating the intensity of the attention on the face.
* 	browFurrowScore: this is a number between 0 and 100, indicating the intensity of the brows as they are lowered on the face.
* 	browRaiseScore: this is a number between 0 and 100, indicating the intensity of the brows as they are raised on the face.
* 	chinRaiseScore: this is a number between 0 and 100, indicating the intensity of the chin as it is raised on the face.
* 	eyeClosureScore: this is a number between 0 and 100, indicating the intensity of the eyes as they are opened and closed  on the face.
* 	innerBrowRaiseScore: this is a number between 0 and 100, indicating the intensity of the inner brows as they are raised on the face.
* 	lipCornerDepressorScore: this is a number between 0 and 100, indicating the intensity of the lip corners as they turn downward on the face. This is usually an indicator of frowning.
* 	lipPuckerScore: this is a number between 0 and 100, indicating the intensity of the lips as they are puckered on the face.
* 	lipSuckScore: this is a number between 0 and 100, indicating the intensity of the lips as they are sucked on the face.
* 	mouthOpenScore: this is a number between 0 and 100, indicating the intensity of the mouth as it is opened and closed on the face.
* 	noseWrinkleScore: this is a number between 0 and 100, indicating the intensity of the nose as it wrinkles on the face.
* 	smileScore: this is a number between 0 and 100, indicating the intensity of the smile on the face.
* 	smirkScore: this is a number between 0 and 100, indicating the intensity of smirk on the face.
* 	upperLipRaiseScore: this is a number between 0 and 100, indicating the intensity of upper lip raise on the face.
* 	interOcularDistanceScore: this is a number indicating the distance between the eyes.
* 	headAngleLeftRightScore: this is a number between -30 and 30 degrees indicating the left/right head angle (yaw) of the head.
* 	headAngleRollScore: this is a number between -60 and 60 degrees indicating the head angle roll of the head.
* 	headAngleUpDownScore: this is a number between -30 and 30 degrees indicating the up/down head angle (pitch) of the head.


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
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingCamera:(AFDXCameraType)camera;
```

This method takes a reference to an object which adheres to the <code>AFDXDetectorDelegate</code> protocol, and a parameter of type <code>AFDXCameraType</code> (<code>AFDX_CAMERA_FRONT</code> or <code>AFDX_CAMERA_BACK</code>) which specifies the camera to use.
The maximum number of faces detected is set to 1. If you want to override this default, use this initializer:  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingCamera:(AFDXCameraType)camera maximumFaces:(NSUInteger)maximumFaces;
```

To optimize performance, you should set this to the maximum number of expected faces that you anticipate.

#### Video File

Another way to feed video into the detector is via a video file that is stored on the file system of your device:  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingFile:(NSString *)path;
```

This initialization method also takes a reference to an object which adheres to the <code>AFDXDetectorDelegate protocol</code>, as well as a path to a video file (with an extension of .mp4 or .m4v) on the device.
The maximum number of faces detected is set to 1. If you want to override this default, use this initializer:  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingFile:(NSString *)path maximumFaces:(NSUInteger)maximumFaces;
```

To optimize performance, you should should set this to the maximum number of expected faces that you anticipate.

#### Images

Affdex SDK also allows you to process images rather than video. Images can be discrete, or unrelated, or they can be frames extracted from video in which case they're continuous, or related, images.
If you have a library of facial images captured independently of one another then you would use the discrete option. This permits Affdex SDK to reset its baselining algorithm between images.
A scenario illustrating the use of continuous image processing is when your app may record faces on a lengthy basis and, for storage efficiency purposes, you store only one frame per second rather than the standard 30 FPS (the default for iPhones). The resulting images are related and saving one frame per second provides you with sufficient granularity for your app's purpose.
Processing either discrete or continuous images does not entail the use of the device camera so you can use Affdex SDK to process images while your device camera is in use.  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingDiscreteImages:(BOOL)discrete;
```

Like the other methods, this initialization method also takes a reference to an object which adheres to the <code>AFDXDetectorDelegate</code> protocol. The second parameter is a flag that the detector uses to determine whether discrete images will be used or not. This aids the detector to optimize processing of the image flow. If you intend to pass related sequential images such as images arising from a video source to the detector, then set this parameter to <code>NO</code>. If you want the detector to analyze a series of unrelated images, then set this parameter to <code>YES</code>. 
The maximum number of faces detected is set to 1. If you want to override this default, use this initializer:  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingDiscreteImages:(BOOL)discrete maximumFaces:(NSUInteger)maximumFaces;
```

To optimize performance, you should should set this to the maximum number of expected faces that you anticipate.

### Step 2. Establish Object Properties

Now that the AFDXDetector object is created, you next establish properties necessary for its operation.
The first step is to specify which classifiers you wish to activate and process. Classifiers employ the machine learning algorithms that yield expression metrics for the facial expressions you specify.  Affdex expression metrics are described in detail in the Introduction to Affdex SDK for iOS documentation. By default, all classifiers are disabled. Here, we’ll turn on a few of the supported classifiers:  

```
detector.smile = YES;
detector.browRaise = YES;
detector.browFurrow = YES;
detector.lipCornerDepressor = YES;
detector.valence = YES;
detector.engagement = YES;
```

If you want to turn on all emotions and expressions, you can use the following convenience methods:

```
[detector setDetectAllEmotions:YES];
[detector setDetectAllExpressions:YES];
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

With our <code>AFDXDetector</code> object created and properties established, we can now start the detector:  

```
NSError *error = [detector start];
```

Check the return value for any error that may have occurred during the start process. If everything is fine, then <code>nil</code> will be returned and the detector comes to life.
Note that if you specify the use of the device camera and the camera is already in use, an error results.
If you have chosen the initialization method for still images, then you will need to push those images to the SDK via the following method:  

```
- (void)processImage:(UIImage *)facePicture;
```

If you’ve chosen the camera or video file option, the SDK will begin to consume video frames from that data source automatically.

### Adhering to the AFDXDetectorDelegate Protocol

The SDK communicates results to your app via the <code>AFDXDetectorDelegate</code> protocol. Here are the methods that your app will need to know about.  

```
- (void)detectorDidFinishProcessing:(AFDXDetector *)detector;
```

This method is called in your code when the detector has finished processing a video file. (It is not called when using the camera or static images.) The implementation of this delegate method is optional.  

```
- (void)detector:(AFDXDetector *)detector didStartDetectingFace:(AFDXFace *)face;
```

This method is called in your code and signals when the detector detects a new face that has come into view. It is often used in conjunction with detector:didStopDetectingFace:. The implementation of this delegate method is optional.  

```
- (void)detector:(AFDXDetector *)detector didStopDetectingFace:(AFDXFace *)face;
```

This method is called in your code and signals when the detector no longer detects a particular face. This is the converse of detector:didStartDetectingFace:. Together, the two methods provide signals of when a face comes into or goes out of view. The implementation of this delegate method is also optional.  

```
- (void)detector:(AFDXDetector *)detector hasResults:(NSMutableDictionary *)faces forImage:(UIImage *)image atTime:(NSTimeInterval)time;
```

This method is called in your code when the detector has processed a video frame from the camera, from a video file, or via a static image.
There are four parameters sent to this method:  

1.	A reference to the detector.
2.	A dictionary of <code>AFDXFace</code> objects corresponding to the faces in the image. They key for each object is the face identifier. If <code>nil</code> is passed, then this is an unprocessed frame.
3.	A reference to the image.
4.	A timestamp (relative to 0) representing the point in time that the image was processed,  

For camera and video cases, the number of frames that are processed to the detector is usually a subset of the available frames. 

## Interpreting the Data

When the array of faces comes into the delegate method, your application can interpret the data as it sees fit. Here’s a code example:  

```
// Convenience method to work with processed images.
- (void)processedImageReady:(AFDXDetector *)detector image:(UIImage *)image faces:(NSDictionary *)faces atTime:(NSTimeInterval)time;
{
    for (AFDXFace *face in [faces allValues])
    {
        if (isnan(face.smile) == NO)
        {
            // do something with the value...
        }
        if (isnam(face.browRaise) == NO)
        {
            // do something with the value...
        } 
        // handle other metrics here
        . . .
    }
}

// Convenience method to work with unprocessed images.
- (void)unprocessedImageReady:(AFDXDetector *)detector image:(UIImage *)image atTime:(NSTimeInterval)time;
{
    // This is an unprocessed frame... do something with it...
}

// The delegate method of the AFDXDetectorDelegate protocol.
- (void)detector:(AFDXDetector *)detector hasResults:(NSMutableDictionary *)faces forImage:(UIImage *)image atTime:(NSTimeInterval)time;
{
    if (nil == faces)
    {
        [self unprocessedImageReady:detector image:image atTime:time];
    }
    else
    {
        [self processedImageReady:detector image:image faces:faces atTime:time];
    }
}
```

In the above code snippet, the delegate method will call one of two instance methods depending on the value of the <code>faces</code> dictionary. The <code>unprocessedImageReady:image:atTime:</code> method receives unprocessed frames while the <code>processedImageReady:image:faces:atTime:</code> method receives the processed ones. In that method, you can check the metric values for  all <code>AFDXFace</code> objects in the dictionary is examined. The value extracted from the metric should be checked for NaN (not a number) which indicates that the detector has not been instructed to classify that expression.
For multiple face detection, it is important to keep in mind that each face has its own face identifier (a unique number) which is tracked as long as that face remains in the image and does not "cross over" another face. If one face's bounding box collides with another face's bounding box from one frame to the next (in video or non-discrete image mode), the face tracker may assign a different face ID to those faces.

<strong>Where to Go From Here</strong>

For detailed class documentation, see the documentation folder. 
We’re excited to help you get the most of our SDK in your application. Please use the following ways to contact us with questions, comments, or suggestions.
  
Email: [sdk@affectiva.com](mailto:sdk@affectiva.com)
  
Web: [www.affectiva.com/solutions/apis-sdks/](http://www.affectiva.com/solutions/apis-sdks/)
