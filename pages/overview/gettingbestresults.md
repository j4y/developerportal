---
title: Getting Optimal Results from the SDK
permalink: /gettingbestresults/
audience: writer, designer
tags: overview
keywords: 
last_updated: 
summary: 
metadata: false
---  


The Affdex SDK builds on our real world experience analyzing millions of faces worldwide, both online and offline. The SDK handles variances in gender, age, and ethnicity with high accuracy, and has been cross-culturally validated on real world data.  While accommodating a variety of lighting conditions and head orientations, the SDK produces best results when people face the screen and their facial features are visible. Obstructions to the face, such as a hand over the mouth, will result in a temporary loss of facial expression data so developers should advice users to avoid such obstructions.

<strong>Cameras</strong>

Recommended: 

* RGB camera
* min resolution 320x240
* 10 frames per second minimum framerate

We have found that the classification performance is good as long as the subject’s face occupies at least 30x30 pixel within an image. Ideally the larger the face the better (assuming that the whole face - including eyebrows, lips and eye corners - is within view of the camera).

<strong>Head pose</strong> 

The performance is best with frontal head pose. The system performs well with head rotations (pitch, yaw and roll) up to 25 degrees from frontal.  We have not extensively evaluated performance beyond these limits.  If possible, we suggest encouraging the subject to position the camera/hold the mobile device such that their face is roughly center and frontal.

The position of the head (x and y coordinates) within the images is not very important - as long as the eye corners, eyebrows and lips are all visible.  If any of these features are occluded that will impede the face tracking and may lead to only partial results.

<img src="{{ "/images/graphic5.png" | prepend: site.baseurl }}">

<strong>Lighting</strong>

The Affdex algorithms are very robust in diverse lighting conditions. However, for best results have the subjects lit uniformly and avoid strong lights in the background. 




## A Note About Privacy

Affdex takes the issue of privacy seriously, and we ask developers using the Affdex SDK to also be vigilant about safeguarding user information. The Affdex SDK collects a minimal set of anonymous technical data to help us better understand how it is being used.

The Affdex SDK does not collect the following information:

* The Affdex SDK does not collect personal information
* The Affdex SDK does not store face video obtained from the device camera; all the processing is done local to the device, transiently, on a frame-by-frame basis.
* The Affdex SDK does not perform facial or identity recognition.

The Affdex SDK for Android leverages the Flurry Analytics service; please see <a href=http://www.flurry.com/legal-privacy/privacy-policy target=_blank>Flurry's Privacy Policy</a> for details, including their instructions allowing users to opt out of tracking.



## A Final Note

We are excited that you are using our Affdex SDK. We are passionate about bringing emotional intelligence to the digital world, and look forward to seeing what amazing new apps and digital experiences you will emotion-enable using our technology.

We are always interested in promoting and marketing new solutions built with our SDK. Just send us a note at sdk@affectiva.com if you would like to share with us what you are working on.