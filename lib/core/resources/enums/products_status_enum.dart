enum ProductsStatus {
  active,
  inactive;

  factory ProductsStatus.fromString(String value) {
    switch (value) {
      case 'active':
        return ProductsStatus.active;
      case 'inactive':
        return ProductsStatus.inactive;
      default:
        return ProductsStatus.inactive;
    }
  }
}
