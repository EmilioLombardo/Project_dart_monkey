import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminMakeEventPage extends StatefulWidget {
  final String? eventId;

  AdminMakeEventPage({this.eventId});

  @override
  _AdminMakeEventPageState createState() => _AdminMakeEventPageState();
}

class _AdminMakeEventPageState extends State<AdminMakeEventPage> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  // Controllers for form fields
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _registrationOpenDateController = TextEditingController();
  final TextEditingController _registrationOpenTimeController = TextEditingController();
  final TextEditingController _registrationCloseDateController = TextEditingController();
  final TextEditingController _registrationCloseTimeController = TextEditingController();
  final TextEditingController _numberOfSpotsController = TextEditingController();
  final TextEditingController _openForController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _cancellationPolicyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _paymentDetailsController = TextEditingController();
  final TextEditingController _locationDetailsController = TextEditingController();
  final TextEditingController _mapLinkController = TextEditingController();
  final TextEditingController _dressCodeController = TextEditingController();
  final TextEditingController _foodAndDrinksController = TextEditingController();
  final TextEditingController _activitiesController = TextEditingController();
  final TextEditingController _sponsorsController = TextEditingController();
  final TextEditingController _photographerController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.eventId != null) {
      _loadEventData();
    }
  }

  void _loadEventData() async {
    DocumentSnapshot eventDoc = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .get();

    if (eventDoc.exists) {
      var data = eventDoc.data() as Map<String, dynamic>;
      _nameController.text = data['name'] ?? '';
      _descriptionController.text = data['description'] ?? '';
      _imageController.text = data['imageUrl'] ?? '';
      _placeController.text = data['place'] ?? '';
      _startDateController.text = data['startDate'] ?? '';
      _startTimeController.text = data['startTime'] ?? '';
      _endDateController.text = data['endDate'] ?? '';
      _endTimeController.text = data['endTime'] ?? '';
      _registrationOpenDateController.text = data['registrationOpenDate'] ?? '';
      _registrationOpenTimeController.text = data['registrationOpenTime'] ?? '';
      _registrationCloseDateController.text = data['registrationCloseDate'] ?? '';
      _registrationCloseTimeController.text = data['registrationCloseTime'] ?? '';
      _numberOfSpotsController.text = data['numberOfSpots'] ?? '';
      _openForController.text = data['openFor'] ?? '';
      _typeController.text = data['type'] ?? '';
      _categoryController.text = data['category'] ?? '';
      _hostController.text = data['host'] ?? '';
      _contactEmailController.text = data['contactEmail'] ?? '';
      _contactPhoneController.text = data['contactPhone'] ?? '';
      _cancellationPolicyController.text = data['cancellationPolicy'] ?? '';
      _priceController.text = data['price'] ?? '';
      _paymentDetailsController.text = data['paymentDetails'] ?? '';
      _locationDetailsController.text = data['locationDetails'] ?? '';
      _mapLinkController.text = data['mapLink'] ?? '';
      _dressCodeController.text = data['dressCode'] ?? '';
      _foodAndDrinksController.text = data['foodAndDrinks'] ?? '';
      _activitiesController.text = data['activities'] ?? '';
      _sponsorsController.text = data['sponsors'] ?? '';
      _photographerController.text = data['photographer'] ?? '';
      _rulesController.text = data['rules'] ?? '';
      _accountNumberController.text = data['accountNumber'] ?? '';
    }
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final eventData = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'imageUrl': _imageController.text,
        'place': _placeController.text,
        'startDate': _startDateController.text,
        'startTime': _startTimeController.text,
        'endDate': _endDateController.text,
        'endTime': _endTimeController.text,
        'registrationOpenDate': _registrationOpenDateController.text,
        'registrationOpenTime': _registrationOpenTimeController.text,
        'registrationCloseDate': _registrationCloseDateController.text,
        'registrationCloseTime': _registrationCloseTimeController.text,
        'numberOfSpots': _numberOfSpotsController.text,
        'openFor': _openForController.text,
        'type': _typeController.text,
        'category': _categoryController.text,
        'host': _hostController.text,
        'contactEmail': _contactEmailController.text,
        'contactPhone': _contactPhoneController.text,
        'cancellationPolicy': _cancellationPolicyController.text,
        'price': _priceController.text,
        'paymentDetails': _paymentDetailsController.text,
        'locationDetails': _locationDetailsController.text,
        'mapLink': _mapLinkController.text,
        'dressCode': _dressCodeController.text,
        'foodAndDrinks': _foodAndDrinksController.text,
        'activities': _activitiesController.text,
        'sponsors': _sponsorsController.text,
        'photographer': _photographerController.text,
        'rules': _rulesController.text,
        'accountNumber': _accountNumberController.text,
      };

      if (widget.eventId != null) {
        FirebaseFirestore.instance
            .collection('events')
            .doc(widget.eventId)
            .update(eventData);
      } else {
        final newDoc = FirebaseFirestore.instance.collection('events').doc();
        newDoc.set({
          'uid': newDoc.id,
          'createdAt': FieldValue.serverTimestamp(),
          ...eventData,
        });
      }

      Navigator.pop(context);
    }
  }

  void _createEvent() {
    if (_formKey.currentState!.validate()) {
      final newDoc = FirebaseFirestore.instance.collection('events').doc();
      final eventData = {
        'uid': newDoc.id,
        'name': _nameController.text,
        'description': _descriptionController.text,
        'imageUrl': _imageController.text,
        'place': _placeController.text,
        'startDate': _startDateController.text,
        'startTime': _startTimeController.text,
        'endDate': _endDateController.text,
        'endTime': _endTimeController.text,
        'registrationOpenDate': _registrationOpenDateController.text,
        'registrationOpenTime': _registrationOpenTimeController.text,
        'registrationCloseDate': _registrationCloseDateController.text,
        'registrationCloseTime': _registrationCloseTimeController.text,
        'numberOfSpots': _numberOfSpotsController.text,
        'openFor': _openForController.text,
        'type': _typeController.text,
        'category': _categoryController.text,
        'host': _hostController.text,
        'contactEmail': _contactEmailController.text,
        'contactPhone': _contactPhoneController.text,
        'cancellationPolicy': _cancellationPolicyController.text,
        'price': _priceController.text,
        'paymentDetails': _paymentDetailsController.text,
        'locationDetails': _locationDetailsController.text,
        'mapLink': _mapLinkController.text,
        'dressCode': _dressCodeController.text,
        'foodAndDrinks': _foodAndDrinksController.text,
        'activities': _activitiesController.text,
        'sponsors': _sponsorsController.text,
        'photographer': _photographerController.text,
        'rules': _rulesController.text,
        'accountNumber': _accountNumberController.text,
        'createdAt': FieldValue.serverTimestamp(),
      };

      newDoc.set(eventData);

      Navigator.pop(context);
    }
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventId != null ? 'Edit Event' : 'Create Event'),
        backgroundColor: Color(0xFF1045A6),
        actions: widget.eventId != null
            ? [
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: _saveEvent,
                ),
              ]
            : [],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildBasicInformationPage(),
                    _buildTimingPage(),
                    _buildRegistrationPage(),
                    _buildContactDetailsPage(),
                    _buildEventDetailsPage(),
                    _buildSummaryPage(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInformationPage() {
    return _buildPage(
      title: 'Basic Information',
      children: [
        _buildTextField(_nameController, 'Name'),
        _buildTextField(_descriptionController, 'Description'),
        _buildTextField(_imageController, 'Image URL'),
        _buildTextField(_placeController, 'Place'),
      ],
      onNext: _nextPage,
    );
  }

  Widget _buildTimingPage() {
    return _buildPage(
      title: 'Timing',
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(_startDateController, 'Start Date')),
            SizedBox(width: 10),
            Expanded(child: _buildTextField(_startTimeController, 'Start Time')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildTextField(_endDateController, 'End Date')),
            SizedBox(width: 10),
            Expanded(child: _buildTextField(_endTimeController, 'End Time')),
          ],
        ),
      ],
      onNext: _nextPage,
      onPrevious: _previousPage,
    );
  }

  Widget _buildRegistrationPage() {
    return _buildPage(
      title: 'Registration',
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(_registrationOpenDateController, 'Open Date')),
            SizedBox(width: 10),
            Expanded(child: _buildTextField(_registrationOpenTimeController, 'Open Time')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildTextField(_registrationCloseDateController, 'Close Date')),
            SizedBox(width: 10),
            Expanded(child: _buildTextField(_registrationCloseTimeController, 'Close Time')),
          ],
        ),
        _buildTextField(_numberOfSpotsController, 'Number of Spots', keyboardType: TextInputType.number),
        _buildTextField(_openForController, 'Open For'),
      ],
      onNext: _nextPage,
      onPrevious: _previousPage,
    );
  }

  Widget _buildContactDetailsPage() {
    return _buildPage(
      title: 'Contact Details',
      children: [
        _buildTextField(_hostController, 'Host'),
        _buildTextField(_contactEmailController, 'Contact Email'),
        _buildTextField(_contactPhoneController, 'Contact Phone'),
        _buildTextField(_locationDetailsController, 'Location Details'),
        _buildTextField(_mapLinkController, 'Map Link'),
        _buildTextField(_paymentDetailsController, 'Payment Details'),
        _buildTextField(_priceController, 'Price', keyboardType: TextInputType.number),
        _buildTextField(_accountNumberController, 'Account Number', keyboardType: TextInputType.number),
      ],
      onNext: _nextPage,
      onPrevious: _previousPage,
    );
  }

  Widget _buildEventDetailsPage() {
    return _buildPage(
      title: 'Event Details',
      children: [
        _buildTextField(_typeController, 'Type'),
        _buildTextField(_categoryController, 'Category'),
        _buildTextField(_cancellationPolicyController, 'Cancellation Policy'),
        _buildTextField(_dressCodeController, 'Dress Code'),
        _buildTextField(_foodAndDrinksController, 'Food and Drinks'),
        _buildTextField(_activitiesController, 'Activities'),
        _buildTextField(_sponsorsController, 'Sponsors'),
        _buildTextField(_photographerController, 'Photographer'),
        _buildTextField(_rulesController, 'Rules'),
      ],
      onNext: _nextPage,
      onPrevious: _previousPage,
    );
  }

  Widget _buildSummaryPage() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSummaryTile('Name', _nameController.text),
                  _buildSummaryTile('Description', _descriptionController.text),
                  _buildSummaryTile('Image URL', _imageController.text),
                  _buildSummaryTile('Place', _placeController.text),
                  _buildSummaryTile('Start Date', _startDateController.text),
                  _buildSummaryTile('Start Time', _startTimeController.text),
                  _buildSummaryTile('End Date', _endDateController.text),
                  _buildSummaryTile('End Time', _endTimeController.text),
                  _buildSummaryTile('Registration Open Date', _registrationOpenDateController.text),
                  _buildSummaryTile('Registration Open Time', _registrationOpenTimeController.text),
                  _buildSummaryTile('Registration Close Date', _registrationCloseDateController.text),
                  _buildSummaryTile('Registration Close Time', _registrationCloseTimeController.text),
                  _buildSummaryTile('Number of Spots', _numberOfSpotsController.text),
                  _buildSummaryTile('Open For', _openForController.text),
                  _buildSummaryTile('Host', _hostController.text),
                  _buildSummaryTile('Contact Email', _contactEmailController.text),
                  _buildSummaryTile('Contact Phone', _contactPhoneController.text),
                  _buildSummaryTile('Location Details', _locationDetailsController.text),
                  _buildSummaryTile('Map Link', _mapLinkController.text),
                  _buildSummaryTile('Payment Details', _paymentDetailsController.text),
                  _buildSummaryTile('Price', _priceController.text),
                  _buildSummaryTile('Account Number', _accountNumberController.text),
                  _buildSummaryTile('Type', _typeController.text),
                  _buildSummaryTile('Category', _categoryController.text),
                  _buildSummaryTile('Cancellation Policy', _cancellationPolicyController.text),
                  _buildSummaryTile('Dress Code', _dressCodeController.text),
                  _buildSummaryTile('Food and Drinks', _foodAndDrinksController.text),
                  _buildSummaryTile('Activities', _activitiesController.text),
                  _buildSummaryTile('Sponsors', _sponsorsController.text),
                  _buildSummaryTile('Photographer', _photographerController.text),
                  _buildSummaryTile('Rules', _rulesController.text),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  child: Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1045A6),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                if (widget.eventId != null)
                  ElevatedButton(
                    onPressed: _saveEvent,
                    child: Text('Save Event'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1045A6),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                if (widget.eventId == null)
                  ElevatedButton(
                    onPressed: _createEvent,
                    child: Text('Create Event'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1045A6),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required List<Widget> children,
    void Function()? onNext,
    void Function()? onPrevious,
  }) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...children,
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onPrevious != null)
                  ElevatedButton(
                    onPressed: onPrevious,
                    child: Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1045A6),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                if (onNext != null)
                  ElevatedButton(
                    onPressed: onNext,
                    child: Text('Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1045A6),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildSummaryTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
