import 'package:flutter/material.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Full name',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                    onTap: () {},
                    child: Text(
                      'change',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.red),
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Text('detailed address st. block'),
            Text('city,  Postal code, country')
          ],
        ),
      ),
    );
  }
}
