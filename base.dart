///APP
// ignore_for_file: avoid_print

import 'dart:io';
import 'package:project1/constants.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:async';

bool isLoggedIn = false;
bool isAdmin = false;
bool endApp = false;
bool hasAccountBool = false;
bool reloadApp = true;

class AdminAccounts extends Admin {
  String? accountName;
  late String _username;
  late String _password;

  void loginVerification(Admin admin) {
    print('Input your username: ');
    _username = stdin.readLineSync() ?? 'noUser';
    print('Input your password: ');
    _password = stdin.readLineSync()!;

    //Cryptographic Hash Function of Bitcoin - SHA256
    var hmacSha256 = Hmac(sha256, utf8.encode(_username));
    var digest = hmacSha256.convert(utf8.encode(_password));
    _password = digest.toString();

    if (adminAccounts.containsKey(_username)) {
      if (adminAccounts[_username] == _password) {
        isLoggedIn = true;
        isAdmin = true;
      }
    } else {
      print('Invalid username/password');
    }
  }

  void registerAdmin(Admin admin) {
    AdminAccounts adminAccount = AdminAccounts();
    accountName = admin.name;
    print('Input your username(6-16 characters): ');
    adminAccount._username = stdin.readLineSync()!;

    while (adminAccount._username.split('').length > 16 || adminAccount._username.split('').length < 6) {
      print('Username invalid.\nInput your username(6-16 characters): ');
      adminAccount._username = stdin.readLineSync()!;
    }

    bool isNotUnique = adminAccounts.containsKey(adminAccount._username);

    while (isNotUnique) {
      print('Username is already used. Please choose another username: ');
      adminAccount._username = stdin.readLineSync()!;
      isNotUnique = adminAccounts.containsKey(adminAccount._username);
    }
    print('Username accepted!');

    print('Input your password(8-24 characters): ');
    adminAccount._password = stdin.readLineSync()!;

    while (adminAccount._password.split('').length > 24 || adminAccount._password.split('').length < 8) {
      print('Password invalid.\nInput your password(8-16 characters): ');
      adminAccount._password = stdin.readLineSync()!;
    }
    //print(adminAccount._password);   For testing
    print('Password accepted');
    adminAccounts[adminAccount._username] = adminAccount._password;
    //print(adminAccounts); For testing
    print('Employee account created!');

    var hmacSha256 = Hmac(sha256, utf8.encode(adminAccount._username));
    var digest = hmacSha256.convert(utf8.encode(adminAccount._password));

    adminAccount._password = digest.toString();
    //print(adminAccount._password); For testing
    adminAccounts[adminAccount._username] = adminAccount._password;
    //print(adminAccounts); For testing
  }

  //DONE
  bool loginVerificationAdmin(Admin admin) {
    print('Input your username: ');
    _username = stdin.readLineSync() ?? 'noUser';
    print('Input your password: ');
    _password = stdin.readLineSync()!;

    var hmacSha256 = Hmac(sha256, utf8.encode(_username));
    var digest = hmacSha256.convert(utf8.encode(_password));
    _password = digest.toString();

    if (adminAccounts.containsKey(_username)) {
      if (adminAccounts[_username] == _password) {
        isLoggedIn = true;
        print('Login successful!');
        return true;
      }
      return false;
    } else {
      print('Invalid username/password');
      return false;
    }
  }
}

class Accounts extends Employee {
  String? accountName;
  late String _username;
  late String _password;

