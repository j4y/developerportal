---
title: Affdex SDK for Windows
permalink: /win/
tags: [windows, sdk]
audience: writer, designer
keywords:
last_updated:
summary:
---
{% include linkrefs.html %}

<img src={{ "/images/windows.png" | prepend: site.baseurl }} align=right>

SDK Developer Guide Release 2.1

## Requirements & Dependencies

##### Hardware requirements (recommended)

*	Processor, 2 GHz
*	RAM, 1 GB
*	Disk Space (min) : 950 MB

##### Runtime Requirements

*	Visual C++ Redistributable runtime for VS 2013
*	Microsoft .NET framework v 4.0 (.NET SDK only)

The software runtime requirements are installed automatically by the SDK installer.

##### Supported operating systems

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

In order to initialize the detector, a valid license file must be provided. Each license file issued by Affectiva is time bound and will only work for a fixed period of time shown in the license file, after which the SDK will throw an <code>AffdexLicenseException</code>. The location of the license file must be indicated by calling the following method with the fully qualified path to it:

```
void setLicensePath( String licensePath);
```

The Affdex classifier data files are used in frame analysis processing. These files are supplied as part of the SDK. The location of the data files on the physical storage needs to be passed to a detector in order to initialize it by calling the following with the fully qualified path to the folder containing them:

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
The <code>FrameDetector</code> constructor expects four parameters, a buffer size (which is necessary for setting the number of frames of the internal frame buffer), a process frame rate (useful for throttling the maximum number of frames processed per second), a maximum number of faces to process, and the face detector mode (LARGE_FACES for closer, SMALL_FACES for farther away). By default, the process frame rate is set to 30. If the buffer becomes full because processing cannot keep up with the supply of frames, the oldest unprocessed frame is dropped.  

```
FrameDetector(const int bufferSize,
              const float processFrameRate = DEFAULT_PROCESSING_FRAMERATE,
              const unsigned int maxNumFaces = DEFAULT_MAX_NUM_FACES,
              const FaceDetectorMode faceConfig = affdex::FaceDetectorMode::LARGE_FACES);
```

After successfully initializing the detector using the start method. The frames can be passed to the detector by calling the process method.  

```
void process(Frame frame);
```

### CameraDetector

Using a webcam is a common way to obtain video for facial expression detection. The CameraDetector can access a webcam connected to the device to capture frames and feed them directly to the facial expression engine.
The constructor of the <code>CameraDetector</code> class expects the camera ID, the number of frames to capture per second, the number of frames to process per second, the maximum number of faces to process, and the face detector mode (LARGE_FACES for closer, SMALL_FACES for farther away).

```
CameraDetector(const int cameraId = 0, const double cameraFPS = 15,
               const double processFPS = DEFAULT_PROCESSING_FRAMERATE,
               const unsigned int maxNumFaces = DEFAULT_MAX_NUM_FACES,
               const FaceDetectorMode faceConfig = affdex::FaceDetectorMode::LARGE_FACES);
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

Another common use of the SDK is to process previously captured video files. The <code>VideoDetector</code> helps streamline this effort by decoding and processing frames from a video file. Like the <code>FrameDetector</code>, the constructor accepts a parameter for processing frames per second. This parameter regulates how many frames from the video stream get processed. During processing, the <code>VideoDetector</code> decodes and processes frames as fast as possible and actual processing times will depend on CPU speed. Please see [this list]({{ site.baseurl }}/supportedvideoformats/) of accepted file types and recommended video codecs that are compatible with the detector.   Other parameters include the maximum number of faces to process, and face detector mode (LARGE_FACES for closer faces, and SMALL_FACES for farther away faces).

```
VideoDetector(const double processFPS = DEFAULT_PROCESSING_FRAMERATE,
              const unsigned int maxNumFaces = DEFAULT_MAX_NUM_FACES,
              const FaceDetectorMode faceConfig = affdex::FaceDetectorMode::SMALL_FACES);
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

The <code>PhotoDetector</code> class is used for streamlining the processing of still images. Since photos lack any continuity over time, the expression and emotion detection is performed independently on each frame and the timestamp is ignored. Due to this fact, the underlying emotion detection may return different results than the video based detectors. It takes two arguments, maximum number of faces, and face mode (LARGE_FACES for closer faces, and SMALL_FACES for farther away faces).

```
PhotoDetector(const unsigned int maxNumFaces = DEFAULT_MAX_NUM_FACES,
              const FaceDetectorMode faceConfig = FaceDetectorMode::SMALL_FACES);
```

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


## Interface classes

##### ImageListener

This interface delivers information about the images and faces captured by a detector. The <code>ImageListener</code> contains two client callback methods:

<code>onImageResults</code> returns the processed frame and a dictionary of the faces found. An individual entry in the dictionary is comprised of a face ID and a Face object which contains metrics about the face. If the image was processed but no face was found, the returned dictionary will be empty.

```
virtual void onImageResults(Dictionary<int, Face> faces, Frame image);
```

<code>onImageCapture</code> returns all the frames passed to the detector.  

```
virtual void onImageCapture(Frame image);
```

##### FaceListener

This interface provides methods that the Detector uses to communicate to users of the class. The following method indicates that the face detector has detected a face and has begun tracking it. The receiver should expect that tracking continues until detection has stopped.  

```
virtual void onFaceFound(float timestamp, int faceId);
```

The following method indicates that the face detector has stopped tracking a face, and is called when a face is no longer detected. The receiver should expect that there is no face tracking until the detector is started again.  

```
virtual void onFaceLost(float timestamp, int faceId);
```

##### ProcessStatusListener

This is a client listener interface which delivers information on the state of the processing.
The <code>ProcessStatusListener</code> contains callbacks to inform about the status of the processing.  <code>onProcessingFinished</code> is called when a video file has completed processing. <code>onProcessingException</code> is called if an AffdexException is encountered during the processing. If either of those callbacks is triggered, no further calls to any registered ImageListeners should be expected and it is safe to stop the detector.  

```
virtual void onProcessingFinished();
virtual void onProcessingException(AffdexException exception); 
```
