---
title:  
permalink: /downloads/
metadata: false
---
## SDK Downloads

Select from the table the SDK package for the platform you will be developing on.  
The Android SDK comes as an uncompressed folder.  
The iOS SDK comes as a .tar folder.  
To get the Affdex Unity Asset, go to the Unity [Asset Store](https://www.assetstore.unity3d.com/) where you can import it into your project.  
The Windows SDKs come as self extracting executables.  

### Downloads

<table border="1" style="width:60%">
<tr>
<th style="background-color:#c0c0c0;"><center>Platform</center></th>
<th style="background-color:#c0c0c0;"><center>Version</center></th>
<th style="background-color:#c0c0c0;"><center>Size</center></th>
</tr>
{% for item in site.data.downloads %}
<tr>
<td style="background-color:#F0F0F0;"><center>{{ item.platform }}</center></td>
<td style="background-color:#F0F0F0;"><center><a href={{ item.url }} target=_blank>{{ item.version }}</a></center></td>
<td style="background-color:#F0F0F0;"><center>{{ item.size }}</center></td>
</tr>
{% endfor %}
</table>

<!--
##Legacy Downloads

<ul>
{% for olditem in site.data.legacydownloads %}
<li>
{{item.platform}}
{% for oldversion in item.subitems %}
<ul>
<li>
<a href={{oldversion.url}} target=_blank>{{oldversion.oldversion}}</a>
Size: {{oldversion.size}}
</li>
</ul>
{% endfor %}
{% endfor %}
</li>
</ul>
 
 
 table > thead > tr > th {
 vertical-align: bottom;
 border-bottom: 2px solid #ddd;
 text-transform: uppercase;
 background-color: #777777;
 color: white;
 text-align: center;
 }
 
 
 
 
 
-->