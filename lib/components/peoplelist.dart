import 'package:flutter/material.dart';

class PeopleList extends StatefulWidget {
  PeopleList({
    super.key,
    required this.pictures,
    required this.names,
  });

  final List<String> pictures;
  final List<String> names;

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < widget.pictures.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 35.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: Image.asset(
                      widget.pictures[i],
                      fit: BoxFit.cover,
                      height: 200,
                      width: 175,
                    ),
                  ),
                  Text(widget.names[i])
                ],
              ),
            )
        ],
      ),
    );
  }
}
