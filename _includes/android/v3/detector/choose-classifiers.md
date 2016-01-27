### Choosing the classifiers
Next step is to turn on the detection of the metrics needed. For example, to set on or off the detection of the smile and joy classifiers:  

```java
detector.setDetectSmile(true);
detector.setDetectJoy(true);
```

To turn on or off the detection of all expressions, emotions or emojis:

```java
detector.setDetectAllExpressions(true);
detector.setDetectAllEmotions(true);
detector.setDetectAllEmojis(true);
```

To check the status of a detector at any time, for example smile:

```java
detector.getDetectSmile();
```
