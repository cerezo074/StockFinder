# StockFinder 📈

StockFinder is an iOS application designed to efficiently manage and search for stock information. The app retrieves a large dataset of stock details, stores them locally using **SwiftData**, and provides users with a seamless search experience. Users can quickly find stocks using either their **ticker symbol** or **company name**, ensuring fast and accurate results.

The app displays key stock details, including:
- **Ticker Symbol** (e.g., AAPL, TSLA)
- **Company Name** (e.g., Apple Inc., Tesla Motors)
- **Current Stock Price** (formatted as currency)

This data is fetched from an API, stored using **SwiftData**, and presented to users in a clean and modern UI.

---

## 📂 Project Structure

StockFinder follows an **MVVM-C architecture** and applies a **Clean Architecture approach** while adhering to **SOLID principles**. The project is modularized into distinct layers:

- **App**: Entry point of the application.
- **Core**: Contains essential utilities, services, data structures, and networking logic.
- **Repositories**: Manages data persistence using **SwiftData**.
- **UI**: Contains reusable components, UI extensions, fonts, and custom styling.
- **Domain**: Business logic and core data handling.
- **Presentation**: Houses views and ViewModels, including **NavigationStack**-based navigation.
- **Resources**: Fonts, colors, and other assets.
- **Tests**: Unit tests for critical logic.

---

## ⚡ Optimized Search Performance

StockFinder implements an **efficient search engine** using a **Trie data structure**, optimizing search performance significantly.


### 🔍 How It Works:
- **Trie-based Indexing**: The app indexes stock tickers and names using a **Trie**, making prefix-based search **fast and memory-efficient**.  
  - **Insertion Complexity**: \(O(N)\), where \(N\) is the length of the word being inserted.  
  - **Search Complexity**: \(O(M)\), where \(M\) is the length of the prefix being searched.  
  - Without a Trie, the search process would be significantly slower. Instead of quickly traversing the tree structure, the app would need to iterate over the **entire dataset** to filter possible matches. This means:  
    - **Iterating through all stock entries** (which can be **very large**).  
    - **Comparing each entry character by character** to validate whether it matches the input.  
    - This results in a much higher time complexity, making searches slow and inefficient for large datasets.  
- **Parallelized Search Processing**:  
  - The app simultaneously builds **two search indexes**: **ticker-based** and **name-based**.  
  - When the user types, the app first attempts to **find results based on the ticker**.  
  - If no results are found, it **immediately** searches by **company name**.  
  - Both operations happen **concurrently**, ensuring a **fast and responsive** search experience.  
- **Debounced Input with Combine**:  
  - The app integrates **Combine** with a **debounce mechanism** to avoid unnecessary search executions while the user is still typing.  
  - This ensures that results are only displayed **when the user pauses**, providing a **better user experience** by showing outcomes when the user is certain of their input.  

Instead of using **Task Groups**, the app utilizes **async let** for parallel execution, reducing overhead while maintaining efficiency.

---

## 🛠️ Tech Stack

- **SwiftUI** – Modern declarative UI framework.
- **SwiftData** – Local data persistence.
- **NavigationStack** – Modern SwiftUI navigation handling.
- **MVVM-C Architecture** – Modular and scalable structure.
- **SOLID Principles** – Ensuring maintainable and testable code.
- **Trie Data Structure** – Efficient and fast search indexing.
- **Advanced Swift Concurrency**:
  - **Actors** for data consistency and safe concurrent access.
  - **async/await** for structured concurrency.
  - **async let** for parallel execution instead of Task Groups.
- **Combine Framework** – Used for reactive programming, including **debounced search handling**.
- **Custom Fonts & UI Styling** – Implements **Poppins** font for modern design.

---

## ✅ Unit Testing Considerations

StockFinder uses the **Swift Testing framework** (instead of XCTest) for unit tests.

Unit tests were implemented for **two key classes**, focusing on the **core functionality** of the app:

1. **StockHomeViewModel**: Handles most of the **presentation logic**.
2. **StockDataController**: Manages **business logic** and **data persistence**.

These classes were prioritized because they contain the **most critical logic** in the application.

---
