import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad/models/admin/my_admin.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/models/hot_deal_model.dart';
import 'package:grad/models/user.dart';

class FirebaseHelper {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> saveUserData(MyUser user) async {
    //* Convert user data to a Map
    Map<String, dynamic> userData = {
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'phone': user.phone,
      'userId': user.userId
    };
    //* Add user data to Firestore collection
    firebaseFirestore.collection('users').doc(user.userId).set(userData);
  }

  Future<void> saveAdminData(MyAdmin admin) async {
    //* Convert user data to a Map
    Map<String, dynamic> adminData = {
      'name': admin.name,
      'email': admin.email,
      'adminId': admin.adminId
    };
    //* Add user data to Firestore collection
    firebaseFirestore.collection('admins').doc(admin.adminId).set(adminData);
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<MyUser?> getCurrentUserData() async {
    final userId = firebaseAuth.currentUser!.uid;
    return await getUserDataFromFirestore(userId);
  }

  Future<MyUser?> getUserDataFromFirestore(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userSnapshot.exists) {
        // User data found, create a User object and return it
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        return MyUser(
          userId: userData['userId'],
          firstName: userData['firstName'],
          lastName: userData['lastName'],
          email: userData['email'],
          phone: userData['phone'],
        );
      } else {
        // User data not found
        return null;
      }
    } catch (e) {
      // Error occurred while fetching user data
      return null;
    }
  }

  static Future<List<String>> getBannerImages() async {
    List<String> bannerUrls = [];

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference bannersCollection = firestore.collection('banners');
      QuerySnapshot querySnapshot = await bannersCollection.get();
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String imageUrl = data['imageUrl'];
        bannerUrls.add(imageUrl);
      }
      return bannerUrls;
    } catch (error) {
      print('Error getting banner images: $error');
      return [];
    }
  }

  Future<List<CategoryResponseModel>> getAllProducts() async {
    List<String> categories = await getCategories();
    List<CategoryResponseModel> allProducts = [];
    for (var category in categories) {
      List<CategoryResponseModel> categoryProducts =
          await getCategoryProducts(category);
      allProducts.addAll(categoryProducts);
    }

    return allProducts;
  }

  static Future<List<String>> getCategories() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    final List<String> categoryList =
        querySnapshot.docs.map((doc) => doc['title'] as String).toList();
    return categoryList;
  }

  Future<List<CategoryResponseModel>> getCategoryProducts(
      String category) async {
    QuerySnapshot productSnapshots = await firebaseFirestore
        .collection('products')
        .doc(category)
        .collection('products')
        .get();
    List<CategoryResponseModel> products = [];
    for (var productDoc in productSnapshots.docs) {
      Map<String, dynamic> data = productDoc.data() as Map<String, dynamic>;
      CategoryResponseModel product = CategoryResponseModel(
        title: data['title'],
        quantity: data['quantity'],
        description: data['description'],
        image: data['image'],
        price: data['price'],
        category: data['category'],
      );
      products.add(product);
    }
    return products;
  }

  Future<List<HotDealModel>> getHotDealsCollection() async {
    try {
      CollectionReference hotDealsCollection =
          FirebaseFirestore.instance.collection('hot_deals');
      QuerySnapshot querySnapshot = await hotDealsCollection.get();
      List<HotDealModel> hotDealsList = querySnapshot.docs
          .map((DocumentSnapshot doc) =>
              HotDealModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return hotDealsList;
    } catch (error) {
      return [];
    }
  }

  Future<void> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    await usersCollection.doc(userId).update({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }
}
