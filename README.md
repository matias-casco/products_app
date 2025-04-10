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

### Test Summary
All tests passed successfully with a total of 31 tests executed across different application components.
TOTAL: 31/31 tests passed

### Test Structure
1. Datasources
DioHttpClientImpl
2/2 tests passed

✅ should perform a GET request and return a Product model

✅ should handle errors when performing a GET request

ProductsDatasourceImpl
6/6 tests passed

getProducts:

✅ Should perform a GET request and return a products model

✅ Should handle errors when performing a GET request

getCategories:

✅ Should perform a GET request and return a CategoriesModel

✅ Should handle errors when performing a GET request

getProductsByCategory:

✅ Should perform a GET request and return a products model

✅ Should handle errors when performing a GET request

2. Repositories
ProductsRepositoryImpl
6/6 tests passed

getProducts:

✅ Should return Right<Failure, Products>

✅ Should return Left<Failure, Products> when an exception occurs

getCategories:

✅ Should return Right<Failure, Categories>

✅ Should return Left<Failure, Categories> when an exception occurs

getProductsByCategory:

✅ Should return Right<Failure, Products>

✅ Should return Left<Failure, Products> when an exception occurs

3. Use Cases
GetCategoriesUseCase
1/1 test passed

✅ Should return Right<Failure, Categories> when calling successfully

GetProductsByCategoryUseCase
1/1 test passed

✅ Should return Right<Failure, Products> when calling successfully

GetProductsUseCase
1/1 test passed

✅ Should return Right<Failure, Products> when calling successfully

4. Presentation (Cubits)
ProductsPageCubit
4/4 tests passed

getProducts:

✅ Should load a Products entity and set ProductPageStatus.loaded

✅ Should return a failure when an exception occurs and set ProductPageStatus.error

getCategories:

✅ Should load a Categories entity and set CategoriesListStatus.loaded

✅ Should return a failure when an exception occurs and set CategoriesListStatus.error
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
