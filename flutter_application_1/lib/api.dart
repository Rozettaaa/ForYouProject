class ApiUrl {
  // ค่าตัวแปรสำหรับใช้งานจริง
  static const String liveBaseURL = "https://localhost/foryou_project";
  // กรณีทดสอบที่ localhost android ใช้ค่าตามนี้ได้เลย เปลี่ยน path และ port เท่านั้น
  static const String localBaseURL = "http://192.168.1.42/foryou_project";

// ทดสอบที่เครื่องใช้ค่านี้
  static const String baseURL = localBaseURL; // ทดสอบที่เครื่องใช้ค่านี้
  static const String logincustomer = baseURL + "/logincustomer.php";
  static const String logincaregiver = baseURL + "/logincaregiver.php";
  static const String registercustomer = baseURL + "/createcustomer.php";
  static const String registercaregiver = baseURL + "/createcaregiver.php";
  static const String selectcity = baseURL + "/selectcity.php";
  static const String selectcityby = baseURL + "/selectcityby.php";
  static const String selectall = baseURL + "/selectall.php";
  static const String selectdatacustomer = baseURL + "/selectdatacustomer.php";
  static const String reservation = baseURL + "/reservation.php";
  static const String getreservation = baseURL + "/getwait.php";
}
