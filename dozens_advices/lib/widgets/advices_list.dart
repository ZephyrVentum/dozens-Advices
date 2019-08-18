import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdvicesList extends StatelessWidget {
  AdvicesList({Key key, this.advices}) : super(key: key);

  final DateFormat _formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) => ListView.separated(
      separatorBuilder: (_, index) {
        return Container(height: 1, color: Theme.of(context).dividerColor);
      },
      itemCount: advices.length,
      itemBuilder: (_, index) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Styles.highlightInkWellColor,
            splashColor: Colors.black26,
            onTap: () {},
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(advices[index].views.toString(), style: Styles.advicesListDateTextStyle(context)),
                        SizedBox(width: 2),
                        Icon(
                          Icons.visibility,
                          color: Styles.averageGradientColor,
                          size: 21,
                        ),
                        SizedBox(width: 2),
                        advices[index].isFavourite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.deepOrange,
                                size: 21,
                              )
                            : Container()
                      ],
                    ),
                    Text(
                      _formatter.format(DateTime.fromMicrosecondsSinceEpoch(
                          advices[index].createdAt)),
                      style: Styles.advicesListDateTextStyle(context),
                    )
                  ],
                ),
                leading: Image(image: AssetImage(getImagePath(advices[index]))),
                title: Text(
                  advices[index].mainContent,
                  style: Styles.advicesListContentTextStyle(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
        );
      });

  String getImagePath(Advice advice) {
    switch (advice.type) {
      case AdviceType.ADVICE:
        return "assets/images/ic_advice.png";
      case AdviceType.QUOTE:
        return "assets/images/ic_quote.png";
      case AdviceType.FACT:
        return "assets/images/ic_fact.png";
      case AdviceType.JOKE:
        return "assets/images/ic_joke.png";
      default:
        return "assets/images/ic_advice.png";
    }
  }

  final List<Advice> advices;
}
