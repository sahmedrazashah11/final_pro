import 'package:flutter/material.dart';

class OrderProgressBar extends StatefulWidget {
  final int currentStep;
  final Function(int) onUpdate;

  const OrderProgressBar({
    Key? key,
    required this.currentStep,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _OrderProgressBarState createState() => _OrderProgressBarState();
}

class _OrderProgressBarState extends State<OrderProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: widget.currentStep / 6, // Assuming 5 steps in total
          color: Colors.blue, // Customize the color as needed
          backgroundColor: Colors.grey,
        ),
        SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStepText("Order Pending", 1),
            _buildStepText("Order Accept", 2),
            _buildStepText("In Process", 3),
            _buildStepText("Waiting Payment", 4),
            _buildStepText("Shipment", 5),
            _buildStepText("Order Complete", 6),
          ],
        ),
      ],
    );
  }

  Widget _buildStepText(String text, int stepNumber) {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          color: stepNumber <= widget.currentStep ? Colors.green : Colors.grey,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 6,
            color:
                stepNumber <= widget.currentStep ? Colors.black : Colors.grey,
            fontWeight: stepNumber <= widget.currentStep
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Method to update the current step
  void updateCurrentStep(int newStep) {
    setState(() {
      widget.onUpdate(newStep);
    });
  }
}

class OrderStatusPage extends StatefulWidget {
  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  int currentStep = 3;

  // GlobalKey to access the OrderProgressBar state
  final GlobalKey<_OrderProgressBarState> progressBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderProgressBar(
          key: progressBarKey,
          currentStep: currentStep,
          onUpdate: (newStep) {
            setState(() {
              currentStep = newStep;
            });
          },
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Simulate a change in order status
            currentStep = (currentStep % 6) + 1;

            // Access the OrderProgressBarState directly using the GlobalKey
            progressBarKey.currentState?.updateCurrentStep(currentStep);
          },
          child: Text('Update Order Status'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
      ),
      body: Center(
        child: OrderStatusPage(),
      ),
    ),
  ));
}
