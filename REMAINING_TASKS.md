# Remaining Tasks

## 1. Add Product Card Navigation

**File:** `lib/modules/home/home_dashboard_page.dart`
**Line:** ~498

**Change:**
```dart
// FROM:
  Widget _buildProductCard(ProductModel product) {
    return Container(
      decoration: BoxDecoration(...),
      child: Column(...),
    );
  }

// TO:
  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed('/home/product/${product.id}'),
      child: Container(
        decoration: BoxDecoration(...),
        child: Column(...),
      ),
    );
  }
```

## 2. Add Banner Carousel (Optional Enhancement)

**File:** `lib/modules/home/home_dashboard_page.dart`

**Add this method before `_formatCategoryName`:**
```dart
  Widget _buildBanner() {
    final banners = [
      {"title": "Summer Sale!", "subtitle": "Up to 50% OFF", "colors": [Color(0xFFFF6B6B), Color(0xFFFFE66D)]},
      {"title": "New Arrivals", "subtitle": "Check latest products", "colors": [Color(0xFF4FACFE), Color(0xFF00F2FE)]},
      {"title": "Special Offer", "subtitle": "Free shipping >$50", "colors": [Color(0xFF667EEA), Color(0xFF764BA2)]},
    ];

    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: banner["colors"] as List<Color>),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(banner["title"] as String, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(banner["subtitle"] as String, style: const TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
```

**Then add banner to the page** in the `build` method's `CustomScrollView`:
```dart
slivers: [
  _buildAppBar(user?.fullName ?? user?.username ?? 'User'),
  SliverToBoxAdapter(child: _buildBanner()),  // ADD THIS LINE
  SliverToBoxAdapter(child: _buildSearchBar(currentState)),
  // ... rest of the slivers
]
```

## Features Completed ✅

1. ✅ Blog/Posts infrastructure with DummyJSON API
2. ✅ Blog page with search and tag filtering
3. ✅ Post detail page
4. ✅ Product detail page with image gallery
5. ✅ 4-tab navigation (Home, Blog, Items, Profile)
6. ✅ Complete state management for blog
7. ✅ Error handling across all services

## Quick Test

After making the above changes:

```bash
# Test product navigation
1. Open app → Home tab
2. Click any product card
3. Should open product detail page

# Test blog
1. Open app → Blog tab
2. Should see list of posts
3. Click a post → opens post detail
4. Use search and tag filters

# Test banner
1. Open app → Home tab
2. Should see rotating banner at top
3. Swipe left/right to see different banners
```

## Commands to Run

```bash
# If you make changes, commit them:
git add lib/modules/home/home_dashboard_page.dart
git commit -m "feat: Add product card navigation and banner carousel"
git push -u origin claude/ini-adalah-011CUscS8mUzumh5L1UExsPY
```
