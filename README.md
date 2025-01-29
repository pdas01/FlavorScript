### Summary: 
FlavorScript is a simple SwiftUI app to display list of recipes from json.

## Prerequisites
* XCode 16.2+
* iOS version: 16+ 

## Screenshots
| Some Content State | Empty State | Error |  
|-|-|-|
|![SomeContent](/screenshots/RecipesPage.png) | ![Empty](/screenshots/EmptyState.png) | ![Error](/screenshots/ErrorState.png) |

| Cuisine Filters | Detail Page | Settings Page |
|-|-|-|
| ![Cuisine Filters](/screenshots/CuisineFilter.png) | ![DetailPage](/screenshots/DetailPage.png) | ![SettingsPage](/screenshots/SettingsPage.png) |

| App Icon | Splash Screen |
|-|-|
| <img width=100 src="screenshots/AppIcon.png"/> | <img width=100 src="screenshots/SplashScreen.png"/> |

## Video 
<video width=200 src="screenshots/Video.mov" controls width="600"></video>

### Focus Areas:
* MVVM architecture - Clear separation of logic and UI.
* Caching - fetch from the disk instead calling network
* Functional changes - Implemented a modular design with reusable components for scalability.
* Unit Testing – Ensured code reliability through test coverage.

### Time spent on this project
Spent approx 4-5 hours 
- Architecture and design ~ 1 hr
- Caching & networking ~ 1 - 1.5 hr
- UI ~ 1hr
- Unit testing ~1hr
- Documentation ~0.5hr


### Trade-offs and Decisions: 
* Used only disk caching and no in-memory caching to keep it minimal 
* Used three JSON files to toggle between success, malformed, and empty states depending on the user settings. 
* Although originally designed as a single-page app, added tab navigation for better organization.
* Included a Settings page to manage developer options, such as switching response types and clearing image caches.

### What could be improved?
* Unreliable cache directory: I used cache directory which can be cleared by the system during low storage which makes it unreliable for long-term storage. Also could have used in-memory cache NSCache for fast access.
* No cache invalidation: There is no cache invalidation logic if images gets updated, the cached version would continue to use the outdated data unless cleared cached from Settings. It would be 
* Better UI for detail page 


