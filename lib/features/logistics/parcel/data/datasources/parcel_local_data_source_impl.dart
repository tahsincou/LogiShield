import 'package:logishield/core/database/database_helper.dart';
import 'package:logishield/features/logistics/parcel/data/datasources/parcel_local_data_source.dart';
import 'package:logishield/features/logistics/parcel/data/models/parcel_model.dart';
import 'package:sqflite/sqflite.dart';

class ParcelLocalDataSourceImpl implements ParcelLocalDataSource {
  final DatabaseHelper databaseHelper;

  ParcelLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<ParcelModel>> getParcels() async {
    final db = await databaseHelper.database;

    final rows = await db.query('parcels', orderBy: 'lastUpdated DESC');

    return rows.map((row) {
      return ParcelModel.fromJson({...row, 'isDelayed': row['isDelayed'] == 1});
    }).toList();
  }

  @override
  Future<void> replaceParcels(List<ParcelModel> parcels) async {
    final db = await databaseHelper.database;

    await db.transaction((txn) async {
      await txn.delete('parcels');

      for (final parcel in parcels) {
        final json = parcel.toJson();

        await txn.insert('parcels', {
          ...json,
          'isDelayed': parcel.isDelayed ? 1 : 0,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }
}