  //Register Employee - DONE
  void register(Employee employee) {
    Accounts account = Accounts();
    accountName = employee.name;
    print('Input your username(6-16 characters): ');
    account._username = stdin.readLineSync()!;

    while (account._username.split('').length > 16 || account._username.split('').length < 6) {
      print('Username invalid.\nInput your username(6-16 characters): ');
      account._username = stdin.readLineSync()!;
    }

    bool isNotUnique = accounts.containsKey(account._username);

    while (isNotUnique) {
      print('Username is already used. Please choose another username: ');
      account._username = stdin.readLineSync()!;
      isNotUnique = accounts.containsKey(account._username);
    }
    print('Username accepted!');

    print('Input your password(8-24 characters): ');
    account._password = stdin.readLineSync()!;

    while (account._password.split('').length > 24 || account._password.split('').length < 8) {
      print('Password invalid.\nInput your password(8-16 characters): ');
      account._password = stdin.readLineSync()!;
    }
    //print(account._password);   For testing
    print('Password accepted');
    accounts[account._username] = account._password;
    //print(accounts); For testing
    print('Employee account created!');

    var hmacSha256 = Hmac(sha256, utf8.encode(account._username));
    var digest = hmacSha256.convert(utf8.encode(account._password));

    account._password = digest.toString();
    //print(account._password); For testing
    accounts[account._username] = account._password;
    //print(accounts); For testing
  }

  //DONE!
  bool loginVerification(Employee employee) {
    print('Input your username: ');
    _username = stdin.readLineSync() ?? 'noUser';
    print('Input your password: ');
    _password = stdin.readLineSync()!;

    var hmacSha256 = Hmac(sha256, utf8.encode(_username));
    var digest = hmacSha256.convert(utf8.encode(_password));
    _password = digest.toString();

    if (accounts.containsKey(_username)) {
      if (accounts[_username] == _password) {
        isLoggedIn = true;
        print('Login successful!');
        return true;
      }
      return false;
    } else {
      print('Invalid username/password');
      return false;
    }
  }
}

class Leaves {
  String? employeeName;
  int leaveCount = 0;
  int? employeeId;
  List leaveDates = List.empty(growable: true);

  //DONE!!!
  void applyLeave(Employee employee) {
    String numberOfDays = '0';
    String leaveMonth = '';
    String leaveDay = '';
    Leaves leavingEmployee = Leaves();
    leavingEmployee.employeeName = employee.name;
    leavingEmployee.employeeId = employee.id;

    print('How many days: ');
    numberOfDays = stdin.readLineSync()!;

    while (!isNumber(numberOfDays)) {
      print('Print a valid number of days');
      numberOfDays = stdin.readLineSync()!;
    }

    for (int i = 1; i <= int.parse(numberOfDays); i += 1) {
      print('Select month of leave (Capital first letter): ');
      leaveMonth = stdin.readLineSync()!;

      while (!months.contains(leaveMonth)) {
        print('Enter a valid leave month: ');
        leaveMonth = stdin.readLineSync()!;
      }
      print('Enter leave day (1-31): ');
      leaveDay = stdin.readLineSync()!;

      while (!days.contains(leaveDay)) {
        print('Enter a valid leave-day(1-31): ');
        leaveDay = stdin.readLineSync()!;
      }

      if (leaveMonth == 'February') {
        while (leaveDay == '29' || leaveDay == '30' || leaveDay == '31') {
          print('Enter a valid leave day(1-28): ');
          leaveDay = stdin.readLineSync()!;
        }
      } else if (!monthsWith31.contains(leaveMonth)) {
        while (leaveDay == '31') {
          print('Enter a valid leave day(1-30): ');
          leaveDay = stdin.readLineSync()!;
        }
      }
      leavingEmployee.leaveDates.add('$leaveMonth $leaveDay');
      leavingEmployee.leaveCount += 1;
    }
    leavingEmployee.employeeName = employees.last.name;
    leaves.add(leavingEmployee);
  }

  //DONE!!
  void cancelLeave(Employee employee) {
    if (leaves.isNotEmpty) {
      Leaves findEmployeeByName(String name) => leaves.firstWhere((e) => e.employeeName == name);
      int leaveIndex = findEmployeeByName(employee.name).employeeId! - 1;
      leaves.removeAt(leaveIndex);
      print('Your booked leave(s) is removed');
    } else {
      print('You have no booked leaves');
    }
  }

  void deleteLeave(Admin admin) {}

