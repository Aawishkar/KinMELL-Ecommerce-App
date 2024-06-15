import 'package:app/config/config.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/models/product/product.dart';
import 'package:app/views/products/details_page.dart';
import 'package:app/views/products/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color _favIconColor = Colors.black;

class ProductCard extends StatefulWidget {
  final Product? model;
  const ProductCard({Key? key, this.model}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(children: [
              AspectRatio(
                aspectRatio: 1.1,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(0)),
                  decoration: BoxDecoration(
                    color: GlobalVariables.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ProductDetailsPage.routeName, arguments: {
                        'productId': widget.model!.productId,
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.model!.fullImagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.model!.calculateDiscount > 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: Colors.green,
                    ),
                    child: Text(
                      "${widget.model!.calculateDiscount}% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 5),
            Text(
              widget.model!.productName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${Config.currency}${widget.model!.productPrice.toString()}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.w600,
                    color: widget.model!.calculateDiscount > 0
                        ? Colors.red
                        : Colors.black,
                    decoration: widget.model!.productSalePrice > 0
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                Text(
                  (widget.model!.calculateDiscount > 0)
                      ? " ${widget.model!.productSalePrice.toString()}"
                      : "",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  iconSize: 15,
                  icon: Icon(Icons.favorite_outlined),
                  onPressed: () {
                    setState(() {
                      if (_favIconColor == Colors.black) {
                        _favIconColor = Colors.red;
                        //widget.product.isFavourite=true;

                      } else {
                        _favIconColor = Colors.black;
                        // widget.product.isFavourite=false;
                      }
                    });
                  },
                  color: _favIconColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}




//  GestureDetector(
//                 child: SizedBox(
//                   child: Image.network(
//                     widget.model!.fullImagePath,
//                     fit: BoxFit.cover,
//                   ),
//                   height: GlobalVariables.screenHeight * 0.12,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushNamed(ProductDetailsPage.routeName, arguments: {
//                     'productId': widget.model!.productId,
//                   });
//                 },
//               ),