import 'package:flutter/material.dart';
import '../models/stepmodel.dart';
import '../utils/constants.dart';
import '../widgets/apptext_widget.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_textfield_widget.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _field1Controller = TextEditingController();
  final _field2Controller = TextEditingController();

  int _currentStep = 0;

  final List<StepModel> _steps = [
    StepModel(title: "Create New Campaign", subtitle: "Fill out these details and get your campaign ready"),
    StepModel(title: "Create Segments", subtitle: "Get full control over your audience"),
    StepModel(title: "Bidding Strategy", subtitle: "Optimize your campaign reach with AdSense"),
    StepModel(title: "Site links", subtitle: "Set up your customer journey flow"),
    StepModel(title: "Review Campaign", subtitle: "Double check your campaign is ready to go!"),
  ];

  bool _isToggle1 = false;
  bool _isToggle2 = false;

  void _nextStep() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        if (_currentStep < _steps.length - 1) {
          _currentStep++;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      print('Form submitted!');
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Field 1: ${_field1Controller.text}');
      print('Field 2: ${_field2Controller.text}');
      print('Toggle 1: $_isToggle1');
      print('Toggle 2: $_isToggle2');
    }
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the available width to decide the layout for mobile/web
          bool isMobile = constraints.maxWidth < 600; // Define mobile view threshold

          return Row(
            children: [
            
              Expanded(
                flex: isMobile ? 1 : 2,  // Use more space on larger screens (web/tablet)
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.horizontalPadding,
                    vertical: Constants.verticalPadding
                  ),
                  child: Card(
                    child: Padding(
                      padding:const  EdgeInsets.all(8),
                        
                      child: SingleChildScrollView(  // Added to make the content scrollable
                        child: Form(
                          key: _formKey,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Subtitle
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText(
                                    text: "Create New Email Campaign",
                                    textsize: Constants.titleFontSize,
                                  ),
                                 
                              AppText(
                                text: "Fill out these details to build your broadcast",
                                textsize: Constants.subtitleFontSize,
                              ),
                                ],
                              ),
                             
                              SizedBox(height: Constants.verticalPadding),
                             
                              CustomInput(
                                label: 'Campaign Subject',
                                controller: _nameController,
                                validator: (value) =>
                                    value?.isEmpty ?? true ? 'Please enter the subject' : null,
                              ),
                              SizedBox(height: Constants.fieldSpacing),
                              CustomInput(
                                label: 'Preview Text',
                                helpertext: "Keep this simple (around 50 characters)",
                                controller: _emailController,
                                maximumLines: 5,
                                validator: (value) => value?.isEmpty ?? true ? 'Please enter preview text' : null,
                              ),
                              SizedBox(height: Constants.fieldSpacing),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomInput(
                                      label: '"From" Name',
                                      controller: _field1Controller,
                                      validator: (value) => value?.isEmpty ?? true ? 'Please enter Field 1' : null,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CustomInput(
                                      label: '"From" Email',
                                      controller: _field2Controller,
                                      validator: (value) => value?.isEmpty ?? true ? 'Please enter Field 2' : null,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Constants.fieldSpacing),
                             
                              SwitchListTile(
                                activeColor: Colors.orange,
                                inactiveThumbColor: Colors.grey,
                                activeTrackColor: Colors.orange.shade200,
                                inactiveTrackColor: Colors.grey.shade300,
                                title: Text('Run only once per customer'),
                                value: _isToggle1,
                                onChanged: (value) {
                                  setState(() {
                                    _isToggle1 = value;
                                  });
                                },
                              ),
                              SwitchListTile(
                                activeColor: Colors.orange,
                                inactiveThumbColor: Colors.grey,
                                activeTrackColor: Colors.orange.shade200,
                                inactiveTrackColor: Colors.grey.shade300,
                                title: Text('Custom audience'),
                                value: _isToggle2,
                                onChanged: (value) {
                                  setState(() {
                                    _isToggle2 = value;
                                  });
                                },
                              ),
                              SizedBox(height: Constants.verticalPadding),
                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      text: "Save Draft",
                                      buttonColor: Colors.grey,
                                      onPressed: _submitForm,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 2,
                                    child: CustomButton(
                                      text: _currentStep==4?"Submit":"Next Step",
                                      buttonColor: Colors.orange,
                                      onPressed: _nextStep,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              
              if (!isMobile) 
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: Constants.verticalPadding
                    ),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: ListView.builder(
                          itemCount: _steps.length,
                          itemBuilder: (context, index) {
                            final step = _steps[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _currentStep == index ? Colors.orange : Colors.white,
                                child: Text("${index + 1}"),
                                radius: 20,
                              ),
                              title: Text(step.title),
                              subtitle: Text(step.subtitle),
                              onTap: () {
                                setState(() {
                                  _currentStep = index;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