  //DONE
  void showLeavesOfEmployees() {
    if (leaves.isNotEmpty) {
      for (int i = 0; i < leaves.length; i += 1) {
        print(
            'Row${i + 1}: Name = ${leaves[i].employeeName}, Leave count: ${leaves[i].leaveCount}, Leave date: '
            '${leaves[i].leaveDates}');
      }
    } else {
      print('No employee has applied (yet) for a leave.');
    }
  }
}

class Employee extends Leaves {
  int id = 1;
  late String name;
  String? address;
  String? contactNumber;
  String? dateRegistered;
  int? salary;
  String? birthday;
  int numberOfEmployees = 1;
  String? leaveDate;

  //DONE
  String askName() {
    print('Enter Name: ');
    name = stdin.readLineSync()!;
    while (isNumber(name)) {
      print('Enter a valid name: ');
      name = stdin.readLineSync()!;
    }
    return name;
  }

  //DONE
  String askAddress() {
    print('Enter address: ');
    String address = stdin.readLineSync()!;
    while (isNumber(address)) {
      print('Enter a valid address: ');
      address = stdin.readLineSync()!;
    }
    return address;
  }

  //DONE
  String askNumber() {
    print('Enter Contact Number: ');
    String number = stdin.readLineSync()!;
    var numberList = number.split('').toList();
    int numberLength = numberList.length;
    while (!isNumber(number) || numberLength != 11 || numberList[0] != '0' || numberList[1] != '9') {
      print('Enter a valid contact number (09-..): ');
      number = stdin.readLineSync()!;
      numberList = number.split('').toList();
      numberLength = numberList.length;
    }
    return number;
  }

  //DONE
  String askRegistrationDate() {
    DateTime dateToday = DateTime.now();
    int month = int.parse(dateToday.month.toString().padLeft(2));
    String dateRegister =
        '${months[month]} ${dateToday.day.toString().padLeft(2, '0')}, ${dateToday.year.toString()}';
    return dateRegister;
  }

  //DONE
  int askSalary() {
    print('Enter Salary: ');
    var salary = stdin.readLineSync()!;

    while (!isNumber(salary) || (int.parse(salary) <= 15000)) {
      print('Input not valid, input new salary:');
      salary = stdin.readLineSync()!;
    }
    int intSalary = int.parse(salary);
    return intSalary;
  }

  //DONE!
  String askBirthday() {
    print('Enter month of birth (capital first letter e.g. January): ');
    String birthdayMonth = stdin.readLineSync()!;

    while (!months.contains(birthdayMonth)) {
      print('Enter a valid birth month: ');
      birthdayMonth = stdin.readLineSync()!;
    }
    print('Enter day of birth (1-31): ');

    String birthDay = stdin.readLineSync()!;

    while (!days.contains(birthDay)) {
      print('Enter a valid day of birth(1-31): ');
      birthDay = stdin.readLineSync()!;
    }

    if (birthdayMonth == 'February') {
      while (birthDay == '29' || birthDay == '30' || birthDay == '31') {
        print('Enter a valid day of birth: ');
        birthDay = stdin.readLineSync()!;
      }
    } else if (!monthsWith31.contains(birthdayMonth)) {
      while (birthDay == '31') {
        print('Enter a valid birth-day(1-30)');
        birthDay = stdin.readLineSync()!;
      }
    }
    String finalBirthday = birthdayMonth + ' ' + birthDay;
    return finalBirthday;
  }

  //DONE
  String displayInformation() {
    return '{name: $name\nid: $id\naddress: $address\ncontactnumber: $contactNumber\n'
        'dateRegistered: $dateRegistered\nsalary: $salary\nbirthday: $birthday}\n';
  }

