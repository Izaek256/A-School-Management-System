import 'package:flutter/material.dart';

class AppTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final List<double>? columnWidths;

  const AppTable({
    super.key,
    required this.headers,
    required this.rows,
    this.columnWidths,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        horizontalMargin: 20,
        headingRowColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(0.1)),
        columns: headers.map((header) => DataColumn(
          label: Text(
            header,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )).toList(),
        rows: rows.map((row) => DataRow(
          cells: row.map((cell) => DataCell(Text(cell))).toList(),
        )).toList(),
      ),
    );
  }
}