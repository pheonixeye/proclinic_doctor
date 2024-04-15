String visitTypeTranslated(String type, bool isEnglish) {
  if (isEnglish) {
    return type;
  } else {
    return switch (type) {
      'Consultation' => 'كشف',
      'Follow Up' => 'استشارة',
      'Procedure' => 'اجراء طبي',
      _ => throw UnimplementedError(),
    };
  }
}
