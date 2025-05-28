import 'package:equatable/equatable.dart';
import 'dart:io';

// Manually define the state class inheriting from Equatable
class FastTagState extends Equatable {
  final bool isLoading;
  final String error;
  final File? rcFrontImage;
  final File? rcBackImage;
  final File? idProof;
  final File? addressProof;
  final File? vehiclePhoto;
  final File? ownerPhoto;
  final String vehicleNumber;
  final String chasisNumber;
  final String engineNumber;
  final String ownerName;
  final String vehicleClass;
  final String fuelType;
  final String makerModel;
  final String insuranceExpiry;
  final String emissionNorms;
  final String registrationDate;
  final String fitnessUpto;
  final String mvTaxUpto;
  final String puccUpto;
  final String rcStatus;
  final String panCard;
  final String dob;
  final String mobileNumber;
  final String email;
  final String address;
  final String registeringAuthority;
  final Map<String, dynamic>? rechargeDetails;

  const FastTagState({
    this.isLoading = false,
    this.error = '',
    this.rcFrontImage,
    this.rcBackImage,
    this.idProof,
    this.addressProof,
    this.vehiclePhoto,
    this.ownerPhoto,
    this.vehicleNumber = '',
    this.chasisNumber = '',
    this.engineNumber = '',
    this.ownerName = '',
    this.vehicleClass = '',
    this.fuelType = '',
    this.makerModel = '',
    this.insuranceExpiry = '',
    this.emissionNorms = '',
    this.registrationDate = '',
    this.fitnessUpto = '',
    this.mvTaxUpto = '',
    this.puccUpto = '',
    this.rcStatus = '',
    this.panCard = '',
    this.dob = '',
    this.mobileNumber = '',
    this.email = '',
    this.address = '',
    this.registeringAuthority = '',
    this.rechargeDetails = null,
  });

  // Manually implement copyWith
  FastTagState copyWith({
    bool? isLoading,
    String? error,
    File? rcFrontImage,
    File? rcBackImage,
    File? idProof,
    File? addressProof,
    File? vehiclePhoto,
    File? ownerPhoto,
    String? vehicleNumber,
    String? chasisNumber,
    String? engineNumber,
    String? ownerName,
    String? vehicleClass,
    String? fuelType,
    String? makerModel,
    String? insuranceExpiry,
    String? emissionNorms,
    String? registrationDate,
    String? fitnessUpto,
    String? mvTaxUpto,
    String? puccUpto,
    String? rcStatus,
    String? panCard,
    String? dob,
    String? mobileNumber,
    String? email,
    String? address,
    String? registeringAuthority,
    Map<String, dynamic>? rechargeDetails,
  }) {
    return FastTagState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      rcFrontImage: rcFrontImage ?? this.rcFrontImage,
      rcBackImage: rcBackImage ?? this.rcBackImage,
      idProof: idProof ?? this.idProof,
      addressProof: addressProof ?? this.addressProof,
      vehiclePhoto: vehiclePhoto ?? this.vehiclePhoto,
      ownerPhoto: ownerPhoto ?? this.ownerPhoto,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      chasisNumber: chasisNumber ?? this.chasisNumber,
      engineNumber: engineNumber ?? this.engineNumber,
      ownerName: ownerName ?? this.ownerName,
      vehicleClass: vehicleClass ?? this.vehicleClass,
      fuelType: fuelType ?? this.fuelType,
      makerModel: makerModel ?? this.makerModel,
      insuranceExpiry: insuranceExpiry ?? this.insuranceExpiry,
      emissionNorms: emissionNorms ?? this.emissionNorms,
      registrationDate: registrationDate ?? this.registrationDate,
      fitnessUpto: fitnessUpto ?? this.fitnessUpto,
      mvTaxUpto: mvTaxUpto ?? this.mvTaxUpto,
      puccUpto: puccUpto ?? this.puccUpto,
      rcStatus: rcStatus ?? this.rcStatus,
      panCard: panCard ?? this.panCard,
      dob: dob ?? this.dob,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      registeringAuthority: registeringAuthority ?? this.registeringAuthority,
      rechargeDetails: rechargeDetails ?? this.rechargeDetails,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        rcFrontImage,
        rcBackImage,
        idProof,
        addressProof,
        vehiclePhoto,
        ownerPhoto,
        vehicleNumber,
        chasisNumber,
        engineNumber,
        ownerName,
        vehicleClass,
        fuelType,
        makerModel,
        insuranceExpiry,
        emissionNorms,
        registrationDate,
        fitnessUpto,
        mvTaxUpto,
        puccUpto,
        rcStatus,
        panCard,
        dob,
        mobileNumber,
        email,
        address,
        registeringAuthority,
        rechargeDetails,
      ];
}
