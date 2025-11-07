# Network Troubleshooting Guide

This document helps you troubleshoot network connectivity issues when running the BoilPart Flutter application.

## Common Network Errors

### 1. Connection Error (CORS Issue on Web)

**Error Message:**
```
DioExceptionType.connectionError
The XMLHttpRequest onError callback was called
```

**Cause:** Cross-Origin Resource Sharing (CORS) policy blocking requests when running on Flutter Web.

**Solutions:**

#### Option A: Run Chrome with disabled web security (Development Only)
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

#### Option B: Use CORS Proxy (Development Only)
Uncomment and modify `.env`:
```env
# Use CORS proxy for web development
API_BASE_URL=https://cors-anywhere.herokuapp.com/https://dummyjson.com
```

#### Option C: Run on Mobile/Desktop
CORS only affects web browsers. Run on mobile or desktop instead:
```bash
flutter run -d windows  # Windows
flutter run -d macos    # macOS
flutter run -d linux    # Linux
flutter run             # Android/iOS device
```

### 2. Connection Timeout

**Error Message:**
```
Connection timeout. Please check your internet connection.
```

**Solutions:**
- Check your internet connection
- Increase timeout in `.env`:
  ```env
  API_TIMEOUT=60000  # Increase to 60 seconds
  ```
- Try again when network is stable

### 3. No Internet Connection

**Error Message:**
```
No internet connection. Please check your network and try again.
```

**Solutions:**
- Verify internet connection is active
- Check firewall settings
- Disable VPN if causing issues
- Try switching between WiFi and mobile data

### 4. Server Error (500, 502, 503)

**Error Message:**
```
Server error: 500. Please try again later.
```

**Solutions:**
- The API server is experiencing issues
- Wait a few minutes and try again
- Check API status at: https://dummyjson.com

## Testing Network Connectivity

### Test with curl
```bash
curl https://dummyjson.com/products?limit=5
```

If this works but the app doesn't, it's likely a CORS issue on web.

### Test Login Endpoint
```bash
curl -X POST https://dummyjson.com/auth/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"emilys","password":"emilyspass"}'
```

## Platform-Specific Issues

### Flutter Web
- **Issue:** CORS errors are common
- **Solution:** Use one of the CORS solutions above
- **Note:** DummyJSON supports CORS, but some browsers may still block it

### Flutter Mobile (Android/iOS)
- **Issue:** Internet permission not granted
- **Solution:** Check AndroidManifest.xml has:
  ```xml
  <uses-permission android:name="android.permission.INTERNET" />
  ```

### Flutter Desktop (Windows/macOS/Linux)
- **Issue:** Firewall blocking requests
- **Solution:** Allow app through firewall

## Alternative APIs

If DummyJSON is not working, try alternative APIs in `.env`:

```env
# Option 1: ReqRes (for users only)
API_BASE_URL=https://reqres.in/api

# Option 2: JSONPlaceholder (for posts/todos)
API_BASE_URL=https://jsonplaceholder.typicode.com
```

**Note:** Each API has different endpoints and data structures. You may need to adjust the code.

## App Features for Error Handling

The app now includes:

✅ **Automatic Retry:** Network errors are automatically retried once
✅ **User-Friendly Messages:** Clear error messages explain what went wrong
✅ **Pull to Refresh:** Swipe down on the home screen to retry
✅ **Offline Detection:** App detects when you're offline
✅ **Timeout Configuration:** Adjustable timeout in `.env`

## Need More Help?

1. Check the error message in the app - it should tell you exactly what's wrong
2. Look at the console logs for detailed error information
3. Try running on a different platform (web → mobile or vice versa)
4. Verify the API is working by testing with curl
5. Check the `.env` file configuration

## Development Tips

- **Always test on mobile/desktop** before assuming there's a network issue
- **CORS is only a web browser issue**, not a networking issue
- **Use Chrome DevTools** to see network requests when running on web
- **Check DummyJSON status** at their website before debugging your code

---

**Last Updated:** 2025-11-07
**API Used:** DummyJSON (https://dummyjson.com)
