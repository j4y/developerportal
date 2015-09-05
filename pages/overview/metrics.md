---
title: The Metrics
permalink: /metrics/
tags: []
keywords: 
audience: 
last_updated: 
summary: 
metadata: false
---
{% include linkrefs.html %} 

The face provides a rich canvas of emotion. Humans are innately programmed to express and communicate emotion through facial expressions. Affdex scientifically measures and reports the emotions and facial expressions using sophisticated computer vision and machine learning techniques. When you use the Affdex Mobile SDK in your applications, you will receive facial expression output from Affdex in the form of Affdex metrics: 7 emotional metrics, 2 composite metrics measuring the emotional experience and 15 facial expression metrics.

## Emotions

<table>
<tr>
<td><img src="../images/faces/Anger.jpg" alt="" title="Anger" align=center>
<center>Anger</center></td>
<td><img src="../images/faces/Sadness.jpg" alt="" title="Sadness" align=center>
<center>Sadness</center></td>
<td><img src="../images/faces/Disgust.jpg" alt="" title="Disgust" align=center>
<center>Disgust</center></td>
<td><img src="../images/faces/Fear.jpg" alt="" title="Fear" align=center>
<center>Fear</center></td>
</tr>
<tr>
<td><img src="../images/faces/Joy.jpg" alt="" title="Joy" align=center>
<center>Joy</center></td>
<td><img src="../images/faces/Surprise.jpg" alt="" title="Surprise" align=center>
<center>Surprise</center></td>
<td><img src="../images/faces/Contempt.jpg" alt="" title="Contempt" align=center>
<center>Contempt</center></td>
</tr>
</table>

Furthermore, the SDK allows for measuring valence and engagement, as alternative metrics for measuring the emotional experience:

<strong>Engagement</strong>: A measure of facial muscle activation that illustrates the subject’s expressivness. The range of values is between 0 and 100.

<strong>Valence</strong>: A measure of the positive (or negative) nature of the recorded person experience. The range of values for the metric is between -100 to 100.

## Facial Expressions 

<table>
<tr>
<td><img src="../images/faces/Attention.jpg" alt="" title="Attention" align=center>
<center>Attention</center>
Measure of point of focus of the user based on the head orientation</td>
<td><img src="../images/faces/Brow%20Furrow.jpg" alt="" title="Brow Furrow" align=center>
<center>Brow Furrow</center>
Both eyebrows moving lower and closer together</td>
<td><img src="../images/faces/Brow%20Raise.jpg" alt="" title="Brow Raise" align=center>
<center>Brow Raise</center>
Both eyebrows moved upwards</td>
<td><img src="../images/faces/Inner%20Brow%20Raise.jpg" alt="" title="Inner Brow Raise" align=center>
<center>Inner Brow Raise</center>
The inner corners of eyebrows are raised</td>
<td><img src="../images/faces/Eye%20Closure.jpg" alt="" title="Eye Closure" align=center>
<center>Eye Closure</center>
Both eye lids closed</td>
</tr>
<tr>
<td><img src="../images/faces/Nose%20Wrinkle.jpg" alt="" title="Nose Wrinkle" align=center>
<center>Nose Wrinkle</center>
Wrinkles appear along the sides and across the root of the nose due to skin pulled upwards</td>
<td><img src="../images/faces/Upper%20Lip%20Raise.jpg" alt="" title="Upper Lip Raise" align=center>
<center>Upper Lip Raise</center>
The upper lip moving upwards</td>
<td><img src="../images/faces/Lip%20Suck.jpg" alt="" title="Lip Suck" align=center>
<center>Lip Suck</center>
Suck the red parts of the lips and the adjacent skin into the mouth covering the teeth</td>
<td><img src="../images/faces/Lip%20Pucker.jpg" alt="" title="Lip Pucker" align=center>
<center>Lip Pucker</center>
The lips pushed foward</td>
<td><img src="../images/faces/Lip%20Press.jpg" alt="" title="Lip Press" align=center>
<center>Lip Press</center>
Pressing the lips together without pushing up the chin boss</td>
</tr>
<tr>
<td><img src="../images/faces/Mouth%20Open.jpg" alt="" title="Mouth Open" align=center>
<center>Mouth Open</center>
Lower lip dropped downwards</td>
<td><img src="../images/faces/Lip%20Depressor.jpg" alt="" title="Lip Depressor" align=center>
<center>Lip Corner Depressor</center>
Lip corners dropping downwards (frown)</td>
<td><img src="../images/faces/Chin%20Raise.jpg" alt="" title="Chin Raise" align=center>
<center>Chin Raise</center>
The chin boss and the lower lip pushed upwards</td>
<td><img src="../images/faces/Smirk.jpg" alt="" title="Smirk" align=center>
<center>Smirk</center>
Left or right lip corners pulled upwards and outwards</td>
<td><img src="../images/faces/Smile.jpg" alt="" title="Smile" align=center>
<center>Smile</center>
Lip corners pulling outwards and upwards towards the ears, combined with other indicators from around the face</td>
</tr>
</table>

Emotion and expression metrics scores indicate when users make a specific emotion, or expression (e.g., a smile) along with the degree of confidence. The metrics can be thought of as detectors: as the emotion or facial expression occurs and intensifies, the score rises from 0 (no expression) to 100 (expression fully present). 

In addition, we also expose a composite emotional metric called valence which gives feedback on the overall experience. Valence measures 0 to 100 indicate a neutral to positive experience, while -100 to 0 indicate a negative to neutral experience.

<img src="{{ "/images/graphic1.png" | prepend: site.baseurl }}">

## Face Tracking and Head Angle Estimation

In addition to the emotion and facial expression metrics, the SDKs include our latest face tracker which calculates the following metrics:

<img src="{{ "/images/graphic2.png" | prepend: site.baseurl }}" align="right">

<strong>Facial Landmarks Estimation</strong>
The tracking of the cartesian coordinates for the facial landmarks.

<strong>Head Orientation Estimation</strong>
Estimation of the head position in a 3-D space in Euler angles (pitch, yaw, roll).

<strong>Interocular Distance</strong>
The distance between the two outer eye corners.