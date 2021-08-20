import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../domain/entities/enterprise_entity.dart';

class EnterpriseIntem extends StatelessWidget {
  final Function() onTap;
  final EnterpriseEntity enterprise;

  const EnterpriseIntem({
    Key? key,
    required this.enterprise,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: NetworkImage(
                '${dotenv.env['serverUrl']}${enterprise.photo}',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              enterprise.name.toUpperCase(),
              style: h5.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
