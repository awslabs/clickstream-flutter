// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0
class ClickstreamItem {
  ClickstreamItem({
    this.id,
    this.name,
    this.locationId,
    this.brand,
    this.currency,
    this.price,
    this.quantity,
    this.creativeName,
    this.creativeSlot,
    this.category,
    this.category2,
    this.category3,
    this.category4,
    this.category5,
    this.attributes,
  });

  final String? id;
  final String? name;
  final String? locationId;
  final String? brand;
  final String? currency;
  final num? price;
  final int? quantity;
  final String? creativeName;
  final String? creativeSlot;
  final String? category;
  final String? category2;
  final String? category3;
  final String? category4;
  final String? category5;
  // used to add custom item attribute.
  final Map<String, Object?>? attributes;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (locationId != null) 'location_id': locationId,
      if (brand != null) 'brand': brand,
      if (currency != null) 'currency': currency,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (creativeName != null) 'creative_name': creativeName,
      if (creativeSlot != null) 'creative_slot': creativeSlot,
      if (category != null) 'category': category,
      if (category2 != null) 'category2': category2,
      if (category3 != null) 'category3': category3,
      if (category4 != null) 'category4': category4,
      if (category5 != null) 'category5': category5,
      if (attributes != null) ...attributes!,
    };
  }
}
