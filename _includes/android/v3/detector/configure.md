### Configuring the detector

**License**

In order to initialize the detector, a valid license file must be provided. Each license file issued by Affectiva is time bound and will only work for a fixed period of time shown in the license file, after which the SDK will throw a `LicenseException`

**classdoc:** LicenseException [[java]({{ site.baseurl }}/pages/platforms/v3/android/javadoc/com/affectiva/android/affdex/sdk/AffdexException.html)]

Copy this file into your Android app project under the folder ```app/main/src/assets``` and specify the relative path under that folder to ```setLicensePath```

```java
String licensePath="affdex.license"
detector.setLicensePath(licensePath);
```

Alternatively, the license can be loaded as a byte array

```java
detector.setLicenseStream(Reader reader);
```
