import 'fb_respone.dart';

mixin FirebaseHelper {
  FbResponse get successResponse =>
      FbResponse('Operation completed successfully', true);

  FbResponse get errorResponse => FbResponse('Operation failed', false);
}
