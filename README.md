# DorianGray
Dorian Gray as a name may be the perfect parody for a little photo viewing app.

##### 'Picture-in-Picture' Zoomed Out Effect in Full-Screen Image Mode
![](https://c2.staticflickr.com/6/5342/17802206041_649b50db0b_z.jpg)

###### Version 1.2 Highlights
- Like button with spinner animation
- Like count
- Save 'Like' button state locally when the button is toggled
- UX Improvements
  - "No Image" placeholder image before downloaded image arrives
  - Updated image height constraints and image loading on scrolling to fine-tune UX
  - Update GCD queues' priorities to fine-tune scrolling performance

##### No-Image placeholder while images are downloading
![](https://c4.staticflickr.com/8/7739/17775188716_a36c08c4ab_z.jpg)

##### Like Button & Count
![](https://c1.staticflickr.com/9/8860/17615234829_2898c0d768_z.jpg)

###### Version 1.1 Highlights
- Full screen mode to view images (*Instagram app does not have full screen viewing feature; Understand that Instagram is trying to remain square-size photos*); Single tap gesture to enter/exist between table view and full-screen mode
- Simple custom animation implementation for toggling between table view and full-screen mode
- Double tap gesture on full-screen would zoom out image to a **smaller** scale with the existing table view on background; Pinch gesture to rotate image to see basic animation
- **Share** button to use iPhone standard menu that offers standard features such as saving images locally, mailing, etc. (*Instagram app won't let you save the images locally yet.*)
- Long-presse gesture on table view's image cell would bring up the same iPhone standard menu
- Use AFNetwork framework
- GCD ([Grand Central Dispatch](https://developer.apple.com/library/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/)) implementation with multiple threads with different priorities, around image download, archiving images locally and retrieving images
- Retrieve and render only visible images on the deceleration of scrolling to mimic lazy-loading, or load just-in-time behavior
- Various code improvements and fixes

Full Screen Mode

![](https://c2.staticflickr.com/6/5457/17497495142_e0b50b2a47_z.jpg)

![](https://c4.staticflickr.com/8/7789/17499640415_0094c5db8c_z.jpg)

![](https://c4.staticflickr.com/8/7747/16879332783_f6ecda4f37_z.jpg)

###### Version 1.0 Highlights
- Integrated with Instagram API with login & authentication
- Infinitive Scroll
- Pull-to-Refresh
- NSNotificationCenter pattern to manage data changes between models and API
- KVO (Key-Value Observing) pattern to manage touch events
- Programmatic constraints to manage auto-layouts
- Fluency of subclassing UITableView, UITableviewcell, UIWebView

More features are coming...

Instagram Integration Demo

![](https://farm8.staticflickr.com/7712/17111018897_4da01a90d4_c.jpg)

![](https://farm9.staticflickr.com/8691/16698207873_c496ee602a_c.jpg)

![](https://farm9.staticflickr.com/8766/17130680898_07dde11491_c.jpg)

Demo with randomly generated static data in previous version:

![](https://farm8.staticflickr.com/7682/17085570808_f9fe6f386b_c.jpg)

![](https://farm9.staticflickr.com/8816/17247376276_f1451e3187_c.jpg)
