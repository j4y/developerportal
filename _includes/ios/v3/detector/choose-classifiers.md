### Choosing the classifiers
Next step is to turn on the detection of the [metrics](/metrics) needed. By default, all classifiers are disabled. Here, we’ll turn on a few classifiers. For example:

```objective-c
// turning on a few emotions
detector.joy = YES;
detector.anger = YES;

// turning on a few expressions
detector.smile = YES;
detector.browRaise = YES;
detector.browFurrow = YES;

// turning on a few emoji
detector.smiley = YES;
detector.kissing = YES; // etc
```

To turn on or off the detection of all expressions, emotions or emojis:

```objective-c
[detector setDetectAllEmotions:YES];
[detector setDetectAllExpressions:YES];
[detector setDetectEmojis:YES];
```

To check the status of a detector at any time, for example smile:

```objective-c
detector.getDetectSmile();
```
