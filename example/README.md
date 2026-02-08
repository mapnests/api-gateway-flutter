# TNMaps SDK Documentation (v1.0.0)

## API Registration & Authentication

### Step 1: Register for API Access

**Endpoint:** `http://192.168.169.58:3030/register`

- Create an account and register for API access.

### Step 2: Login to Dashboard

**Endpoint:** `http://192.168.169.58:3030/login`

- Use your credentials to log in and manage your projects.

## Project Setup

### Step 1: Create a Project

1. Log in to the TNMaps Dashboard.
2. Navigate to the dashboard.
3. Go to the **Projects** section.
4. Click on **"Create Project"**.
5. Provide a **Project Name** and **Project Description**.
6. After project creation, go to the **details section**.
7. In the **Android Section**, add your **Package Name** and **SHA256 fingerprint**.
8. Once successfully created, you will receive an **API Key**.

## 🔗 Required Git Repositories

Make sure every team member has access to the following repositories:

- `git@vcs.technonext.com:TechnoNext/common/tn-map/flutter-sdk.git`

> 🔐 **Note:**  
> These repositories are private. Please ensure you have **SSH access** and valid credentials
> configured
> in your Git profile.

### Step 1: Add Dependencies

#### a. Add Flutter Plugin

In your `pubspec.yaml`:

```yaml
dependencies:
   api_gateway_flutter_sdk:
      git:
         url: git@vcs.technonext.com:TechnoNext/common/tn-map/flutter-sdk.git
         ref: 1.0.16
```      

### Step 2: Add Dependencies

Add the following dependencies to your `build.gradle` file:

### : mavenLocal Add Dependencies and applicationId according base on api key.

Add mavenLocal() project base build files. Like below

```groovy

allprojects {
   repositories {
      google()
      mavenCentral()
      ** mavenLocal()**
   }
}

```

```groovy
   applicationId = "com.example.app"
```

### Step 4: Add SDK to IOS Project

**go to ios folder && exection commnad**
**pod install**

### Step 4: open Runner.xcworkspace by xcode

in singing & Capabilities select update your team and bundle identifier

### Step 5: add apiKey and packageName in .env file in asserts folder

```dart

String API_KEY = "";
String PACKAGE_NAME = "";
```

### Step 6: run the app with the following command

```bash

**--dart-define=ENV=debug** like

flutter run --dart-define=ENV=debug
```


### Example:

```dart

Future<void> _getGeocode() async {
   try {
      String requestJson = jsonEncode({
         "apiKey": API_KEY,
         "packageName": PACKAGE_NAME,
         "q": "Uttara",
         "language": "en",
         "limit": 5
      });

      final result = await TnmapFlutterPlugin.getGeocode(requestJson);

      setState(() {
         _response = result;
      });
   } catch (e) {
      setState(() {
         _response = "Error: $e";
      });
   }
}

```

### Example: geomap data json sample:

**Request:**
```dart

String requestJson = jsonEncode({
   "apiKey": API_KEY,
   "packageName": PACKAGE_NAME,
   "q": "Uttara",
   "language": "en",
   "limit": 5
});
```

**Response:**
```json
    {
   "data": [
      {
         "place_id": 318548,
         "lat": "23.7921765",
         "lon": "90.4155528",
         "category": "place",
         "type": "suburb",
         "place_rank": 19,
         "importance": 0.14667666666666662,
         "addresstype": "suburb",
         "name": "Gulshan",
         "display_name": "Gulshan, Dhaka, Dhaka Metropolitan, Dhaka District, Dhaka Division, Bangladesh"
      }
   ],
   "message": "Success",
   "status": true
}

```

### Example: geomap data json sample:

**Request:**

```dart

String requestJson = jsonEncode({
   "apiKey": API_KEY,
   "packageName": PACKAGE_NAME,
   "q": "Uttara",
   "language": "en",
   "limit": 5
});
```

**Response:**

```json
    {
   "data": [
      {
         "place_id": 318548,
         "lat": "23.7921765",
         "lon": "90.4155528",
         "category": "place",
         "type": "suburb",
         "place_rank": 19,
         "importance": 0.14667666666666662,
         "addresstype": "suburb",
         "name": "Gulshan",
         "display_name": "Gulshan, Dhaka, Dhaka Metropolitan, Dhaka District, Dhaka Division, Bangladesh"
      }
   ],
   "message": "Success",
   "status": true
}

```

### Example: reverse geocode data json sample:

**Request:**

```dart

String requestJson = jsonEncode({
   "apiKey": API_KEY,
   "packageName": PACKAGE_NAME,
   "lat": 23.80631,
   "lon": 90.41889,
   "language": "en"
});
```

**Response:**

```json
        {
   "data": {
      "place_id": 313095,
      "lat": "23.806617404029236",
      "lon": "90.41881019418601",
      "category": "highway",
      "type": "residential",
      "place_rank": 26,
      "importance": 0.0533433333333333,
      "addresstype": "road",
      "name": "Road 11",
      "display_name": "Road 11, Gulshan, Baridhara, Dhaka, Dhaka Metropolitan, Dhaka District, Dhaka Division, 1229, Bangladesh",
      "address": {
         "ISO3166-2-lvl4": "BD-C",
         "ISO3166-2-lvl5": "BD-13",
         "borough": "Baridhara",
         "city": "Dhaka",
         "country": "Bangladesh",
         "country_code": "bd",
         "municipality": "Dhaka Metropolitan",
         "postcode": "1229",
         "road": "Road 11",
         "state": "Dhaka Division",
         "state_district": "Dhaka District",
         "suburb": "Gulshan"
      }
   },
   "message": "Success",
   "status": true
}

```

## 🔧 Troubleshooting & Common Errors

**Cause:**
> Failed to transform tnmap.flutter.sdk-1.0.17.aar (com.technonext:tnmap.flutter.sdk:1.0.17) to
> match attributes {artifactType=android-aar-metadata, org.gradle.category=library,
> org.gradle.libraryelements=jar, org.gradle.status=release, org.gradle.usage=java-runtime}.

```bash
  cd android
    ./gradlew clean
    ./gradlew build
    ../gradlew assemble
  flutter pub get
```

### ❌ Error: `Invalid publication 'mavenAar': artifact file does not exist`
**Cause:**  
The `.aar` file (`mapsdk-release.aar`) is missing from the expected path:

**Solution:**

1. Run:
   ```bash
   flutter clean
   flutter pub get
   ```

2. Navigate to your plugin's android/ directory and build the AAR:
   ./gradlew assembleRelease

**Cause:**  
This error occurs when Flutter’s Git cache for the plugin is out of sync or corrupted, usually due
to updates on the remote `develop` branch.
**Solution:**

Remove the cached version of the plugin and fetch it again:

```bash
  rm -rf ~/.pub-cache/git/flutter-sdk-*
  flutter pub get
```

## Notes & Best Practices

- Ensure **API Key** is correctly configured in `DistanceMatrixActivity`.
- Use a **valid Package Name** & **SHA256 Fingerprint** in the TNMaps dashboard.

## Support

For any issues or support, contact the **TNMaps team** or refer to the official documentation.