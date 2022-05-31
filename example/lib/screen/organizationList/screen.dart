import 'package:browsr_example/constants/widget/loadingWidget.dart';
import 'package:browsr_example/screen/organizationList/components/errorBody.dart';
import 'package:browsr_example/screen/organizationList/components/orgListBody.dart';
import 'package:browsr_example/screen/organizationList/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrganizationListService(),
      child: Consumer(
        builder: (context, OrganizationListService service, child) {
          switch (service.status) {
            case OrganizationListStatus.loading:
              return loadingWidget();
            case OrganizationListStatus.screen:
              return OrgListBody();
            default:
              return ErrorBody();
          }
        },
      ),
    );
  }
}
