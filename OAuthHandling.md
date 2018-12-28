<h2 dir='rtl'>روند کلی</h2>
<p dir='rtl'>
منطق کار به این صورت هست که بجای استفاده از <code>SessionManager</code> پیشفرض Alamofire باید یه <code>SessionManager</code> ساخته بشه، مشخصه‌های <code>adapter</code> و <code>retrier</code> اون مقداردهی بشه، و حالا زمانیکه می‌خوایم درخواست وبی رو بدیم که باید احراز هویت بشه، با استفاده از این <code>SessionManager</code> جدید اون درخواست رو به سرور بفرستیم. 
<br>
این <code>SessionManager</code> کارش اینه که بیاد و هدر مخصوص احراز هویت رو به درخواست اضافه کنه، و اگه درخواست با کد <code>401</code> مواجه شد، بیاد با استفاده از اطلاعات فعلی، توکن احراز هویت رو بروزرسانی کنه، و بعدش در صورت موفقیت‌آمیز بودن روند بروزرسانی توکن، اون درخواست(هایی) که توی صف بودن ویا با خطا مواجه شدن رو مجدد ارسال کنه.
</p>

<h2 dir='rtl'>مدل‌های مورد استفاده</h2>

<h3 dir='rtl'>مدل <code>OAuthObject</code></h3>
<p dir='rtl'>
این مدل اطلاعات مربوط به احراز هویت رو نگه می‌داره. مشخصه‌هایی که داره ایناست:

<ul dir='rtl'>
  <li>مشخصه <code>accessToken</code> از نوع <code>String</code>:
  این مشخصه توکن اصلی هست که مورد استفاده قرار می‌گیره.
  </li> 
  <li>مشخصه <code>expiresIn</code> از نوع <code>Int</code>: این مشخصه تعداد ثانیه اعتبار این توکن رو مشخص می‌کنه.</li>
  <li>مشخصه <code>refreshToken</code> از نوع <code>String</code>:
  این مشخصه، توکنی هست که برای بروزرسانی توکن اصلی مورد استفاده قرار می‌گیره.
  </li>
  <li>مشخصه <code>createdAt</code> از نوع <code>Date</code>:
  این مشخصه تاریخ ساخته‌شدن توکن اصلی برنامه رو مشخص می‌کنه.
  </li>
</ul>
</p>
<p dir='rtl'>
برای این مدل، چند نوع سازنده یا <code>initializer</code> پیاده‌سازی شده تا بشه با <code>JSON</code> و یا <code>Dictionary</code> کار کرد. البته کلیدها بصورت پیشفرض در نظر گرفته شدن، که توی کد کاملا مشخص هستن.
</p>






<br>
<h3 dir='rtl'>مدل <code>OAuthHandler</code><h3>







<br>
<h2 dir='rtl'>پروتکل <code>IDMoyaOAuthHandlerDelegate</code></h2>
<p dir='rtl'>
این پروتکل پیاده‌سازی شده تا بشه روند دریافت و بروزرسانی و ذخیره توکن‌ها رو مدیریت کرد. همچنین یه سری اطلاعات مورد نیاز روند بروزرسانی رو در اختیار <code>OAuthHandler</code> می‌ذاره.
</p>
<p dir='rtl'>
در ادامه متدها و مشخصه‌ها و البته پیاده‌سازی پیشفرض‌شون رو توضیح میدیم.
</p>

<h3 dir='rtl'>متد <code>idMoyaOAuthHanlder_RefreshTokenEndpoint</code></h3>
<p dir='rtl'>
این متد یه <code>IDMoyaEndpointObject</code> بر می‌گردونه که اطلاعاتش در واقع مشخصات مربوط به درخواست رفرش توکن هست. این اطلاعات شامل آدرس لینک، پارامترها، متد اچ‌تی‌تی‌پی، انکودینگ مورد استفاده و اینجور چیزاست.
</p>
<p dir='rtl'>
پیاده‌سازی پیشفرض‌اش هم بصورت زیر هست:
</p>

```swift
public func idMoyaOAuthHanlder_RefreshTokenEndpoint(_ oauthHandler: IDMoya.OAuthHandler) -> IDMoyaEndpointObject {
  return IDMoyaEndpointObject(
    baseURLString : oauthHandler.baseURLString,
    path          : "api/oauth2/token",
    method        : .post,
    encoding      : JSONEncoding.default,
    parameters    : [
      "access_token"  : oauthHandler.oauthObject.accessToken,
      "refresh_token" : oauthHandler.oauthObject.refreshToken,
      "client_id"     : oauthHandler.clientID,
      "grant_type"    : "refresh_token",
    ],
    headers       : nil,
    useOAuth      : false
  )
}
```

