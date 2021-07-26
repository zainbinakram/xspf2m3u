# xspf2m3u
A simple batch file to convert vlc created playlist (.xspf) to generic m3u playlist format.

Very useful if you want to use your online playlist in android devices ( particularly IPTV).
There exists an option to export playlists in vlc player but those playlist miss the track metadata. 
Vlc m3u creator only takes file location (URI) and gives no title rather gives the file location as title.
This file takes the title as given in the playlist and exports it to the respective track(s)/channel(s).
This batch also auto assign groups by reading the track titles (you can edit that according to your needs).
e.g; If the title is "UK-This is my title", this batch wil give groupname "UK" to that track/channel (and similarly "USA-Another title" will be given groupname "USA").  
This batch file inputs all .xspf files found in the folder where this .bat is placed and outputs to a single "MYM3U.M3U"

TESTED WITH MULTIPLE XSPF FILES AND ALSO WITH LARGE XSPF FILES ( I.E HAVING MORE THAN 3000 TRACKS/CHANNELS ).
