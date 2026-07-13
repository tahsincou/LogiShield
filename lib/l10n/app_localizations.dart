import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'LogiShield'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @parcels.
  ///
  /// In en, this message translates to:
  /// **'Parcels'**
  String get parcels;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @totalParcels.
  ///
  /// In en, this message translates to:
  /// **'Total Parcels'**
  String get totalParcels;

  /// No description provided for @delayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get delayed;

  /// No description provided for @inTransit.
  ///
  /// In en, this message translates to:
  /// **'In Transit'**
  String get inTransit;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @delayedParcels.
  ///
  /// In en, this message translates to:
  /// **'Delayed Parcels'**
  String get delayedParcels;

  /// No description provided for @requiresAction.
  ///
  /// In en, this message translates to:
  /// **'{count} requires action'**
  String requiresAction(int count);

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @searchParcelHint.
  ///
  /// In en, this message translates to:
  /// **'Search tracking, customer, phone or carrier'**
  String get searchParcelHint;

  /// No description provided for @delayedOnly.
  ///
  /// In en, this message translates to:
  /// **'Delayed only'**
  String get delayedOnly;

  /// No description provided for @parcelCount.
  ///
  /// In en, this message translates to:
  /// **'{count} parcels'**
  String parcelCount(int count);

  /// No description provided for @noParcelsFound.
  ///
  /// In en, this message translates to:
  /// **'No parcels found'**
  String get noParcelsFound;

  /// No description provided for @parcelsAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your parcels will appear here.'**
  String get parcelsAppearHere;

  /// No description provided for @loadingParcels.
  ///
  /// In en, this message translates to:
  /// **'Loading parcels...'**
  String get loadingParcels;

  /// No description provided for @addParcel.
  ///
  /// In en, this message translates to:
  /// **'Add Parcel'**
  String get addParcel;

  /// No description provided for @editParcel.
  ///
  /// In en, this message translates to:
  /// **'Edit Parcel'**
  String get editParcel;

  /// No description provided for @createParcel.
  ///
  /// In en, this message translates to:
  /// **'Create Parcel'**
  String get createParcel;

  /// No description provided for @updateParcel.
  ///
  /// In en, this message translates to:
  /// **'Update Parcel'**
  String get updateParcel;

  /// No description provided for @parcelDetails.
  ///
  /// In en, this message translates to:
  /// **'Parcel Details'**
  String get parcelDetails;

  /// No description provided for @trackingId.
  ///
  /// In en, this message translates to:
  /// **'Tracking ID'**
  String get trackingId;

  /// No description provided for @carrier.
  ///
  /// In en, this message translates to:
  /// **'Carrier'**
  String get carrier;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @codAmount.
  ///
  /// In en, this message translates to:
  /// **'COD Amount'**
  String get codAmount;

  /// No description provided for @customerInformation.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInformation;

  /// No description provided for @parcelInformation.
  ///
  /// In en, this message translates to:
  /// **'Parcel Information'**
  String get parcelInformation;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @delayStatus.
  ///
  /// In en, this message translates to:
  /// **'Delay Status'**
  String get delayStatus;

  /// No description provided for @onSchedule.
  ///
  /// In en, this message translates to:
  /// **'On Schedule'**
  String get onSchedule;

  /// No description provided for @delayAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Delay Analysis'**
  String get delayAnalysis;

  /// No description provided for @elapsedTime.
  ///
  /// In en, this message translates to:
  /// **'Elapsed Time'**
  String get elapsedTime;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'{count} hours'**
  String hours(int count);

  /// No description provided for @delayedByHours.
  ///
  /// In en, this message translates to:
  /// **'Delayed by {count} hours'**
  String delayedByHours(int count);

  /// No description provided for @carrierRule.
  ///
  /// In en, this message translates to:
  /// **'Carrier Rule'**
  String get carrierRule;

  /// No description provided for @hourThreshold.
  ///
  /// In en, this message translates to:
  /// **'{count}-hour threshold'**
  String hourThreshold(int count);

  /// No description provided for @noRuleConfigured.
  ///
  /// In en, this message translates to:
  /// **'No rule configured'**
  String get noRuleConfigured;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @highValueParcel.
  ///
  /// In en, this message translates to:
  /// **'High-value COD parcel'**
  String get highValueParcel;

  /// No description provided for @deleteParcel.
  ///
  /// In en, this message translates to:
  /// **'Delete Parcel'**
  String get deleteParcel;

  /// No description provided for @deleteParcelConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this parcel?'**
  String get deleteParcelConfirmation;

  /// No description provided for @parcelCreated.
  ///
  /// In en, this message translates to:
  /// **'Parcel created successfully'**
  String get parcelCreated;

  /// No description provided for @parcelUpdated.
  ///
  /// In en, this message translates to:
  /// **'Parcel updated successfully'**
  String get parcelUpdated;

  /// No description provided for @parcelDeleted.
  ///
  /// In en, this message translates to:
  /// **'Parcel deleted successfully'**
  String get parcelDeleted;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @pickedUp.
  ///
  /// In en, this message translates to:
  /// **'Picked Up'**
  String get pickedUp;

  /// No description provided for @sortingHub.
  ///
  /// In en, this message translates to:
  /// **'Sorting Hub'**
  String get sortingHub;

  /// No description provided for @outForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for Delivery'**
  String get outForDelivery;

  /// No description provided for @returned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get returned;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn': return AppLocalizationsBn();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
