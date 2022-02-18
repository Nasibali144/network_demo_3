import 'package:flutter/material.dart';
import 'package:network_demo_3/models/user_model.dart';
import 'package:network_demo_3/services/http_service.dart';
import 'package:network_demo_3/services/util_service.dart';

class DetailPage extends StatefulWidget {
  static const String id = "/detail_page";
  final int? userId;
  final CRUD? type;
  const DetailPage({Key? key, this.userId, this.type}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
  User? user;
  bool readOnly = true;
  String button = "";
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    role(widget.type!);
  }

  void role(CRUD type) {
    switch(type) {
      case CRUD.TYPE_CREATE: {
        setState(() {
          readOnly = false;
          button = "Create";
        });
      } break;
      case CRUD.TYPE_READ: {
        setState(() {
          button = "Edit";
        });
        roleRead(widget.userId!);
      } break;
      case CRUD.TYPE_UPDATE: {
        setState(() {
          readOnly = false;
          button = "Save";
        });
        roleRead(widget.userId!);
      } break;
      case CRUD.TYPE_DELETE: {
        
      } break;
    }
  }

  void onPressed(CRUD type) {
    switch(type) {
      case CRUD.TYPE_CREATE: {
        createUser();
      } break;
      case CRUD.TYPE_READ: {


      } break;
      case CRUD.TYPE_UPDATE: {

      } break;
      case CRUD.TYPE_DELETE: {

      } break;
    }
  }
  
  void roleRead(int id) async {
    await HttpService.GET(HttpService.API_USER_ONE + id.toString(), HttpService.paramEmpty()).then((response) {
      if(response != null) {
        setState(() {
          user = HttpService.parseUserOne(response);
        });
      }
    });

    setState(() {
      usernameController.text = user!.username;
      emailController.text = user!.email;
      addressController.text = user!.address.city;
      phoneController.text = user!.phone;
      websiteController.text = user!.website;
      companyController.text = user!.company.name;
    });
  }
  
  void createUser() {
    String username = usernameController.text.trim().toString();
    String email = emailController.text.trim().toString();
    String address = addressController.text.trim().toString();
    String phone = phoneController.text.trim().toString();
    String website = websiteController.text.trim().toString();
    String company = companyController.text.trim().toString();
    
    if(username.isEmpty || email.isEmpty || address.isEmpty || phone.isEmpty || website.isEmpty || company.isEmpty) {
      // error msg
      return;
    }
    User user = User(
      id: 0,
      name: username,
      username: username,
      email: email,
      address: Address(street: address, city: "city", geo: Geo(lng: "41.154545", lat: "69.455545"), suite: "suite", zipcode: "3336"),
      phone: phone,
      website: website,
      company: Company(name: company, bs: "bs", catchPhrase: 'catchPhrase'),
    );
    apiCreateUser(user);
    
  }
  
  void apiCreateUser(User user) {
    setState(() {
      isLoading = true;
    });
    HttpService.POST(HttpService.API_CREATE_USER, HttpService.paramsCreate(user)).then((value) {

      setState(() {
        isLoading = false;
      });

      if(value != null) {
        User user = HttpService.parseCreateUser(value);
        print(user.id);
        Navigator.pop(context, true);
      } else {
        // error msg
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 80),
                Center(child: CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 60,
                  child: Icon(Icons.person, size: 60, color: Colors.white,),
                ),),
                SizedBox(height: 30),

                // #username
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: usernameController,
                    readOnly: readOnly,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_circle, color: Colors.purple, size: 40,),
                      hintText: "UserName",
                    ),
                  ),
                ),
                Divider(height: 4, color: Colors.black,),

                // #email
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: emailController,
                    readOnly: readOnly,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_circle, color: Colors.purple, size: 40,),
                      hintText: "Email",
                    ),
                  ),
                ),
                Divider(height: 4, color: Colors.black,),

                // #address
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: addressController,
                    readOnly: readOnly,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_circle, color: Colors.purple, size: 40,),
                      hintText: "Address",
                    ),
                  ),
                ),
                Divider(height: 4, color: Colors.black,),

                // #phone
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: phoneController,
                    readOnly: readOnly,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_circle, color: Colors.purple, size: 40,),
                      hintText: "Phone",
                    ),
                  ),
                ),
                Divider(height: 4, color: Colors.black,),

                // #website
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: websiteController,
                    textInputAction: TextInputAction.next,
                    readOnly: readOnly,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_circle, color: Colors.purple, size: 40,),
                      hintText: "WebSite",
                    ),
                  ),
                ),
                Divider(height: 4, color: Colors.black,),

                // #company
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextField(
                    controller: companyController,
                    readOnly: readOnly,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_circle, color: Colors.purple, size: 40,),
                      hintText: "Company",
                    ),
                  ),
                ),
                Divider(height: 4, color: Colors.black,),

                SizedBox(height: 30),
                // #button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: MaterialButton(
                    onPressed: () {
                      onPressed(widget.type!);
                    },
                    minWidth: MediaQuery.of(context).size.width * 0.7,
                    shape: StadiumBorder(),
                    height: 60,
                    color: Colors.purple,
                    child: Text(button, style: TextStyle(color: Colors.white, fontSize: 18),),
                  ),
                )
              ],
            ),

          ),

          isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}
