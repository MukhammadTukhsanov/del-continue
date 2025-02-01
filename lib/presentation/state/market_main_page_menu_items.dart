import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/pages/market_products.dart';

List<Map<String, dynamic>> menuItems = [
  {
    "title": "Ko`p sotilganlar",
    "imageSrc": "assets/images/moreSales.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Meva va sabzavotlar",
    "imageSrc": "assets/images/vegetables.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Ichimliklar",
    "imageSrc": "assets/images/drinks.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Go`sht mahsulotlari",
    "imageSrc": "assets/images/meals.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Sut & nonushta",
    "imageSrc": "assets/images/milk_breakfast.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Asosiy oziq-ovqat",
    "imageSrc": "assets/images/main_foods.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Non mahsulotlari",
    "imageSrc": "assets/images/bread.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Tozalik",
    "imageSrc": "assets/images/cleaning.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Muzqaymoq",
    "imageSrc": "assets/images/ice_cream.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Choy & Qahva",
    "imageSrc": "assets/images/tea_cofe.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Shaxsiy gigiena",
    "imageSrc": "assets/images/personal_hygiene.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Bir martalik ishlatiladigan mahsulotlar",
    "imageSrc": "assets/images/disposable_products.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  },
  {
    "title": "Boshqalar",
    "imageSrc": "assets/images/others.png",
    "onTap": (context, index) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MarketProducts(
                    activeIndex: index,
                  )));
    }
  }
];
