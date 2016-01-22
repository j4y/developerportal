---
title:
permalink: /downloads/
metadata: false
---

#### Sign up for a free evaluation license

Use [this form](http://www.affectiva.com/45-day-free-trial/) to signup for a free 45 day license to use the SDKs. Once the form is submitted, you should receive an email containing the license file to use with the SDK.

Contact sales@affectiva.com for more information about Developer and/or Commercial distribution licenses.

#### Download the SDK

Use the download links below to download the latest SDK version:

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
