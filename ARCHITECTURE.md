# Product Catalog - Flutter Architecture Guide

## 📁 Project Structure

This project follows **Feature-First Clean Architecture** with **Riverpod** for state management.

```
lib/
├── core/                           # Shared across features
│   ├── constants/                  # App-wide constants
│   ├── theme/                      # Theme configuration
│   ├── utils/                      # Utility functions
│   └── widgets/                    # Reusable widgets
│
├── features/                       # Feature modules
│   └── products/                   # Product feature
│       ├── data/                   # Data layer
│       │   ├── models/            # Data models (JSON serialization)
│       │   ├── datasources/       # API & local data sources
│       │   └── repositories/      # Repository implementations
│       │
│       ├── domain/                 # Business logic layer
│       │   ├── entities/          # Business entities (pure Dart)
│       │   ├── repositories/      # Repository contracts
│       │   └── usecases/          # Business use cases
│       │
│       └── presentation/           # UI layer
│           ├── providers/         # Riverpod providers
│           ├── pages/             # Screen widgets
│           └── widgets/           # Feature-specific widgets
│
└── main.dart                       # App entry point
```

## 🏗️ Architecture Layers

### 1. Domain Layer (Business Logic)
- **Entities**: Pure Dart classes representing business models
- **Repositories**: Abstract interfaces defining data operations
- **Use Cases**: Specific business operations (optional for simple apps)

**Key Principles:**
- No dependencies on Flutter or external packages
- Contains core business logic
- Defines contracts that data layer implements

### 2. Data Layer (Data Management)
- **Models**: Extend entities with JSON serialization
- **Data Sources**: Handle API calls, local database, etc.
- **Repository Implementations**: Implement domain repository contracts

**Key Principles:**
- Handles all data operations
- Converts between models and entities
- Manages data sources (remote/local)

### 3. Presentation Layer (UI)
- **Providers**: Riverpod state management
- **Pages**: Full-screen UI components
- **Widgets**: Reusable UI components

**Key Principles:**
- Consumes providers for state
- No business logic (delegates to domain)
- Focuses purely on UI

## 🔄 Data Flow

```
User Interaction
    ↓
Widget (ConsumerWidget)
    ↓
Provider (Riverpod)
    ↓
Repository
    ↓
Data Source (API/Local)
    ↓
Model → Entity
    ↓
Back to Widget
```

## 🎯 Current Features

### Product List
- Display all products
- Pull-to-refresh
- Navigate to product details

### Product Detail
- View product information
- Stock status
- Add to cart (placeholder)

### Search (To be implemented)
- Search products by name/description
- Filter by category

## 📦 Key Providers

### `productListProvider`
Fetches and provides the complete product list.

```dart
final productsAsync = ref.watch(productListProvider);
```

### `productDetailProvider`
Fetches details for a specific product by ID.

```dart
final productAsync = ref.watch(productDetailProvider(productId));
```

### `searchResultsProvider`
Provides search results based on query.

```dart
final results = ref.watch(searchResultsProvider);
```

## 🚀 Getting Started

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **Run with riverpod_lint enabled:**
   - The `analysis_options.yaml` is already configured
   - Restart Dart Analysis Server in VS Code

## 🛠️ Development Guidelines

### Adding a New Feature

1. Create feature folder structure:
   ```
   features/new_feature/
   ├── data/
   ├── domain/
   └── presentation/
   ```

2. Define entity in `domain/entities/`
3. Create repository interface in `domain/repositories/`
4. Implement data model in `data/models/`
5. Create data source in `data/datasources/`
6. Implement repository in `data/repositories/`
7. Create providers in `presentation/providers/`
8. Build UI in `presentation/pages/` and `presentation/widgets/`

### Best Practices

✅ **DO:**
- Keep entities pure (no Flutter/external dependencies)
- Use `const` constructors where possible
- Handle errors at the repository level
- Use meaningful provider names
- Implement loading and error states

❌ **DON'T:**
- Put business logic in widgets
- Access data sources directly from UI
- Forget to handle loading/error states
- Mix presentation and business logic

## 📚 Next Steps

- [ ] Implement search functionality
- [ ] Add category filtering
- [ ] Integrate real API
- [ ] Add error handling improvements
- [ ] Implement cart functionality
- [ ] Add local caching
- [ ] Write unit tests
- [ ] Add integration tests

## 🧪 Testing Strategy

```
lib/features/products/
└── test/
    ├── domain/
    │   └── entities/product_test.dart
    ├── data/
    │   ├── models/product_model_test.dart
    │   └── repositories/product_repository_impl_test.dart
    └── presentation/
        └── providers/product_providers_test.dart
```

## 📖 Resources

- [Riverpod Documentation](https://riverpod.dev)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Best Practices](https://flutter.dev/docs/development/best-practices)
