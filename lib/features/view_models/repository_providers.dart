import 'package:flutter_firebase/features/repository/authentication_repo.dart' show AuthenticationRepo;
import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;
import '../../core/top_level_providers/top_level_providers.dart';
import '../repository/authentication_repo_impl.dart';

final authenticationRepoProvider = Provider.autoDispose<AuthenticationRepo>((ref) {
  final database = ref.read(databaseProvider);
  return AuthenticationRepoImpl(database: database);
});
