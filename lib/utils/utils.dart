String formatAmount(String amount){
  List list = amount.split(".");
  String last = "";
  if(list[1] != "0000"){
    try{
      last = "," + list[1].substring(0, 2);
    }catch(e){
      last = "," + list[1];
    }
  }
  String res = list[0] + last;
  return res;
}
