// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `language`
  String get language {
    return Intl.message('language', name: 'language', desc: '', args: []);
  }

  /// `log out`
  String get sign_out {
    return Intl.message('log out', name: 'sign_out', desc: '', args: []);
  }

  /// `choose language`
  String get choose_language {
    return Intl.message(
      'choose language',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `Market`
  String get market {
    return Intl.message('Market', name: 'market', desc: '', args: []);
  }

  /// `quantity`
  String get quantity {
    return Intl.message('quantity', name: 'quantity', desc: '', args: []);
  }

  /// `DC by closest`
  String get distributions_centers_by_closest {
    return Intl.message(
      'DC by closest',
      name: 'distributions_centers_by_closest',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message('name', name: 'name', desc: '', args: []);
  }

  /// `location`
  String get location {
    return Intl.message('location', name: 'location', desc: '', args: []);
  }

  /// `sales type`
  String get sales_type {
    return Intl.message('sales type', name: 'sales_type', desc: '', args: []);
  }

  /// `products of DC`
  String get products_of_distribution_center {
    return Intl.message(
      'products of DC',
      name: 'products_of_distribution_center',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message('price', name: 'price', desc: '', args: []);
  }

  /// `details`
  String get details {
    return Intl.message('details', name: 'details', desc: '', args: []);
  }

  /// `my_invoices`
  String get my_invoices {
    return Intl.message('my_invoices', name: 'my_invoices', desc: '', args: []);
  }

  /// `reserve`
  String get reserve {
    return Intl.message('reserve', name: 'reserve', desc: '', args: []);
  }

  /// `transferred`
  String get transferred {
    return Intl.message('transferred', name: 'transferred', desc: '', args: []);
  }

  /// `un transferred`
  String get un_transferred {
    return Intl.message(
      'un transferred',
      name: 'un_transferred',
      desc: '',
      args: [],
    );
  }

  /// `with accept`
  String get with_accept {
    return Intl.message('with accept', name: 'with_accept', desc: '', args: []);
  }

  /// `add to cart`
  String get add_to_cart {
    return Intl.message('add to cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `loads`
  String get loads {
    return Intl.message('loads', name: 'loads', desc: '', args: []);
  }

  /// `accept`
  String get accept {
    return Intl.message('accept', name: 'accept', desc: '', args: []);
  }

  /// `wait`
  String get wait {
    return Intl.message('wait', name: 'wait', desc: '', args: []);
  }

  /// `ok`
  String get ok {
    return Intl.message('ok', name: 'ok', desc: '', args: []);
  }

  /// `quantity not available`
  String get quantity_not_available {
    return Intl.message(
      'quantity not available',
      name: 'quantity_not_available',
      desc: '',
      args: [],
    );
  }

  /// `invoice`
  String get invoice {
    return Intl.message('invoice', name: 'invoice', desc: '', args: []);
  }

  /// `number`
  String get number {
    return Intl.message('number', name: 'number', desc: '', args: []);
  }

  /// `status`
  String get status {
    return Intl.message('status', name: 'status', desc: '', args: []);
  }

  /// `type`
  String get type {
    return Intl.message('type', name: 'type', desc: '', args: []);
  }

  /// `load`
  String get load_keyword {
    return Intl.message('load', name: 'load_keyword', desc: '', args: []);
  }

  /// `vehicle id`
  String get vehicle_id {
    return Intl.message('vehicle id', name: 'vehicle_id', desc: '', args: []);
  }

  /// `delete`
  String get delete {
    return Intl.message('delete', name: 'delete', desc: '', args: []);
  }

  /// `edit`
  String get edit {
    return Intl.message('edit', name: 'edit', desc: '', args: []);
  }

  /// `product`
  String get product {
    return Intl.message('product', name: 'product', desc: '', args: []);
  }

  /// `desciption`
  String get desciption {
    return Intl.message('desciption', name: 'desciption', desc: '', args: []);
  }

  /// `no loads found`
  String get no_loads_found {
    return Intl.message(
      'no loads found',
      name: 'no_loads_found',
      desc: '',
      args: [],
    );
  }

  /// `no invoices found`
  String get no_invoices_found {
    return Intl.message(
      'no invoices found',
      name: 'no_invoices_found',
      desc: '',
      args: [],
    );
  }

  /// `field is required`
  String get field_is_required {
    return Intl.message(
      'field is required',
      name: 'field_is_required',
      desc: '',
      args: [],
    );
  }

  /// `quantity  is invalid`
  String get quantity_is_invalid {
    return Intl.message(
      'quantity  is invalid',
      name: 'quantity_is_invalid',
      desc: '',
      args: [],
    );
  }

  /// `reserved load`
  String get reserved_load {
    return Intl.message(
      'reserved load',
      name: 'reserved_load',
      desc: '',
      args: [],
    );
  }

  /// `unit`
  String get unit {
    return Intl.message('unit', name: 'unit', desc: '', args: []);
  }

  /// `import cycle`
  String get import_cycle {
    return Intl.message(
      'import cycle',
      name: 'import_cycle',
      desc: '',
      args: [],
    );
  }

  /// `lowest temperature`
  String get lowest_temperature {
    return Intl.message(
      'lowest temperature',
      name: 'lowest_temperature',
      desc: '',
      args: [],
    );
  }

  /// `highest temperature`
  String get highest_temperature {
    return Intl.message(
      'highest temperature',
      name: 'highest_temperature',
      desc: '',
      args: [],
    );
  }

  /// `lowest humidity`
  String get lowest_humidity {
    return Intl.message(
      'lowest humidity',
      name: 'lowest_humidity',
      desc: '',
      args: [],
    );
  }

  /// `highest humidity`
  String get highest_humidity {
    return Intl.message(
      'highest humidity',
      name: 'highest_humidity',
      desc: '',
      args: [],
    );
  }

  /// `lowest light`
  String get lowest_light {
    return Intl.message(
      'lowest light',
      name: 'lowest_light',
      desc: '',
      args: [],
    );
  }

  /// `highest light`
  String get highest_light {
    return Intl.message(
      'highest light',
      name: 'highest_light',
      desc: '',
      args: [],
    );
  }

  /// `lowest pressure`
  String get lowest_pressure {
    return Intl.message(
      'lowest pressure',
      name: 'lowest_pressure',
      desc: '',
      args: [],
    );
  }

  /// `highest pressure`
  String get highest_pressure {
    return Intl.message(
      'highest pressure',
      name: 'highest_pressure',
      desc: '',
      args: [],
    );
  }

  /// `lowest ventilation`
  String get lowest_ventilation {
    return Intl.message(
      'lowest ventilation',
      name: 'lowest_ventilation',
      desc: '',
      args: [],
    );
  }

  /// `highest ventilation`
  String get highest_ventilation {
    return Intl.message(
      'highest ventilation',
      name: 'highest_ventilation',
      desc: '',
      args: [],
    );
  }

  /// `actual load`
  String get actual_load {
    return Intl.message('actual load', name: 'actual_load', desc: '', args: []);
  }

  /// `transferred load`
  String get transferred_load {
    return Intl.message(
      'transferred load',
      name: 'transferred_load',
      desc: '',
      args: [],
    );
  }

  /// `can transfer`
  String get can_transfer {
    return Intl.message(
      'can transfer',
      name: 'can_transfer',
      desc: '',
      args: [],
    );
  }

  /// `min Capacity to transfer`
  String get min_Capacity_to_transfer {
    return Intl.message(
      'min Capacity to transfer',
      name: 'min_Capacity_to_transfer',
      desc: '',
      args: [],
    );
  }

  /// `piece price`
  String get piece_price {
    return Intl.message('piece price', name: 'piece_price', desc: '', args: []);
  }

  /// `choose location`
  String get choose_location {
    return Intl.message(
      'choose location',
      name: 'choose_location',
      desc: '',
      args: [],
    );
  }

  /// `Permission to access location is denied. Please enable it in settings.`
  String
  get Permission_to_access_location_is_denied_Please_enable_it_in_settings {
    return Intl.message(
      'Permission to access location is denied. Please enable it in settings.',
      name:
          'Permission_to_access_location_is_denied_Please_enable_it_in_settings',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
