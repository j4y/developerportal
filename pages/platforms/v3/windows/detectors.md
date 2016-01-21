---
title: Detectors
permalink: /v3/windows/detectors/
tags: [windows, sdk]
audience: writer, designer
keywords:
last_updated:
summary:
metadata: false
---
## CameraDetector

A `Detector` used to acquire and process frames from a physical camera.

```csharp
class CameraDetector : Detector
{
public:

    /// <summary>
    /// Creates a CameraDetector with the following default settings:
    /// <para> camerId = 0. The camera Id </para>
    /// <para> cameraFPS = 15. Capture framerate from the camera. </para>
    /// <para> processFPS = 30. Capture framerate from the process. </para>
    /// <para> maxNumFaces = 1. The max number of faces to be tracked. </para>
    /// <para> faceConfig = FaceDetectorMode.LARGE_FACES.  Face detector configuration. </para>
    /// </summary>
    CameraDetector();

    /// <summary>
    /// Creates a CameraDetector.
    /// <para>
    /// This class acquires the device camera and will immediately start processing frames from the camera feed.
    /// Processing is asynchronous so some frames may be dropped
    /// </para>
    /// </summary>
    /// <param name="cameraId">Device id for the camera. </param>
    /// <param name="cameraFPS">Capture framerate from the camera. Must be positive.</param>
    /// <param name="processFPS">Maximum framerate from processing. Must be positive.</param>
    CameraDetector(int cameraId, double cameraFPS, double processFPS);

    /// <summary>
    /// Creates a CameraDetector.
    /// <para>
    /// This class acquires the device camera and will immediately start processing frames from the camera feed.
    /// Processing is asynchronous so some frames may be dropped
    /// </para>
    /// </summary>
    /// <param name="cameraId">Device id for the camera. </param>
    /// <param name="cameraFPS">Capture framerate from the camera. Must be positive.</param>
    /// <param name="processFPS">Maximum framerate from processing. Must be positive.</param>
    /// <param name="maxNumFaces">The max number of faces to be tracked.</param>
    /// <param name="faceConfig">Face detector configuration.</param>
    CameraDetector(int cameraId, double cameraFPS, double processFPS, unsigned int maxNumFaces, FaceDetectorMode faceConfig);

    /// <summary>
    /// Finalizes an instance of the <see cref="CameraDetector"/> class.
    /// </summary>
    ~CameraDetector();

    /// <summary>
    /// Set/reset the camera framerate. Must be positive
    /// </summary>
    /// <param name="cameraFPS">Capture framerate from the camera. Must be positive.</param>
    /// <exception cref="AffdexException"> <see cref="AffdexException"/> on an invalid FPS value </exception>

    void setCameraFPS(const double cameraFPS);

    /// <summary>
    /// Set/reset the camera id. Must be positive
    /// </summary>
    /// <param name="cameraId">Capture id of the camera. Must be positive.</param>
    /// <exception cref="AffdexException"> <see cref="AffdexException"/> on an invalid value.</exception>
    void setCameraId(const int cameraId);

};
```
***
## PhotoDetector

A `Detector` for processing still images

```csharp
class PhotoDetector : Detector
{
public:

    /// <summary>
    /// Initializes a new instance of the PhotoDetector class with default face detector configuration
    /// <para> maxNumFaces = 1. The max number of faces to be tracked. </para>
    /// <para> faceConfig = FaceDetectorMode.SMALL_FACES.  Face detector configuration. </para>
    /// </summary>
    PhotoDetector();

    /// <summary>
    /// Initializes a new instance of the PhotoDetector class.
    /// <param name="maxNumFaces">The max number of faces to be tracked.</param>
    /// <param name="faceConfig">Face detector configuration.</param>
    /// </summary>
    PhotoDetector(unsigned int maxNumFaces, FaceDetectorMode faceConfig);

    /// <summary>
    /// Finalizes an instance of the PhotoDetector class.
    /// </summary>
    ~PhotoDetector();

    /// <summary>
    /// Processes a photo.
    /// <para>
    /// Results will be processed synchronously and this method will block until the results callback returns.
    /// Subsequent calls to process will be processed independently.
    /// </para>
    /// </summary>
    /// <param name="frame"> Photo to be processed. Timestamp values are ignored and can be used to identify the photo.</param>
    void process(Frame frame);
};
```
***

