---
title: Metrics
permalink: /metrics/
tags: []
keywords:
audience:
last_updated:
summary:
metadata: false
---
{% include linkrefs.html %}

The face provides a rich canvas of emotion. Humans are innately programmed to express and communicate emotion through facial expressions. Affdex scientifically measures and reports the emotions and facial expressions using sophisticated computer vision and machine learning techniques. When you use the Affdex Mobile SDK in your applications, you will receive facial expression output from Affdex in the form of Affdex metrics: 7 emotional metrics, 2 composite metrics measuring the emotional experience, 15 facial expression metrics, and 14 emojis.

## Emotions

<table border="0">
<tr>
<td><font size="2"><img src="{{ "/images/faces/Anger.jpg" | prepend: site.baseurl }}" | prepend: site.baseurl }}" alt="" title="Anger" align=center>
<center><strong>Anger</strong></center></font></td>
<td><font size="2"><img src="{{ "/images/faces/Sadness.jpg" | prepend: site.baseurl }}" alt="" title="Sadness" align=center>
<center><strong>Sadness</strong></center></font></td>
<td><font size="2"><img src="{{ "/images/faces/Disgust.jpg" | prepend: site.baseurl }}" alt="" title="Disgust" align=center>
<center><strong>Disgust</strong></center></font></td>
<td><font size="2"><img src="{{ "/images/faces/Fear.jpg" | prepend: site.baseurl }}" alt="" title="Fear" align=center>
<center><strong>Fear</strong></center></font></td>
</tr>
<tr>
<td><font size="2"><img src="{{ "/images/faces/Joy.jpg" | prepend: site.baseurl }}" alt="" title="Joy" align=center>
<center><strong>Joy</strong></center></font></td>
<td><font size="2"><img src="{{ "/images/faces/Surprise.jpg" | prepend: site.baseurl }}" alt="" title="Surprise" align=center>
<center><strong>Surprise</strong></center></font></td>
<td><font size="2"><img src="{{ "/images/faces/Contempt.jpg" | prepend: site.baseurl }}" alt="" title="Contempt" align=center>
<center><strong>Contempt</strong></center></font></td>
</tr>
</table>

Furthermore, the SDK allows for measuring valence and engagement, as alternative metrics for measuring the emotional experience:

<strong>Engagement</strong>: A measure of facial muscle activation that illustrates the subject’s expressivness. The range of values is from 0 to 100.

<strong>Valence</strong>: A measure of the positive or negative nature of the recorded person's experience. The range of values for the metric is from -100 to 100.

## Facial Expressions 

