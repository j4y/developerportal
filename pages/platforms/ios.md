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

SDK Developer Guide Release 2.1

## What's New: 

### in SDK V2.1

* The SDK supports detection of multiple faces. 
* Identification of gender is now available.
* Detection of glasses is now available.
* Scores for popular Emoji expressions are now available.

### in SDK V2.0

* iOS 8 is now the minimum version of iOS supported.
* The static library <code>libAffdex.a</code> has been replaced with an iOS Framework called <code>Affdex.framework</code>.
* A new class called <code>AFDXFace</code> has been added which contains classifier scores and information about the face.
* Some of the delegate methods in the <code>AFDXDelegate</code> protocol have changed.
These changes will require some adaptations to your existing Xcode projects. Please read this guide thoroughly in order to understand the changes.

## What’s in the SDK

The Affdex SDK package consists of the following:

* 	<b>Framework_Device/Affdex.framework</b>, the Affdex SDK framework for armv7 and arm64 device targets. You should link against this framework if you are submitting your app to the App Store.
* 	<b>Framework_Simulator/Affdex.framework</b>, the Affdex SDK framework for i386 and x86_64 simulator targets. You can link against this framework if you only intend to use the simulator.
* 	<b>Framework_Universal/Affdex.framework</b>, the Affdex SDK framework for both device and simulator targets. You can link against this framework if you want to test your app on both the simulator and on a device.

We've made sample source available to show you how to use the SDK. You can find these source examples on our <a href=https://github.com/Affectiva/ios-sdk-samples target=_blank>GitHub site</a>.
 
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

For an example on how to do this, see the <a href=https://github.com/Affectiva/ios-sdk-samples target=_blank>AffdexMe</a> source example.

## Using the SDK

In order to utilize the SDK, your app should link to the provided <code>Affdex.framework</code> framework. Choose the appropriate framework for your specific development situation (Device, Simulator, or Universal) Your code must include the Objective-C header file <code>Affdex/Affdex.h</code>. 

Since the function of the SDK is to detect emotions and expressions, one of the key tasks is the examination of images for a face. The <code>AFDXDetector</code> combines face detection, tracking and expression classification to do this. An image may contain no faces, one face, or many faces. This class will detect the faces and and deliver information on the faces to your app, including the emotions and expressions that the faces make.

Also defined in the header file is the <code>AFDXFace</code> object, which encapsulates the properties of a single face:  

* 	<strong>faceId</strong>: this is a numeric value, guaranteed to be unique for a particular face as long as it remains visible in successive frames.
* 	<strong>facePoints</strong>: this is an array of CGPoint objects, each of which denotes a facial landmark on the face. The point is relative to the coordinate space of the image processed. There can be many such points in this array.
* 	<strong>faceBounds</strong>: this is a CGRect which describes the bounding box of the face.  

Head angle values are encapsulated inside of the <code>AFDXOrientation</code> class, which is accesible through the <code>orientation</code> property of the <code>AFDXFace</code> object. The following values are accessible:


<table border=1 style="width:100%">
<tr><th><center>Property Name</center></th>
<th><center>Description</center></th>
<th><center>Range</center></th></tr>
<td><center>yaw</td></center>
<td><center>Left/Right Head Angle of the Face</td></center>
<td><center>-30 - 30</td></center><tr>
<td><center>pitch</td></center>
<td><center>Up/Down Head Angle of the Face</td></center>
<td><center>-30 - 30</td></center></tr>
<td><center>roll</td></center>
<td><center>Head Tilt Angle of the Face</td></center>
<td><center>-30 - 30</td></center></tr>
<td><center>interocularDistance</td></center>
<td><center>Distance in pixels between outer eye corners</td></center>
<td><center>&nbsp &nbsp N/A</td></center></tr>
</table>

Appearance values are encapsulated inside of the <code>AFDXAppearance</code> class, which is accesible through the <code>appearance</code> property of the <code>AFDXFace</code> object. The following values are accessible:  

<table border=1 style="width:100%">
<th><center>Property Name</center></th>
<th><center>Type</center></th>
<th><center>Description</center></th>
<th><center>Values</center></th>
<tr><td><center>glasses</td></center><td><center>enum</td></center><td><center>Presence or Absence of Glasses</td></center><td><center>AFDX_GLASSES_YES, AFDX_GLASSES_NO</td></center>
<tr><td><center>gender</td></center><td><center>enum</td></center><td><center>Perceived Gender</td></center><td><center>AFDX_GENDER_MALE, AFDX_GENDER_FEMALE, AFDX_GENDER_UNKNOWN</td></center></tr>
</table>


