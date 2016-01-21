---
title: Interface classes
permalink: /v3/windows/interfaces/
tags: [windows, sdk]
audience: writer, designer
keywords:
last_updated:
summary:
metadata: false
---

## ImageListener

This interface delivers information about the images and faces captured by a detector. The <code>ImageListener</code> contains two client callback methods:

`onImageResults` returns the processed frame and a dictionary of the faces found. An individual entry in the dictionary is comprised of a face ID and a Face object which contains metrics about the face. If the image was processed but no face was found, the returned dictionary will be empty.

```csharp
void onImageResults(Dictionary<int, Face> faces, Frame image);
```

`onImageCapture` returns all the frames passed to the detector.  

```csharp
void onImageCapture(Frame image);
```
***
## FaceListener

This interface provides methods that the Detector uses to communicate to users of the class. The following method indicates that the face detector has detected a face and has begun tracking it. The receiver should expect that tracking continues until detection has stopped.  

```csharp
void onFaceFound(float timestamp, int faceId);
```

The following method indicates that the face detector has stopped tracking a face, and is called when a face is no longer detected. The receiver should expect that there is no face tracking until the detector is started again.  

```csharp
void onFaceLost(float timestamp, int faceId);
```
***
## ProcessStatusListener

This is a client listener interface which delivers information on the state of the processing.
The `ProcessStatusListener` contains callbacks to inform about the status of the processing.  `onProcessingFinished` is called when a video file has completed processing. `onProcessingException` is called if an `AffdexException` is encountered during the processing. If either of those callbacks is triggered, no further calls to any registered ImageListeners should be expected and it is safe to stop the detector.  

```csharp
void onProcessingFinished();
void onProcessingException(AffdexException exception); 
```