  //DONE! -contact number for verification (kunyare send sms para 2-factor)
  void updateEmployeeBySelf(Employee employee) {
    Employee findEmployeeByName(String name) => employees.firstWhere((e) => e.name == name);
    int employeeIndex = findEmployeeByName(employee.name).id - 1;
    print('number of employees = ${employees.length}'); // for TESTING
    print(employeeIndex); //for TESTING
    print('What is your contact number: '); //verification
    print(employee.contactNumber);
    String contact = stdin.readLineSync()!;
    print(employee.contactNumber);

    if (contact == employee.contactNumber) {
      print('Change address(A), contact number(N)?');
      String update = stdin.readLineSync()!.toUpperCase();

      if (update != 'A' && update != 'N') {
        print('Invalid input, please try again');
        print('Change address(A), contact number(N)?');
      } else if (update == 'A') {
        print('Input new address: ');
        String updateAddress = stdin.readLineSync()!.toUpperCase();
        employees[employeeIndex].address = updateAddress;
        print('Update address successful!');
      } else if (update == 'N') {
        print('Input new contact number: ');
        String updateNumber = stdin.readLineSync()!.toUpperCase();
        employees[employeeIndex].contactNumber = updateNumber;
        print('Update contact number successful!');
      }
    } else {
      print('Invalid contact number verification.');
    }
  }

  void viewMyDetails(Employee employee) {
    Employee findEmployeeByName(String name) => employees.firstWhere((e) => e.name == name);
    int employeeIndex = findEmployeeByName(employee.name).id - 1;
    print('number of employees = ${employees.length}'); // for TESTING
    print(employeeIndex); //for TESTING
    print(employees[employeeIndex].displayInformation());
  }
}

class Admin extends Employee {
  //ADD EMPLOYEES DONE!
  void addEmployee(int numberEmployees) {
    for (int i = 1; i <= numberEmployees; i += 1) {
      var employee = Employee();
      employee.id = employees.length + 1;
      employee.name = employee.askName();
      // employee.address = employee.askAddress();
      // employee.contactNumber = employee.askNumber();
      // employee.dateRegistered = employee.askRegistrationDate();
      // employee.salary = employee.askSalary();
      // employee.birthday = employee.askBirthday();
      employees.add(employee);
      print('${employee.name} is successfully added!');
    }
  }

  //DONE
  void addAdmin() {
    var newAdmin = Admin();
    newAdmin.id = admins.length + 1;
    newAdmin.name = newAdmin.askName();
    newAdmin.address = newAdmin.askAddress();
    newAdmin.contactNumber = newAdmin.askNumber();
    newAdmin.dateRegistered = newAdmin.askRegistrationDate();
    newAdmin.salary = newAdmin.askSalary();
    newAdmin.birthday = newAdmin.askBirthday();
    admins.add(newAdmin);
  }

  //DONE!!
  void deleteEmployee() {
    print('Enter name of employee to delete: ');
    String _name = stdin.readLineSync()!;

    print('Enter username: ');
    String _user = stdin.readLineSync()!;

    print('Enter password: ');
    String _pass = stdin.readLineSync()!;

    if (employees.any((element) => element.name == _name)) {
      var hmacSha256 = Hmac(sha256, utf8.encode(_user));
      var digest = hmacSha256.convert(utf8.encode(_pass));
      _pass = digest.toString();

      //print(_pass); //For testing

      if (_pass == accounts['admin']) {
        Employee findEmployeeByName(String name) => employees.firstWhere((e) => e.name == name);
        int employeeIndex = findEmployeeByName(_name).id;
        //print(employeeIndex); // For testing
        employees.removeAt(employeeIndex);
        print('Employee $_name is successfully removed.');
      }
    } else {
      print('No employee with name "$_name"');
    }
  }