Emotions are available from within the <code>AFDXEmotions</code> class, which is accesible from the <code>emotions</code> property of the detector. You can explicitly turn on or off the ability to capture an emotion by setting the emotion name in the detector. See the example code under [establishing object properties](#step-2-establish-object-properties).  

The following table shows the available emotions and their ranges.  
 
<table border="1" style="width:100%">
<tr><th><center>Emotion</center></th><th><center>Property Name</center></th><th><center>Range</center></th></tr>
<tr><td><center>Anger</td></center><td><center>anger</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Sadness</td></center><td><center>sadness</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Disgust</td></center><td><center>disgust</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Fear</td></center><td><center>fear</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Joy</td></center><td><center>joy</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Surprise</td></center><td><center>surprise</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Contempt</td></center><td><center>contempt</td></center</center><td><center>0 - 100</td></center></tr>
<tr><td><center>Valence</td></center><td><center>valence</td></center><td><center>-100 - 100</td></center></tr>
<tr><td><center>Engagement</td></center><td><center>expressiveness</td></center><td><center>0 - 100</td></center></tr>
</table>

Emoji are available from within the <code>AFDXEmoji</code> class, which is accesible from the <code>emoji</code> property of the detector. You can explicitly turn on or off the ability to capture an emotion by setting the emotion name in the detector. See the example code under [establishing object properties](#step-2-establish-object-properties).  

The following table shows the available emoji and their ranges.  


<table border="1" style="width:100%">
<tr><th><center>Emoji Name</center></th><th><center><center>Score Name</center></th><th><center>Range</center></th></tr>
<tr><td><center>Laughing</td></center><td><center><center>laughing</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Smiley</td></center><td><center><center>smiley</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Relaxed</td></center><td><center><center>relaxed</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Wink</td></center><td><center><center>wink</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Kissing</td></center><td><center><center>kissing</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Kissing Closed Eyes</td></center><td><center><center>kissingClosedEyes</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Stuck Out Tongue Winking Eye</td></center><td><center><center>stuckOutTongueWinkingEye</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Stuck Out Tongue</td></center><td><center>stuckOutTongue</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Stuck Out Tongue Closed Eyes</td></center><td><center>stuckOutTongueClosedEyes</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Flushed</td></center><td><center>flushed</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Disappointed</td></center><td><center>disappointed</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Rage</td></center><td><center>rage</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Scream</td></center><td><center>scream</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Smirk</td></center><td><center>smirk</td></center><td><center>0 - 100</td></center></tr>
</table>

Expressions are available from within the <code>AFDXExpressions</code> class, which is accesible from the <code>expressions</code> property of the detector. You can explicitly turn on or off the ability to capture an emotion by setting the emotion name in the detector. See the example code under [establishing object properties](#step-2-establish-object-properties). 

<table border="1" style="width:100%">
<tr><th><center>Expression</center></th><th><center>Property Name</center></th><th><center>Range</center></th></tr>
<tr><td><center>Attention</td></center><td><center>attention</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Brow Furrow</td></center><td><center>browFurrow</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Brow Raise</td></center><td><center>browRaise</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Inner Brow Raise</td></center><td><center>innerBrowRaise</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Eye Closure</td></center><td><center>eyeClosure</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Nose Wrinkle</td></center><td><center>noseWrinkle</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Upper Lip Raise</td></center><td><center>upperLipRaise</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Lip Suck</td></center><td><center>lipSuck</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Lip Pucker</td></center><td><center>lipPucker</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Lip Press</td></center><td><center>lipPress</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Mouth Open</td></center><td><center>mouthOpen</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Lip Corner Depressor</td></center><td><center>lipCornerDepressor</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Chin Raise</td></center><td><center>chinRaise</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Smirk</td></center><td><center>smirk</td></center><td><center>0 - 100</td></center></tr>
<tr><td><center>Smile</td></center><td><center>smile</td></center><td><center>0 - 100</td></center></tr>
</table>


There’s no better way to show how to use the Affdex SDK than through a set of examples. The following code snippets demonstrate how easy it is to obtain facial expression results using your device’s camera, a video file, or from images.

## Step 1. Call the Correct Initializer

There are three ways for the SDK to analyze video and images for facial expressions:

1.	The On-Device Camera
2.	Video File
3.	Images  

Each has its own specific initialization method below to create the <code>AFDXDetector</code> object that will be used to detect facial expressions.

### The On-Device Camera

Using the built-in camera is a common way to obtain video for facial expression detection. Either the front and back camera of your iPhone, iPad or iPod Touch can be used to feed video directly to the detector using the method:  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingCamera:(AFDXCameraType)camera maximumFaces:(NSUInteger)maximumFaces;
```

This method takes a reference to an object which adheres to the <code>AFDXDetectorDelegate</code> protocol, a parameter of type <code>AFDXCameraType</code> (<code>AFDX_CAMERA_FRONT</code> or <code>AFDX_CAMERA_BACK</code>) which specifies the camera to use, and the maximum number of faces to detect (currently only one face is detected).

### Video File

Another way to feed video into the detector is via a video file that is stored on the file system of your device:  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate usingFile:(NSString *)path maximumFaces:(NSUInteger)maximumFaces;
```

This initialization method also takes a reference to an object which adheres to the <code>AFDXDetectorDelegate</code> protocol, a path to a video file (with an extension of .mp4 or .m4v) on the device, and the maximum number of faces to detect (currently only one face is detected).

### Images 

Affdex SDK also allows you to process images rather than video. Images can be discrete, or unrelated, or they can be frames extracted from video in which case they're continuous, or related, images.
If you have a library of facial images captured independently of one another then you would use the discrete option.
A scenario illustrating the use of continuous image processing is when your app may record faces on a lengthy basis and, for storage efficiency purposes, you store only one frame per second rather than the standard 30 FPS (the default for iPhones). The resulting images are related and saving one frame per second provides you with sufficient granularity for your app's purpose.
Processing either discrete or continuous images does not entail the use of the device camera so you can use Affdex SDK to process images while your device camera is in use.  

```
- (id)initWithDelegate:(id <AFDXDetectorDelegate>)delegate discreteImages:(BOOL)discrete maximumFaces:(NSUInteger)maximumFaces;
```

Like the other methods, this initialization method also takes a reference to an object which adheres to the <code>AFDXDetectorDelegate</code> protocol, as well as a maximum number of faces (currently only one face is detected).

The second parameter is a flag that the detector uses to determine whether discrete images will be used or not. This aids the detector to optimize processing of the image flow. If you intend to pass related sequential images such as images arising from a video source to the detector, then set this parameter to <code>NO</code>. If you want the detector to analyze a series of unrelated images, then set this parameter to <code>YES</code>. 

## Step 2. Establish Object Properties

Now that the <code>AFDXDetector</code> object is created, you next establish properties necessary for its operation.
The first step is to specify which classifiers you wish to activate and process. Affdex expression metrics are described in detail in the [Metrics](/metrics) documention. By default, all classifiers are disabled. Here, we’ll turn on a few classifiers:  

```
// turning on a few emotions
detector.joy = YES;
detector.anger = YES;

// turning on a few expressions
detector.smile = YES;
detector.browRaise = YES;
detector.browFurrow = YES;

// turning on a few emoji
detector.smiley = YES;
detector.kissing = YES; // etc
```

If you want to turn on all emotions and expressions, you can use the following convenience methods:

```
[detector setDetectAllEmotions:YES];
[detector setDetectAllExpressions:YES];
```

You must also specify a path to your license file. This file is provided by Affectiva when you register for the SDK, and must be added to your Xcode project. Xcode will copy the license file to the resources area of the app bundle; you can set the licensePath property as follows:  

```
detector.licensePath = [[NSBundle mainBundle] pathForResource:@"sdk" ofType:@"license"];
```

Or you can set the licenseString variable to the path of your license file.

```
detector.licenseString = @"....."; // change the ellipses to the license string.
```

If you plan to use the camera to process facial frames using the Affdex SDK, you can specify the maximum number of frames per second. This is helpful to balance battery life with your processing requirements. The default (and recommended) rate is 5 frames per second, but you may also set it lower if you are using an older device such as an iPad 2, and need additional performance.  

```
detector.maxProcessRate = 8.0;
```

## Step 3. Start the Detector

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

## Adhering to the <code>AFDXDetectorDelegate</code> Protocol

The SDK communicates results to your app via the <code>AFDXDetectorDelegate</code> protocol. Here are the methods that your app will need to know about.  

```
- (void)detectorDidFinishProcessing:(AFDXDetector *)detector;
```

This method is called in your code when the detector has finished processing a video file. (It is not called when using the camera or static images.) The implementation of this delegate method is optional.  

```
- (void)detector:(AFDXDetector *)detector didStartDetectingFace:(AFDXFace *)face;
```

This method is called in your code and signals when the detector detects a new face that has come into view. It is often used in conjunction with <code>detector:didStopDetectingFace:</code>. The implementation of this delegate method is optional.  

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
        if (isnan(face.smileScore) == NO)
        {
            // do something with the value...
        }
        if (isnan(face.browRaiseScore) == NO)
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

In the above code snippet, the delegate method will call one of two instance methods depending on the value of the <code>faces</code> dictionary. The <code>unprocessedImageReady:image:atTime:</code> method receives unprocessed frames while the <code>processedImageReady:image:faces:atTime:</code> method receives the processed ones. In that method, you can check the metric values for  all <code>AFDXFace</code> objects in the dictionary. The value extracted from the metric should be checked for NaN (not a number) which indicates that the detector has not been instructed to detect that emotion or expression.

 For multiple face detection, it is important to keep in mind that each face has its own face identifier (a unique number) which is tracked as long as that face remains in the image and does not "cross over" another face. If one face's bounding box collides with another face's bounding box from one frame to the next (in video or non-discrete image mode), the face tracker may assign a different face ID to those faces.
