### Processing a frame
After successfully initializing the detector using the start method. The frames can be passed to the detector by calling the process method. The process method expects a [Frame]({{ site.baseurl }}/v3/windows/data-structures/#frame)

```csharp
detector.process(Frame frame);
```
