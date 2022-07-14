import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeID = 'edit-product-screen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageEditingController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editingProduct =
      Product(id: '1', title: '', description: '', price: 0, imageUrl: '');
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInitializing = true;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInitializing) {
      final String? productId =
          ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        _editingProduct =
            Provider.of<ProductsProvider>(context).findByID(productId);
        _initValues = {
          'title': _editingProduct.title,
          'description': _editingProduct.description,
          'price': _editingProduct.price.toString(),
          'imageUrl': _editingProduct.imageUrl,
        };
        _imageEditingController.text = _editingProduct.imageUrl;
      }
    }
    _isInitializing = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageEditingController.text.isEmpty) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    if (_editingProduct.id != '1') {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editingProduct.id, _editingProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editingProduct);
    }
    Navigator.of(context).pop();
    print(_editingProduct.title);
    print(_editingProduct.id);
    print(_editingProduct.price);
    print(_editingProduct.imageUrl);
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageEditingController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_editingProduct.title);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _initValues['title'],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      _editingProduct = Product(
                          id: _editingProduct.id,
                          title: value as String,
                          description: _editingProduct.description,
                          price: _editingProduct.price,
                          imageUrl: _editingProduct.imageUrl);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['price'],
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      _editingProduct = Product(
                          id: _editingProduct.id,
                          title: _editingProduct.title,
                          description: _editingProduct.description,
                          price: double.parse(value as String),
                          imageUrl: _editingProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Please enter a price';
                      }

                      if (double.parse(value) <= 0) {
                        return 'Please enter positive price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['description'],
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    onSaved: (value) {
                      _editingProduct = Product(
                          id: _editingProduct.id,
                          title: _editingProduct.title,
                          description: value as String,
                          price: _editingProduct.price,
                          imageUrl: _editingProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the description';
                      }
                      if (value.length < 10) {
                        return 'Should be at least 10 letters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    child: _imageEditingController.text.isEmpty
                        ? Text('Enter the image url please!')
                        : FittedBox(
                            child: Image.network(
                              _imageEditingController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'image url'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageEditingController,
                    focusNode: _imageUrlFocusNode,
                    onEditingComplete: _saveForm,
                    onSaved: (value) {
                      _editingProduct = Product(
                          id: _editingProduct.id,
                          title: _editingProduct.title,
                          description: _editingProduct.description,
                          price: _editingProduct.price,
                          imageUrl: value as String);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an image URL.';
                      }
                      if (!value.startsWith('http') &&
                          !value.startsWith('https')) {
                        return 'Please enter a valid URL.';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: _saveForm,
                    icon: Icon(Icons.save),
                    label: Text('Save'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
