import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/models/weather_locations.dart';
import 'package:weather_app/widgets/location_summary_widget.dart';
import 'package:weather_app/widgets/page_transformers.dart';
import 'package:weather_app/widgets/slider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgImg = '';

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == 'Sunny') {
      bgImg = '/Users/arihandixit/VSCodeProjects/weather_app/assets/sunny.jpg';
    } else if (locationList[_currentPage].weatherType == 'Night') {
      bgImg = '/Users/arihandixit/VSCodeProjects/weather_app/assets/night.jpg';
    } else if (locationList[_currentPage].weatherType == 'Rainy') {
      bgImg = '/Users/arihandixit/VSCodeProjects/weather_app/assets/rainy.jpg';
    } else if (locationList[_currentPage].weatherType == 'Cloudy') {
      bgImg =
          '/Users/arihandixit/VSCodeProjects/weather_app/assets/cloudy.jpeg';
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //title: Text('Weather App'),
          backgroundColor: Colors.transparent,
          elevation: 0, //for android formatting
          leading: const IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            onPressed: (null),
          ),
          actions: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: GestureDetector(
                  onTap: () => print('Menu Clicked'),
                  child: SvgPicture.asset(
                    '/Users/arihandixit/VSCodeProjects/weather_app/assets/menu.svg',
                    height: 30,
                    width: 30,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: Container(
          child: Stack(children: [
            Image.asset(
              bgImg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentPage) SliderDot(true) else SliderDot(false)
                ],
              ),
            ),
            TransformerPageView(
                transformer: new ScaleAndFadeTransformer(),
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.8,
                onPageChanged: _onPageChanged,
                itemCount: locationList.length,
                itemBuilder: (ctx, i) => LocationSummaryWidget(i))
          ]),
        ));
  }
}
