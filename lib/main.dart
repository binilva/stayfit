import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GymHomePage());
  }
}

class GymHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          'Gym Management System',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,

        backgroundColor: Colors.indigo[600],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/jym1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                'Are you a Trainer or a Client?',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),

              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Client Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientLoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[600],
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                ),
                child: Text(
                  'Client',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),

              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Trainer Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerLoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                ),
                child: Text(
                  'Trainer',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainerLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<TrainerLoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Login method to handle validation
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, show success
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logging in...')));

      // Navigate to the next page and pass the username
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainerPage(username: _usernameController.text),
        ),
      );
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Navigate to the Create Account page
  void _createAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAccountPageTrainer()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.indigo[600], // AppBar color
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: _validateUsername,
              ),
              SizedBox(height: 16.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 24.0),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 17, color: Colors.white60),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blueGrey[600], // Background col// Text color
                ),
              ),
              SizedBox(height: 16.0),

              // Create Account Button
              TextButton(
                onPressed: _createAccount,
                child: Text('Create a New Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccountPageTrainer extends StatefulWidget {
  @override
  _CreateAccountPageTrainerState createState() =>
      _CreateAccountPageTrainerState();
}

class _CreateAccountPageTrainerState extends State<CreateAccountPageTrainer> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Name validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  // Age validation
  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    int? age = int.tryParse(value);
    if (age == null || age < 18) {
      return 'You must be at least 18 years old';
    }
    return null;
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Create Account method
  void _createAccount() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, show success
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account Created Successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.indigo[600], // AppBar color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: _validateName,
              ),
              SizedBox(height: 16.0),

              // Age Field
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: _validateAge,
              ),
              SizedBox(height: 16.0),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              SizedBox(height: 16.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 24.0),

              // Create Account Button
              ElevatedButton(
                onPressed: _createAccount,
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainerPage extends StatelessWidget {
  final String username;

  TrainerPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer page'),
        centerTitle: true,
        backgroundColor: Colors.indigo[600],
      ),
      body: Stack(
        children: [
          // Container with background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/back1.jpg',
                ), // Replace with your image path
                fit: BoxFit.cover, // Ensure the image covers the entire screen
              ),
            ),
          ),
          // Your scrollable content inside SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Welcome, $username!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ), // Adjust text color to ensure visibility on the background
                  ),
                  SizedBox(height: 50),
                  // Column to display circular buttons one below the other
                  Column(
                    children: [
                      // Circular Pay Button
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Payment Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PayPage()),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.payment,
                          color: Colors.green,
                          label: 'Members',
                          imageurl: "images/members.jpg",
                        ),
                      ),
                      SizedBox(height: 15), // Space between buttons
                      // Circular Exercise Button
                      GestureDetector(
                        onTap: () {
                          // Navigate to Exercise Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExercisePage(),
                            ),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.shopping_cart,
                          color: Colors.blue,
                          label: 'Add Members',
                          imageurl: "images/addmem.png",
                        ),
                      ),
                      SizedBox(height: 15), // Space between buttons
                      // Additional Shop Button 2
                      GestureDetector(
                        onTap: () {
                          // Navigate to Shop Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => button2()),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.shopping_cart,
                          color: Colors.red,
                          label: 'Payment details',
                          imageurl: "images/payment.jpeg",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Shop Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => button2()),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.shopping_cart,
                          color: Colors.yellow,
                          label: 'Attendance',
                          imageurl: "images/attendance.webp",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            width: 100,
            height: 70,
            // Smaller size for the circle button
            child: ElevatedButton(
              onPressed: () {
                // Define your AI button action here
                print("AI Button Pressed!");
              },
              child: Text(
                'AI',
                style: TextStyle(fontSize: 22, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Addmembers extends StatefulWidget {
  @override
  _Addmembers createState() => _Addmembers();
}

class _Addmembers extends State<Addmembers> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Name validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  // Age validation
  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    int? age = int.tryParse(value);
    if (age == null || age < 18) {
      return 'You must be at least 18 years old';
    }
    return null;
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Create Account method
  void _createAccount() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, show success
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account Created Successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: _validateName,
              ),
              SizedBox(height: 16.0),

              // Age Field
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: _validateAge,
              ),
              SizedBox(height: 16.0),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              SizedBox(height: 16.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 24.0),

              // Create Account Button
              ElevatedButton(
                onPressed: _createAccount,
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay for Gym Membership'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Payment Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can make payments for your gym membership.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle payment action here
                  print('Payment Processed');
                },
                child: Text('Proceed with Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Tracker'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Exercise Tracker Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Track your workout routines and exercises here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle exercise action here
                  print('Exercise Started');
                },
                child: Text('Start Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Shop'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class button2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Shop'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class button3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Shop'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class button4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Shop'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientLoginPage extends StatefulWidget {
  @override
  _ClientLoginPageState createState() => _ClientLoginPageState();
}

class _ClientLoginPageState extends State<ClientLoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Login method to handle validation
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, show success
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logging in...')));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClientPage(username: _usernameController.text),
        ),
      );
    }
  }

  // Username validation
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Navigate to the Create Account page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.indigo[600],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: _validateUsername,
              ),
              SizedBox(height: 16.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 24.0),

              // Login Button
              ElevatedButton(onPressed: _login, child: Text('Login')),
              SizedBox(height: 16.0),

              // Create Account Button
            ],
          ),
        ),
      ),
    );
  }
}

