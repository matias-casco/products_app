# 🛍️ Products App  

## 📌 Description  
**Products App** is a Flutter e-commerce application that allows users to view products and view detailed information. It follows **Clean Architecture**, uses **ChangeNotifier** for state management, and handles API requests with **Dio**.  

---

## 🚀 Features  

### 🔹 **Products Page**
- Displays a list of available products with a clean UI.  
- Supports **pull-to-refresh** with `RefreshIndicator`.  
- Uses `ChangeNotifier` and `ValueListenableBuilder` for state management.

### 🔹 **Product Details Page**
- Shows product images, description, price, and category.  
- Includes shipping information, warranty, dimensions, and return policy.  
- Displays **customer reviews** in a structured format.  
- Uses a responsive UI with `SliverAppBar`.

### 🔹 **Navigation**
- Implemented with `go_router` for efficient route management.  
- Navigates to **ProductDetailsPage** when selecting a product.  

### 🔹 **State Management & Error Handling**
- Uses `ValueListenableBuilder` for real-time UI updates.  
- **Loading indicators** (`CircularProgressIndicator`) when fetching data.  
- Shows **error messages** with retry options in case of failure.

---

## 🛠️ Technologies & Dependencies  
The app is built using the following technologies:  

- **Flutter** - Main framework  
- **Dart** - Programming language  
- **go_router** - Navigation  
- **Dio** - HTTP client for API requests
- **get_it** - Singleton creation and dependency injection
- **Mockito** - Unit testing with mocks  
- **fpdart** - Functional programming utilities (`Either<Failure, Success>`)  
- **network_image_mock** - Image widget testing

---

## 🧪 Tests  

Unit tests were conducted to ensure stable and expected behavior of the application.  

### ✅ **Test Results**  

| **#** | **Test Case** | **Description** | **Result** |
|---|----------------------|---------------|-------------|
| 1️⃣ | `DioHttpClientImpl` - GET request success | Performs a GET request and returns a product model. | ✅ Passed |
| 2️⃣ | `DioHttpClientImpl` - Error handling | Handles errors when performing a GET request. | ✅ Passed |
| 3️⃣ | `ProductsDatasourceImpl` - GET request success | Performs a GET request and returns a product model. | ✅ Passed |
| 4️⃣ | `ProductsDatasourceImpl` - Error handling | Handles errors when performing a GET request. | ✅ Passed |
| 5️⃣ | `ProductsRepositoryImpl` - Successful response | Returns `Right<Failure, Products>` when fetching products. | ✅ Passed |
| 6️⃣ | `ProductsRepositoryImpl` - Error handling | Returns `Left<Failure, Products>` when an error occurs. | ✅ Passed |
| 7️⃣ | `GetProductsUseCase` - Successful execution | Returns `Right<Failure, Products>` when called successfully. | ✅ Passed |
| 8️⃣ | `ProductsPageNotifier` - Loads product data | Loads a product entity correctly. | ✅ Passed |
| 9️⃣ | `ProductsPageNotifier` - Handles errors | Returns a failure when an exception occurs. | ✅ Passed |
| 🔟 | `ProductPage` - Displays AppBar text | Shows "Buy Today" in the AppBar. | ✅ Passed |
| 1️⃣1️⃣ | `ProductPage` - Shows loading indicator | Displays `CircularProgressIndicator` while loading. | ✅ Passed |
| 1️⃣2️⃣ | `ProductPage` - Error message | Displays an error message when loading fails. | ✅ Passed |
| 1️⃣3️⃣ | `ProductPage` - Shows products | Displays product list when data is loaded. | ✅ Passed |
| 1️⃣4️⃣ | `ProductPage` - Navigation to details | Navigates to `ProductDetailsPage` when tapping a product. | ✅ Passed |

---

## 📥 Installation & Setup  

### 📌 **Prerequisites**  
Ensure you have the following installed on your system:  
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable version)  
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)  
- Android Studio / VS Code (for development)  
- Xcode (if running on iOS)  
- An Android Emulator or a physical device connected via USB  

---

### 🚀 **Steps to Run the Application Locally**  

1️⃣ **Clone the repository**  
```bash
git clone https://github.com/matias-casco/products_app.git
cd products_app
```

2️⃣ **Install dependencies**
```bash
flutter pub get
```

3️⃣ **Run the application on an emulator or device**

```bash
flutter run
```

4️⃣ **Run tests**

```bash
flutter test
```
