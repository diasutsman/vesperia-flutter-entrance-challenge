import 'package:cached_network_image/cached_network_image.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/constants/icon.dart';
import 'package:entrance_test/src/features/dashboard/products/detail/component/product_detail_controller.dart';
import 'package:entrance_test/src/models/product_model.dart';
import 'package:entrance_test/src/models/product_rating_model.dart';
import 'package:entrance_test/src/utils/date_util.dart';
import 'package:entrance_test/src/utils/number_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            "Detail Product",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color(0xFF2E2E2E),
            ),
          ),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Obx(
          () => controller.isProductDetailLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CachedNetworkImage(
                          imageUrl: controller.product?.images?.isNotEmpty ==
                                  true
                              ? controller.product?.images![0].urlSmall ?? ''
                              : '',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                            ic_error_image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              controller.product?.name ?? '',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                            Text(
                              controller.product?.price
                                      .inRupiahGrammaticallyCorrect() ??
                                  '',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Color(0xFFFFCC00),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  controller.product?.ratingAverage ?? '',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF2E2E2E),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "(${controller.product?.reviewCount.toString() ?? ''} Reviews)",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF949494),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Divider(
                        indent: 0,
                        thickness: 1,
                        endIndent: 0,
                        height: 4,
                        color: Color(0xFFF0F0F0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Product Description',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.product?.description ?? '-',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 0,
                        thickness: 1,
                        endIndent: 0,
                        height: 4,
                        color: Color(0xFFF0F0F0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Terms & Conditions of Return / Refund',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              controller.product?.returnTerms ?? '',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 0,
                        thickness: 1,
                        endIndent: 0,
                        height: 4,
                        color: Color(0xFFF0F0F0),
                      ),
                      controller.product?.reviewCount == 0
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Product Review',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: const Color(0xFF2E2E2E),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          showMoreRatings(context);
                                        },
                                        style: TextButton.styleFrom(
                                          textStyle: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: const Color(0xFF7D26CD),
                                          ),
                                        ),
                                        child: const Text(
                                          'See More',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rate_rounded,
                                        color: Color(0xFFFFCC00),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        controller.product?.ratingAverage ?? '',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF2E2E2E),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "from ${controller.product?.ratingCount ?? ''} rating",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF949494),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF949494),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${controller.product?.reviewCount ?? ''} reviews",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF949494),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  controller.isProductRatingsLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final productRating = controller
                                                .productRatings[index];
                                            return productRatingItem(
                                              productRating: productRating,
                                            );
                                          },
                                          itemCount:
                                              controller.productRatings.length,
                                        ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void showMoreRatings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        final DraggableScrollableController productSheetController =
            DraggableScrollableController();
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          initialChildSize: 0.5,
          maxChildSize: 0.5,
          minChildSize: 0.5,
          // controller: controller.productSheetController,
          controller: productSheetController,
          builder: (context, scrollController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: SizedBox(
                      width: 100,
                      child: Divider(
                        thickness: 5,
                        color: Color(0xFF949494),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PagedListView<int, ProductRatingModel>(
                    padding: const EdgeInsets.all(24),
                    shrinkWrap: true,
                    pagingController: controller.productRatingsPagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<ProductRatingModel>(
                      itemBuilder: (context, item, index) => productRatingItem(
                        productRating: item,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget productRatingItem({required ProductRatingModel productRating}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: productRating.user.profilePicture ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                    ic_error_image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productRating.user.name,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xFF2E2E2E),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: List.generate(
                      productRating.rating,
                      (_) {
                        return const Icon(
                          Icons.star_rate_rounded,
                          color: Color(0xFFFFCC00),
                        );
                      },
                    ),
                  )
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(
                DateUtil.getTimeAgo(
                  productRating.createdAt,
                ),
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: const Color(0xFF949494),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            productRating.review,
            textAlign: TextAlign.left,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: const Color(0xFF2E2E2E),
            ),
          ),
        ],
      ),
    );
  }
}
