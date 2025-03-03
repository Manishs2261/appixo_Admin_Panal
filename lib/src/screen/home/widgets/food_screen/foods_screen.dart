import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/widgets/shimmer_effect.dart';
import 'food_controller.dart';
import 'model/food_model.dart';

class FoodsScreen extends StatelessWidget {
  FoodsScreen({
    super.key,
  });

  final listOfFoodController  = Get.put(ListOfFoodController());

  @override
  Widget build(BuildContext context) {
    return  Obx(
          () => listOfFoodController.isLoadingInitial.value
          ? ListView.builder(
        // Shimmer effect during the initial load
        itemCount: 2, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return ShimmerEffect(
            width: double.infinity,
            height: 200,
            bottomShimmer: true,
            bottomWidth: double.infinity,
            bottomHeight: 20,
          );
        },
      )
          : CustomMaterialIndicator(
        durations: RefreshIndicatorDurations(
            settleDuration: Duration(milliseconds: 1000)),
        onRefresh: () async {
          listOfFoodController.foodListData.clear();
          listOfFoodController.lastDocument = null;
          listOfFoodController.hasMoreData.value = true;
          await listOfFoodController.fetchData();
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const CircularProgressIndicator(
            color: Colors.blue,
          );
        },
        child: listOfFoodController.foodListData.isEmpty &&
            !listOfFoodController.isLoadingMore.value
            ? Center(
          child: Text(
            'No rooms available. Pull to refresh.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        )
            : Wrap(
          spacing: 8, // Space between cards
          runSpacing: 8, // Space between rows
          children: List.generate(
            listOfFoodController.isLoadingMore.value
                ? listOfFoodController.foodListData.length + 1
                : listOfFoodController.foodListData.length,
                (index) {
              if (index == listOfFoodController.foodListData.length &&
                  listOfFoodController.isLoadingMore.value) {
                return SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              }
              return FoodCard(foodModel: listOfFoodController.foodListData[index],);
            },
          ),
        )

          ),
    );
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key, required this.foodModel,
  });

  final FoodModel foodModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Set card width dynamically
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4), // Shadow offset
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 140,
                  // Set a fixed height for the PageView
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodModel.imageList?.length ?? 0,
                      itemBuilder: (context, imageIndex) {
                        print(foodModel.imageList?[imageIndex]);
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width * 0.8,
                              imageUrl:foodModel.imageList?[imageIndex] ?? '',
                              placeholder: (context, url) => ShimmerEffect(
                                  width: MediaQuery.of(context).size.width * 0.8, height: 140),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.image_outlined),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                ),
    // Name
                Text(
                  foodModel.shopName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Name
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Dark color for contrast
                  ),
                ),
                Text(
                foodModel.userName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Name
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87, // Dark color for contrast
                  ),
                ),
    // Email
                Text(
                  foodModel.userName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Email
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey, // Lighter text color
                  ),
                ),
    // City
                Row(
                  children: [
                    Icon(Icons.location_city, size: 16, color: Colors.grey),
    // City icon
                    SizedBox(width: 4),
                    Text(
                      'New York City',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // City
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


