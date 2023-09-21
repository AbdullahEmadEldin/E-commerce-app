import 'package:e_commerce_app/business_logic_layer/user_preferences_cubit/user_perferences_cubit.dart';
import 'package:e_commerce_app/data_layer/Models/address_model.dart';
import 'package:e_commerce_app/Utilities/ArgsModels/add_address_args.dart';
import 'package:e_commerce_app/Utilities/api_paths.dart';
import 'package:e_commerce_app/Utilities/routes.dart';
import 'package:e_commerce_app/data_layer/repository/firestore_repo.dart';
import 'package:e_commerce_app/view/Pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressTile extends StatefulWidget {
  final ShippingAddress address;
  final bool inViewPage;

  const AddressTile({Key? key, required this.address, this.inViewPage = false})
      : super(key: key);

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  late bool isDefault;
  @override
  void initState() {
    super.initState();
    isDefault = widget.address.isDefault;
  }

  @override
  Widget build(BuildContext context) {
    // final database = Provider.of<Repository>(context);

    return BlocProvider.value(
      value: BlocProvider.of<UserPrefCubit>(context),
      child: Card(
        key: Key(widget.address.id),
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
                    widget.address.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                      onTap: () {
                        widget.inViewPage
                            ? Navigator.of(context).pushNamed(
                                AppRoutes.addAddressPage,
                                arguments: widget.address)
                            : Navigator.of(context).pushNamed(
                                AppRoutes.viewAddressesPage,
                                // arguments: database
                              );
                      },
                      child: Text(
                        widget.inViewPage ? 'Edit' : 'Change',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.red),
                      ))
                ],
              ),
              const SizedBox(height: 8),
              Text(widget.address.address),
              Text(
                  '${widget.address.city}, ${widget.address.state} ${widget.address.postalCode}, ${widget.address.country}'),
              widget.inViewPage
                  ? BlocListener<UserPrefCubit, UserPrefState>(
                      listener: (context, state) {
                        if (state is SaveAddressSucess) {
                          context.read<UserPrefCubit>().getAllAddress();
                        }
                      },
                      child: CheckboxListTile.adaptive(
                        title: const Text('Default Shipping address'),
                        value: isDefault,
                        onChanged: (newValue) async {
                          setState(() {
                            isDefault = newValue!;
                          });

                          //TODO: logic of making one default address
                          final defaultAddress =
                              widget.address.copyWith(isDefault: newValue);
                          await BlocProvider.of<UserPrefCubit>(context,
                                  listen: false)
                              .saveUserAddress(defaultAddress);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