<h3 dir='rtl'>متد <code>idMoyaOAuthHandler_AdaptURLRequest</code></h3>
<p dir='rtl'>
این متد میاد و قبل از ارسال درخواست به سرور، براساس اینکه باید احراز هویت بشه یا نه، هدر مخصوص احراز هویت رو به درخواست اضافه می‌کنه، و اون درخواست رو برمی‌گردونه تا بره برای ارسال به سرور. پیاده‌سازی پیشفرض‌اش هم بصورت زیر هست:
</p>

```swift
public func idMoyaOAuthHandler_AdaptURLRequest(_ oauthHandler: IDMoya.OAuthHandler, urlRequest: URLRequest) -> URLRequest {
  if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(oauthHandler.baseURLString) {
    var urlRequest = urlRequest
    urlRequest.setValue("Bearer " + oauthHandler.oauthObject.accessToken, forHTTPHeaderField: "Authorization")
    return urlRequest
  }
  return urlRequest
}
```

<h3 dir='rtl'>متد <code>idMoyaOAuthHandler_DidSuccessfullyRefreshed</code></h3>
<p dir='rtl'>
این متد زمانی فراخوانی میشه، که روند رفرش توکن‌ها با موفقیت با پایان رسیده. توی این متد، به <code>OAuthObject</code> جدید دسترسی خواهیم داشت.
</p>

```swift
public func idMoyaOAuthHandler_DidSuccessfullyRefreshed(_ oauthHandler: IDMoya.OAuthHandler, withNewOAuthObject oauthObject: IDMoya.OAuthObject) {

}
```

<h3 dir='rtl'>متد <code>idMoyaOAuthHandler_DidFailedToRefresh</code></h3>
<p dir='rtl'>
این متد زمانی فراخوانی میشه، که روند رفرش توکن‌ها، با خطا مواجه بشه. همچنین داده دریافتی از سرور رو هم بهمراه خودش داره.
</p>

```swift
public func idMoyaOAuthHandler_DidFailedToRefresh(_ oauthHandler: IDMoya.OAuthHandler, response: DataResponse<Any>?) {

}
```

<h3 dir='rtl'>مشخصه <code>idMoyaOAuthHandler_StoredOAuthObject</code></h3>
<p dir='rtl'>
این مشخصه، میاد و چک می‌کنه که بتونه براساس اطلاعات ذخیره‌شده، یه شیء از <code>OAuthObject</code> بسازه و اونو برگردونه. 
</p>
<p dir='rtl'>چون بطور پیشفرض اطلاعات دریافتی توی <code>UserDefaults.standard</code> ذخیره میشه، بطور پیشفرض هم اطلاعات این منبع مورد استفاده قرار می‌گیره.</p>

```swift
public var idMoyaOAuthHandler_StoredOAuthObject: IDMoya.OAuthObject? {
  let userDefaults = UserDefaults.standard
  let userDefaultsKeys = (
    accessToken  : "IDAM.UDK.AO.AT",
    refreshToken : "IDAM.UDK.AO.RT",
    expiresIn    : "IDAM.UDK.AO.EI",
    createdAt    : "IDAM.UDK.AO.CA"
  )
  guard
    let _accessToken      = userDefaults.object(forKey: userDefaultsKeys.accessToken) as? String,
    let _refreshToken     = userDefaults.object(forKey: userDefaultsKeys.refreshToken) as? String,
    let _createdAt_Double = userDefaults.object(forKey: userDefaultsKeys.createdAt) as? Double,
    let _expiresIn        = userDefaults.object(forKey: userDefaultsKeys.expiresIn) as? Int
    else { return nil }
  return IDMoya.OAuthObject(
    accessToken  : _accessToken,
    refreshToken : _refreshToken,
    expiresIn    : _expiresIn,
    createdAt    : Date(timeIntervalSince1970: _createdAt_Double)
  )
}
```


<h3 dir='rtl'>متد <code>idMoyaOAuthHandler_StoreNewOAuthObject</code></h3>
<p dir='rtl'>این متد، برای ذخیره شیء <code>OAuthObject</code> جدید مورد استفاده قرار می‌گیره. بطور پیشفرض، برای ذخیره اطلاعات اون، از <code>UserDefaults.standard</code> استفاده شده.</p>

