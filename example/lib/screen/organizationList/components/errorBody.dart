import 'package:browsr_example/screen/organizationList/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrganizationListService _service =
        Provider.of<OrganizationListService>(context, listen: false);
    return Column(
      children: [
        const Text("Error Occurred"),
        Text(
          _service.errorReason ?? "",
          maxLines: 5,
        ),
        InkWell(
          onTap: () => _service.init(),
          child: const Text("Retry"),
        )
      ],
    );
  }
}
