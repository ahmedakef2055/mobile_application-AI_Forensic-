# 🚀 Quick Start Guide - AI Forensic App

## الإعداد الفوري (5 دقائق)

### 1️⃣ تثبيت التبعيات
```bash
cd /var/www/mobile_application-AI_Forensic--main
flutter pub get
```

### 2️⃣ توليد الكود (Freezed + JSON Serializable)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3️⃣ تحديث main.dart
**ملف:** `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().initialize();
  runApp(const ProviderScope(child: MyApp()));
}
```

### 4️⃣ التشغيل
```bash
flutter run
```

✅ **التطبيق يعمل الآن!**

---

## 📱 سير العمل (User Flow)

```
Splash Screen (3 sec)
        ↓
Onboarding (اختياري)
        ↓
Login
        ↓
Dashboard + BottomNavigation
        ├── Dashboard (statistics)
        ├── Incidents (حوادث)
        ├── Alerts (تنبيهات)
        └── Profile (الملف الشخصي)
```

---

## 🔐 بيانات الاختبار

### Login Credentials
```
Email: admin@company.com
Password: أي كلمة (يقبل أي كلمة في الوضع التجريبي)
```

### Mock Data
- 5 حوادث محاكاة
- 4 تنبيهات محاكاة
- مقاييس أمان واقعية

---

## 📁 هيكل المشروع

```
lib/
├── main.dart                 # نقطة الدخول
├── app/
│   ├── app.dart            # تكوين التطبيق
│   └── router.dart         # المسارات
├── models/                 # نماذج البيانات ✨ جديد
│   ├── user.dart
│   ├── incident.dart
│   ├── alert.dart
│   ├── severity.dart
│   └── security_metric.dart
├── services/               # الخدمات ✨ جديد
│   ├── api_service.dart
│   └── local_storage_service.dart
├── providers/              # إدارة الحالة ✨ جديد
│   ├── auth_provider.dart
│   ├── incidents_provider.dart
│   ├── alerts_provider.dart
│   └── dashboard_provider.dart
├── core/
│   ├── theme/             # المظهر
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_spacing.dart
│   ├── widgets/           # مكونات مشتركة ✨ محسّن
│   │   ├── app_button.dart
│   │   ├── app_text_field.dart
│   │   ├── loading_view.dart
│   │   └── error_view.dart
│   ├── validators/        # التحقق من الصحة ✨ جديد
│   │   └── form_validators.dart
│   └── assets/
│       └── app_assets.dart
└── features/              # الواجهات
    ├── auth/
    │   ├── login_page.dart (قديم)
    │   ├── login_page_new.dart ✨ جديد
    │   ├── signup_page.dart
    │   └── forgot_password_page.dart
    ├── home/
    │   ├── security_dashboard_home_page.dart (قديم)
    │   ├── security_dashboard_home_page_new.dart ✨ جديد
    │   └── home_navigation_wrapper.dart ✨ جديد (BottomNav)
    ├── incidents/
    ├── alerts/
    ├── profile/
    ├── splash/
    └── onboarding/       ✨ جديد (محسّن)
```

---

## 🎨 نظام التصميم (Design System)

### الألوان
```dart
AppColors.primary       // #6366F1 (Indigo)
AppColors.text         // #1F2937 (Dark)
AppColors.mutedText    // #6B7280 (Gray)
AppColors.card         // #FFFFFF
AppColors.border       // #E5E7EB
AppColors.bgTop        // #0F0F23
AppColors.bgBottom     // #0D1929
```

### التباعد
```dart
AppSpacing.s4   // 4px
AppSpacing.s8   // 8px
AppSpacing.s12  // 12px
AppSpacing.s16  // 16px
AppSpacing.s24  // 24px
AppSpacing.s32  // 32px
```

### أنماط النصوص
```dart
AppTextStyles.h1        // 28sp, Bold
AppTextStyles.h2        // 20sp, Bold
AppTextStyles.body      // 16sp, Regular
AppTextStyles.caption   // 13sp, Regular (gray)
```

---

## 🔄 الملاحة (Navigation)

### باستخدام GoRouter فقط

```dart
// الانتقال إلى صفحة
context.go('/home');

// الانتقال مع الإرجاع
context.push('/incidents');

// الرجوع
context.pop();

// تنظيف الـ stack والانتقال
context.goNamed('dashboard');
```

---

## 🛠️ الأدوات الجديدة

### 1. AppButton - الزر المتقدم

```dart
AppButton(
  label: 'تسجيل الدخول',
  onPressed: () => _handleLogin(),
  isLoading: isLoading,
  variant: ButtonVariant.primary,  // primary, secondary, outline, danger, success
  prefixIcon: Icon(Icons.login),
  suffixIcon: Icon(Icons.arrow_forward),
)
```

### 2. AppTextField - حقل الإدخال

```dart
AppTextField(
  label: 'البريد الإلكتروني',
  hint: 'example@email.com',
  controller: emailCtrl,
  validator: FormValidators.validateEmail,
  prefixIcon: Icon(Icons.mail),
  textInputAction: TextInputAction.next,
)
```

### 3. ErrorView - عرض الخطأ

```dart
ErrorView(
  title: 'خطأ في تحميل البيانات',
  message: 'حاول مرة أخرى لاحقاً',
  onRetry: () => _refresh(),
  fullScreen: true,
)
```

### 4. LoadingView - عرض التحميل

```dart
LoadingView(
  message: 'جاري تحميل البيانات...',
  size: 50,
  fullScreen: true,
)
```

---

## 📊 نظام الحالة (State Management)

### استخدام Providers

```dart
// 1. مشاهدة الحالة
final authState = ref.watch(authProvider);

// 2. الوصول للـ notifier
final authNotifier = ref.read(authProvider.notifier);

// 3. إجراء عملية
await authNotifier.login(email, password);

// 4. التعامل مع الأخطاء
if (authState.error != null) {
  showDialog(...);
}
```

### المتاحون الحاليون:
- `authProvider` - المصادقة
- `incidentsProvider` - الحوادث
- `alertsProvider` - التنبيهات
- `dashboardProvider` - لوحة التحكم

---

## ✔️ قائمة التحقق (Checklist)

- [ ] تشغيل `flutter pub get`
- [ ] تشغيل `build_runner build`
- [ ] تحديث `main.dart`
- [ ] تشغيل `flutter run`
- [ ] اختبار LoginPage
- [ ] اختبار Dashboard
- [ ] اختبار Navigation
- [ ] اختبار Error handling

---

## 🐛 استكشاف الأخطاء

### المشكلة: "Missing Freezed generated files"
**الحل:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### المشكلة: "LocalStorageService not initialized"
**الحل:** تأكد من استدعاء `await LocalStorageService().initialize()` في `main()`

### المشكلة: "Mock data not showing"
**الحل:** تحقق من أن المتصفح يستخدم providers بشكل صحيح

---

## 📚 الموارد الإضافية

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Docs](https://riverpod.dev)
- [GoRouter Docs](https://pub.dev/packages/go_router)
- [Freezed Docs](https://pub.dev/packages/freezed)

---

## 🎯 الخطوات التالية

1. **استبدال الصفحات القديمة** بالجديدة
2. **إضافة معالجة الأخطاء الفعلية** من API
3. **تطبيق عمليات التصفية والفرز**
4. **إضافة الرسوم المتحركة والانتقالات**
5. **كتابة اختبارات الوحدة**

---

**ملاحظة:** جميع الواجهات والمكونات جاهزة للاستخدام الفوري! 🚀