  //DONE!!!
  void updateEmployeeByAdmin() {
    print('Enter name of employee to update: ');
    String _name = stdin.readLineSync()!;

    print('Enter your (admin) username: ');
    String _user = stdin.readLineSync()!;

    print('Enter your password: ');
    String _pass = stdin.readLineSync()!;

    if (employees.any((element) => element.name == _name)) {
      var hmacSha256 = Hmac(sha256, utf8.encode(_user));
      var digest = hmacSha256.convert(utf8.encode(_pass));
      _pass = digest.toString();

      if (_pass == accounts['admin']) {
        //MAIN CODE
        Employee findEmployeeByName(String name) => employees.firstWhere((e) => e.name == name);
        int employeeIndex = findEmployeeByName(_name).id;

        //Admin can change address, contact number, salary, birthday of employee
        print('Change address(A), contact number(N), salary(S), birthday(B)?');
        String update = stdin.readLineSync()!.toUpperCase();

        if (update == 'A') {
          print('Input new address: ');
          String updateAddress = stdin.readLineSync()!;
          employees[employeeIndex].address = updateAddress;
          print('$_name\'s address update successful!');
        } else if (update == 'N') {
          print('Input new contact number: ');
          String updateNumber = stdin.readLineSync()!.toUpperCase();
          while (!isNumber(updateNumber)) {
            print('Input is not a number, input new contact number: ');
            updateNumber = stdin.readLineSync()!;
          }
          employees[employeeIndex].address = updateNumber;
          print('$_name\'s contact number update successful!');
        } else if (update == 'S') {
          print('Input new salary for employee $_name: ');
          String updateSalary = stdin.readLineSync()!;
          while (!isNumber(updateSalary) || (int.parse(updateSalary) <= 15000)) {
            print('Input not valid, input new salary:');
            updateSalary = stdin.readLineSync()!;
          }
          employees[employeeIndex].salary = int.parse(updateSalary);
          print('$_name\'s salary update successful!');
        } else if (update == 'B') {
          print('Input new birthday: ');
          String updateBirthday = stdin.readLineSync()!;
          employees[employeeIndex].birthday = updateBirthday;
          print('$_name\'s birthday update successful!');
        } else {
          print('Invalid input, please try again');
        }
      } else {
        print('Incorrect username/password');
      }
    } else {
      print('No employee with name "$_name"');
    }
  }

  //DONE
  void showAdminData() {
    for (int i = 0; i < admins.length; i += 1) {
      print(admins[i].displayInformation());
    }
  }

  //DONE
  void showEmployeeData() {
    for (int i = 0; i < employees.length; i += 1) {
      if (employees.isEmpty) {
        print('There are currently no employees registered');
      }
      print(employees[i].displayInformation());
    }
  }
}

