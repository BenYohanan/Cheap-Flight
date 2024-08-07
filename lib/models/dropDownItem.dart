class TravelOption {
  final String value;
  final String label;

  TravelOption({required this.value, required this.label});
}

class TravelSelection {
  TravelOption? from;
  TravelOption? to;
  int adults;
  int children;
  int infants;

  TravelSelection({
    this.from,
    this.to,
    this.adults = 1,
    this.children = 0,
    this.infants = 0,
  });
}

class TravelViewModel {
  List<TravelOption> locations = [
    TravelOption(value: 'ABB', label: 'ASABA (ABB)'),
    TravelOption(value: 'ABV', label: 'Abuja (ABV)'),
    TravelOption(value: 'AKR', label: 'Akure (AKR)'),
    TravelOption(value: 'ANA', label: 'Anambra (ANA)'),
    TravelOption(value: 'BNI', label: 'Benincity (BNI)'),
    TravelOption(value: 'CBQ', label: 'Calabar (CBQ)'),
    TravelOption(value: 'ENU', label: 'Enugu (ENU)'),
    TravelOption(value: 'GMO', label: 'Gombe (GMO)'),
    TravelOption(value: 'IBA', label: 'Ibadan (IBA)'),
    TravelOption(value: 'ILR', label: 'Ilorin (ILR)'),
    TravelOption(value: 'KAD', label: 'Kaduna (KAD)'),
    TravelOption(value: 'KAN', label: 'Kano (KAN)'),
    TravelOption(value: 'LOS', label: 'Lagos (LOS)'),
    TravelOption(value: 'MIU', label: 'Maiduguri (MIU)'),
    TravelOption(value: 'MDI', label: 'Makurdi (MDI)'),
    TravelOption(value: 'QOW', label: 'Owerri (QOW)'),
    TravelOption(value: 'PHC', label: 'Portharcourt (PHC)'),
    TravelOption(value: 'QUO', label: 'Uyo (QUO)'),
    TravelOption(value: 'QRW', label: 'Warri (QRW)'),
    TravelOption(value: 'YOL', label: 'Yola (YOL)'),
  ];

  List<TravelOption> adultOptions = List.generate(9, (index) {
    return TravelOption(
        value: '${index + 1}', label: '${index + 1} Adult (12yrs+)');
  });

  List<TravelOption> childOptions = List.generate(7, (index) {
    return TravelOption(
        value: '$index',
        label: '$index Child${index > 1 ? ' (2 - 11yrs)' : ''}');
  });

  List<TravelOption> infantOptions = List.generate(7, (index) {
    return TravelOption(
        value: '$index', label: '$index Infant${index > 1 ? ' (< 2yrs)' : ''}');
  });
}
