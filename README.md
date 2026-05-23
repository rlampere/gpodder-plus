# gPodder+

## An augmentation of gPodder with new features and UI updates

This repository is for gPodder+ source files. The gPodder+ project is a branch of the
gPodder software that was modified by Rob L. with the goal of creating a version of
gPodder that provided the features I want in a podcast management tool.

First off, a big shout out to the gPodder team for creating and maintaining a great
codebase on which I could build my personalized app. I have found the gPodder code to be
a great starting point since it offers so many features that I find very useful.
My primary goal was to update the UI in a way that is useful to me as well as add important
features that allow me to work with podcasts I really enjoy but are no longer supported online.

In general, the features I've added to gPodder include:
- Use of Plex-style media file naming.
  - If my media files get separated from my gPodder database, I want to know what the file contains.
  - I find the Plex-style to work pretty well for me.
- Ability to add a new podcast manually along with adding a single episode or a batch of episodes.
  - I have a lot of old podcasts that are no longer available online and I wanted to be able to
  include them within gPodder and have them look and behave like a regular podcast.
- Ability to lookup podcast and episode information online and use the metadata in my manually created podcasts and episodes.
  - A lot of my old podcast episodes have inconsistent MP3 tags embedded in them so most of the important information,
  like publish date, are missing. Being able to get accurate metadata is important to keeping my podcasts accurate.
- Enhance the UI by using CSS to define styles that can be altered while the app is running.
  - The changes to text color and style as well as background and foreground colors can be easily changed,
  and those changes integrate with the dark and light themes already provided by gPodder.

If you are interested in using my changes, feel free to do so. It is free software, without any warranty that can be
modified and/or redistributed under the terms of GNU General Public License 3.0 or later. Enjoy!
