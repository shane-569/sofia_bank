import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class ExpandableFAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const ExpandableFAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _ExpandableFAQItemState createState() => _ExpandableFAQItemState();
}

class _ExpandableFAQItemState extends State<ExpandableFAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.orange,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
            child: Text(widget.answer),
          ),
      ],
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({Key? key}) : super(key: key);

  final List<Map<String, String>> faqs = const [
    {
      'question': 'What is FASTag?',
      'answer':
          'FASTag is an electronic toll collection system in India, operated by the National Highway Authority of India. It is a simple to use, rechargeable tag affixed on the windscreen of your vehicle.'
    },
    {
      'question': 'What are the benefits of FASTag?',
      'answer':
          'Convenience of cashless payment, saves time and fuel, SMS alerts for transactions, online recharge, and environmental benefits.'
    },
    {
      'question': 'What is the Validity of FASTag?',
      'answer': 'FASTag has a validity of 5 years.'
    },
    {
      'question': 'Which all Toll Plaza are ready for FASTag?',
      'answer':
          'More than 700 toll plazas across national and state highways are enabled with FASTag. More are being added regularly.'
    },
    {
      'question': 'What If there is a double deduction of toll charges',
      'answer':
          'You can report double deductions to your tag issuing bank or the toll plaza operator. They will investigate and resolve the issue.'
    },
    {
      'question':
          'What do I do if there is an incorrect deduction of toll charges?',
      'answer':
          'Contact your tag issuing bank or the toll plaza operator with details of the transaction. They will verify and correct the deduction if it was incorrect.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'FAQs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: faqs
                .map((faq) => ExpandableFAQItem(
                      question: faq['question']!,
                      answer: faq['answer']!,
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Still have doubt?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  text: 'Send your query on ',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'fastag@fastag.com',
                      style: TextStyle(
                        color: AppColors.orange, // Or a blue color for links
                        decoration: TextDecoration.underline,
                      ),
                      // TODO: Add functionality to open email client
                    ),
                    TextSpan(
                      text: ', we will revert on your query soon.',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
