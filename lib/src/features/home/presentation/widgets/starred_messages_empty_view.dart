import 'package:flutter/material.dart';class StarredMessagesEmptyView extends StatelessWidget {
  const StarredMessagesEmptyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF25D366),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.star_border_rounded, color: const Color(0xFF0B141A), size: (100 * 0.80),  weight: 2.0, 
              ),
          ),
          SizedBox(height: 30,),
          Text('No starred Messages',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),),
          SizedBox(height: 20,),
          Text('Tap and hold on any message to star it, so you can easily find it later.',
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600], 
              height: 1.4)
          ),
        ],
      ),
    );
  }
}