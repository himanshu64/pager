import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget productCard(
    {required String thumbnail,
    required String displayName,
    required double mrp,
    required double salePrice}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        FadeInImage(
          imageErrorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            print('Error Handler');
            return Container(
              width: 100.0,
              height: 100.0,
              child: Image.asset('assets/error.png'),
            );
          },
          placeholder: AssetImage(
            'assets/loading.png',
          ),
          image: NetworkImage(thumbnail),
          fit: BoxFit.cover,
          height: 100.0,
          width: 100.0,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$displayName',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Sale Price : ',
                    children: <TextSpan>[
                      TextSpan(
                        text: '\₹${mrp.toString()}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                          text: ' \₹${salePrice.toString()}',
                          style: TextStyle(fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
