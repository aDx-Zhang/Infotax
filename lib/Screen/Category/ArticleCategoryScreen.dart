import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Screen/Category/ArticleCategoryListScreen.dart';
import 'package:info_tax_square/Screen/Category/components/CategoryCardDesign.dart';
import 'package:info_tax_square/Utils/SearchFeild.dart';

class ArticleCategoryScreen extends StatelessWidget {
  ArticleCategoryScreen({
    Key? key,
  }) : super(key: key);
  var controller = Get.put(ApiController());
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchField(
            controller: textController,
            onChange: (value) {
              controller.getFilteredArticlesCategories(value);
            },
          ),
          Expanded(
            child: GetBuilder<ApiController>(builder: (controller) {
              return controller.isArticlesCategoriesLoaded.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: textController.text.isEmpty
                              ? controller.articlesCategories.length
                              : controller.filterArticlesCategories.length,
                          itemBuilder: (context, index) {
                            var category = textController.text.isEmpty
                                ? controller.articlesCategories[index]
                                : controller.filterArticlesCategories[index];
                            return CategoryCardDesign(
                              title: category.catName,
                              url: category.catNameUrl,
                              id: category.catId,
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (_)=>ArticleCategoryListScreen(catList: category.catId,)));

                                Get.to(() => ArticleCategoryListScreen(
                                      catList: category.catId,
                                    ));
                              },
                            );
                          }),
                    );
            }),
          )
        ],
      ),
    );
  }
}
