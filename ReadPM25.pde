/**
 * Read and Display PlanTower PM2.5 sensor.
 * 
 * You need first install PL2303 USB2TTL drivers.
 * The driver download url is: http://www.prolific.com.tw/US/ShowProduct.aspx?pcid=41&showlevel=0017-0037-0041
 * 
 * Author: Bob Yang / bob.yang.dev@gmail.com
 */
PM25Decoder pm25Decoder;
PFont font;

void setup() 
{
  size(800, 800);
  background(255);
  font = createFont("宋体", 48, true);
  pm25Decoder = new PM25Decoder(this);
  pm25Decoder.setup();
}

void draw()
{
  background(255);             // Set background to white
  fill(0);
  pm25Decoder.update();
  int pm25CF1 = pm25Decoder.pm25Cf1();
  int pm25 = pm25Decoder.pm25();
  int pm10CF1 = pm25Decoder.pm10Cf1();
  int pm10 = pm25Decoder.pm10();
  int pm03Count = pm25Decoder.pm03Count();
  int pm05Count = pm25Decoder.pm05Count();
  int pm1Count = pm25Decoder.pm1Count();
  int pm25Count = pm25Decoder.pm25Count();
  int pm5Count = pm25Decoder.pm5Count();
  int pm10Count = pm25Decoder.pm10Count();
  
  textFont(font, 48);
  text("PM2.5浓度(CF1) "+ pm25CF1 + "μg/m³", 50, 70);
  text("PM2.5浓度(ATM) "+ pm25 + "μg/m³", 50, 70*2);
  text("PM10浓度(CF1) "+ pm10CF1 + "μg/m³", 50, 70*3);
  text("PM10浓度(ATM) "+ pm10 + "μg/m³", 50, 70*4);
  
  text("PM>0.3um Count: "+ pm03Count + "/0.1L", 50, 70*5);
  text("PM>0.5um Count: "+ pm05Count + "/0.1L", 50, 70*6);
  text("PM>1.0um Count: "+ pm1Count + "/0.1L", 50, 70*7);
  text("PM>2.5um Count: "+ pm25Count + "/0.1L", 50, 70*8);
  text("PM>5.0um Count: "+ pm5Count + "/0.1L", 50, 70*9);
  text("PM>10um Count: "+ pm10Count + "/0.1L", 50, 70*10);
  
}