class ClientPage extends StatelessWidget {
  final String username;

  ClientPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client page'),
        centerTitle: true,
        backgroundColor: Colors.indigo[600],
      ),
      body: Stack(
        children: [
          // Container with background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/back1.jpg',
                ), // Replace with your image path
                fit: BoxFit.cover, // Ensure the image covers the entire screen
              ),
            ),
          ),
          // Your scrollable content inside SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Welcome, $username!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ), // Adjust text color to ensure visibility on the background
                  ),
                  SizedBox(height: 50),
                  // Column to display circular buttons one below the other
                  Column(
                    children: [
                      // Circular Pay Button
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Payment Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PayPage()),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.payment,
                          color: Colors.green,
                          label: 'Pay',
                          imageurl: "images/payment.jpeg",
                        ),
                      ),
                      SizedBox(height: 15),
                      // Circular Exercise Button
                      GestureDetector(
                        onTap: () {
                          // Navigate to Exercise Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExercisePage(),
                            ),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.fitness_center,
                          color: Colors.orange,
                          label: 'Exercise',
                          imageurl: "images/exercies.jpg",
                        ),
                      ),
                      SizedBox(height: 15),
                      // Circular Shop Button
                      GestureDetector(
                        onTap: () {
                          // Navigate to Shop Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShopPage()),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.shopping_cart,
                          color: Colors.blue,
                          label: 'Shop',
                          imageurl: "images/shop.png",
                        ),
                      ),
                      SizedBox(height: 15),
                      // Additional Shop Button 2
                      GestureDetector(
                        onTap: () {
                          // Navigate to Shop Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => button2()),
                          );
                        },
                        child: CircleButton(
                          icon: Icons.person_2_outlined,
                          color: Colors.red,
                          label: 'Your attendance',
                          imageurl: "images/attendance.webp",
                        ),
                      ),
                      SizedBox(height: 15),

                      // Additional Shop Button 3
                    ],
                  ),
                ],
              ),
            ),
          ),
          // The AI Button that stays fixed at the bottom-right corner
          Positioned(
            bottom: 20,
            right: 20,
            width: 100,
            height: 70,
            // Smaller size for the circle button
            child: ElevatedButton(
              onPressed: () {
                // Define your AI button action here
                print("AI Button Pressed!");
              },
              child: Text(
                'AI',
                style: TextStyle(fontSize: 22, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PayPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pay for Gym Membership')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Payment Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can make payments for your gym membership.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle payment action here
                  print('Payment Processed');
                },
                child: Text('Proceed with Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExercisePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise Tracker')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Exercise Tracker Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Track your workout routines and exercises here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle exercise action here
                  print('Exercise Started');
                },
                child: Text('Start Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gym Shop')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class button7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gym Shop')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class button6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gym Shop')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class button5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gym Shop')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gym Shop Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can shop for gym equipment, merchandise, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle shop action here
                  print('Shopping Started');
                },
                child: Text('Go Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String label;
  final String imageurl;

  CircleButton({
    required this.icon,
    this.color,
    required this.label,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.height,
          // Smaller size for the circle button
          height: MediaQuery.of(context).size.height * .85 / 5,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageurl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(30),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Check if imageUrl is provided, if so show the image, else show the icon
              SizedBox(height: 5),
              Text(label, style: TextStyle(fontSize: 22, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
