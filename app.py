import firebase_admin
from firebase_admin import credentials, firestore, auth
from flask import Flask, jsonify, request

# Initialize Flask application
app = Flask(__name__)

# Initialize Firestore with your Firebase project credentials
cred = credentials.Certificate('E:/AOU/grad.json')
firebase_admin.initialize_app(cred)

# Get a Firestore client instance
db = firestore.client()

@app.route('/')
def index():
    return 'This is the Wassla App Recommendation System!'

@app.route('/recommendations', methods=['POST'])
def get_recommendations():
    try:
        # Get user ID from request body
        request_data = request.get_json()
        user_id = request_data.get('user_id')

        if not user_id:
            return jsonify({'error': 'User ID is required in the request body'}), 400

        # Retrieve user's wishlist
        user_wishlist_ref = db.collection('wishlist').document(user_id).collection('items')
        user_wishlist_docs = user_wishlist_ref.stream()
        user_wishlist = [doc.to_dict() for doc in user_wishlist_docs]

        if not user_wishlist:
            return jsonify({'error': 'User has no items in wishlist'}), 404

        # Generate recommendations based on the entire wishlist
        recommendations, categories, most_frequent_category = generate_recommendations(user_wishlist)

        if not recommendations:
            return jsonify({'message': 'No recommendations found'}), 200

        return jsonify(recommendations)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

def generate_recommendations(wishlist):
    try:
        # Collect all unique categories from the wishlist and get category for each item
        categories = set()
        category_counts = {}
        for item in wishlist:
            category = item.get('category')
            categories.add(category)
            category_counts[category] = category_counts.get(category, 0) + 1

        if not categories:
            return [], None, None

        # Sort categories by occurrence count in descending order
        sorted_categories = sorted(category_counts.items(), key=lambda x: x[1], reverse=True)

        # Select the most frequent category from the wishlist
        most_frequent_category = sorted_categories[0][0]

        # Retrieve products from the most frequent category
        recommended_products_ref = db.collection('products').document(most_frequent_category).collection('products').limit(3)
        recommended_products_docs = recommended_products_ref.stream()
        recommended_products = [doc.to_dict() for doc in recommended_products_docs]

        return recommended_products, categories, most_frequent_category
    except Exception as e:
        return [], None, None

if __name__ == '__main__':
    app.run(debug=True)