## FrameDetector

A `Detector` used to process a sequence of timestamped frames.

```csharp
class FrameDetector : Detector
{
public:

    /// <summary>
    /// Creates a FrameDetector.
    /// </summary>
    /// <param name="bufferSize">Size of buffer to use for processing </param>
    /// <param name="processFrameRate">Maximum processing framerate.</param>
    /// <param name="maxNumFaces">The max number of faces to be tracked.</param>
    /// <param name="faceConfig">Face detector configuration.</param>
    FrameDetector(int bufferSize, float processFrameRate, unsigned int maxNumFaces, FaceDetectorMode faceConfig);

    /// <summary>
    /// Creates a FrameDetector.
    /// </summary>
    /// <param name="bufferSize"> Size of buffer to use for processing </param>
    FrameDetector(int bufferSize);

    /// <summary>
    /// Finalizes an instance of the <see cref="FrameDetector"/> class.
    /// </summary>
    ~FrameDetector();

    /// <summary>
    /// Provide a frame for the detector to process.
    /// Callers may pass frames to this method at any rate that is suitable for them. The
    /// detector expects subsequent frames to be related to previous frames (e.g. a video stream).
    /// </summary>
    /// <param name="frame"> <see cref="Frame" /> of video to be added to the processing buffer.</param>
    void process(Frame frame);
};
```
***

## VideoDetector

A `Detector` that opens a video file and will immediately start decoding and processing frames for it.
It requires opencv_ffmpeg.dll in runtime for video decoding.

```csharp
class VideoDetector : Detector
{
public:

    /// <summary>
    /// Creates a VideoDetector with the default parameters:
    /// <para> processFPS = 30. Capture framerate from the process. </para>
    /// <para> maxNumFaces = 1. The max number of faces to be tracked. </para>
    /// <para> faceConfig = FaceDetectorMode.LARGE_FACES.  Face detector configuration. </para>
    /// </summary>
    VideoDetector();

    /// <summary>
    /// Creates a VideoDetector with custom processing frame rate.
    /// </summary>
    /// <param name="processFPS">Peak frame-rate at which frames from the video will be processed. Frames occuring in excess of this rate will be dropped.</param>
    VideoDetector(double processFPS);

    /// <summary>
    /// Creates a VideoDetector with custom processing frame rate and face detector config.
    /// </summary>
    /// <param name="processFPS">Peak frame-rate at which frames from the video will be processed. Frames occuring in excess of this rate will be dropped.</param>
    /// <param name="maxNumFaces">The max number of faces to be tracked.</param>
    /// <param name="faceConfig">Face detector configuration.</param>
    VideoDetector(double processFPS, unsigned int maxNumFaces, FaceDetectorMode faceConfig);

    /// <summary>
    /// Finalizes an instance of the <see cref="VideoDetector"/> class.
    /// </summary>
    ~VideoDetector() override;

    /// <summary>
    /// Open a video file
    /// </summary>
    /// <param name="path">Path to the video file to be processed.</param>
    void process(String path);
};
```
***

## Detector
Base `Detector` class

