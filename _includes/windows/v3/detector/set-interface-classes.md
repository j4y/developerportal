### Configuring the callback functions
The Detectors use callback functions defined in interface classes to communicate events and results. The event listeners need to be initialized before the detector is started:
The [FaceListener]({{ site.baseurl }}/v3/windows/interfaces/#facelistener) is a client callback interface which sends notification when the detector has started or stopped tracking a face. Call `setFaceListener` to set the `FaceListener`:  

```csharp
class MyApp : Affdex.FaceListener {
  MyApp() {
    detector.setFaceListener(this);
  }
};
```

The [ImageListener]({{ site.baseurl }}/v3/windows/interfaces/#imagelistener) is a client callback interface which delivers information about an image which has been handled by the Detector. Call `setImageListener` to set the `ImageListener`:  

```csharp
class MyApp : Affdex.ImageListener {
  MyApp() {
    detector.setImageListener(this);
  }
};
```

The [ProcessStatusListener]({{ site.baseurl }}/v3/windows/interfaces/#processstatuslistener) is a callback interface which provides information regarding the processing state of the detector. Call `setProcessStatusListener` to set the `ProcessStatusListener`:  

```csharp
class MyApp : Affdex.ProcessStatusListener {
  MyApp() {
    detector.setProcessStatusListener(this);
  }
};
```
