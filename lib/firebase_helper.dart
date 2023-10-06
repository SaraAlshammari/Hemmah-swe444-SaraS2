import 'fb_respone.dart';

mixin FirebaseHelper {
  FbResponse get successResponse =>
      FbResponse('Job is posted successfully', true);

  FbResponse get errorResponse => FbResponse('Operation failed', false);
}
