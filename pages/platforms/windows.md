---
title: Affdex SDK for Windows
permalink: /windows/
tags: [windows, sdk]
audience: writer, designer
keywords: 
last_updated: 
summary: 
---
{% include linkrefs.html %} 

<img src={{ "/images/windows.png" | prepend: site.baseurl }} align=right>

SDK Developer Guide Release 2.0
 
## Requirements & Dependencies

<em><strong>Hardware requirements (recommended)</strong></em>

*	Processor, 2 GHz
*	RAM, 1 GB
*	Disk Space (min) : 950 MB

<em><strong>Runtime Requirements</strong></em>

*	Visual C++ Redistributable runtime for VS 2013
*	Microsoft .NET framework v 4.0 (.NET SDK only)

The software runtime requirements are installed automatically by the SDK installer.

<em><strong>Supported operating systems</strong></em>

*	Windows 7 and above

 
## Using the SDK

Since the purpose of the SDK is to detect facial expressions and their underlying emotions from facial images. Facial images can be captured from different sources:

*	Camera: a webcam that is connected to the device.
*	Video: a video file on a device's local storage.
*	Frames: a sequence of timed images.
*	Photos: a facial photo

For each of the different sources, the SDK defines a detector class that can handle processing images acquired from that source. There are a set of comon steps needed to start using a detector.

### Creating a Detector
First step is to instantiate a detector that matches the source. Each detector expects a different set of parameters in their constructor that is dependent on their functionality, for example the <code>FrameDetector</code> constructor expects two parameters, a buffer size, which is necessary for setting the capacity (number of frames) of the internal FrameBuffer and a process frame rate, which can be used to throttle the maximum number of frames that get processed per second. By default, the process frame rate is set to 30.

```
FrameDetector(int bufferSize, int processFrameRate);
```

### Configuring a Detector 

In order to succesfully initialize the detector, a valid license file must be provided. Each license file issued by Affectiva is time bound and will only work for a fixed period of time shown in the license file, after which the SDK will throw an <code>AffdexLicenseException</code>. The location of the license file must be indicated by calling the following method with the fully qualified path to it:

```
void setLicensePath( String licensePath);
```

The Affdex classifier data files are used in frame analysis processing. These files are supplied as part of the SDK. The location of the data files on the phyiscal storage needs to be passed to a detector in order to initalize it by calling the following with the fully qualified path to the folder containing them:

```
void setClassifierPath(String classifierPath);
```

 
The Detectors use callback or interface classes to communicate events and results. The event listeners need to be initialized before the detector is started:
The <code>FaceListener</code> is a client callback interface which sends notification when the detector has started or stopped tracking a face. Call the following method to set the <code>FaceListener</code>:  

```
void setFaceListener(FaceListener listener);
```

The <code>ImageListener</code> is a client callback interface which delivers information about an image which has been handled by the Detector. Call the following methods to set the <code>ImageListener</code>:  

```
void setImageListener(ImageListener listener);
```

The <code>ProcessStatusListener</code> is a callback interface which provides information regarding the processing state of the detector. Call the following methods to set the <code>ProcessStatusListener</code>:  

```
void setProcessStatusListener(ProcessStatusListener listener);
```

### Setting the Classifiers

The following methods are available to turn on or off the detection of various classifiers.

```
bool getDetectClassifier();
```

and

```
void setDetectClassifier(bool detectClassifier);
```

By default, all classifiers are turned off (set to false).

For example, to set on or off the detection of the smile and attention classifiers:  

```
bool getDetectAttention();
void setDetectAttention(bool detectAttention);

bool getDetectSmile();
void setDetectSmile(bool detectSmile);
```

To turn on or off the detection of all expresssions and emotions: 

```
void setDetectAllExpressions(bool activate);
void setDetectAllEmotions(bool activate);
```

### Starting a Detector

After a detector is configured using the methods above, the detector initialization can be triggered by calling the start method:  

```
void start();
```

Likewise, stopping the detector can be done as follows: 

```
void stop();
```

The processing state can be reset. This method resets the context of the video frames. Additionally Face IDs and Timestamps are set to zero (0):  

```
void reset();
```

In order to determine whether the detector is currently running, call the following:  

```
bool isRunning();
```

This returns the state of the detector. If detector is running; it returns <strong>true</strong>, else <strong>false</strong>.
 
## Detectors

For each of the possible sources of facial frames, the SDK defines a detector class to consume and process images from these sources.

### FrameDetector

The <code>FrameDetector</code> tracks expressions in a sequence of real-time frames. It expects each frame to have a timestamp that indicates the time the frame was captured. The timestamps arrive in an increasing order. The <code>FrameDetector</code> will detect a face in an frame and deliver information on it to you, including the facial expressions. 
The <code>FrameDetector</code> constructor expects two parameters, a buffer size (which is necessary for setting the number of frames of the internal frame buffer), and a process frame rate (useful for throttling the maximum number of frames processed per second). By default, the process frame rate is set to 30. If the buffer becomes full because processing cannot keep up with the supply of frames, the oldest unprocessed frame is dropped.  

