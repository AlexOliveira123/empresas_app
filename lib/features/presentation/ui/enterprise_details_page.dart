import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_typography.dart';
import '../../domain/entities/enterprise_entity.dart';

class EnterpriseDetailsPage extends StatelessWidget {
  final EnterpriseEntity enterprise;

  const EnterpriseDetailsPage({Key? key, required this.enterprise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppIcons.leftIcon.icon(
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppColors.whiteColor,
        title: Text(
          enterprise.name,
          style: h6.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              '${dotenv.env['serverUrl']}${enterprise.photo}',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                enterprise.description,
                style: body1.copyWith(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
