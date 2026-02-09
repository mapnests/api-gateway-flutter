# api-gateway-flutter
Flutter SDK for integrating API Gateway.
It automatically generates required security headers and allows you to merge them with your existing HTTP client (Dio, http, Retrofit-style wrappers, etc.).

## 2.0.0+2

* API Gateway Flutter SDK 2.0.0
* Update .Arr file and .xcframework file

## Changelog (v1.0.0)
- Initial Flutter SDK integration
- Automatic secure header generation
- Android & iOS support

## Onboarding Process

1. Send email mentioning all of your package names (com.example.debug, com.example.release etc) and send to `apigw@technonext.com` to get `bind-client-config.json`.
2. Place `bind-client-config.json` in the **root directory** of your project android & IOS.


## Installation
Add dependencies to your pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter
  tnmap_flutter_plugin: ^latest
```
> 🔹 Always use the latest stable version of `tnmap_flutter_plugin` from pub.dev

Then run:

```sh
flutter pub get
```

## Usage

```dart
final headers = await TnmapFlutterPlugin.getHeaders();
```
These headers are mandatory and must be sent with every API request.

Example: Call API using Dio (Merged Headers)

```dart
final sdkHeaders = await TnmapFlutterPlugin.getHeaders();

final mergedHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  ...sdkHeaders,
};

final response = await Dio().get(
'http://example.com/api',
options: Options(headers: mergedHeaders),
);

```

Example: Central API Client (Recommended)
```dart
class ApiClient {
  static final Dio _dio = Dio();

  static Future<Response> get(
      String url, {
        required Map<String, String> headers,
      }) {
    return _dio.get(
      url,
      options: Options(headers: headers),
    );
  }
}

```


## Project Setup Android

### Root `build.gradle.kts`
Add the Mapnests `config-loader` plugin.

Plugin: `com.mapnests.config-loader:com.mapnests.config-loader.gradle.plugin:4.0.0`

``` groovy
buildscript {
    repositories {
        mavenLocal()
        gradlePluginPortal()
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.13.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.2.21")
        classpath("com.mapnests.config-loader:com.mapnests.config-loader.gradle.plugin:4.0.0")
    }
}
```
or 

```kotlin

pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        mavenLocal()
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    id("com.mapnests.config-loader") version "4.0.0" apply false
}

include(":app")

```




### Module build.gradle

Set Java and Kotlin compatibility, minSdk, applicationId and compileOptions.


```groovy
plugins {
  // other gradle plugins
  id("com.mapnests.config-loader")
}

defaultConfig {
    applicationId = "com.example.api_gateway_flutter_example"
    minSdk = 24
}


compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}
```

## Project Setup IOS

1. Drag and drop the `TNApiGetwaySDK.xcframework` into your project’s **Project Navigator** (e.g., into a `Frameworks` group).
2. Select your project in Xcode → **Target** → **General** tab.
3. Scroll down to **Frameworks, Libraries, and Embedded Content**.
4. Click the **+** button → Add `TNApiGetwaySDK.xcframework`.
5. Set **Embed** to **Embed & Sign**.

### Root `add TNApiGetwaySDKConfigFile under your  Info.plist`

```xml

<dict>
    <key>TNApiGetwaySDKConfigFile</key>
    <string>bind-client-config.json</string>
</dict>
```

## Developer Notes
- Package name must match the value registered in bind-client-config.json
- HTTPS is recommended
- Headers must be fetched before every API call
- Do not hard-code SDK headers
## Common Fixes

#401 / Unauthorized
- Wrong package name or bundle ID
- Incorrect bind-client-config.json
- Config file not found at runtime

#iOS Crash (Simulator / OS mismatch)
- Rebuild SDK for correct iOS version
- Clean build folder

---

## Support

For issues or feature requests contact us through email: `apigw@technonext.com`