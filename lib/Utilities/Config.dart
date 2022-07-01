

class Config
{

  static var API_V = "api";
  // static var BASE_URL = "https://awezo.hissro.net/" ;
  static var BASE_URL = "http://192.168.0.106/serviceprovider/" ;

  static var CATEGORY_LIST = BASE_URL +API_V+ "/get_categories";
  static var BUSINESS_LIST = BASE_URL +API_V+ "/get_business";
  static var BUSINESS_SERVICES = BASE_URL +API_V+ "/appointment_service";
  static var GET_EMPLOYEE = BASE_URL +API_V+ "/get_doctors";
  static var BUSINESS_REVIEWS = BASE_URL +API_V+ "/get_reviews";
  static var BUSINESS_PHOTOS = BASE_URL +API_V+ "/get_photos";
  static var LOGIN_URL = BASE_URL +API_V+ "/login";
  static var signup_URL = BASE_URL +API_V+ "/signup";
  static var GET_DOCTORS = BASE_URL +API_V+ "/get_doctors";
  static var TIME_SLOT_URL = BASE_URL +API_V+ "/get_time_slot";
  static var BOOKAPPOINTMENT_URL = BASE_URL +API_V+ "/add_appointment";
  static var CANCELAPPOINTMENTS_URL = BASE_URL +API_V+ "/cancel_appointment";
  static var ADD_BUSINESS_REVIEWS = BASE_URL +API_V+ "/add_business_review";
  static var USERDATA_URL = BASE_URL +API_V+ "/get_userdata";
  static var VendorRegistration = BASE_URL +API_V+ "/vendor_registration";
  static var AddAppointment = BASE_URL +API_V+ "/add_appointment";
  static var MyAppointments = BASE_URL +API_V+ "/my_appointments";



  /* Other Path */
  static var CATEGORY_IMAGE = BASE_URL + "uploads/admin/category/";
  static var BUSINESS_IMAGE = BASE_URL +  "uploads/business/";
  static var REVIEWS_IMAGE = BASE_URL +  "uploads/profile/";
  static var REVIEWS_PHOTOS = BASE_URL +  "uploads/business/businessphoto/";





}

