import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:london_hackathon_2024/Core/Services/Authorisation.dart';
import 'package:london_hackathon_2024/UI/views/auditmenu/accident_registry.dart';
import 'package:london_hackathon_2024/UI/views/auditmenu/car_registry.dart';
import 'package:london_hackathon_2024/UI/views/auditmenu/maintanance_registry.dart';
import 'package:london_hackathon_2024/UI/views/auditmenu/transfer_ownership.dart';
import 'package:london_hackathon_2024/UI/widgets/navigation_tile.dart';
import 'package:provider/provider.dart';

class AuditView extends StatefulWidget {
  const AuditView({super.key});

  @override
  State<AuditView> createState() => _AuditViewState();
}

class _AuditViewState extends State<AuditView> {
  void logOut() async {
    await AuthService.signOut();
  }

  void navigateToCarRegistry() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CarRegistryView(),
      ),
    );
  }

  void navigateToAddMaintanance() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CarMaintananceView(),
      ),
    );
  }

  void navigateToOwnerTransferShip() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransferOwnerShipView(),
      ),
    );
  }

  void navigateToReportAccident() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AccidentRegistryView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;

    var secondaryColor = Theme.of(context).colorScheme.secondary;
    var backgroundColor = Theme.of(context).colorScheme.background;
    var tetriaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              NavigationTile(
                click: navigateToCarRegistry,
                title: "Car Registry",
                description: "Register a car in Carnet Network\n",
                iconData: Icons.car_rental,
              ),
              const SizedBox(
                height: 20,
              ),
              NavigationTile(
                click: navigateToAddMaintanance,
                title: "Maintanance Registry",
                description: "Register a maintanance event in Carnet Network",
                iconData: Icons.construction,
              ),
              const SizedBox(
                height: 20,
              ),
              NavigationTile(
                click: navigateToReportAccident,
                title: "Accident Registry",
                description: "Register a traffic accident in Carnet Network",
                iconData: Icons.car_crash,
              ),
              const SizedBox(
                height: 20,
              ),
              NavigationTile(
                click: navigateToOwnerTransferShip,
                title: "Transfer Ownership",
                description: "Transfer ownership of a car to a different owner in Carnet Network",
                iconData: Icons.gavel,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
