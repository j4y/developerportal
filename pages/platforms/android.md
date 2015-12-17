---
title: Affdex SDK for Android
permalink: /android/
tags: [android, sdk]
audience: writer, designer
keywords: 
last_updated: 
summary: 
---
{% include linkrefs.html %} 

<img src={{ "/images/android.png" | prepend: site.baseurl }} align=right>

SDK Developer Guide Release 2.1

## Requirements & Dependencies

The Affdex SDK requires a device running Android API 16 or above.
Java 1.6 or above is required on your development machine.



 The SDK requires access to external storage on the Android device, and Internet access for collecting anonymous analytics (see “A Note about Privacy” in “Introducing the SDK”). Include the following in your app’s <code>AndroidManifest.xml</code>:  

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```


### Licensing
After you request the SDK, Affectiva will provide to you an Affectiva license file.  Copy this file into your Android app project under the folder <em>/assets/Affdex</em>, and specify its relative path under that folder when invoking the <code>setLicensePath</code> method (described in more detail below). 


## Adding the SDK to Your Project 

In order to use this SDK in one of your Android apps, you will need to copy some files from the SDK into your Android project. In your Android project, alongside your “src and “res” folders, you may have the optional folders “assets” and “libs”. Copy the SDK’s “assets” folder into your project. If you already have an “assets” folder, copy the contents of the SDK’s “assets” folder into your “assets” folder. In a similar way, copy the SDK's “libs” folder into your project. 

The provided sample app does not have “assets” or “libs” folders.  In this case, simply copy the entire “assets and “libs” folders into the app’s project, at the same level as the “res” and “src” folders.
We do not recommend adding any of your own files to the “assets/Affdex” folder.

## Using the SDK

The following code snippets demonstrate how easy it is to obtain facial expression results using your device’s camera, a video file, or from images.

## SDK Operating Modes

The Affdex SDK has the following operating modes:

*   Camera mode:  the SDK turns on and connects to the camera and processes the frames it records.  Sample app: AffdexMe.
*   Video file mode:  provide to the SDK a path to a video file. 
*   Pushed frame mode:  provide to the SDK individual frames of video and their timestamps. 
*   Photo mode:  provide discrete images to the SDK (unrelated to any other image).

The SDK provides mode-specific Detector classes for each of these modes: CameraDetector, VideoFileDetector, FrameDetector, and PhotoDetector. 


### SDK calling overview

In general, calls to the SDK are made in the following order:

*   Construct a Detector corresponding to the operating mode that you want. 
*   Call <code>setLicensePath()</code> with the path to the license file provided by Affectiva.
*   Set options for the Detector. In particular, enable detection of at least one facial expression metric (e.g. call <code>setDetectSmile()</code> to detect smiles).  Several facial expressions can be detected by the SDK, as described in “Introducing the SDK”. See the “Options” section below for more information on the different options available. 
*   Call <code>start()</code> to start processing.  Note the types of exceptions that can be thrown and handle them as desired. 
*   If you are pushing your own images (pushed frame mode or photo mode), call <code>process()</code> with each image.
*   When you are done processing, call <code>stop()</code>. 

To receive results from the SDK, implement the <code>Detector.ImageListener</code> and/or <code>Detector.FaceListener</code> interfaces, and register your listener object(s) with the Detector via <code>setImageListener()</code> and/or <code>setFaceListener()</code>. These interfaces provide results of the SDK’s processing of each frame.  The <code>ImageListener</code> interface provides information about facial expressions and [face points]({{ site.baseurl }}/fpi/) for a face found in a given image via its <code>onImageResults</code> callback.  The FaceListener interface notifies its listener when a face appears or disappears via its <code>onFaceDetectionStarted()</code> and <code>onFaceDetectionStopped()</code> callbacks. For an example of using these callbacks to show and hide the results from the SDK, see the sample app AffdexMe. 
To check to see if the Detector is running (<code>start()</code> has been called, but not <code>stop()</code>), call <code>isRunning()</code>.  
{{ note }} Be sure to always call <code>stop()</code> following a successful call to <code>start()</code> (including for example, in circumstances where you abort processing, such as in exception catch blocks).  This ensures that resources held by the Detector instance are released. {{ end }}

### Camera Mode 

Using the built-in camera is a common way to obtain video for facial expression detection. Either the front or back camera of your Android device can be used to feed video directly to the Detector.  
A demonstration of Camera Mode is the sample app AffdexMe.  
To use Camera Mode,  implement the <code>Detector.ImageListener</code> and/or <code>Detector.FaceListener</code> interface. Then follow this sequence of SDK calls:  

*   Construct a CameraDetector. The <code>cameraType</code> argument specifies whether to connect to the front or back camera, the <code>cameraPreviewView</code> argument optionally specifics a SurfaceView onto which the SDK should display preview frames, the <code>maxNumFaces</code> argument indicates the maximum number of faces that the system should try to track (may slow down the system if value is too high), and the <code>faceDetectorMode</code> argument is a flag to specify if the system is tracking large (up close) or small (farther away) faces. Possible values are   <code>Detector.FaceDetectorMode.LARGE_FACES</code> or <code>Detector.FaceDetectorMode.SMALL_FACES</code>.

```
public CameraDetector(Context context, CameraType cameraType, SurfaceView cameraPreviewView, int maxNumFaces, FaceDetectorMode faceDetectorMode)
```

*   Call <code>setLicensePath()</code> with the path to the license file provided by Affectiva.  
*   Set options for the Detector. In particular, turn on at least one facial expression metric to detect facial expressions, e.g.  
```
setDetectSmile(true);  
```

*   Call <code>start()</code> to initialize the SDK and call <code>startCamera(CameraType)</code> to start the device Camera.   If successful, you will start receiving calls to <code>onImageResults()</code>.  
*   When you are done, call <code>stopCamera()</code> to stop the Camera and call <code>stop()</code> to release the resources used by the Affdex SDK.  
*	Remember to add the Camera permission to your <em>AndroidManifest.xml</em> file.

#### Sizing the SurfaceView

Aside from the convenience of managing the Android Camera, <code>CameraDetector</code> also takes care of choosing the frame rate and frame size that will work best with the SDK. Since it is the developer’s responsibility to layout and size the <code>SurfaceView</code> passed into <code>CameraDetector</code>, you may want to resize the <code>SurfaceView</code> to match the aspect ratio of the returned frames. For this purpose, implement the <code>CameraDetector.OnCameraEventListener</code> interface to receive the <code>onCameraSizeSelected</code> event. Below is a block of sample code showing how to resize the <code>SurfaceView</code> to occupy as much space as its parent container while matching the aspect ratio of the incoming camera frames.

```
@Override
public void onCameraSizeSelected(int cameraWidth, int cameraHeight, ROTATE rotation) {
    int cameraPreviewWidth;
    int cameraPreviewHeight;    	

//cameraWidth and cameraHeight report the unrotated dimensions of the camera frames, so switch the width and height if necessary

    if (rotation == ROTATE.BY_90_CCW || rotation == ROTATE.BY_90_CW) {
    cameraPreviewWidth = cameraHeight;
    cameraPreviewHeight = cameraWidth;
    } else {
    cameraPreviewWidth = cameraWidth;
    cameraPreviewHeight = cameraHeight;
    }

//retrieve the width and height of the ViewGroup object containing our SurfaceView (in an actual application, we would want to consider the possibility that the mainLayout object may not have been sized yet)

    int layoutWidth = mainLayout.getWidth();
    int layoutHeight = mainLayout.getHeight();

//compute the aspect Ratio of the ViewGroup object and the cameraPreview

    float layoutAspectRatio = (float)layoutWidth/layoutHeight; 	
    float cameraPreviewAspectRatio = (float)cameraWidth/cameraHeight;

    int newWidth;
    int newHeight;

    if (cameraPreviewAspectRatio > layoutAspectRatio) {
    newWidth = layoutWidth;
    newHeight =(int) (layoutWidth / cameraPreviewAspectRatio);
    } else {
    newWidth = (int) (layoutHeight * cameraPreviewAspectRatio);
    newHeight = layoutHeight;
    }

//size the SurfaceView

    ViewGroup.LayoutParams params = surfaceView.getLayoutParams();
    params.height = newHeight;
    params.width = newWidth;
    surfaceView.setLayoutParams(params);
}
```

#### Hiding the SurfaceView

Some applications may not wish to display the camera preview on screen. Since Android requires an active Surface for the camera to function, <code>CameraDetector</code> always requires a <code>SurfaceView</code to be passed in. However, if you do not wish to display the preview, you can set the <code>SurfaceView</code> to be 1px by 1px and call <code>SurfaceView.setAlpha(0)</code> to hide it on-screen.

### Video File Mode

Another way to feed video into the detector is via a video file that is stored on the file system of your device. Follow this sequence of SDK calls: 

*   Construct a VideoFileDetector. The <code>filePath</code> argument is the path to your video file, the <code>maxNumFaces</code> argument indicates the maximum number of faces that the system should try to track (may slow down the system if value is too high), and the <code>faceDetectorMode</code> argument is a flag to specify if the system is tracking large (up close) or small (farther away) faces. Possible values are <code>Detector.FaceDetectorMode.LARGE_FACES</code> or <code>Detector.FaceDetectorMode.SMALL_FACES</code>.  
```
public VideoFileDetector(Context context, String filePath, int maxNumFaces, FaceDetectorMode faceDetectorMode)
```

*   Call <code>setLicensePath()</code> with the path to the license file provided by Affectiva.
*   Set options for the Detector. In particular, turn on at least one facial expression metric to detect facial expressions, e.g.   
```
setDetectSmile(true); 
```

*   Call <code>start()</code> to start processing. You will start receiving calls to <code>onImageResults()</code>. 
*   When you are done processing, call <code>stop()</code>. 

### Pushed Frame Mode

If your app is processing video and has access to video frames, you can push those video frames to the Affdex SDK for processing.  Each video frame has an associated timestamp that increases with each frame in the video.  Your app may have access to video frames because your app is interfacing to the device’s camera, or because your app is reading a video file, or perhaps by some other method. The <code>maxNumFaces</code> argument indicates the maximum number of faces that the system should try to track (may slow down the system if value is too high), and the <code>faceDetectorMode</code> argument is a flag to specify if the system is tracking large (up close) or small (farther away) faces. Possible values are <code>Detector.FaceDetectorMode.LARGE_FACES</code> or <code>Detector.FaceDetectorMode.SMALL_FACES</code>.  

*   Construct a FrameDetector.  
```
public FrameDetector(Context context, int maxNumFaces, FaceDetectorMode faceDetectorMode)
```

*   Call <code>setLicensePath()</code> with the path to the license file provided by Affectiva.  
*   Set options for the Detector. In particular, turn on at least one facial expression metric to detect facial expressions, e.g.  
```
setDetectSmile(true); 
```

*   Call <code>start()</code> to start processing.
*   For each video frame, create an Affdex Frame (Bitmap, RGBA, and YUV420sp/NV21 formats are supported).
{{ note }} Frame is an abstract base class with two concrete subclasses: BitmapFrame and ByteArrayFrame; you should construct one of these concrete subclasses. {{ end }}

*   Call <code>process</code> with the Affdex Frame and timestamp of the frame:  
```
public abstract void process(Frame frame, float timestamp); 
```

*   For each call to <code>process</code>, the SDK will call <code>onImageResults()</code>. 
*   When you are done processing, call <code>stop()</code>. 


### Photo Mode

Use Photo Mode for processing images that are unrelated to each other (that is, they are not sequential frames of a video). Discrete images are processed by the SDK independently, without regard to the content of the preceding images, using different algorithms and data than are used with the other modes involving sequences of frames from a video source. The <code>maxNumFaces</code> argument indicates the maximum number of faces that the system should try to track (may slow down the system if value is too high), and the <code>faceDetectorMode</code> argument is a flag to specify if the system is tracking large (up close) or small (farther away) faces. Possible values are <code>Detector.FaceDetectorMode.LARGE_FACES</code> or <code>Detector.FaceDetectorMode.SMALL_FACES</code>.  

*   Construct a PhotoDetector.  
```
public PhotoDetector(Context context, int maxNumFaces, FaceDetectorMode faceDetectorMode)
```

*   Call <code>setLicensePath()</code> with the path to the license file provided by Affectiva.
*   Set options for the Detector. In particular, turn on at least one facial expression metric to detect facial expressions, e.g.  
```
setDetectSmile(true); 
```

*   Call <code>start()</code> to initialize the PhotoDetector. 
*   For each photo to be processed, create an Affdex Frame from your frame (Bitmap, RGBA, and YUV420sp/NV21 formats are supported). 

{{ note }} Frame is an abstract base class with two concrete subclasses: BitmapFrame and ByteArrayFrame; you should construct one of these concrete subclasses. {{ end }}

*   Call process with the Affdex Frame:  
```
public abstract void process(Frame frame); 
```

*   For each call to process, the SDK will call <code>onImageResults()</code>. 
*   When you are done processing, call <code>stop()</code>. 



## Options

This section describes various options for operating the SDK.

### Detecting facial expressions

The Affdex SDK can detect a variety of facial expressions, yielding metric scores for the expressions you configure.  Affdex expression metrics are described in detail in the “Introducing the SDK” document. By default, no expressions are detected. Detection can be enabled or disabled via setDetectXXX methods defined on the Detector class.  For example:  
```
setDetectSmile(true) 
```

See the Detector class <a href={{ "/pages/platforms/javadoc/index.html" | prepend: site.baseurl }}>Javadoc</a> for a complete list of the methods available.

### Processing Rate

In Camera Mode, you can specify the maximum number of frames per second that the SDK should process. This can improve performance if your requirements do not require every frame in the video stream from the camera to be processed. The default (and recommended) rate is 5 frames per second, but you may also set it lower if you are using a slower device, and need additional performance. Here is an example of setting the processing rate to 20 FPS:  
```
setMaxProcessRate(20); 
```

### Face Detection Statistics
To get the percentage of time any face was detected during a run (between <code>start()</code> and <code>stop()</code>), call:  
```
getPercentFaceDetected();  
```

This can only be called after <code>stop()</code>. 

### Interpreting the Data

To receive the results of the SDK’s processing of a frame, implement the <code>Detector.ImageListener</code> and/or <code>Detector.FaceListener</code> interfaces.  

For the ImageListener interface, implement the callback <code>onImageResults()</code>, which is called by the SDK for every frame (except those that the CameraDetector skips in order to honor the maximum processing rate, unless <code>setSendUnprocessFrames(true)</code> has been called).
This method receives these parameters: 

1.  A list of Face objects.  In this release, this will be an empty list if no face was found in the frame, or a list of Face objects for each face found in the frame.  In Camera Mode, if setSendUnprocessedFrames(true) has been called, then this parameter will be null for any frame that has been skipped in order to honor the maximimum processing rate. 
2.  The image processed, as an Affdex Frame (a wrapper type for images, including Bitmaps, for example).
3.  The timestamp of the frame.  In Photo Mode, this will be zero.

The returned Face object contains five accessible inner objects: appearance, emoji, emotions, expressions, and measurements. Each of these inner objects has getter methods for retrieving the scores detected for each metric. For example, the smile score can be retrieved by calling <code>face.expressions.getSmile()</code>  
The appearance metrics are enumerations that include identification of gender as male, female or unknown, as well as the detection of the presence or absence of worn glasses.  
The follow code sample shows an example of how to retrieve metric values from the Face object in <code>onImageResults</code>:  

```
@Override
public void onImageResults(List<Face> faces, Frame image,float timestamp) {

    if (faces == null)
        return; //frame was not processed

    if (faces.size() == 0)
        return; //no face found

    Face face = faces.get(0); //0 indexed list of faces found

    //Appearance
    Gender genderValue = face.appearance.getGender();
    Glasses glassesValue = face.appearance.getGlasses();

    //Some Emoji
    float smiley = face.emoji.getSmiley();
    float laughing = face.emoji.getLaughing();
    float wink = face.emoji.getWink();


    //Some Emotions
    float joy = face.emotions.getJoy();
    float anger = face.emotions.getAnger();
    float disgust = face.emotions.getDisgust();

    //Some Expressions
    float smile = face.expressions.getSmile();
    float brow_furrow = face.expressions.getBrowFurrow();
    float brow_raise = face.expressions.getBrowRaise();

    //Measurements
    float interocular_distance = face.measurements.getInterocularDistance();
    float yaw = face.measurements.orientation.getYaw();
    float roll = face.measurements.orientation.getRoll();
    float pitch = face.measurements.orientation.getPitch();
}

```
  
The Face object also provides a <code>getFacePoints()</code> method, which returns an array of face point coordinates.
In the following code sample, the face point coordinates are retrieved from the face object and logged. 

```
@Override
public void onImageResults(List<Face> faces, Frame frame,float timestamp) {

    if (faces == null)
        return; //frame was not processed

    if (faces.size() == 0)
        return; //no face found

    Face face = faces.get(0); //0 indexed list of faces found

    PointF[] points = face.getFacePoints();

    for (int n = 0; n < points.length; n++) {
        Log.i(LOG_TAG, String.format("Point %d is located at %.2f,%.2f \n",n,points[n].x,points[n].y));
    }
}
```
