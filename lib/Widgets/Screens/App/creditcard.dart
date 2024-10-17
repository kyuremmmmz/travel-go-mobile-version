import 'package:TravelGo/Controllers/paymentIntegration/creditCard.dart';
import 'package:TravelGo/Routes/Routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class Creditcard extends StatelessWidget {
  final String name;
  final int phone;
  final String hotelorplace;
  final String nameoftheplace;
  final int price;
  final int payment;
  const Creditcard({
    super.key,
    required this.name,
    required this.phone,
    required this.hotelorplace,
    required this.nameoftheplace,
    required this.price,
    required this.payment,
    String? origin,
    String? destination,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credit Card Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreditCardFormScreen(
        name: name,
        phone: phone,
        hotelorplace: hotelorplace,
        nameoftheplace: nameoftheplace,
        price: price,
        payment: payment,
      ),
    );
  }
}

class CreditCardFormScreen extends StatefulWidget {
  final String name;
  final int phone;
  final String hotelorplace;
  final String nameoftheplace;
  final int price;
  final int payment;
  const CreditCardFormScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.hotelorplace,
    required this.nameoftheplace,
    required this.price,
    required this.payment,
    String? origin,
    String? destination,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CreditCardFormScreenState createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final cardNumber = TextEditingController();
  final cardHolderName = TextEditingController();
  final expiryDate = TextEditingController();
  final cvvCode = TextEditingController();
  bool isCvvFocused = false;
  bool _value = false;
  bool isPaymentSuccess = false;

  @override
  void dispose() {
    cardNumber.dispose();
    cardHolderName.dispose();
    expiryDate.dispose();
    cvvCode.dispose();
    super.dispose();
  }

  Future<void> creditCard() async {
    await CreditcardBackend().payViaCredit(
      widget.price,
      widget.price,
      widget.hotelorplace,
      widget.name,
      widget.phone,
    );
    if (mounted) {
      setState(() {
        isPaymentSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cvvCodeKey;
    var expiryDateKey;
    var cardHolderKey;
    var cardNumberKey;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber.text,
              expiryDate: expiryDate.text,
              cardHolderName: cardHolderName.text,
              cvvCode: cvvCode.text,
              showBackView: isCvvFocused,
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              onCreditCardWidgetChange: (CreditCardBrand) {},
              enableFloatingCard: true,
              bankName: 'BDO',
              obscureCardNumber: true,
              obscureInitialCardNumber: false,
              obscureCardCvv: true,
              cardType: CardType.mastercard,
              isHolderNameVisible: true,
              height: 175,
              textStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              width: MediaQuery.of(context).size.width,
              isChipVisible: true,
              isSwipeGestureEnabled: true,
              animationDuration: const Duration(milliseconds: 1000),
              frontCardBorder: Border.all(color: Colors.grey),
              backCardBorder: Border.all(color: Colors.grey),
              chipColor: Colors.red,
              padding: 16,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  formKey: _formKey,
                  onCreditCardModelChange: onCreditCardModelChange,
                  cardNumber: '',
                  expiryDate: '',
                  cardHolderName: '',
                  cvvCode: '',
                  cardNumberKey: cardNumberKey,
                  cvvCodeKey: cvvCodeKey,
                  expiryDateKey: expiryDateKey,
                  cardHolderKey: cardHolderKey,
                  obscureCvv: true,
                  obscureNumber: true,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  enableCvv: true,
                  cvvValidationMessage: 'Please input a valid CVV',
                  dateValidationMessage: 'Please input a valid date',
                  numberValidationMessage: 'Please input a valid number',
                  cardNumberValidator: (String? cardNumber) {
                    return null;
                  },
                  expiryDateValidator: (String? expiryDate) {
                    return null;
                  },
                  cvvValidator: (String? cvv) {
                    return null;
                  },
                  cardHolderValidator: (String? cardHolderName) {
                    return null;
                  },
                  onFormComplete: () {},
                  autovalidateMode: AutovalidateMode.always,
                  disableCardNumberAutoFillHints: false,
                  inputConfiguration: const InputConfiguration(
                    cardNumberDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder',
                    ),
                    cardNumberTextStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                    cardHolderTextStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                    expiryDateTextStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                    cvvCodeTextStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL AMOUNT: ${widget.price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'PHP ${widget.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color.fromRGBO(5, 103, 180, 1),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Theme(
              data: ThemeData(
                checkboxTheme: const CheckboxThemeData(
                  shape: CircleBorder(),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: ListTileTheme(
                  horizontalTitleGap: 0.0,
                  child: CheckboxListTile(
                    activeColor: Colors.green,
                    title: RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text:
                              "I have reviewed my transaction details and agree to the ",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        TextSpan(
                          text: "Terms of Service.",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                AppRoutes.navigateToForgotPassword(context),
                        ),
                      ]),
                    ),
                    value: _value,
                    onChanged: (bool? value) {
                      setState(() {
                        _value = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: _value
                    ? () {
                        creditCard();
                      }
                    : null,
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber.text = creditCardModel.cardNumber;
      expiryDate.text = creditCardModel.expiryDate;
      cardHolderName.text = creditCardModel.cardHolderName;
      cvvCode.text = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
