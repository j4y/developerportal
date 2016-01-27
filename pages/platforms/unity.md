---
title: Affdex SDK for Unity
permalink: /unity/
tags: [unity, sdk, asset]
audience: writer, designer
keywords: 
last_updated: 
summary: 
---
{% include linkrefs.html %} 

<img src={{ "/images/unity.png" | prepend: site.baseurl }} align=right>

SDK Developer Guide Release 2.0
 
## Requirements & Dependencies

<em><strong>Hardware requirements (recommended)</strong></em>

*	Processor, 2 GHz (64-bit)
*	RAM, 1 GB
*	Disk Space (min) : 950 MB

<em><strong>Runtime Requirements</strong></em>

* [Unity 5.2.1](http://unity3d.com/get-unity)
* [Visual Studio 14](https://www.visualstudio.com/) or Xamarin Studio
* [QuickTime Movie Player](http://www.apple.com/quicktime/download/) 

<em><strong>Supported operating systems</strong></em>

*	Windows 7 and above

## Video Tutorial
<iframe width="420" height="315" src="https://www.youtube.com/embed/HjtPiXWx220" frameborder="0" allowfullscreen></iframe>
 
## Using the Asset

We package our plugin as an asset that we intend to sell on Unity's Asset Store.  It is currently only available directly from us (contact SDK@affectiva.com for a copy).  The purpose of the asset is to detect facial expressions and their underlying emotions from facial images. Facial images can be captured from different sources:  

*	Frames: a sequence of timed images.
*	Video: a video file on a device's local storage.

For each of the different sources, the underlining emotion recognition engine defines a detector class that can handle processing images acquired from that source. There are a set of common steps needed to start using a detector.  

### Add detector to scene
First step is to add a detector to your scene's Main Camera (Add Component -> Scripts -> Affdex -> Detector):  
<img src={{ "/images/unity/AddComponentDetector.png" | prepend: site.baseurl }}>

You can now add a license key, set the emotions you are interested in, and the expressions you are interested in:  
<img src={{ "/images/unity/SetEmotions.png" | prepend: site.baseurl }}>

### Add CameraInput to scene
You can either use Affectiva's CameraInput script or write your own.  To use ours, add a camera input component to your scene's Main Camera (Add Component -> Scripts -> Affdex -> Camera Input):  
<img src={{ "/images/unity/AddCameraInput.png" | prepend: site.baseurl }}> 

Set the camera rate, camera location, width and height:  
<img src={{ "/images/unity/SetCameraInput.png" | prepend: site.baseurl }}>

Affdex performs best using a resolution ratio of 4:3 (ie: 320x240, 640x480, 800x600, 1024x768, etc).  

To create your own script for getting images take a look at the <code>Frame</code> data structure below.  You can also see a prototype of Affectiva's <code>CameraInput</code> script on [GitHub](https://gist.github.com/ForestJay/e47a258cc2ae7a9a44c8).  

### Configuring a Detector 

In order to initialize the detector, a valid license must be provided. The asset validates that a license of an appropriate length is set.  If the asset determines that a license of the proper size has not been set an error will be sent to the console stating, "License is invalid":  
<img src={{ "/images/unity/InvalidLicense.png" | prepend: site.baseurl }} align=right style="margin:5px 5px">

Each license issued by Affectiva is time bound and will only work for a fixed period of time shown in the license file, after which the underlining emotion recognition engine will throw an <code>AffdexLicenseException</code> which will be caught by the asset and output to the console.  

The Affdex classifier data files are used in frame analysis processing. These files are supplied as part of the asset. The location of the data files on the physical storage must remain as:  

```
Assets/StreamingAssets/affdex-data
```

## AbstractAffdexListener

The Detectors use callback classes to communicate events and results:
The <code>AbstractAffdexListener</code> is a client callback which receives notification when the detector has started or stopped tracking a face. The OnFaceLost, OnFaceFound, and OnImageResults methods must be defined as part of a class attached as a component within Unity.  Here is an example of how they look:  

```
using Affdex;
using System.Collections.Generic;

public class PlayerEmotions : AbstractAffdexListener
{
    public float currentSmile;
    public float currentInterocularDistance;
    public float currentContempt;
    public float currentValence;
    public float currentAnger;
    public float currentFear;
    
    public override void onFaceFound(float timestamp, int faceId)
    {
        Debug.Log("Found the face");
    }

    public override void onFaceLost(float timestamp, int faceId)
    {
        Debug.Log("Lost the face");
    }
    
    public override void onImageResults(Dictionary<int, Face> faces)
    {
        Debug.Log("Got face results");
        if (faces.Count > 0)
        {
            FeaturePoints featurePointsList = Face[0].FeaturePoints; //Feature points can be retrieved from the face class.
            faces[0].Expressions.TryGetValue(Expressions.Smile, out currentSmile);
            currentInterocularDistance = faces[0].Measurements.interOcularDistance;
            faces[0].Emotions.TryGetValue(Emotions.Contempt, out currentContempt);
            faces[0].Emotions.TryGetValue(Emotions.Valence, out currentValence);
            faces[0].Emotions.TryGetValue(Emotions.Anger, out currentAnger);
            faces[0].Emotions.TryGetValue(Emotions.Fear, out currentFear);
        }
    }
}
```

OnImageResults is probably the most valuable method here.  The Faces class allows you to get the current values of all expressions, and all emotions.  It also allows you to get the interocular distance, facial feature point locations, and the orientation of the face.

For a fully implemented sample, check out [EmoSurvival](https://github.com/Affectiva/EmoSurvival/blob/master/Assets/Scripts/Player/PlayerEmotions.cs).  You can use onFaceLost to pause a game.  If you use Time.timeScale to pause, the camera script will also pause, as it uses the same time values.  

### Setting the Classifiers

While you can use the detector UI to set the emotion and expression classifiers (as discussed above) you can also set them programmatically.  The following methods are available to turn on or off the detection of various classifiers.  

By default, all classifiers are turned off (set to false).  Every classifier you turn on will take a bit more system resources.  

To set the detection of the smile classifier to on, call the Detector class's SetExpressionState method:  

```
void SetExpressionState(Expressions.Smile, true);
```
 
## Detectors

For each of the possible sources of facial frames, the asset has a script to consume and process images from these sources.  

### Detector

This is automatically attached to a scene with the Affdex\Detector script.  In the underlining emotion recognition engine, this uses the <code>Detector</code>.  It tracks expressions in a sequence of real-time frames. It expects each frame to have a timestamp that indicates the time the frame was captured. The timestamps arrive in an increasing order, which is why pausing the game using Time.timeScale can impact processing. The <code>Detector</code> will detect a face in an frame and deliver information on it to you.  

### Video File Input

Another common use of the asset is to process previously captured video files. The <code>VideoFileInput</code> helps streamline this effort by decoding and processing frames from a video file. During processing, the <code>VideoFileInput</code> decodes and processes frames as fast as possible and actual processing times will depend on CPU speed. Please see [this list](http://docs.unity3d.com/Manual/class-MovieTexture.html) of accepted file types and recommended video codecs that are compatible with the detector.  

## Data Structures

###Frame

The <code>Frame</code> is used for passing images to and from the detectors. If you use the <code>CameraInput</code> script described above you don't need to do this as that script takes care of it for you.  To initialize a new instance of a frame, you must call the frame constructor. The frame constructor requires the width and height of the frame and a pointer to the pixel array representing the image. Additionally, the color format of the incoming image must be supplied. (See below for supported color formats.)  

```
Frame(int frameWidth, int frameHeight, ref byte[] pixels, COLOR_FORMAT 
frameColorFormat);
```

A timestamp can be optionally set. It is required when passing the frame to the FrameDetector, and is not when using the PhotoDetector. The timestamp is automatically generated by querying the system time when using the CameraDetector, and is decoded from the video file in the case of the VideoDetector.  

```
Frame(int frameWidth, int frameHeight, ref byte[] pixels, COLOR_FORMAT 
frameColorFormat, float timestamp);
```

The following color formats are supported by the Frame class:  

```
enum class COLOR_FORMAT
{
    RGB,
    BGR
};
```

<!-- commented out until future release
```
enum class COLOR_FORMAT
{
  RGB,      // 24-bit pixels with Red, Green, Blue pixel ordering
  BGR,      // 24-bit pixels with Blue, Green, Red pixel ordering
  RGBA,     // 32-bit pixels with Red, Green, Blue, Alpha  pixel ordering
  BGRA,     // 24-bit pixels with Blue, Green, Red, Alpha pixel ordering
  YUV_NV21, // 12-bit pixels with YUV information (NV21 encoding)
  YUV_I420  // 12-bit pixels with YUV information (I420 encoding)
};
```
end comment -->

To retrieve the color format used to create the frame, call:  

```
COLOR_FORMAT getColorFormat();
```

To get the Frame image's underlying byte array of pixels, call this method:  

```
byte[] getBGRByteArray();
```

To retrieve the length of the frame's byte array in addition to the image's width and height in pixels, call the following methods:  

```
int getBGRByteArrayLength();
int getWidth() const;
int getHeight() const;
```

Client applications have the ability to get and set the Frame's timestamp through the following:  

```
float getTimestamp() const;
void setTimestamp(float value);
```

To see an example of how to send frames to the detector review [this GitHub Gist](https://gist.github.com/ForestJay/e47a258cc2ae7a9a44c8).  

### Face

The Face class represents a face found with a processed frame. It contains results for detected expressions and emotions and the face and head measurements.  

```
Face.Expressions
Face.Emotions
Face.Measurements
```

The Face object also enables users to retrieve the feature points associated with a face:  

```
Face.FeaturePoints
```

<strong>Expressions</strong>

<code>Expressions</code> is a representation of the probabilities of the facial expressions detected. Each value represents a probability between 0 to 100 of the presence of the expression in the frame analyzed:  

```
struct Expressions
{
  float Smile;
  float InnerEyeBrowRaise;
  float BrowRaise;
  float BrowFurrow;
  float NoseWrinkler;
  float UpperLipRaiser;
  float LipCornerDepressor;
  float ChinRaiser;
  float LipPucker;
  float LipPress;
  float LipSuck;
  float MouthOpen;
  float Smirk;
  float EyeClosure;
  float Attention;
};
```

<strong>Emotions</strong>

<code>Emotions</code> is a representation of the probabilities of the emotions detected. Each value represents a probability between 0 to 100 of the presence of the emotion in the frame analyzed. Valence, a measure of positivity or negativity of the expressions, ranges from -100 to 100:  

```
struct Emotions
{
  float Joy;
  float Fear;
  float Disgust;
  float Sadness;
  float Anger;
  float Surprise;
  float Contempt;
  float Valence;
  float Engagement;
};
```

<strong>Measurements</strong>

<code>Measurements</code> is a representation of the head and face measurements. The Interocular distance is the defined as the distance between the two outer eye corners in pixels:  

```
struct Expressions
{
  Orientation orientation;
  float interoculardistance;
};
```
<img src="../images/graphic3.png" align=right>

<strong>Orientation</strong>

<code>Orientation</code> is a representation of the orientation of the head in a 3-D space using Euler angles (pitch, yaw, roll):
  
```
struct Orientation
{
  float pitch;
  float yaw;
  float roll;
};
```

<strong>FeaturePoint</strong>

<code>FeaturePoint</code> is the cartesian coordinates of a facial feature on the source image and is defined as the following:  

```
struct FeaturePoint
{
  int id;
  float x;
  float y;
};
```

See the feature point indices [table]({{ site.baseurl }}/fpi/) for a full list of feature points.


## Special Notes on Builds

The SDK DLL is 64-bit.  This means that when you build you should build to 64-bit.  If you get an error like "Failed to load native library!  Make sure you build in 64-bit mode!" it probably means you built a 32-bit executable.  If you need a 32-bit version of the DLL please contact sdk@Affectiva.com .  
