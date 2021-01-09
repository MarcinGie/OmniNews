# OmniNews
Sample app fetching news from Firebase Realtime Database and searching within fetched news

#### Installation
To install and use app use Cocoapods

```ruby
  cd OmniNews
  pod install
```

#### Architecture
The app leverages basic Dependency Injection with `DependencyContainer`, which is initiated at app start and provided to `NavigationViewController`.

`NavigationViewController` is responsible for showing `ListViewController` and responding to user's `Article`/`Topic` selection with presenting `DetailsViewController`.

`ListViewController` consists of `SearchBar` for query input, `SegmentedControl` that allows for selection of `Article` or `Topic` type and `TableView` for displaying results.

`Store` is responsible for communication with database and mapping of results into `Models`.

`Models` are simple structs that are source for `ViewModels`.

`ViewModels` are used as an input for `ListCell`/`DetailsViewController` configuration. Based on whether `ListItemViewModel` was created with `Article` or `Topic`, cell or viewController are configured differently (with potential for future improvement).

Most of the communication between layers is achieved with Rx `Subjects`/`Observables`.

#### Used frameworks
Despite the fact that I'm not a big fan of throwing 3rd party dependencies around and usually try to achieve results with tolls already available, I decided to help myself with addition of:
- `EasyPeasy` - for more concise, faster (personal preference) in-code layout
- `Firebase/Database`
- `RxSwift`
- `RxDataSources` - for more concise TableView & Rx integration
- `SDWebImage` - to handle fetching & caching images

#### Disclaimer
The author has taken several assumptions while reading the assignment description and provided a resolution that is the best intention to fulfill it - any decisions are a subject to discussion and may very well be changed :)

#### Potential improvements
- Refactor result -> `Model` mapping
- Show more love to UI/UX - create more pleasant UI and refactor UI code
- Fix search to allow for more intuitive filtering - at the moment it filters only titles that start with query
- Add unit tests for `Store`
- Add UI and Integration tests
- Introduce `Coordinator` pattern in order to reduce ViewControllers' responsibilities
- Provide CI/CD for smoother integration & testing
