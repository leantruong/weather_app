import 'package:flutter/material.dart';
import 'package:weather_app/features/location/data/models/city_model.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/utils/debounce.dart';
import 'custom_container.dart';
import 'search_form_widget.dart';

class SearchSelectionChild extends StatefulWidget {
  final List<CityModel> items;
  final CityModel? selectedItem;
  final String Function(CityModel)? valueShow;
  final bool Function(CityModel)? indexWhereCondition;
  final String? title;
  final ValueChanged<CityModel?>? onChanged;
  final Function(CityModel model) onSelected;
  final Function(String? value)? onSearchChanged;
  final bool showSearchBox;

  const SearchSelectionChild(this.items,
      {Key? key,
      this.onChanged,
      this.valueShow,
      this.indexWhereCondition,
      this.selectedItem,
      this.title,
      this.showSearchBox = true,
      this.onSearchChanged,
      required this.onSelected})
      : super(key: key);

  @override
  State<SearchSelectionChild> createState() => _SearchSelectionChildState();
}

class _SearchSelectionChildState<T> extends State<SearchSelectionChild> {
  int? _selectedItemIndex;
  List<int> shownIndexes = [];
  List<CityModel> itemsShow = [];
  final searchController = TextEditingController(text: '');

  int? getIndex() {
    int? selected;
    if (widget.indexWhereCondition != null) {
      selected = widget.items.indexWhere(widget.indexWhereCondition!);
    } else {
      selected = widget.selectedItem == null
          ? null
          : widget.items.indexOf(widget.selectedItem as CityModel);
    }
    return selected == -1 ? null : selected;
  }

//   @override
//   void didUpdateWidget(covariant SearchSelectionChild oldWidget) {
//     if (oldWidget.selectedItem != widget.selectedItem) {
//       _selectedItemIndex = getIndex();
//     }
//     super.didUpdateWidget(oldWidget);
//   }

  void _onSearchChanged(String value) {
    EasyDebouncer().run(const Duration(milliseconds: 400), () {
        itemsShow = CityModel.citiesList
            .where((element) =>
                element.city.toLowerCase().contains(value.toLowerCase()))
            .toList();

    //   final list = CityModel.citiesList
    //       .map((e) => e.city)
    //       .where((element) => element.toLowerCase().contains('b'))
    //       .toList();
    //   itemsShow = CityModel.citiesList
    //       .where((element) => list.contains(element.city))
    //       .toList();

      setState(() {});
    //   print(list);
    //   print(itemsShow.map((e) => e.city).toList());
    });
  }

  void _cancelSearch() {
    searchController.clear();
    itemsShow = widget.items;
    setState(() {});
  }

  @override
  void initState() {
    //  _selectedItemIndex = getIndex();
    itemsShow = widget.items;

    shownIndexes = List.generate(widget.items.length, (index) => index);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Visibility(
                    visible: widget.showSearchBox,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SearchFromWidget(
                        cancelAction: _cancelSearch,
                        onChanged: (value) {
                          widget.onSearchChanged?.call(value);

                          _onSearchChanged(value);
                        },
                        controller: searchController,
                        hint: 'Search ${widget.title}',
                      ),
                    ),
                  ),
                  Expanded(
                    child: itemsShow.isEmpty
                        ? const Center(
                            child: Text('Not found city'),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: itemsShow.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              itemBuilder: (_, index) {
                                final data = itemsShow[index];
                                final isMatching =
                                    _selectedItemIndex == shownIndexes[index];
                                return InkWell(
                                    onTap: () {
                                      _selectedItemIndex = shownIndexes[index];
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);

                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      setState(() {});
                                      widget.onSelected(data);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        color: Colors.white,
                                        border: isMatching
                                            ? Border.all(
                                                color: AppColors.secondaryColor
                                                    .withOpacity(.3),
                                                width: 2,
                                              )
                                            : Border.all(color: Colors.white),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_city,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data.city,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: isMatching == true
                                                  ? AppColors.textActive
                                                  : AppColors.bgCard,
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 16.0,
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
