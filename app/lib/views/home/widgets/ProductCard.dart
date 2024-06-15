import 'package:app/config/config.dart';
import 'package:app/constants/globalvariable.dart';
//import 'package:app/utils/Product.dart';
import 'package:app/views/products/productPage.dart';
import 'package:app/views/products/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app/models/product/product.dart';
import 'package:app/views/products/details_page.dart';

// Products heading ko product card.

Color _favIconColor = Colors.black;

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRation = 1.1,
    this.model,
  }) : super(key: key);
  final double width, aspectRation;
  final Product? model;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: widget.aspectRation,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(0)),
                decoration: BoxDecoration(
                  color: GlobalVariables.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
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
            const SizedBox(height: 15),
            Text(
              widget.model!.productName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${Config.currency}${widget.model!.productPrice.toString()}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: GlobalVariables.backgroundColor,
                  ),
                ),
                IconButton(
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
                ),
                //     InkWell(
                //          borderRadius: BorderRadius.circular(30),
                //          onTap: () {
                //           if(widget.product.isFavourite== true){
                //             widget.product.isFavourite==false;
                //           }else{
                //             widget.product.isFavourite=true;
                //           }
                //          },
                //          child: Container(
                // padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                // height: getProportionateScreenWidth(28),
                // width: getProportionateScreenWidth(28),
                // decoration: BoxDecoration(
                //   color: widget.product.isFavourite
                //       ? GlobalVariables.backgroundColor.withOpacity(0.15)
                //       : GlobalVariables.secondaryColor.withOpacity(0.1),
                //   shape: BoxShape.circle,
                // ),
                // child: SvgPicture.asset(
                //   "assets/icons/Heart Icon_2.svg",
                //   color: widget.product.isFavourite
                //       ? Color(0xFFFF4848)
                //       : Color(0xFFDBDEE4),
                // ),
                //          ),
                //        ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
