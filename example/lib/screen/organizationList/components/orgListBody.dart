import 'package:browsr_example/screen/organizationList/components/orgList.dart';
import 'package:browsr_example/screen/organizationList/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrganizationListService _serivce =
        Provider.of<OrganizationListService>(context, listen: false);
    return Column(
      children: [
        TextField(
          controller: _serivce.searchController,
          onChanged: (value) {
            _serivce.updateDisplayList();
          },
          decoration: const InputDecoration(
              label: Padding(
            padding: EdgeInsets.all(8),
            child: Text("Search"),
          )),
        ),
        InkWell(
          onTap: () {
            _serivce.sortList();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Sort"),
                SizedBox(width: 8),
                Icon(
                  Icons.sort_by_alpha,
                  size: 20,
                )
              ],
            ),
          ),
        ),
        const Expanded(child: OrgList()),
      ],
    );
  }
}
