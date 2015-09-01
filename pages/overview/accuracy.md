---
title: Accuracy
permalink: /accuracy/
audience: writer, designer
tags: overview
keywords: 
last_updated: 
summary: 
---
 


Affectiva uses the area under a Receiver Operating Characteristic (ROC) curve to report on detector accuracy as this is the most generalized way to measure detector accuracy.

The more obvious facial expressions including smile, brow furrow, inner eyebrow raise, outer brow raise, lip press, nose wrinkler, and upper lip raiser, have an ROC score of over 0.9. 
The more nuanced facial expressions, which are much harder for even humans to reliably identify, including a lip depressor, mouth open, lip pucker and eye close have an ROC score of over 0.8. 

The classifiers for emotion expressions (combinations of action units that occur frequently when specific emotions are experienced) have ROC scores greater than or equal to 0.8, with expressions of joy, disgust and surprise the most accurately detected.  Expressions of sadness and fear tend to be more nuanced and subtle and are therefore harder to detect resulting in scores at the lower end of the range.

While ROC scores cannot be directly compared with other accuracy measures, in typical use cases this translates to over 95% accuracy on individual frames, though the exact number will vary depending on use case.

Analysis of our technology shows the best performance in a range of +/- 25 degrees frontal, outside of which accuracy begins to suffer.

Furthermore, for the effect of the differences in lighting conditions on accuracy, the classifier accuracy drops only when the face is extremely poorly illuminated or backlit. This occurs when the average pixel brightness of the face falls below 30 on a scale of 0 (pitch black) to 255 (white). In the example below, our classifiers can handle the three images on the right.


<center><img src="../images/lighting.png"></center>



# Cultural differences

Our emotion metrics are trained and tested on datasets comprising hundred of thousands of facial frames, from the 3+ million facial videos we have analyzed.  These videos were gathered from 91 countries spanning 4 continents and represent real-world, spontaneous facial expressions, made under challenging conditions such as varying lighting, different head movements, and variances in facial features due to ethnicity, age, gender, facial hair, and glasses. Many scientific studies have demonstrated the universality of facial expressions of emotions.
