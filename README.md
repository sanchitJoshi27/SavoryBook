# SavoryBook

A SwiftUI-based recipe browsing app built for the Fetch iOS Take-Home Assessment.  
It fetches recipe data from a remote API, supports image caching, and provides seamless UI/UX for searching and filtering recipes.

---

## Demo
[Watch the demo](DemoAssets/SavoryBookDemo.mov)


---

## Features

- **Async/Await Networking**: All API interactions are done using modern Swift concurrency.

-  **Error Handling & Empty States**: Gracefully handles malformed/empty data or network issues.

- **Custom Disk + Memory Image Caching**: Avoids redundant downloads using a custom cache system.

- **Search & Filter**: Filter recipes by cuisine and search by name.

- **Dark Mode Compatible**: UI adapts smoothly to both light and dark system appearances.

- **Unit Tests**: Covers core logic like fetching, search, and filtering.

- **No External Dependencies**: Pure Swift implementation without third-party libraries.

---

## Focus Areas

I Prioritized the following areas:

1. **Swift Concurrency**: Used `async/await` across all async operations to ensure modern and readable async code.

2. **Custom Image Caching**: Implemented both memory and disk-based caching manually to meet the requirement of avoiding external libraries.

3. **Search & Filter Logic**: Clean and responsive UI interaction for filtering large datasets.

4. **Testing**: Ensured testability and correctness via unit tests for API logic and filter/search features.

---

## Time Spent

I spent approximately **10 hours** in total:

| Activity                 | Time Spent |
|--------------------------|------------|
| Project setup & planning | ~0.5 hour  |
| SwiftUI UI/UX development| ~2 hours   |
| API integration          | ~1.5 hours |
| Image caching system     | ~3 hour    |
| Search/filter logic      | ~1 hour  |
| Unit testing             | ~1 hour    |
| Debugging & optimization | ~0.5 hour    |
| README/demo prep         | ~0.5 hour  |

---

## Trade-offs & Decisions

- **No CoreData**: Skipped CoreData as persistent caching wasn’t a requirement and would increase scope.

- **No animations/transitions**: Focused on correctness and performance rather than polish under time constraints.

- **Search + Filter only in-memory**: Fast but not persisted; acceptable for prototype/demo purposes.

---

## Weakest Part of the Project

- **Image Caching Implementation**: I found this to be the most challenging part due to my limited prior experience with building a disk-based caching layer manually. While it works as intended, the implementation could be more robust and optimized with further refinement and testing.

---

## ℹ️ Additional Information

- App is developed using **Swift 5.9**, **Xcode 15**, and built entirely in **SwiftUI**.

- Compatible with **iOS 16+**.

- All async logic is isolated via `@MainActor` where applicable to avoid threading bugs.

- Fully testable and self-contained—no external setup required to run.
