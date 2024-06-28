import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ElevatedButtonFill extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  const ElevatedButtonFill({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: const Color(0xDA071E38),
        minimumSize: const Size.fromHeight(54.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
      child: loading
          ? const SpinKitThreeBounce(
              color: Colors.white,
              size: 20.0,
            )
          : Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
            ),
    );
  }
}
