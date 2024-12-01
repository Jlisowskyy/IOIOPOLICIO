import 'package:flutter/material.dart';
import '../models/data_model.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      child: const Row(
        children: [
          Expanded(
            child: Text(
              AppDataModel.adText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            AppDataModel.adSubtext,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          )
        ],
      ),
    );
  }
}
