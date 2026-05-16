import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeMode { dark, light }

enum AppLocale { ar, en }

class AppSettings {
  final AppThemeMode themeMode;
  final AppLocale locale;

  const AppSettings({
    this.themeMode = AppThemeMode.light,
    this.locale = AppLocale.ar,
  });

  AppSettings copyWith({
    AppThemeMode? themeMode,
    AppLocale? locale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  bool get isDark => themeMode == AppThemeMode.dark;
  bool get isArabic => locale == AppLocale.ar;
  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;
  Locale get materialLocale =>
      isArabic ? const Locale('ar') : const Locale('en');
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings());

  void setThemeMode(AppThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void toggleTheme() {
    setThemeMode(state.isDark ? AppThemeMode.light : AppThemeMode.dark);
  }

  void setLocale(AppLocale locale) {
    state = state.copyWith(locale: locale);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

/// Quick translation map. Add keys here and reference them via `tr(key, ref)`.
class AppStrings {
  static const Map<String, Map<String, String>> _t = {
    // Home / Dashboard
    'home.title': {'ar': 'لوحة التحكم', 'en': 'Dashboard'},
    'home.subtitle': {
      'ar': 'لوحة التحكم الأساسية والإحصائيات الأمنية',
      'en': 'Core dashboard and security statistics'
    },
    'home.search.hint': {
      'ar': 'ابحث عن حادثة أو تنبيه...',
      'en': 'Search incidents or alerts...'
    },
    'home.loading': {
      'ar': 'جاري تحميل البيانات...',
      'en': 'Loading data...'
    },
    'home.error': {'ar': 'خطأ', 'en': 'Error'},
    'home.metric.active_alerts': {
      'ar': 'التنبيهات النشطة',
      'en': 'Active Alerts'
    },
    'home.metric.open_incidents': {
      'ar': 'الحوادث المفتوحة',
      'en': 'Open Incidents'
    },
    'home.metric.threats_blocked': {
      'ar': 'التهديدات المحظورة',
      'en': 'Threats Blocked'
    },
    'home.metric.system_health': {
      'ar': 'صحة النظام',
      'en': 'System Health'
    },
    'home.gauge.title': {
      'ar': 'صحة النظام العامة',
      'en': 'Overall System Health'
    },
    'home.recent_alerts': {
      'ar': 'التنبيهات الأخيرة',
      'en': 'Recent Alerts'
    },
    'home.view_all': {'ar': 'عرض الكل', 'en': 'View all'},

    // Incidents page
    'incidents.title': {'ar': 'الحوادث', 'en': 'Incidents'},
    'incidents.subtitle': {
      'ar': 'إدارة ومتابعة الحوادث الأمنية',
      'en': 'Manage and track security incidents'
    },
    'incidents.item.subtitle': {
      'ar': 'اضغط لعرض التفاصيل',
      'en': 'Tap to view details'
    },
    'incidents.tab.all': {'ar': 'الكل', 'en': 'All'},
    'incidents.tab.open': {'ar': 'مفتوحة', 'en': 'Open'},
    'incidents.tab.in_progress': {
      'ar': 'قيد المعالجة',
      'en': 'In progress'
    },
    'incidents.tab.resolved': {'ar': 'مغلقة', 'en': 'Resolved'},
    'incidents.footer.attention': {
      'ar': 'حوادث تحتاج إلى الانتباه',
      'en': 'incidents require attention'
    },
    'incidents.footer.updated': {
      'ar': 'آخر تحديث: منذ دقيقتين',
      'en': 'Last updated: 2 minutes ago'
    },

    // Settings page
    'settings.title': {'ar': 'الإعدادات', 'en': 'Settings'},
    'settings.subtitle': {
      'ar': 'تخصيص التطبيق حسب تفضيلاتك',
      'en': 'Customize the app to your preferences'
    },
    'settings.section.language': {
      'ar': 'اللغة والمنطقة',
      'en': 'Language & Region'
    },
    'settings.section.notifications': {
      'ar': 'الإشعارات',
      'en': 'Notifications'
    },
    'settings.section.security': {'ar': 'الأمان', 'en': 'Security'},
    'settings.section.about': {'ar': 'حول التطبيق', 'en': 'About'},
    'settings.app_language': {
      'ar': 'لغة التطبيق',
      'en': 'App Language'
    },
    'settings.notifications.enable': {
      'ar': 'تفعيل الإشعارات',
      'en': 'Enable Notifications'
    },
    'settings.notifications.enable.sub': {
      'ar': 'تلقي التنبيهات الأمنية',
      'en': 'Receive security alerts'
    },
    'settings.notifications.email': {
      'ar': 'إشعارات البريد',
      'en': 'Email Notifications'
    },
    'settings.notifications.email.sub': {
      'ar': 'إرسال التنبيهات عبر الإيميل',
      'en': 'Send alerts by email'
    },
    'settings.notifications.sms': {
      'ar': 'الرسائل النصية',
      'en': 'SMS Messages'
    },
    'settings.notifications.sms.sub': {
      'ar': 'إرسال التنبيهات عبر SMS',
      'en': 'Send alerts by SMS'
    },
    'settings.biometric': {'ar': 'البصمة', 'en': 'Biometric'},
    'settings.biometric.sub': {
      'ar': 'تسجيل الدخول عبر البصمة',
      'en': 'Sign in with biometrics'
    },
    'settings.2fa': {
      'ar': 'المصادقة الثنائية',
      'en': 'Two-Factor Authentication'
    },
    'settings.2fa.sub': {
      'ar': 'تفعيل 2FA للأمان الإضافي',
      'en': 'Enable 2FA for extra security'
    },
    'settings.change_password': {
      'ar': 'تغيير كلمة المرور',
      'en': 'Change Password'
    },
    'settings.change_password.sub': {
      'ar': 'تحديث كلمة المرور الخاصة بك',
      'en': 'Update your password'
    },
    'settings.change_password.toast': {
      'ar': 'سيتم إعادة التوجيه لتغيير كلمة المرور قريباً',
      'en': 'You will be redirected to change password soon'
    },
    'settings.version': {'ar': 'الإصدار', 'en': 'Version'},
    'settings.version.sub': {
      'ar': 'رقم الإصدار الحالي',
      'en': 'Current version number'
    },
    'settings.signout': {'ar': 'تسجيل الخروج', 'en': 'Sign Out'},
    'settings.signout.confirm': {
      'ar': 'هل أنت متأكد من تسجيل الخروج؟',
      'en': 'Are you sure you want to sign out?'
    },
    'settings.signout.action': {'ar': 'خروج', 'en': 'Sign Out'},

    // Common toast titles
    'toast.coming_soon': {'ar': 'قريباً', 'en': 'Coming soon'},
    'toast.coming_soon.body': {
      'ar': 'هذه الخاصية تحت التطوير وسنطلقها قريباً',
      'en': 'This feature is under development and will be released soon'
    },

    // Navigation
    'nav.home': {'ar': 'الرئيسية', 'en': 'Home'},
    'nav.incidents': {'ar': 'الحوادث', 'en': 'Incidents'},
    'nav.alerts': {'ar': 'التنبيهات', 'en': 'Alerts'},
    'nav.profile': {'ar': 'حسابي', 'en': 'Account'},
    'nav.settings': {'ar': 'الإعدادات', 'en': 'Settings'},

    // Profile page
    'profile.title': {'ar': 'الملف الشخصي', 'en': 'Profile'},
    'profile.subtitle': {
      'ar': 'بيانات ملفك الشخصي والإعدادات',
      'en': 'Your profile data and settings'
    },
    'profile.role': {'ar': 'مسؤول الأمان', 'en': 'Security Admin'},
    'profile.security': {'ar': 'المصادقة والأمان', 'en': 'Auth & Security'},
    'profile.security.sub': {
      'ar': 'إدارة كلمة المرور والمصادقة الثنائية',
      'en': 'Manage password and 2FA'
    },
    'profile.notifications': {'ar': 'الإشعارات', 'en': 'Notifications'},
    'profile.notifications.sub': {
      'ar': 'تفضيلات الإشعارات',
      'en': 'Notification preferences'
    },
    'profile.language': {'ar': 'اللغة', 'en': 'Language'},
    'profile.language.sub': {
      'ar': 'اختر لغة الواجهة',
      'en': 'Choose interface language'
    },
    'profile.appearance': {'ar': 'المظهر', 'en': 'Appearance'},
    'profile.appearance.sub': {
      'ar': 'وضع التطبيق (فاتح/غامق)',
      'en': 'App mode (light/dark)'
    },
    'profile.help': {'ar': 'المساعدة والدعم', 'en': 'Help & Support'},
    'profile.help.sub': {
      'ar': 'الأسئلة الشائعة والدعم',
      'en': 'FAQs and support'
    },
    'profile.about': {'ar': 'حول التطبيق', 'en': 'About App'},
    'profile.about.sub': {
      'ar': 'معلومات الإصدار والترخيص',
      'en': 'Version and license info'
    },
    'profile.privacy': {'ar': 'سياسة الخصوصية', 'en': 'Privacy Policy'},
    'profile.privacy.sub': {
      'ar': 'كيف نحمي بياناتك',
      'en': 'How we protect your data'
    },
    'profile.terms': {'ar': 'شروط الاستخدام', 'en': 'Terms of Use'},
    'profile.terms.sub': {
      'ar': 'اقرأ الشروط والأحكام',
      'en': 'Read terms and conditions'
    },
    'profile.logout': {'ar': 'تسجيل الخروج', 'en': 'Logout'},
    'profile.logout.confirm': {
      'ar': 'هل أنت متأكد من تسجيل الخروج؟',
      'en': 'Are you sure you want to logout?'
    },

    // Language dialog
    'lang.title': {'ar': 'اختر اللغة', 'en': 'Choose Language'},
    'lang.ar': {'ar': 'العربية', 'en': 'Arabic'},
    'lang.en': {'ar': 'الإنجليزية', 'en': 'English'},

    // Theme dialog
    'theme.title': {'ar': 'اختر المظهر', 'en': 'Choose Theme'},
    'theme.dark': {'ar': 'الوضع الغامق', 'en': 'Dark Mode'},
    'theme.light': {'ar': 'الوضع الفاتح', 'en': 'Light Mode'},

    // Common
    'common.cancel': {'ar': 'إلغاء', 'en': 'Cancel'},
    'common.confirm': {'ar': 'تأكيد', 'en': 'Confirm'},
    'common.save': {'ar': 'حفظ', 'en': 'Save'},
    'common.back': {'ar': 'رجوع', 'en': 'Back'},

    // Alerts page
    'alerts.title': {'ar': 'التنبيهات', 'en': 'Alerts'},
    'alerts.subtitle': {
      'ar': 'جميع التنبيهات الأمنية والمنبهات',
      'en': 'All security alerts and notifications'
    },
    'alerts.empty': {'ar': 'لا توجد تنبيهات', 'en': 'No alerts'},
    'alerts.empty.sub': {
      'ar': 'لا توجد تنبيهات مطابقة للفلتر',
      'en': 'No alerts match the filter'
    },
    'alerts.mark_all_read': {
      'ar': 'تعليم الكل كمقروء',
      'en': 'Mark all as read'
    },
    'alerts.mark_read': {'ar': 'تعليم كمقروء', 'en': 'Mark as read'},
    'alerts.marked': {
      'ar': 'تم تعليم التنبيه كمقروء',
      'en': 'Alert marked as read'
    },
    'alerts.all_marked': {
      'ar': 'تم تعليم جميع التنبيهات كمقروءة',
      'en': 'All alerts marked as read'
    },
    'alerts.filter.all': {'ar': 'الكل', 'en': 'All'},
    'sev.critical': {'ar': 'حرجة', 'en': 'Critical'},
    'sev.high': {'ar': 'عالية', 'en': 'High'},
    'sev.medium': {'ar': 'متوسطة', 'en': 'Medium'},
    'sev.low': {'ar': 'منخفضة', 'en': 'Low'},
    'sev.info': {'ar': 'معلومات', 'en': 'Info'},

    'time.now': {'ar': 'الآن', 'en': 'Now'},
    'time.min': {'ar': 'د', 'en': 'm'},
    'time.hour': {'ar': 'س', 'en': 'h'},
    'time.day': {'ar': 'ي', 'en': 'd'},
    'time.ago': {'ar': 'منذ', 'en': ''},

    // About page
    'about.title': {'ar': 'حول التطبيق', 'en': 'About App'},
    'about.app_name': {'ar': 'AI Forensic', 'en': 'AI Forensic'},
    'about.tagline': {
      'ar': 'منصة ذكية للتحليل الجنائي الرقمي والاستجابة للحوادث الأمنية',
      'en':
          'Intelligent platform for digital forensic analysis and security incident response'
    },
    'about.version': {'ar': 'الإصدار', 'en': 'Version'},
    'about.build': {'ar': 'رقم البناء', 'en': 'Build'},
    'about.developer': {'ar': 'المطور', 'en': 'Developer'},
    'about.license': {'ar': 'الترخيص', 'en': 'License'},
    'about.contact': {'ar': 'تواصل معنا', 'en': 'Contact us'},
    'about.website': {'ar': 'الموقع الرسمي', 'en': 'Official Website'},
    'about.copyright': {
      'ar': '© 2026 AI Forensic. جميع الحقوق محفوظة.',
      'en': '© 2026 AI Forensic. All rights reserved.'
    },
    'about.features': {'ar': 'المميزات الرئيسية', 'en': 'Key Features'},
    'about.feat1': {
      'ar': 'كشف التهديدات بالذكاء الاصطناعي',
      'en': 'AI-powered threat detection'
    },
    'about.feat2': {
      'ar': 'تحليل جنائي رقمي متقدم',
      'en': 'Advanced digital forensics'
    },
    'about.feat3': {
      'ar': 'استجابة فورية للحوادث',
      'en': 'Real-time incident response'
    },
    'about.feat4': {
      'ar': 'تنبيهات أمنية ذكية',
      'en': 'Smart security alerts'
    },

    // Help page
    'help.title': {'ar': 'المساعدة والدعم', 'en': 'Help & Support'},
    'help.intro': {
      'ar': 'هل تحتاج إلى مساعدة؟ اطّلع على الأسئلة الشائعة أو تواصل معنا',
      'en': 'Need help? Check the FAQs or contact us'
    },
    'help.contact_us': {'ar': 'تواصل مع الدعم', 'en': 'Contact Support'},
    'help.email': {
      'ar': 'support@aiforensic.app',
      'en': 'support@aiforensic.app'
    },
    'help.faq': {'ar': 'الأسئلة الشائعة', 'en': 'Frequently Asked Questions'},
    'help.q1': {
      'ar': 'كيف يمكنني تفعيل المصادقة الثنائية؟',
      'en': 'How do I enable two-factor authentication?'
    },
    'help.a1': {
      'ar':
          'انتقل إلى الإعدادات > الأمان، ثم فعّل خيار "المصادقة الثنائية" واتبع التعليمات لإتمام عملية الإعداد عبر تطبيق المصادقة.',
      'en':
          'Go to Settings > Security, enable "Two-Factor Authentication" and follow the steps to complete setup using your authenticator app.'
    },
    'help.q2': {
      'ar': 'كيف أُغيّر لغة التطبيق؟',
      'en': 'How do I change the app language?'
    },
    'help.a2': {
      'ar':
          'من شاشة "حسابي" اختر "اللغة"، ثم اختر اللغة المفضلة لديك بين العربية والإنجليزية.',
      'en':
          'From the Account screen, tap "Language" and pick your preferred language (Arabic or English).'
    },
    'help.q3': {
      'ar': 'ما الفرق بين مستويات الخطورة؟',
      'en': 'What do the severity levels mean?'
    },
    'help.a3': {
      'ar':
          'حرجة: تتطلب تدخلاً فورياً. عالية: خطر مرتفع. متوسطة: مراقبة دقيقة. منخفضة: تأثير محدود. معلومات: للعلم فقط.',
      'en':
          'Critical: needs immediate action. High: high risk. Medium: needs monitoring. Low: minor impact. Info: informational only.'
    },
    'help.q4': {
      'ar': 'هل بياناتي مشفّرة؟',
      'en': 'Is my data encrypted?'
    },
    'help.a4': {
      'ar':
          'نعم، جميع البيانات يتم تشفيرها أثناء النقل عبر TLS 1.3 وأثناء التخزين باستخدام AES-256.',
      'en':
          'Yes, all data is encrypted in transit via TLS 1.3 and at rest using AES-256.'
    },
    'help.q5': {
      'ar': 'كيف يمكنني تصدير تقرير الحوادث؟',
      'en': 'How can I export an incidents report?'
    },
    'help.a5': {
      'ar':
          'افتح صفحة الحوادث، اختر الفترة الزمنية المطلوبة، ثم اضغط على أيقونة التصدير لاختيار تنسيق PDF أو CSV.',
      'en':
          'Open the Incidents page, select the date range, then tap the export icon to choose PDF or CSV format.'
    },

    // Privacy
    'privacy.title': {'ar': 'سياسة الخصوصية', 'en': 'Privacy Policy'},
    'privacy.last_updated': {
      'ar': 'آخر تحديث: 11 مايو 2026',
      'en': 'Last updated: May 11, 2026'
    },
    'privacy.s1.title': {
      'ar': 'البيانات التي نجمعها',
      'en': 'Data We Collect'
    },
    'privacy.s1.body': {
      'ar':
          'نجمع البيانات اللازمة لتشغيل التطبيق فقط: معلومات الحساب (الاسم والبريد الإلكتروني)، وبيانات الاستخدام (لأغراض تحسين الخدمة)، وسجلات الأمان المتعلقة بحماية حسابك.',
      'en':
          'We collect only the data needed to operate the app: account info (name and email), usage data (to improve the service), and security logs related to your account protection.'
    },
    'privacy.s2.title': {
      'ar': 'كيف نستخدم بياناتك',
      'en': 'How We Use Your Data'
    },
    'privacy.s2.body': {
      'ar':
          'نستخدم بياناتك لتقديم الخدمة، وتحسين الأداء، وكشف التهديدات الأمنية، والتواصل معك حول التحديثات المهمة. لا نبيع بياناتك أبداً لأطراف ثالثة.',
      'en':
          'We use your data to provide the service, improve performance, detect security threats, and contact you about important updates. We never sell your data to third parties.'
    },
    'privacy.s3.title': {'ar': 'حماية البيانات', 'en': 'Data Protection'},
    'privacy.s3.body': {
      'ar':
          'تُشفَّر جميع البيانات باستخدام معايير صناعية (TLS 1.3 للنقل وAES-256 للتخزين)، وتُخزَّن في مراكز بيانات معتمدة بمعيار ISO 27001.',
      'en':
          'All data is encrypted with industry standards (TLS 1.3 in transit, AES-256 at rest) and stored in ISO 27001 certified data centers.'
    },
    'privacy.s4.title': {'ar': 'حقوقك', 'en': 'Your Rights'},
    'privacy.s4.body': {
      'ar':
          'يحق لك الوصول إلى بياناتك، وتعديلها، وطلب حذفها في أي وقت. تواصل معنا عبر البريد الإلكتروني لممارسة هذه الحقوق.',
      'en':
          'You have the right to access, modify, and request deletion of your data at any time. Contact us by email to exercise these rights.'
    },
    'privacy.s5.title': {'ar': 'ملفات تعريف الارتباط', 'en': 'Cookies'},
    'privacy.s5.body': {
      'ar':
          'نستخدم ملفات تعريف ارتباط ضرورية فقط لتشغيل التطبيق وحفظ تفضيلاتك. لا نستخدم ملفات تتبّع إعلانية.',
      'en':
          'We use only essential cookies needed to run the app and save your preferences. We do not use advertising trackers.'
    },

    // Terms
    'terms.title': {'ar': 'شروط الاستخدام', 'en': 'Terms of Use'},
    'terms.intro': {
      'ar':
          'باستخدامك لتطبيق AI Forensic فإنك توافق على الشروط والأحكام التالية:',
      'en':
          'By using the AI Forensic app you agree to the following terms and conditions:'
    },
    'terms.s1.title': {'ar': 'قبول الشروط', 'en': 'Acceptance of Terms'},
    'terms.s1.body': {
      'ar':
          'باستخدامك للتطبيق فإنك تقرّ بأنك قرأت الشروط ووافقت عليها. إذا لم توافق فيرجى عدم استخدام التطبيق.',
      'en':
          'By using the app you confirm that you have read and agreed to the terms. If you do not agree, please do not use the app.'
    },
    'terms.s2.title': {
      'ar': 'الاستخدام المسموح',
      'en': 'Permitted Use'
    },
    'terms.s2.body': {
      'ar':
          'يُستخدم التطبيق للأغراض المشروعة فقط في مجال الأمن السيبراني. يُمنع استخدامه لأي نشاط ضار أو غير قانوني.',
      'en':
          'The app is to be used for legitimate cybersecurity purposes only. Any malicious or unlawful activity is forbidden.'
    },
    'terms.s3.title': {
      'ar': 'مسؤولية المستخدم',
      'en': 'User Responsibility'
    },
    'terms.s3.body': {
      'ar':
          'أنت مسؤول عن الحفاظ على سرية بيانات حسابك، وعن جميع الأنشطة التي تتم من خلاله.',
      'en':
          'You are responsible for keeping your account credentials confidential and for all activity that takes place under your account.'
    },
    'terms.s4.title': {
      'ar': 'الملكية الفكرية',
      'en': 'Intellectual Property'
    },
    'terms.s4.body': {
      'ar':
          'كل المحتوى والشعارات والبرامج داخل التطبيق مملوكة لـ AI Forensic أو مرخّصة لها. لا يجوز نسخها أو إعادة توزيعها.',
      'en':
          'All content, logos, and software in the app are owned by or licensed to AI Forensic. They may not be copied or redistributed.'
    },
    'terms.s5.title': {
      'ar': 'إخلاء المسؤولية',
      'en': 'Disclaimer'
    },
    'terms.s5.body': {
      'ar':
          'يُقدَّم التطبيق "كما هو" دون أي ضمانات صريحة أو ضمنية. لا نتحمّل مسؤولية الأضرار غير المباشرة الناتجة عن الاستخدام.',
      'en':
          'The app is provided "as is" without any warranties express or implied. We are not liable for indirect damages arising from its use.'
    },
    'terms.s6.title': {
      'ar': 'تعديل الشروط',
      'en': 'Changes to Terms'
    },
    'terms.s6.body': {
      'ar':
          'يحق لنا تعديل هذه الشروط في أي وقت. سيتم إخطارك بأي تغييرات جوهرية عبر التطبيق أو البريد الإلكتروني.',
      'en':
          'We may update these terms at any time. Material changes will be communicated via the app or email.'
    },
  };

  static String get(String key, AppLocale locale) {
    final entry = _t[key];
    if (entry == null) return key;
    return entry[locale == AppLocale.ar ? 'ar' : 'en'] ?? key;
  }
}

extension TrRef on WidgetRef {
  String tr(String key) {
    final s = read(settingsProvider);
    return AppStrings.get(key, s.locale);
  }
}
