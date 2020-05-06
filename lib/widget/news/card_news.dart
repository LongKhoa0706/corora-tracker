import 'package:flutter/material.dart';

class CardNews extends StatelessWidget {
  final String title;
  final String dateTime;
  final String author;
  final String urlImage;

  const CardNews(
      {Key key, this.title, this.dateTime, this.author, this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 10,
                color: Colors.grey.withOpacity(.3),
              ),
              BoxShadow(
                offset: Offset(-3, 0),
                blurRadius: 15,
                color: Color(0xffb8bfce).withOpacity(.1),
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(urlImage == null ? "https://img.favpng.com/18/10/5/computer-icons-error-download-png-favpng-k5pE2k8grUC5e95R5WJCfzJnh.jpg" : urlImage), fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title == null ? "" : title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              dateTime == null ? "" : dateTime,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(author == null ? "anonymous" : author, )),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
