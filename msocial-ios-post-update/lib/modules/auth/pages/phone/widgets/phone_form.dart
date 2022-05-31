import 'package:countries/countries.dart';
import 'package:flutter/material.dart';

import '../../../../../imports.dart';

class PhoneFormWidget extends StatefulWidget {
  final TextEditingController codeController;
  final TextEditingController phoneController;
  final Rx<Country> country;
  const PhoneFormWidget({
    Key? key,
    required this.codeController,
    required this.phoneController,
    required this.country,
  }) : super(key: key);

  @override
  _PhoneFormWidgetState createState() => _PhoneFormWidgetState();
}

class _PhoneFormWidgetState extends State<PhoneFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      constraints: BoxConstraints(maxWidth: 400),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          //Phone Code
          SizedBox(
            width: 75,
            child: TextFormField(
              controller: widget.codeController,
              keyboardType: TextInputType.number,
              maxLength: 3,
              decoration: InputDecoration(
                counter: SizedBox.shrink(),
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 30,
                      child: GestureDetector(
                        onTap: () => showCountriesBottomSheet(
                          context,
                          onValuePicked: (v) {
                            widget.codeController.text = v.phoneCode;
                            widget.country(v);
                          },
                        ),
                        child: Obx(
                          () => CountryFlagWidget(widget.country()),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Align(alignment: Alignment(0, -10), child: Text('+'))
                  ],
                ),
              ),
              onChanged: (str) {
                if (str.length == 3) {
                  FocusScope.of(context).nextFocus();
                }
                widget.country(
                  CountriesRepo.getCountryByPhoneCode(
                    str,
                    Country(),
                  ),
                );
              },
            ),
          ),

          SizedBox(width: 12),
          //Phone Number Main TextField
          Expanded(
            child: TextFormField(
              controller: widget.phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counter: SizedBox.shrink(),
                hintText: t.PhoneNumber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
