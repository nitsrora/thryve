import 'package:browsr_example/core/model/organizationModel.dart';
import 'package:browsr_example/screen/organizationList/components/orgListTile.dart';
import 'package:browsr_example/screen/organizationList/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgList extends StatelessWidget {
  const OrgList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrganizationListService _serivce =
        Provider.of<OrganizationListService>(context, listen: true);
    return ListView.builder(
      itemCount: _serivce.displayList.length,
      itemBuilder: (context, index) {
        OrganizationModel _org = _serivce.displayList.elementAt(index);
        return OrgListTile(_org);
      },
    );
  }
}
