// import 'package:logishield/core/database/database_helper.dart';
// import 'package:logishield/features/logistics/parcel/data/datasources/parcel_local_data_source.dart';
// import 'package:logishield/features/logistics/parcel/data/models/parcel_model.dart';
// import 'package:sqflite/sqflite.dart';

// class ParcelLocalDataSourceImpl implements ParcelLocalDataSource {
//   final DatabaseHelper databaseHelper;

//   ParcelLocalDataSourceImpl(this.databaseHelper);

//   @override
//   Future<List<ParcelModel>> getParcels() async {
//     return [];
//   }

//   @override
//   Future<void> replaceParcels(List<ParcelModel> parcels) async {
//     final db = await databaseHelper.database;

//     await db.transaction((txn) async {
//       await txn.delete('parcels');

//       for (final parcel in parcels) {
//         await txn.insert(
//           'parcels',
//           parcel.toJson(),
//           conflictAlgorithm: ConflictAlgorithm.replace,
//         );
//       }
//     });
//   }
// }
