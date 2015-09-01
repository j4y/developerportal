
<h1 id="Introducing the Affdex Mobile SDK">Introducing the Affdex Mobile SDK</h1>
<p>
The Affdex Mobile SDK for iOS and Android captures and reports emotion insights from people&acute;s faces. Emotion insights from faces obtained from the device camera, a video or even a single image are generated on-device and in real time.
</p><p>
Integrating the Affdex Mobile SDK enables iOS and Android developers to create interactive and exciting emotion-aware applications. Users interact with their mobile device using applications you build with the Affdex Mobile SDK, and their facial expressions are captured, analyzed and made available for further processing.
</p><p>
While the science underlying the Affdex SDK is complex, the emotion insights provided by the SDK are easy to interpret and process. Features of the Affdex Mobile SDK include:
</p>
<ul>
<li>	Real-time capture and feedback of emotion insights
</li><li>	Processes videos obtained from device camera, from a video file, or from still images
</li><li>	Flexible and easy to use API
</li><li>	All processing done on device - no videos or images sent to Affdex server
</li></ul>
<p>

<h2 id="Why Emotion-Enable Your Applications?">Why Emotion-Enable Your Applications?</h2>
<p>Mobile devices are incredibly smart, but they don't respond to human sentiment. Emotion-enabled applications open a new world of spontaneous interaction in response to how people feel, allowing your applications to come to life. Using the Affdex Mobile SDK, your applications instantly respond to users’ unfiltered emotion feedback. Your applications become sympathetic to the user, mirroring the user’s emotional state, adjusting their interfaces and flow to better suit the user’s mood.
</p><p>

<h2 id="Technology">Technology</h2>
<p>
The Affdex Mobile SDK builds on the proven cloud-based Affdex facial expression analysis platform. It has been adapted and tuned to process images captured in everyday use of a mobile device.  Processing is on-device (no cloud round trip), and the library is lightweight and fast to support a small memory footprint and real-time processing.
</p><p>
Follow <a href=http://www.affdex.com/clients/affdex-resources/ target=_blank>this link</a> for more information on the science underlying the Affdex SDK.
</p>

<h2 id="Requirements & Platform Details">Requirements & Platform Details</h2>
<p>Integration documentation and example code are packaged with the SDK. You can also visit <a href=http://www.affdex.com/mobile-sdk target=_blank>www.affdex.com/mobile-sdk</a> for more information.
</p>
<p>
Visit our GitHub page for example projects that utilize the SDK: <a href=https://github.com/Affectiva target=_blank>https://github.com/Affectiva</a>
</p><p>

<h2 id="Measurements">Measurements</h2>
<p>The face provides a rich canvas of emotion. Humans are innately programmed to express and communicate emotion through facial expressions. Affdex scientifically measures and reports facial expressions using sophisticated computer vision and machine learning techniques. When you use the Affdex Mobile SDK in your applications, you will receive facial expression output from Affdex in the form of Affdex metrics: expression metrics and emotional metrics.
</p>
<center><img src="images/graphic1.png"></center>
<p>
Expression metrics are scores that indicate when users make a specific facial expression (e.g., a smile) along with the degree of intensity. The metrics can be thought of as expression detectors: as the expression occurs and intensifies, the score rises from 0 (no expression) to 100 (expression fully present). In addition, we also expose a composite emotional metric called valence which gives feedback on the overall experience. Valence measures 0 to 100 indicate a neutral to positive experience, while -100 to 0 indicate a negative to neutral experience.
</p>

<center><img src="images/graphic2.png"></center>

<h2 id="Getting The Best Results">Getting The Best Results</h2>
The Affdex Mobile SDK builds on Affdex real-world experience analyzing billions of faces worldwide, both online and offline. The SDK robustly handles gender, age, and ethnicity, and has been cross-culturally validated on real-world data.  While accommodating a variety of lighting conditions and head orientations, the SDK produces best results when people face the screen and facial features are visible. Obstructions to the face, such as a hand over the mouth, will result in a temporary loss of facial expression data so developers should prompt users to avoid such obstructions.

<h2 id="Ways To Use The SDK">Ways To Use The SDK</h2>

<h3 id="Video">Video</h3>
<p>The SDK supports extracting metrics directly from front-facing or back-facing cameras. You can send consecutive video frames to the SDK for processing. You can also specify a video file that resides on the file system of the device.
</p><p>

<h3 id="Static images">Static images</h3>
<p>The SDK also includes the capability to generate emotion metrics from individual images (photographs).
</p><p>

<h2 id="A Note About Privacy">A Note About Privacy</h2>
<p>Affdex takes the issue of privacy seriously, and we ask developers using the Affdex Mobile SDK to also be vigilant about safeguarding user information. The Affdex Mobile SDK collects a minimal set of anonymous technical data to help us better understand how it is being used.
</p><p>
The Affdex Mobile SDK does not collect the following information:

<ul>
<li>	The Affdex Mobile SDK does not collect personal information
</li><li>	The Affdex Mobile SDK does not store face video obtained from the device camera; all the processing is done local to the device, transiently, on a frame-by-frame basis.
</li><li>	The Affdex Mobile SDK does not perform facial or identity recognition.
</li></ul>
<p>The Affdex SDK for iOS and Android leverages the Flurry Analytics service; please see Flurry's Privacy Policy for details, including their instructions allowing users to opt out of tracking
</p>



## Questions

If you have any comments, concerns, or questions, contact us at SDK@affectiva.com. Our site is [http://www.affectiva.com](affectiva.com). 



