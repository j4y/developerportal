---
title: What's new in this release
permalink: /whats_new/
redirect_from: "/windows/"
tags: [sdk]
audience: writer, designer
keywords:
last_updated:
summary:
metadata: false
---

### What's new in v3.0


* New API to allow tracking of multiple faces in a video source.
* Added models to allow the developer to recognize and track [14 Expressions of Emojis](/metrics#emoji-expressions)
* New API that returns the most likely emoji (`dominantEmoji`) posed in an image.
* Added models to allow identification of [Gender and presence of eye or sun glasses](/metrics#appearance)
* New API that allows the developer to control the face detector configuration to use in the detection.
* Add dynamic core / threading detection to allow SDKs to make use of multiple CPU core if available.
* Refactored the documentation on the developer portal to add tutorials to help developers get started.
* New version of the AffdexMe apps ([iOS](https://github.com/Affectiva/ios-sdk-samples/tree/master/apps/AffdexMe), [Android](https://github.com/Affectiva/affdexme-android) and [Windows](https://github.com/Affectiva/win-sdk-samples/tree/master/AffdexMe)):
  - Track multi faces in realtime.
    On Windows this feature is enabled by default, but on iOS/Android it can toggled from the settings menu.  
  - Display the metrics (Emotion, Appearance and Dominant Emoji).
  - Allow users to take screenshots of the camera feed with the metrics overlay.
  - Allow users to use the back camera to track the metrics.
  - Refactor AffdexMe (Windows) metric and camera visualization class.
* iOS SDK
  - `AFDXFace` class re-organized into categories expressions, emotions, emoji and appearance metrics.
  - `Expressiveness` renamed into `Engagement`
  - Head angles renamed into `Pitch`, `Yaw`, `Roll`
  - Added API to allow embedding the license string as a variable in the app code.
* Win SDK
  - Performance improvements
  - Fix bug, the assembly version doesn't match the file metadata
  - Fix bug, Calling reset() doesn't reset the internal cached timestamps.
* Android SDK
  - Fix bug, the license token validation fails due to zero padding


***
### What's new in v2.0

* Dramatically improved accuracy with new expression models trained over a broader set of facial images.

* Better ease of use and accessibility by standardizing models for seven
emotions:
  Anger, Sadness, Disgust, Joy, Surprise, Fear and Contempt.
* New facial expressions for a total of 15 facial action units, including very
nuanced expressions that are difficult even for the human eye to detect:

    Attention, Brow Furrow, Brow Raise, Inner Brow Raise, Eye Closure, Nose Wrinkle, Upper Lip Raise, Lip Suck, Lip Pucker, Lip Press, Mouth Open, Lip Corner Depressor, Chin Raise, Smirk, Smile.
* 3D head orientation metrics

    Left/Right, Up/Down, Roll

* Supports the development of 64-bit applications for Windows.
* New Developer Portal with documentation and source code for sample
apps, including the flagship AffdexMe demo app.
