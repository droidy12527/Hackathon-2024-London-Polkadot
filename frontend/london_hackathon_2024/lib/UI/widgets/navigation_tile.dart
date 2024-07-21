import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationTile extends StatelessWidget {
  final Function() click;
  final String title;
  final String description;
  final IconData iconData;
  const NavigationTile(
      {super.key, required this.click, required this.title, required this.description, required this.iconData});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;

    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
        child: ListTile(
          onTap: () {
            click();
          },
          title: Row(
            children: [
              Icon(
                iconData,
                color: primaryColor,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      maxLines: 10,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
