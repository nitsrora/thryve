import 'package:browsr_example/core/model/organizationModel.dart';
import 'package:flutter/material.dart';

class OrgListTile extends StatefulWidget {
  final OrganizationModel _org;
  const OrgListTile(this._org);

  @override
  State<OrgListTile> createState() => _OrgListTileState();
}

class _OrgListTileState extends State<OrgListTile> {
  @override
  Widget build(BuildContext context) {
    return (widget._org.name != null)
        ? InkWell(
            onTap: () => setState(() {
              widget._org.toggleIsFav();
            }),
            child: ListTile(
              leading: Image.network(
                widget._org.avatartUrl ?? "",
                width: 20,
                height: 20,
              ),
              title: Text(widget._org.name ?? ""),
              trailing: Icon(
                Icons.favorite,
                color: (widget._org.isFav) ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
          )
        : const SizedBox();
  }
}
