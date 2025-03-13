abstract class MyAssetsEvent {}

class LoadUserAssets extends MyAssetsEvent {}

class DeleteUserAsset extends MyAssetsEvent {
  final String assetId;

  DeleteUserAsset(this.assetId);
}