<table border="0">
<tr>
<td><font size="2"><img src="{{ "/images/faces/Attention.jpg" | prepend: site.baseurl }}" alt="" title="Attention" align=center>
<center><strong>Attention</strong></center><font size="1">
<center>Measure of focus of the user based on the head orientation</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Brow%20Furrow.jpg" | prepend: site.baseurl }}" alt="" title="Brow Furrow" align=center>
<center><strong>Brow Furrow</strong></center><font size="1">
<center>Both eyebrows moving lower and closer together</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Brow%20Raise.jpg" | prepend: site.baseurl }}" alt="" title="Brow Raise" align=center>
<center><strong>Brow Raise</strong></center><font size="1">
<center>Both eyebrows moved upwards</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Inner%20Brow%20Raise.jpg" | prepend: site.baseurl }}" alt="" title="Inner Brow Raise" align=center>
<center><strong>Inner Brow Raise</strong></center><font size="1">
<center>The inner corners of eyebrows are raised</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Eye%20Closure.jpg" | prepend: site.baseurl }}" alt="" title="Eye Closure" align=center>
<center><strong>Eye Closure</strong></center><font size="1">
<center>Both eyelids closed</center></font></font></td>
</tr>
<tr>
<td><font size="2"><img src="{{ "/images/faces/Nose%20Wrinkle.jpg" | prepend: site.baseurl }}" alt="" title="Nose Wrinkle" align=center>
<center><strong>Nose Wrinkle</strong></center><font size="1">
<center>Wrinkles appear along the sides and across the root of the nose due to skin pulled upwards</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Upper%20Lip%20Raise.jpg" | prepend: site.baseurl }}" alt="" title="Upper Lip Raise" align=center>
<center><strong>Upper Lip Raise</strong></center><font size="1">
<center>The upper lip moving upwards</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Lip%20Suck.jpg" | prepend: site.baseurl }}" alt="" title="Lip Suck" align=center>
<center><strong>Lip Suck</strong></center><font size="1">
<center>Measure of pull of the lips and the adjacent skin into the mouth</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Lip%20Pucker.jpg" | prepend: site.baseurl }}" alt="" title="Lip Pucker" align=center>
<center><strong>Lip Pucker</strong></center><font size="1">
<center>The lips pushed foward</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Lip%20Press.jpg" | prepend: site.baseurl }}" alt="" title="Lip Press" align=center>
<center><strong>Lip Press</strong></center><font size="1">
<center>Pressing the lips together without pushing up the chin boss</center></font></font></td>
</tr>
<tr>
<td><font size="2"><img src="{{ "/images/faces/Mouth%20Open.jpg" | prepend: site.baseurl }}" alt="" title="Mouth Open" align=center>
<center><strong>Mouth Open</strong></center><font size="1">
<center>Lower lip dropped downwards</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Lip%20Depressor.jpg" | prepend: site.baseurl }}" alt="" title="Lip Depressor" align=center>
<center><strong>Lip Corner Depressor</strong></center><font size="1">
<center>Lip corners dropping downwards (frown)</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Chin%20Raise.jpg" | prepend: site.baseurl }}" alt="" title="Chin Raise" align=center>
<center><strong>Chin Raise</strong></center><font size="1">
<center>The chin boss and the lower lip pushed upwards</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Smirk.jpg" | prepend: site.baseurl }}" | prepend: site.baseurl }}" alt="" title="Smirk" align=center>
<center><strong>Smirk</strong></center><font size="1">
<center>Left or right lip corner pulled upwards and outwards</center></font></font></td>
<td><font size="2"><img src="{{ "/images/faces/Smile.jpg" | prepend: site.baseurl }}" alt="" title="Smile" align=center>
<center><strong>Smile</strong></center><font size="1">
<center>Lip corners pulling outwards and upwards towards the ears, combined with other indicators from around the face</center></font></font></td>
</tr>
</table>

## Emoji Expressions

<table border="0">
<tr>
<td><font size="2"><center><img src="{{ "/images/emoji/laughing.png" | prepend: site.baseurl }}" alt="" title="Laughing" align=center></center>
<center><strong>Laughing</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/smiley.png" | prepend: site.baseurl }}" alt="" title="Smiley" align=center></center>
<center><strong>Smiley</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/relaxed.png" | prepend: site.baseurl }}" alt="" title="Relaxed" align=center></center>
<center><strong>Relaxed</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/wink.png" | prepend: site.baseurl }}" alt="" title="Wink" align=center></center>
<center><strong>Wink</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/kissing.png" | prepend: site.baseurl }}" alt="" title="Kissing" align=center></center>
<center><strong>Kissing</strong></center></font></td>
</tr>
<tr>
<td><font size="2"><center><img src="{{ "/images/emoji/kissingClosedEyes.png" | prepend: site.baseurl }}" alt="" title="Kissing Closed Eyes"></center>
<center><strong>Kissing Closed Eyes</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/stuckOutTongueWinkingEye.png" | prepend: site.baseurl }}" alt="" title="Stuck Out Tongue Winking Eye"></center>
<center><strong>Stuck Out Tongue Winking Eye</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/stuckOutTongue.png" | prepend: site.baseurl }}" alt="" title="Stuck Out Tongue"></center>
<center><strong>Stuck Out Tongue</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/stuckOutTongueClosedEyes.png" | prepend: site.baseurl }}" alt="" title="Stuck Out Tongue Closed Eyes"></center>
<center><strong>Stuck Out Tongue Closed Eyes</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/flushed.png" | prepend: site.baseurl }}" alt="" title="Flushed"></center>
<center><strong>Flushed</strong></center></font></td>
</tr>
<tr>
<td><font size="2"><center><img src="{{ "/images/emoji/disappointed.png" | prepend: site.baseurl }}" alt="" title="Disappointed"></center>
<center><strong>Disappointed</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/rage.png" | prepend: site.baseurl }}" alt="" title="Rage"></center>
<center><strong>Rage</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/scream.png" | prepend: site.baseurl }}" alt="" title="Scream"></center>
<center><strong>Scream</strong></center></font></td>
<td><font size="2"><center><img src="{{ "/images/emoji/smirk.png" | prepend: site.baseurl }}" alt="" title="Smirk"></center>
<center><strong>Smirk</strong></center></font></td>
</tr>
</table>


