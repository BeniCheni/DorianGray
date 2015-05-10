# DorianGray
Dorian Gray as a name may be the perfect parody for a little photo viewing app.

Instagram Integration Demo
![](https://farm8.staticflickr.com/7712/17111018897_4da01a90d4_c.jpg)
![](https://farm9.staticflickr.com/8691/16698207873_c496ee602a_c.jpg)
![](https://farm9.staticflickr.com/8766/17130680898_07dde11491_c.jpg)

###### Version 1.1 Highlights
- Full screen mode to view images (*Instagram app does not have full screen viewing feature; Understand that Instagram is trying to remain square-size photos*); Single tap guesture to enter/exist between table view and full-screen mode
- Simple custom animation implementation for toggling between table view and full-screen mode
- Double tap guesture on full-screen would zoom out image to a **smaller** scale with the existing table view on background; Pinch guesture to rotate image to see basic animation
- **Share** button to use iPhone standard menu that offers standard features such as saving images locally, mailing, etc. (*Instagram app won't let you save the images locally yet.*)
- Long-presse gesture on table view's image cell would bring up the same iPhone standard menu
- Use AFNetwork framework
- GCD ([Grand Central Dispatch](https://developer.apple.com/library/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/)) implementation with multiple threads with different priorities, around image download, archiving images locally and retrieving images
- Retrieve and render only visible images on the deceleration of scrolling to mimic lazy-loading, or load just-in-time behavior
- Various code improvements and fixes

###### Version 1.0 Highlights
- Integrated with Instagram API with login & authentication
- Infinitive Scroll
- Pull-to-Refresh
- NSNotificationCenter pattern to manage data changes between models and API
- KVO (Key-Value Observing) pattern to manage touch events
- Programmatic constraints to manage auto-layouts
- Fluency of subclassing UITableView, UITableviewcell, UIWebView

More features are coming...

Demo with randomly generated static data in previous version:

![](https://farm8.staticflickr.com/7682/17085570808_f9fe6f386b_c.jpg)

![](https://farm9.staticflickr.com/8816/17247376276_f1451e3187_c.jpg)
