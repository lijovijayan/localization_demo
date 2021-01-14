import './app.db.dart';
import '../models/i18n.model.dart';
import 'package:sembast/sembast.dart';

class I18NDao {
  static const String I18N_STORE_NAME = 'i18n';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are I18n objects converted to Map
  final _i18nStore = intMapStoreFactory.store(I18N_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(I18N i18n) async {
    await _i18nStore.add(await _db, i18n.toMap());
  }

  Future update(I18N i18n) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.equals('lang', i18n.language));
    await _i18nStore.update(
      await _db,
      i18n.toMap(),
      finder: finder,
    );
  }

  Future delete(I18N i18n) async {
    final finder = Finder(filter: Filter.equals('lang', i18n.language));
    await _i18nStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<I18N>> getAllSortedByLang() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('lang'),
    ]);

    final recordSnapshots = await _i18nStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<I18n> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final i18n = I18N.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      // i18n.id = snapshot.key;
      return i18n;
    }).toList();
  }

  Future<I18N> findOne(String language) async {
    final finder = Finder(filter: Filter.equals('lang', language));
    final recordSnapshots = await _i18nStore.find(
      await _db,
      finder: finder,
    );
    List<I18N> i18ns = recordSnapshots.map((snapshot) {
      final i18n = I18N.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      // i18n.id = snapshot.key;
      return i18n;
    }).toList();
    return i18ns.length > 0 ? i18ns.elementAt(0) : null;
  }
}
