import 'package:flutter/material.dart';

/// A custom widget to display loading state
///
/// Provides a standardized loading UI across the application
class LoadingWidget extends StatelessWidget {
  final String? message;

  /// Creates a loading widget
  ///
  /// [message] optional message to display while loading
  const LoadingWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