Emotion, expression and Emoji metrics scores indicate when users show a specific emotion, or expression (e.g., a smile) along with the degree of confidence. The metrics can be thought of as detectors: as the emotion or facial expression occurs and intensifies, the score rises from 0 (no expression) to 100 (expression fully present). 

We also expose a composite emotional metric called valence which gives feedback on the overall experience. Valence measures 0 to 100 indicate a neutral to positive experience, while -100 to 0 indicate a negative to neutral experience.

<center><img src="{{ "/images/graphic1.png" | prepend: site.baseurl }}"></center>

<strong>Valence</strong>: A measure of the positive or negative nature of the recorded person's experience. The range of values for the metric is from -100 to 100.

***
## Facial Expressions

{%include overview/expressions_table.html %}

***
## Emoji Expressions

{%include overview/emojis_table.html %}

***
## Using the the metrics
Emotion, expression and Emoji metrics scores indicate when users show a specific emotion, or expression (e.g., a smile) along with the degree of confidence. The metrics can be thought of as detectors: as the emotion or facial expression occurs and intensifies, the score rises from 0 (no expression) to 100 (expression fully present).

In addition, we also expose a composite emotional metric called _valence_ which gives feedback on the overall experience. Valence measures from 0 to 100 indicate a neutral to positive experience, while measures from -100 to 0 indicate a negative to neutral experience.

<img src="{{ "/images/graphic1.png" | prepend: site.baseurl }}" />

<br />
***
## Appearance

<img src="{{ "/images/graphic6.png" | prepend: site.baseurl }}" align="right" />

Our SDKs also provide the following metrics about the physical appearance:

**Gender**

The gender classifier attempts to identify the subject's gender. In the case of video or live feeds, it tracks a face over a window of time to build confidence in it’s decision. If classifier is unable to reach a decision, the gender is reported as `Unknown`.


**Glasses**  

An confidence level of whether the subject in the image is wearing eye or sun glasses.  

<br />
<br />
***
## Face Tracking and Head Angle Estimation

<img src="{{ "/images/graphic7.png" | prepend: site.baseurl }}" align="right">

<br />

The SDKs include our latest face tracker which calculates the following metrics:

`Facial Landmarks Estimation`
The tracking of the cartesian coordinates for the [facial landmarks](/fpi/).

`Head Orientation Estimation`
Estimation of the head position in a 3-D space in Euler angles (pitch, yaw, roll).

`Interocular Distance`
The distance between the two outer eye corners.

## Appearance

Our SDKs also provide the following appearance metrics:

<strong>Gender</strong>  
Identification of gender as <em>Male</em>, <em>Female</em>, or <em>Unknown</em>.

<strong>Glasses</strong>  
Identification of the presence or absence of glasses.

<br></br>
<br></br>