//DONE
bool isNumber(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

void welcomeText() {
  print('''WELCOME TO THE EMPLOYEE MANAGEMENT SYSTEM
For employees, you can change some of your data, view the current pending leaves, and plot your own leave(s).
For admin(s), you can add other employees, delete employees' data, and modify employee data.
For admins(s), you can also show the list of admins and lists of employees.
To start, please log-in your account or sign-up if you have no account yet\n
''');
}

//Console Loop for all functions
void runApp() {
  while (endApp == false) {
    print('Enter "E" if employee or "A" admin or "Q" to quit');
    String userLevel = stdin.readLineSync()!.toUpperCase();
    if (userLevel == 'Q') {
      endApp = true;
    }

    while (userLevel != 'E' && userLevel != 'A' && userLevel != 'Q') {
      print('Input not valid. Input "E" for employee or "A" for admin or "Q" to quit');
      userLevel = stdin.readLineSync()!.toUpperCase();
    }

    if (userLevel == 'E') {
      print('''You are an employee
You can edit some of your data, view current leaves, and/or plot your leave(s).
But FIRST,\n''');
      isAdmin = false;
    } else if (userLevel == 'A') {
      print('You are an admin');
      isAdmin = true;
    } else if (userLevel == 'Q') {
      quit();
    }

    //Initially, no employee has an account yet
    //Employee is asked to register once, you can log-in or log-out
    print('Do you have an account already? Y/N');
    String hasAccount = stdin.readLineSync()!.toUpperCase();
    while (hasAccount != 'Y' && hasAccount != 'N') {
      print('Invalid answer. Do you have an account already? Y/N');
      hasAccount = stdin.readLineSync()!.toUpperCase();
    }

    //Condition1: has Account and isEmployee
    if (hasAccount == 'Y' && !isAdmin) {
      if (employees.isEmpty) {
        //No employee in list -> createAccount first
        print("You don't have an account yet");
        createAccount();
        isLoggedIn = true;
      } else {
        print('Enter your name');
        String name = stdin.readLineSync()!;
        while (name.isEmpty) {
          print('Enter a valid name');
          name = stdin.readLineSync()!;
        }
        if (employees.any((element) => element.name == name)) {
          //print('We have an employee named $name'); //FOR TESTING
          //print('employee $name @ index: ${findEmployeeIndexByName(name)}'); //FOR TESTING
          int i = 2;
          while (i != 0) {
            bool accountMatched = account.loginVerification(employee);
            if (!accountMatched) {
              print('Tries remaining: $i');
              i -= 1;
            } else {
              while (endApp == false) {
                isLoggedIn = true;
                employeeFunctionsPrompt();
              }
            }
          }
        } else {
          print('Name mismatch. Start again');
          runApp();
        }
      }
      if (isLoggedIn) {
        while (endApp == false) {
          employeeFunctionsPrompt();
          endApp ? null : continueWork();
        }
      }
    }

    //Case2: No account and isEmployee
    if (hasAccount == 'N' && !isAdmin && endApp == false) {
      print('Starting the registration');
      createAccount();
      while (endApp == false) {
        employeeFunctionsPrompt();
        endApp ? null : continueWork();
      }
    }

    //Case3: has account and is Admin
    //ONLY mainAdmin can create new admin accounts
    if (hasAccount == 'Y' && isAdmin && endApp == false) {
      int i = 2;

      while (i != 0) {
        bool accountMatched = adminAccount.loginVerificationAdmin(mainAdmin);
        if (!accountMatched) {
          print('Tries remaining: $i');
          i -= 1;
        } else {
          while (endApp == false) {
            isLoggedIn = true;
            adminFunctionsPrompt();
          }
        }
      }

      adminFunctionsPrompt();
      while (endApp == false) {
        adminFunctionsPrompt();
        endApp ? null : continueWork();
      }
    }

    //Case4: No account but is assigned to be admin
    //wait for admin to create an account for you
    //after admin logs out, you can log in
    if (hasAccount == 'N' && isAdmin && endApp == false) {
      print('Call admin to create account for you :D');
    }
  }
}

void adminFunctionsPrompt() {
  String? adminAction;
  final adminOptions = ['Q', 'O', 'U', 'V', 'D', 'DE', 'DA', 'AAA', 'AE'];

  print('''Welcome dear admin,
To quit, press "Q"
To log-out, press "O"
Do you want to UPDATE employee details? Press "U"
Do you want to view employee leaves? Press "V"
Do you want to delete an employee's DATA? Press "D"
Do you want to display list of employees? Press "DE"
Do you want to display list of admins? Press "DA"
Do you want to add an admin account? Press "AAA"
Do you want to add an employee account? Press "AE"
''');

  adminAction = stdin.readLineSync()!.toUpperCase();
  while (!adminOptions.contains(adminAction)) {
    print('''Invalid answer.
To quit, press "Q"
To log-out, press "O"
Do you want to UPDATE employee details? Press "U"
Do you want to view employee leaves? Press "V"
Do you want to delete an employee's DATA? Press "D"
Do you want to display list of employees? Press "DE"
Do you want to display list of admins? Press "DA"
Do you want to add an admin account? Press "AAA"
Do you want to add an employee account? Press "AE"
''');
    adminAction = stdin.readLineSync()!.toUpperCase();
  }

  void adminFunctions() {
    if (adminAction == 'U') {
      mainAdmin.updateEmployeeByAdmin();
    } else if (adminAction == 'V') {
      mainAdmin.showLeavesOfEmployees();
    } else if (adminAction == 'D') {
      mainAdmin.deleteEmployee();
    } else if (adminAction == 'DE') {
      mainAdmin.showEmployeeData();
    } else if (adminAction == 'DA') {
      mainAdmin.showAdminData();
    } else if (adminAction == 'AAA') {
      mainAdmin.addAdmin();
      adminAccount.registerAdmin(mainAdmin);
    } else if (adminAction == 'AE') {
      createAccount();
      print('You have successfully created employee ${employees.last.name}');
    } else if (adminAction == 'O') {
      logOut();
    } else if (adminAction == 'Q') {
      quit();
    }
  }

  adminFunctions();
}

void employeeFunctionsPrompt() {
  String? employeeAction;
  final employeeOptions = ['L', 'U', 'V', 'O', 'Q', 'E', 'DL'];

  print('''To quit, press "Q"
To log-out, press "O"
Do you want to UPDATE your details? Press "U"
Do you want to plot your LEAVE(S)? Press "L"
Do you want to view the current LEAVES? Press "V"
Do you want to view your Employment data? Press "E"
Do you want to delete your leave application? Press "DL"
''');
  employeeAction = stdin.readLineSync()!.toUpperCase();
  while (!employeeOptions.contains(employeeAction)) {
    print('''Invalid answer.
To quit, press "Q"
To log-out, press "O"
Do you want to UPDATE your details? Press "U"
Do you want to plot your LEAVE(S)? Press "L"
Do you want to view the current LEAVES? Press "V"
Do you want to view your Employment data? Press "E"
Do you want to delete your leave application? Press "DL" 
''');
    employeeAction = stdin.readLineSync()!.toUpperCase();
  }
  void employeeFunctions() {
    if (employeeAction == 'U') {
      employee.updateEmployeeBySelf(employees.last);
    } else if (employeeAction == 'L') {
      employee.applyLeave(employees.last);
    } else if (employeeAction == 'V') {
      employee.showLeavesOfEmployees();
    } else if (employeeAction == 'E') {
      employee.viewMyDetails(employees.last);
    } else if (employeeAction == 'DL') {
      employee.cancelLeave(employees.last);
    } else if (employeeAction == 'O') {
      logOut();
    } else if (employeeAction == 'Q') {
      quit();
    }
  }

  employeeFunctions();
}

void createAccount() {
  mainAdmin.addEmployee(1);
  account.register(employees[0]);
  hasAccountBool = true;
}

void reset() {
  endApp = false;
  isLoggedIn = false;
  isAdmin = false;
}

void logOut() {
  reset();
  print('Logging out..');
  Timer.periodic(const Duration(milliseconds: 400), (timer) {
    print('Logged out');
    timer.cancel();
  });
  reloadApp ? runApp() : quit();
}

void quit() {
  endApp = true;
  print('Ending session..');
  exit(0);
}

bool continueWork() {
  print('''Still continue your work? Press "C"
To quit: Press "Q" :''');
  String stillContinue = stdin.readLineSync()!.toUpperCase();

  while (stillContinue != 'C' && stillContinue != 'Q') {
    print('Invalid answer. Do you want to continue? C/Q');
    stillContinue = stdin.readLineSync()!.toUpperCase();
  }

  if (stillContinue == 'Q') {
    print('Ending session..');
    exit(0);
  } else if (stillContinue == 'C') {
    return true;
  } else {
    return false;
  }
}

void editConstructors() {
  admins.add(mainAdmin);
  mainAdmin.name = 'Jeffrey';
  account.name = 'Maco';
}

int findEmployeeIndexByName(String employeeNameRegistered) {
  Employee findEmployeeByName(String name) => employees.firstWhere((e) => e.name == name);
  int employeeIndex = findEmployeeByName(employeeNameRegistered).id;
  return employeeIndex;
}

List<Employee> employees = List.empty(growable: true);
List<Admin> admins = List.empty(growable: true);
List<Leaves> leaves = List.empty(growable: true);
Map<String, String> adminAccounts = {
  'admin': 'f429ec54f354b72bed77a5c0afedecb91f347f479a09f74f4107592764b56d1c'
  //admin => admin
};
Map<String, String> accounts = {
  'user': '16aa95479af46da4def2d52a345960d2cd276398763e430571ea4aba3ac70f12'
  //user => user
};