```swift
public func idMoyaOAuthHandler_StoreNewOAuthObject(oauthObject: IDMoya.OAuthObject) {
  let userDefaults = UserDefaults.standard
  let userDefaultsKeys = (
    accessToken  : "IDAM.UDK.AO.AT",
    refreshToken : "IDAM.UDK.AO.RT",
    expiresIn    : "IDAM.UDK.AO.EI",
    createdAt    : "IDAM.UDK.AO.CA"
  )
  userDefaults.set(oauthObject.accessToken, forKey: userDefaultsKeys.accessToken)
  userDefaults.set(oauthObject.refreshToken, forKey: userDefaultsKeys.refreshToken)
  userDefaults.set(oauthObject.expiresIn, forKey: userDefaultsKeys.expiresIn)
  userDefaults.set(oauthObject.createdAt.timeIntervalSince1970, forKey: userDefaultsKeys.createdAt)
  userDefaults.synchronize()
}
```

<h3 dir='rtl'>متد <code>idMoyaOAuthHandler_RemoveCurrentOAuthObject</code></h3>
<p dir='rtl'>از این متد برای حذف اطلاعات فعلی و ذخیره‌شده مورد استفاده قرار می‌گیره. پیاده‌سازی پیشفرض‌اش هم بصورت زیر هست:</p>

```swift
public func idMoyaOAuthHandler_RemoveCurrentOAuthObject(_ oauthHandler: IDMoya.OAuthHandler) {
  let userDefaults = UserDefaults.standard
  let userDefaultsKeys = (
    accessToken  : "IDAM.UDK.AO.AT",
    refreshToken : "IDAM.UDK.AO.RT",
    expiresIn    : "IDAM.UDK.AO.EI",
    createdAt    : "IDAM.UDK.AO.CA"
  )
  userDefaults.set(nil, forKey: userDefaultsKeys.accessToken)
  userDefaults.set(nil, forKey: userDefaultsKeys.refreshToken)
  userDefaults.set(nil, forKey: userDefaultsKeys.expiresIn)
  userDefaults.set(nil, forKey: userDefaultsKeys.createdAt)
  userDefaults.synchronize()
}
```

<h2 dir='rtl'><b>نکات مهم</b></h2>

<p dir='rtl'> 👈
هیچ‌کدوم از مشخصه‌های پروتکل، اجباری نیستن؛ چون همه‌شون پیاده‌سازی پیشفرض دارن.
</p>
<p dir='rtl'>👈
مدل <code>OAuthHandler</code> یه مشخصه از نوع <code>static</code> داره، که اون <span style='color:blue;'><b>⚠️ حتما ⚠️</b></span> مقداردهی بشه. پیشنهاد من اینه که مقدارش رو برابر <code>AppDelegate</code> قرار بدین. اینجوری هم مدیریتش آسون‌تره، و هم می‌دونیم که تا وقتی اپ باز هست، مقدار اون مشخصه برابر <code>nil</code> نخواهد شد.<br>
برای این کار توی <code>AppDelegate</code> این رو کار کنین:
</p>

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    IDMoya.OAuthHandler.Delegate = self
    
    return true
  }

}

extension AppDelegate: IDMoyaOAuthHandlerDelegate {

}
```

<p dir='rtl'>👈
شما باید یه شیء از نوع <code>SessionManager</code> بسازین و بعدش یه شیء از <code>OAuthHandler</code> بسازین و بعنوان <code>adapter</code> و <code>retrier</code> بدین به این <code>SessionManager</code> ساخته‌شده. توجه داشته باشین که اون شیء <code>SessionManager</code> رو جایی ذخیره کنین و نگه‌داریش کنین. این کار برای اینه که اگه این شیء از بین بره، امکان <code>retry</code> درخواست‌های متوقف‌شده یا خطادار هم از بین خواهد رفت. همچنین موقعی که از اون <code>SessionManager</code> ساخته‌شده استفاده میشه، باید از متد <code>validate</code> آلاموفایر هم استفاده بشه. مثالش بصورت زیر خواهد بود:
</p>

```swift
MySingleton.OAuthSessionManager?
  .request(...)
  .validate(statusCode: ...) 👈
  .responseJSON { response in ... }
```

<p dir='rtl'>
اون مقدار <code>statusCode</code> باید برابر کدهای مورد قبول بعنوان درخواست موفقیت‌آمیز باشه. ما از این استفاده می‌کنیم: (که میشه همه کدها، بجز کد <code>401</code>)
</p>

```swift
Array(200...400) + Array(402..<600)
```

<p dir='rtl'>
مثال ساخت <code>SessionManager</code> هم بصورت زیر هست:
</p>

```swift
let sessionManager = SessionManager()
let oauthHandler = IDMoya.OAuthHandler(clientID: "cliendID", baseURLString: "baseURLString", oauthObject: oauthObject)
sessionManager.adapter = oauthHandler
sessionManager.retrier = oauthHandler
MySingleton.OAuthSessionManager = sessionManager
```









