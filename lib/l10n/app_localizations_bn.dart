// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'লজিশিল্ড';

  @override
  String get login => 'লগইন';

  @override
  String get dashboard => 'ড্যাশবোর্ড';

  @override
  String get parcels => 'পার্সেল';

  @override
  String get settings => 'সেটিংস';

  @override
  String get logout => 'লগআউট';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get cancel => 'বাতিল';

  @override
  String get theme => 'থিম';

  @override
  String get system => 'সিস্টেম';

  @override
  String get light => 'লাইট';

  @override
  String get dark => 'ডার্ক';

  @override
  String get language => 'ভাষা';

  @override
  String get overview => 'সারসংক্ষেপ';

  @override
  String get totalParcels => 'মোট পার্সেল';

  @override
  String get delayed => 'বিলম্বিত';

  @override
  String get inTransit => 'পরিবহনাধীন';

  @override
  String get delivered => 'ডেলিভারি সম্পন্ন';

  @override
  String get delayedParcels => 'বিলম্বিত পার্সেল';

  @override
  String requiresAction(int count) {
    return '$countটি পার্সেলে ব্যবস্থা প্রয়োজন';
  }

  @override
  String get viewAll => 'সব দেখুন';

  @override
  String get searchParcelHint => 'ট্র্যাকিং, গ্রাহক, ফোন বা কুরিয়ার খুঁজুন';

  @override
  String get delayedOnly => 'শুধু বিলম্বিত';

  @override
  String parcelCount(int count) {
    return '$countটি পার্সেল';
  }

  @override
  String get noParcelsFound => 'কোনো পার্সেল পাওয়া যায়নি';

  @override
  String get parcelsAppearHere => 'আপনার পার্সেলগুলো এখানে দেখা যাবে।';

  @override
  String get loadingParcels => 'পার্সেল লোড হচ্ছে...';

  @override
  String get addParcel => 'পার্সেল যোগ করুন';

  @override
  String get editParcel => 'পার্সেল সম্পাদনা';

  @override
  String get createParcel => 'পার্সেল তৈরি করুন';

  @override
  String get updateParcel => 'পার্সেল হালনাগাদ করুন';

  @override
  String get parcelDetails => 'পার্সেলের বিস্তারিত';

  @override
  String get trackingId => 'ট্র্যাকিং আইডি';

  @override
  String get carrier => 'কুরিয়ার';

  @override
  String get customerName => 'গ্রাহক';

  @override
  String get phone => 'ফোন';

  @override
  String get address => 'ঠিকানা';

  @override
  String get codAmount => 'ক্যাশ অন ডেলিভারি';

  @override
  String get customerInformation => 'গ্রাহকের তথ্য';

  @override
  String get parcelInformation => 'পার্সেলের তথ্য';

  @override
  String get lastUpdated => 'সর্বশেষ হালনাগাদ';

  @override
  String get delayStatus => 'বিলম্বের অবস্থা';

  @override
  String get onSchedule => 'সময়সূচি অনুযায়ী';

  @override
  String get delayAnalysis => 'বিলম্ব বিশ্লেষণ';

  @override
  String get elapsedTime => 'অতিবাহিত সময়';

  @override
  String hours(int count) {
    return '$count ঘণ্টা';
  }

  @override
  String delayedByHours(int count) {
    return '$count ঘণ্টা বিলম্বিত';
  }

  @override
  String get carrierRule => 'কুরিয়ার নিয়ম';

  @override
  String hourThreshold(int count) {
    return '$count ঘণ্টার সীমা';
  }

  @override
  String get noRuleConfigured => 'কোনো নিয়ম নির্ধারিত নেই';

  @override
  String get priority => 'অগ্রাধিকার';

  @override
  String get highValueParcel => 'উচ্চমূল্যের COD পার্সেল';

  @override
  String get delete => 'মুছুন';

  @override
  String get deleteParcel => 'পার্সেল মুছুন';

  @override
  String get deleteParcelConfirmation => 'আপনি কি নিশ্চিতভাবে এই পার্সেলটি মুছতে চান?';

  @override
  String get parcelCreated => 'পার্সেল সফলভাবে তৈরি হয়েছে';

  @override
  String get parcelUpdated => 'পার্সেল সফলভাবে হালনাগাদ হয়েছে';

  @override
  String get parcelDeleted => 'পার্সেল সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get pending => 'অপেক্ষমাণ';

  @override
  String get pickedUp => 'সংগ্রহ করা হয়েছে';

  @override
  String get sortingHub => 'সর্টিং হাবে';

  @override
  String get outForDelivery => 'ডেলিভারির জন্য বের হয়েছে';

  @override
  String get returned => 'ফেরত';

  @override
  String get failed => 'ব্যর্থ';

  @override
  String get all => 'সব';

  @override
  String get offlineMode => 'অফলাইন মোড';

  @override
  String get showingCachedData => 'সংরক্ষিত পার্সেল তথ্য দেখানো হচ্ছে';

  @override
  String get onlineMode => 'অনলাইন';

  @override
  String get refresh => 'রিফ্রেশ';

  @override
  String get email => 'ইমেইল';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get emailRequired => 'ইমেইল লিখুন';

  @override
  String get invalidEmail => 'সঠিক ইমেইল লিখুন';

  @override
  String get passwordRequired => 'পাসওয়ার্ড লিখুন';

  @override
  String get loginSubtitle => 'দ্রুত ব্যবস্থা নেওয়ার জন্য বিলম্বিত পার্সেল পর্যবেক্ষণ করুন।';

  @override
  String get loginInstruction => 'চালিয়ে যেতে আপনার অ্যাকাউন্টের তথ্য দিন।';

  @override
  String get delayedParcelMonitor => 'বিলম্বিত পার্সেল মনিটর';

  @override
  String get invalidCredentials => 'ইমেইল অথবা পাসওয়ার্ড সঠিক নয়।';

  @override
  String get requestTimedOut => 'অনুরোধের সময় শেষ হয়েছে। আবার চেষ্টা করুন।';

  @override
  String get connectionFailed => 'সার্ভারের সঙ্গে সংযোগ করা যায়নি। সংযোগ পরীক্ষা করুন।';

  @override
  String get genericError => 'কিছু সমস্যা হয়েছে। আবার চেষ্টা করুন।';

  @override
  String get timelineCreated => 'তৈরি হয়েছে';

  @override
  String get timelinePickedUp => 'সংগ্রহ করা হয়েছে';

  @override
  String get timelineArrivedAtHub => 'হাবে পৌঁছেছে';

  @override
  String get timelineOutForDelivery => 'ডেলিভারির জন্য বের হয়েছে';

  @override
  String get timelineDelivered => 'ডেলিভারি সম্পন্ন';

  @override
  String get pendingStatus => 'অপেক্ষমাণ';

  @override
  String get carrierPathao => 'পাঠাও';

  @override
  String get carrierSteadfast => 'স্টেডফাস্ট';

  @override
  String get carrierRedX => 'রেডএক্স';

  @override
  String get carrierECourier => 'ই-কুরিয়ার';

  @override
  String get carrierPaperfly => 'পেপারফ্লাই';
}