```csharp
class Detector
{

public:

    /// <summary>
    /// Constructor.
    /// </summary>
    Detector();

    /// <summary>
    /// Virtual desctructor.
    /// </summary>
    virtual ~Detector();

    /// <summary>
    /// Initialize the detector.
    /// </summary>
    /// <exception cref="AffdexLicenseException"> <see cref="AffdexLicenseException" /> on failed license verification.</exception>
    /// <exception cref="AffdexException"> <see cref="AffdexException"/> on failure to initialize.</exception>
    virtual void start();

    /// <summary>
    /// Stop the detector and deallocate resources.
    /// </summary>
    virtual void stop();

    /// <summary>
    /// Reset the processing state of the detector.
    /// This method enables an already initialized detector to begin processing a second video/camera feed.
    /// </summary>
    virtual void reset();

    /// <summary>
    /// Returns the state of the detector.
    /// </summary>
    /// <returns> True if the Detector is initialized. False otherwise. </returns>
    virtual bool isRunning();

    /// <summary>
    /// Gets the face detector configuration in use
    /// </summary>
    virtual FaceDetectorMode getFaceDetectorMode();

    /// <summary>
    /// Gets the max number of faces to be tracked.
    /// </summary>
    virtual unsigned int getMaxNumberFaces();

    /// <summary>
    /// Sets the classifier path.
    /// </summary>
    /// <param name="classifierPath">Path to the directory containing the classifier data files.</param>
    virtual void setClassifierPath(String classifierPath);

    /// <summary>
    /// Sets the path to the license file used to verify the sdk.
    /// </summary>
    /// <param name="licensePath">The license path.</param>
    virtual void setLicensePath(String licensePath);

    /// <summary>
    /// Sets the license string used to verify the sdk.
    /// </summary>
    /// <param name="licenseString">The license string.</param>
    virtual void setLicenseString(String licenseString);

    /// <summary>
    /// Sets the license string used to verify the sdk.
    /// </summary>
    /// <param name="licenseString">The license string.</param>
    virtual void setLicenseString(Byte[] licenseString);

    /// <summary>
    /// Sets the  <see cref="FaceListener" /> listener.
    /// </summary>
    /// <param name="listener">The listener.</param>
    virtual void setFaceListener(FaceListener listener);

    /// <summary>
    /// Sets the <see cref="ImageListener" /> listener.
    /// </summary>
    /// <param name="listener">The listener.</param>
    void setImageListener(ImageListener listener);

    /// <summary>
    /// Sets the <see cref="ProcessStatusListener" /> listener.
    /// </summary>
    /// <param name="listener">The listener.</param>
    void setProcessStatusListener(ProcessStatusListener listener);

    /// <summary>
    /// Configure the detection state of all expressions.
    /// </summary>
    /// <param name="detectAllExpressions">True to enable detection of all expressions. False to disable.</param>
    virtual void setDetectAllExpressions(bool detectAllExpressions);

    /// <summary>
    /// Configure the detection state of all expressions.
    /// </summary>
    /// <param name="detectAllEmotions">True to enable detection of all emotions. False to disable.</param>
    virtual void setDetectAllEmotions(bool detectAllEmotions);

    /// <summary>
    /// Configure the detection state of all emojis.
    /// </summary>
    /// <param name="detectAllEmojis">True to enable detection of all emojis. False to disable.</param>
    virtual void setDetectAllEmojis(bool detectAllEmojis);

    /// <summary>
    /// Gets the current state of glasses detection.
    /// </summary>
    /// <returns> True if gender detection is currently enabled.</returns>
    virtual bool getDetectGlasses();

    /// <summary>
    /// Configure the glasses detection state.
    /// </summary>
    /// <param name="activate">True to enable glasses. False to disable.</param>
    virtual void setDetectGlasses(bool activate);

    /// <summary>
    /// Gets the current state of gender detection.
    /// </summary>
    /// <returns> True if gender detection is currently enabled.</returns>
    virtual bool getDetectGender();

    /// <summary>
    /// Configure the gender detection state.
    /// </summary>
    /// <param name="activate">True to enable gender. False to disable.</param>
    virtual void setDetectGender(bool activate);

    /// <summary>
    /// Gets the current state of engagement detection.
    /// </summary>
    /// <returns> True if engagement detection is currently enabled.</returns>
    virtual bool getDetectEngagement();

    /// <summary>
    /// Configure the engagement detection state.
    /// </summary>
    /// <param name="activate">True to enable engagement. False to disable.</param>
    virtual void setDetectEngagement(bool activate);

    /// <summary>
    /// Gets the current state of lip corner depressor detection.
    /// </summary>
    /// <returns> True if lip corner depressor detection is currently enabled.</returns>
    virtual bool getDetectLipCornerDepressor();

    /// <summary>
    /// Configure the lip corner depressor detection state.
    /// </summary>
    /// <param name="activate">True to enable lip corner depressor. False to disable.</param>
    virtual void setDetectLipCornerDepressor(bool activate);

    /// <summary>
    /// Gets the current state of smile detection.
    /// </summary>
    /// <returns> True if smile detection is currently enabled.</returns>
    virtual bool getDetectSmile();

    /// <summary>
    /// Configure the smile detection state.
    /// </summary>
    /// <param name="activate">True to enable smile. False to disable.</param>
    virtual void setDetectSmile(bool activate);

    /// <summary>
    /// Gets the current state of attention detection.
    /// </summary>
    /// <returns> True if attention detection is currently enabled.</returns>
    virtual bool getDetectAttention();

    /// <summary>
    /// Configure the attention detection state.
    /// </summary>
    /// <param name="activate">True to enable attention. False to disable.</param>
    virtual void setDetectAttention(bool activate);

    /// <summary>
    /// Gets the current state of valence detection.
    /// </summary>
    /// <returns> True if valence detection is currently enabled.</returns>
    virtual bool getDetectValence();

    /// <summary>
    /// Gets the current state of joy detection.
    /// </summary>
    /// <returns> True if joy detection is currently enabled.</returns>
    virtual bool getDetectJoy();

    /// <summary>
    /// Configure the joy detection state.
    /// </summary>
    /// <param name="activate">True to enable joy. False to disable.</param>
    virtual void setDetectJoy(bool activate);

    /// <summary>
    /// Gets the current state of fear detection.
    /// </summary>
    /// <returns> True if fear detection is currently enabled.</returns>
    virtual bool getDetectFear();

    /// <summary>
    /// Configure the fear detection state.
    /// </summary>
    /// <param name="activate">True to enable fear. False to disable.</param>
    virtual void setDetectFear(bool activate);

    /// <summary>
    /// Gets the current state of disgust detection.
    /// </summary>
    /// <returns> True if disgust detection is currently enabled.</returns>
    virtual bool getDetectDisgust();

    /// <summary>
    /// Configure the disgust detection state.
    /// </summary>
    /// <param name="activate">True to enable disgust. False to disable.</param>
    virtual void setDetectDisgust(bool activate);

    /// <summary>
    /// Gets the current state of sadness detection.
    /// </summary>
    /// <returns> True if sadness detection is currently enabled.</returns>
    virtual bool getDetectSadness();

    /// <summary>
    /// Configure the sadness detection state.
    /// </summary>
    /// <param name="activate">True to enable sadness. False to disable.</param>
    virtual void setDetectSadness(bool activate);

    /// <summary>
    /// Gets the current state of anger detection.
    /// </summary>
    /// <returns> True if anger detection is currently enabled.</returns>
    virtual bool getDetectAnger();

    /// <summary>
    /// Configure the anger detection state.
    /// </summary>
    /// <param name="activate">True to enable anger. False to disable.</param>
    virtual void setDetectAnger(bool activate);

    /// <summary>
    /// Gets the current state of surprise detection.
    /// </summary>
    /// <returns> True if surprise detection is currently enabled.</returns>
    virtual bool getDetectSurprise();

    /// <summary>
    /// Configure the surprise detection state.
    /// </summary>
    /// <param name="activate">True to enable surprise. False to disable.</param>
    virtual void setDetectSurprise(bool activate);

    /// <summary>
    /// Gets the current state of contempt detection.
    /// </summary>
    /// <returns> True if contempt detection is currently enabled.</returns>
    virtual bool getDetectContempt();

    /// <summary>
    /// Configure the contempt detection state.
    /// </summary>
    /// <param name="activate">True to enable contempt. False to disable.</param>
    virtual void setDetectContempt(bool activate);

    /// <summary>
    /// Configure the valence detection state.
    /// </summary>
    /// <param name="activate">True to enable valence. False to disable.</param>
    virtual void setDetectValence(bool activate);

    /// <summary>
    /// Gets the current state of eyebrow raise detection.
    /// </summary>
    /// <returns> True if eyebrow raise detection is currently enabled.</returns>
    virtual bool getDetectBrowRaise();

    /// <summary>
    /// Configure the inner eyebrow raise detection state.
    /// </summary>
    /// <param name="activate">True to enable inner eyebrow raise. False to disable.</param>
    virtual void setDetectInnerBrowRaise(bool activate);

    /// <summary>
    /// Gets the current state of inner eyebrow raise detection.
    /// </summary>
    /// <returns> True if inner eyebrow raise detection is currently enabled.</returns>
    virtual bool getDetectInnerBrowRaise();

    /// <summary>
    /// Configure the eyebrow raise detection state.
    /// </summary>
    /// <param name="activate">True to enable eyebrow raise. False to disable.</param>
    virtual void setDetectBrowRaise(bool activate);

    /// <summary>
    /// Gets the current state of eyebrow furrow detection.
    /// </summary>
    /// <returns> True if eyebrow furrow detection is currently enabled.</returns>
    virtual bool getDetectBrowFurrow();

    /// <summary>
    /// Configure the eyebrow furrow detection state.
    /// </summary>
    /// <param name="activate">True to enable eyebrow furrow. False to disable.</param>
    virtual void setDetectBrowFurrow(bool activate);

    /// <summary>
    /// Gets the current state of nose wrinkler detection.
    /// </summary>
    /// <returns> True if nose wrinkler detection is currently enabled.</returns>
    virtual bool getDetectNoseWrinkle();

    /// <summary>
    /// Configure the nose wrinkler detection state.
    /// </summary>
    /// <param name="activate">True to enable nose wrinkler. False to disable.</param>
    virtual void setDetectNoseWrinkle(bool activate);

    /// <summary>
    /// Gets the current state of upper lip raiser detection.
    /// </summary>
    /// <returns> True if upper lip raiser detection is currently enabled.</returns>
    virtual bool getDetectUpperLipRaise();

    /// <summary>
    /// Configure the upper lip raiser detection state.
    /// </summary>
    /// <param name="activate">True to enable upper lip raiser. False to disable.</param>
    virtual void setDetectUpperLipRaise(bool activate);

    /// <summary>
    /// Gets the current state of chin raiser detection.
    /// </summary>
    /// <returns> True if chin raiser detection is currently enabled.</returns>
    virtual bool getDetectChinRaise();

    /// <summary>
    /// Configure the chin raiser detection state.
    /// </summary>
    /// <param name="activate">True to enable chin raiser. False to disable.</param>
    virtual void setDetectChinRaise(bool activate);

    /// <summary>
    /// Gets the current state of lip pucker detection.
    /// </summary>
    /// <returns> True if lip pucker detection is currently enabled.</returns>
    virtual bool getDetectLipPucker();

    /// <summary>
    /// Configure the lip pucker detection state.
    /// </summary>
    /// <param name="activate">True to enable lip pucker. False to disable.</param>
    virtual void setDetectLipPucker(bool activate);

    /// <summary>
    /// Gets the current state of lip press detection.
    /// </summary>
    /// <returns> True if lip press detection is currently enabled.</returns>
    virtual bool getDetectLipPress();

    /// <summary>
    /// Configure the lip press detection state.
    /// </summary>
    /// <param name="activate">True to enable lip press. False to disable.</param>
    virtual void setDetectLipPress(bool activate);

    /// <summary>
    /// Gets the current state of mouth open detection.
    /// </summary>
    /// <returns> True if mouth open detection is currently enabled.</returns>
    virtual bool getDetectMouthOpen();

    /// <summary>
    /// Configure the mouth open detection state.
    /// </summary>
    /// <param name="activate">True to enable mouth open. False to disable.</param>
    virtual void setDetectMouthOpen(bool activate);

    /// <summary>
    /// Gets the current state of lip suck detection.
    /// </summary>
    /// <returns> True if lip suck detection is currently enabled.</returns>
    virtual bool getDetectLipSuck();

    /// <summary>
    /// Configure the lip suck detection state.
    /// </summary>
    /// <param name="activate">True to enable lip suck. False to disable.</param>
    virtual void setDetectLipSuck(bool activate);

    /// <summary>
    /// Gets the current state of smirk detection.
    /// </summary>
    /// <returns> True if smirk detection is currently enabled.</returns>
    virtual bool getDetectSmirk();

    /// <summary>
    /// Configure the smirk detection state.
    /// </summary>
    /// <param name="activate">True to enable smirk. False to disable.</param>
    virtual void setDetectSmirk(bool activate);

    /// <summary>
    /// Gets the current state of eye closure detection.
    /// </summary>
    /// <returns> True if eye closure detection is currently enabled.</returns>
    virtual bool getDetectEyeClosure();

    /// <summary>
    /// Configure the eye closure detection state.
    /// </summary>
    /// <param name="activate">True to enable eye closure. False to disable.</param>
    virtual void setDetectEyeClosure(bool activate);
};
```
