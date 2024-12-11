enum AddonInputType {
  colorPicker,
  checkbox,
  dropdown;

  factory AddonInputType.fromString(String value) {
    switch (value) {
      case 'colorPicker':
        return AddonInputType.colorPicker;
      case 'checkbox':
        return AddonInputType.checkbox;
      case 'dropdown':
        return AddonInputType.dropdown;
      default:
        return AddonInputType.dropdown;
    }
  }

  bool get isColor => this == AddonInputType.colorPicker;
}
