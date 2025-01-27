import 'package:flutter/material.dart';

class CommonTable extends StatelessWidget {
  const CommonTable(
      {super.key,
      required this.data,
      required this.titles,
      required this.onPressed});

  final List<String> titles;
  final List<dynamic> data;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return DataTable(rows: rows, columns: columns);
  }

  /* rows */
  List<DataRow> get rows => List.generate(
        data.length,
        (index) => DataRow(
          cells: List.generate(
            data[index].length,
            (position) {
              if (titles[position].toLowerCase().contains("image") &&
                  data[index][position].toString() != "null" &&
                  data[index][position].toString().isNotEmpty) {
                return DataCell(Image(
                    width: 100,
                    height: 100,
                    image: NetworkImage(data[index][position])));
              } else {
                return DataCell(
                  Text(data[index][position]),
                  onTap: () {
                    onPressed(index);
                  },
                );
              }
            },
          ),
        ),
      );

  /* columns */
  List<DataColumn> get columns => List.generate(titles.length,
      (index) => DataColumn(label: Text(titles[index], softWrap: true)));
}