```
FrameDetector(int bufferSize, int processFrameRate);
```

After successfully initializing the detector using the start method. The frames can be passed to the detector by calling the process method.  

```
void process(Frame frame);
```

### CameraDetector

Using a webcam is a common way to obtain video for facial expression detection. The CameraDetector can access a webcam connected to the device to capture frames and feed them directly to the facial expression engine. 
The constructor of the <code>CameraDetector</code> class expects the camera ID, the number of frames to capture per second and the number of frames to process per second. 

```
CameraDetector(int cameraId=0, double cameraFPS=15, double processFPS);
```

An instance of the <code>CameraDetector</code> can also be created without any parameters. In this case, the detector connects to the first camera on the device list and assumes the capture frame rate to be 15
frames per second. 

```
CameraDetector();
```

In addition to all of the methods common between all of the detectors, methods are available to set the camera ID. The camera ID must be a positive number:  

```
void setCameraId(int cameraId);
```

The capture frame rate can also be set or reset. The frame rate must be a positive number greater than zero (0):  

```
void setCameraFPS(double cameraFPS);
```

### VideoDetector

Another common use of the SDK is to process previously captured video files. The <code>VideoDetector</code> helps streamline this effort by decoding and processing frames from a video file. Like the <code>FrameDetector</code>, the constructor accepts a parameter for processing frames per second. This parameter regulates how many frames from the video stream get processed. During processing, the <code>VideoDetector</code> decodes and processes frames as fast as possible and actual processing times will depend on CPU speed. Please see [this list]({{ site.baseurl }}/supportedvideoformats/) of accepted file types and recommended video codecs that are compatible with the detector.  

```
VideoDetector(double processFPS);
```

Once the detector is started, the processing begins by calling the process function, the path to video file you are processing is passed in as a parameter:  

```
void process(String path);
```

To stop the processing, the stop method can be used, however it is best to only call this method once video processing has completed.  

```
void stop();
```

### PhotoDetector

The <code>PhotoDetector</code> class is used for streamlining the processing of still images. Since photos lack any continuity over time, the expression and emotion detection is performed independently on each frame and the timestamp is ignored. Due to this fact, the underlying emotion detection may return different results than the video based detectors.
Like the <code>FrameDetector</code>, the <code>PhotoDetector</code> must be started:  

```
void start();
```

and stopped:  

```
void stop();
```

Photos are processed using the following method:  

```
void process(Frame frame);
```

Unlike other detectors, photo processing is done <strong>synchronously</strong>.
Calls to process will not return until processing is complete and the ImageListener callback methods have complete. 

## Data Structures

###Frame

The <code>Frame</code> is used for passing images to and from the detectors. To initialize a new instance of a frame, you must call the frame constructor. The frame constructor requires the width and height of the frame and a pointer to the pixel array representing the image. Additionally, the color format of the incoming image must be supplied. (See below for supported color formats.) 

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


## Listeners

<strong>ImageListener</strong>

This interface delivers information about the images and faces captured by a detector. The <code>ImageListener</code> contains two client callback methods:

<code>onImageResults</code> returns the processed frame and a dictionary of the faces found. An individual entry in the dictionary is comprised of a face ID and a Face object which contains metrics about the face. If the image was processed but no face was found, the returned dictionary will be empty. The detectors track a single face, the face that occupies the largest area in the image. A Future release of the SDK will allow tracking mutiple faces in an image.  

```
virtual void onImageResults(Dictionary<int, Face> faces, Frame image);
```

<code>onImageCapture</code> returns all the frames passed to the detector.  

```
virtual void onImageCapture(Frame image);
```

<strong>FaceListener</strong>

This interface provides methods that the Detector uses to communicate to users of the class. The following method indicates that the face detector has detected a face and has begun tracking it. The receiver should expect that tracking continues until detection has stopped.  

```
virtual void onFaceFound(float timestamp, int faceId);
```

The following method indicates that the face detector has stopped tracking a face, and is called when a face is no longer detected. The receiver should expect that there is no face tracking until the detector is started again.  

```
virtual void onFaceLost(float timestamp, int faceId);
```

<strong>ProcessStatusListener</strong>

This is a client listener interface which delivers information on the state of the processing.
The <code>ProcessStatusListener</code> contains callbacks to inform about the status of the processing.  <code>onProcessingFinished</code> is called when a video file has completed processing. <code>onProcessingException</code> is called if an AffdexException is encountered during the processing. If either of those callbacks is triggered, no further calls to any registered ImageListeners should be expected and it is safe to stop the detector.  

```
virtual void onProcessingFinished();
virtual void onProcessingException(AffdexException exception); 
```

