import 'package:bth_03/screen/checkOut.dart';
import 'package:flutter/material.dart';
import '../provider/danhmuc.dart';
import 'package:bth_03/utils/ColorString.dart';

class StoreScreen extends StatefulWidget {
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<tenDanhMuc> items = [
    tenDanhMuc(
        title: 'Household',
        urlImg: 'https://cdn-icons-png.flaticon.com/512/72/72153.png'),
    tenDanhMuc(
        title: 'Grocery',
        urlImg: 'https://cdn-icons-png.flaticon.com/512/3724/3724720.png'),
    tenDanhMuc(
        title: 'Liquor',
        urlImg: 'https://cdn-icons-png.flaticon.com/512/920/920623.png'),
    tenDanhMuc(
        title: 'Chillect',
        urlImg:
            'https://png.pngtree.com/png-vector/20190628/ourlarge/pngtree-cheese-icon-for-your-project-png-image_1520565.jpg'),
  ];
  List<Map<String, dynamic>> nexus =[
    {
      'title': 'Ginger',
      'amount': 'Rs 690.00',
      'imgUrl': 'https://cdn.tgdd.vn/2021/12/CookDish/3-cach-lot-vo-gung-nhanh-chong-chi-voi-3-buoc-don-gian-avt-1200x676.jpg',
    },
    {
      'title': 'Garlic Premium',
      'amount': 'Rs 380.00',
      'imgUrl': 'https://traphaco.com.vn/upload/images/Tin%20t%E1%BB%A9c/2017/Cay%20thuoc%20quy/toi2.jpg',
    },
    {
      'title': 'Red Onions',
      'amount': 'Rs 260.00',
      'imgUrl': 'https://vietbest.vn/components/com_djclassifieds/images/item/0/36_hanh-tim-vinh-chau-soc-trang-vietbest.jpg',
    }    
  ];
  List<Map<String, dynamic>> keels =[
    {
      'title': 'Carot',
      'amount': 'Rs 490.00',
      'imgUrl': 'https://product.hstatic.net/200000271661/product/ca_rot_vi_thuoc_chua_2_f08a9353829c4723a468f1a0cb29bb65.jpg',
    },
    {
      'title': 'Mango -Bud',
      'amount': 'Rs 210.00',
      'imgUrl': 'https://www.hsp.vn/wp-content/uploads/2020/04/qua-xoai.jpg',
    },
    {
      'title': 'Grapes - Green',
      'amount': 'Rs 1,120.00',
      'imgUrl': 'https://product.hstatic.net/1000282430/product/nho-xanh6000200557738_c40c59da9872452593b1426992e9ff91.jpg',
    }    
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All >',
                      style: TextStyle(fontSize: 16, color: color_primary),
                      
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 170,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(
                                  items[index].urlImg,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            items[index].title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
             Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nexus Member Deals',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All >',
                      style: TextStyle(fontSize: 16,  color: color_primary),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 254,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nexus.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              
                              color: Colors.white,
                            ),
                            child: Image(
                              image: NetworkImage(
                                nexus[index]['imgUrl'],
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nexus[index]['title'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                            Text(
                              nexus[index]['amount'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Keels Deals',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All >',
                      style: TextStyle(fontSize: 16,  color: color_primary),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 254,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: keels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Image(
                              image: NetworkImage(
                                keels[index]['imgUrl'],
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nexus[index]['title'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                            Text(
                              nexus[index]['amount'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  );
                },
              ),
            ),
            TextButton(onPressed: (){
               Navigator.push(context,
                        MaterialPageRoute(builder: (_) => checkOutScreen()));
            }, child: Text('Checkout', style: TextStyle(fontSize: 20),)),
          ],
        ),
      ),
    );
  }
}
