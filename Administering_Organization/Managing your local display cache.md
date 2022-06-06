Summary
By default, ArcGIS Pro caches drawing to the following location:


C:\Users\<CURRENT USER>\AppData\Local\ESRI\Local Caches

If there is limited space on the current drive, this location can be changed to store the cache on a different drive.

Note:
If you have been using ArcGIS Pro prior to making this change, it is recommended to move the Local Caches folder to the new cache destination folder to preserve previously cached content.

Procedure
The following instructions describe how to change the default display cache location for ArcGIS Pro.


Warning:
Warning! This article contains instructions to make specific changes to essential parts of your operating system. If these changes are not done correctly, serious problems to the computer operating system and files may occur. 

Esri recommends making a complete backup of the system, including the registry, before implementing any of the specific changes. It is highly recommended to consult with your IT/MIS department, or other qualified computer systems professional, before proceeding. Esri cannot guarantee that you can solve problems that result from incorrect use of the Registry Editor utility. Use the Registry Editor utility at your own risk.

Note:
Your operating system and any subsequent service packs may affect these instructions. These instructions are subject to change.

Close ArcGIS Pro.
Open the Windows Registry Editor.
In the navigation pane of the Registry Editor, browse to:

HKEY_CURRENT_USER > Software > ESRI > ArcGISPro > Settings

Under Settings, if the String Value of Cache Path does not exist, right-click Settings, select New > String Value and name it Cache Path. (Include a space between the two words.)
Right-click Cache Path and select Modify.
In the Edit String Value window, in the Value data box, provide a new cache location, such as D:\ArcGISProCache, and Click OK.
Close the Registry Editor.
