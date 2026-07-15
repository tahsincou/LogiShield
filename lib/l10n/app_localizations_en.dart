// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'LogiShield';

  @override
  String get login => 'Login';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get parcels => 'Parcels';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get overview => 'Overview';

  @override
  String get totalParcels => 'Total Parcels';

  @override
  String get delayed => 'Delayed';

  @override
  String get inTransit => 'In Transit';

  @override
  String get delivered => 'Delivered';

  @override
  String get delayedParcels => 'Delayed Parcels';

  @override
  String requiresAction(int count) {
    return '$count requires action';
  }

  @override
  String get viewAll => 'View all';

  @override
  String get searchParcelHint => 'Search tracking, customer, phone or carrier';

  @override
  String get delayedOnly => 'Delayed only';

  @override
  String parcelCount(int count) {
    return '$count parcels';
  }

  @override
  String get noParcelsFound => 'No parcels found';

  @override
  String get parcelsAppearHere => 'Your parcels will appear here.';

  @override
  String get loadingParcels => 'Loading parcels...';

  @override
  String get addParcel => 'Add Parcel';

  @override
  String get editParcel => 'Edit Parcel';

  @override
  String get createParcel => 'Create Parcel';

  @override
  String get updateParcel => 'Update Parcel';

  @override
  String get parcelDetails => 'Parcel Details';

  @override
  String get trackingId => 'Tracking ID';

  @override
  String get carrier => 'Carrier';

  @override
  String get customerName => 'Customer';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get codAmount => 'COD Amount';

  @override
  String get customerInformation => 'Customer Information';

  @override
  String get parcelInformation => 'Parcel Information';

  @override
  String get lastUpdated => 'Last Updated';

  @override
  String get delayStatus => 'Delay Status';

  @override
  String get onSchedule => 'On Schedule';

  @override
  String get delayAnalysis => 'Delay Analysis';

  @override
  String get elapsedTime => 'Elapsed Time';

  @override
  String hours(int count) {
    return '$count hours';
  }

  @override
  String delayedByHours(int count) {
    return 'Delayed by $count hours';
  }

  @override
  String get carrierRule => 'Carrier Rule';

  @override
  String hourThreshold(int count) {
    return '$count-hour threshold';
  }

  @override
  String get noRuleConfigured => 'No rule configured';

  @override
  String get priority => 'Priority';

  @override
  String get highValueParcel => 'High-value COD parcel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteParcel => 'Delete Parcel';

  @override
  String get deleteParcelConfirmation => 'Are you sure you want to delete this parcel?';

  @override
  String get parcelCreated => 'Parcel created successfully';

  @override
  String get parcelUpdated => 'Parcel updated successfully';

  @override
  String get parcelDeleted => 'Parcel deleted successfully';

  @override
  String get retry => 'Retry';

  @override
  String get pending => 'Pending';

  @override
  String get pickedUp => 'Picked Up';

  @override
  String get sortingHub => 'Sorting Hub';

  @override
  String get outForDelivery => 'Out for Delivery';

  @override
  String get returned => 'Returned';

  @override
  String get failed => 'Failed';

  @override
  String get all => 'All';

  @override
  String get offlineMode => 'Offline mode';

  @override
  String get showingCachedData => 'Showing saved parcel data';

  @override
  String get onlineMode => 'Online';

  @override
  String get refresh => 'Refresh';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get invalidEmail => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get loginSubtitle => 'Delayed parcel monitoring for faster operational action.';

  @override
  String get loginInstruction => 'Enter your account details to continue.';

  @override
  String get delayedParcelMonitor => 'Delayed Parcel Monitor';

  @override
  String get invalidCredentials => 'Invalid email or password.';

  @override
  String get requestTimedOut => 'The request timed out. Please try again.';

  @override
  String get connectionFailed => 'Unable to connect to the server. Check your connection.';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get timelineCreated => 'Created';

  @override
  String get timelinePickedUp => 'Picked Up';

  @override
  String get timelineArrivedAtHub => 'Arrived at Hub';

  @override
  String get timelineOutForDelivery => 'Out for Delivery';

  @override
  String get timelineDelivered => 'Delivered';

  @override
  String get pendingStatus => 'Pending';

  @override
  String get carrierPathao => 'Pathao';

  @override
  String get carrierSteadfast => 'Steadfast';

  @override
  String get carrierRedX => 'RedX';

  @override
  String get carrierECourier => 'eCourier';

  @override
  String get carrierPaperfly => 'Paperfly';
}
