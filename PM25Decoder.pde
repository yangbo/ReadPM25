/**
 * Read and Display PlanTower PM2.5 sensor.
 * 
 * You need first install PL2303 USB2TTL drivers.
 * The driver download url is: http://www.prolific.com.tw/US/ShowProduct.aspx?pcid=41&showlevel=0017-0037-0041
 * 
 * Author: Bob Yang / bob.yang.dev@gmail.com
 */
import processing.serial.*;

class PM25Decoder {
  
  private String portName;
  private Serial port;  // Create object from Serial class
  private PApplet context;
  private int[] frame = new int[32];
  
  // Do not specify port name.
  // We will guess the PL2303 usb serials dev file name.
  public PM25Decoder(PApplet context){
    this.context = context;
  }
  
  // Can specify port name
  public PM25Decoder(PApplet context, String portName){
    this.context = context;
  }
  
  public void setup(){
    if (portName == null || portName.length() == 0){
        for (String name : Serial.list()){
          if (name.contains("usb")){
            portName = name;
            break;
          }
        }
    }
    if (portName == null || portName.length() == 0){
      println("Port Name is empty!");
    }else{
      println("Connect to port name: " + portName);
      port = new Serial(context, portName, 9600);
    }
  }
  
  public void update(){
    int val = 0;
    if ( port != null ) {
      readFrame();
    }
  }
  
  private void readFrame(){
    while(port.available() >= 32){
      if (port.read() == 0x42 && port.read()==0x4d){
        frame[0] = 0x42;
        frame[1] = 0x4d;
        
        for (int i=0; i<30; i++){
          int inByte = port.read();
          if (inByte != -1){
            frame[i+2] = inByte;
          }
        }
        printFrame();
      }
    }
  }
  
  private void printFrame(){
    for (int n : frame){
      print(n+" ");
    }
    println("");
  }
  
  // pm1.0 (cf=1,standard particle material)
  public int pm1Cf1(){
    return getInt(4);
  }
  
  // last pm2.5 values
  public int pm25Cf1(){
    return getInt(6);
  }
  
  // pm10 (cf=1, standard particle material)
  public int pm10Cf1(){
    return getInt(8);
  }
  
  // pm1.0 (atmosphere environment)
  public int pm1(){
    return getInt(10);
  }
  
  // pm2.5 (atmosphere environment)
  public int pm25(){
    return getInt(12);
  }
  
  // pm10 (atmosphere environment)
  public int pm10(){
    return getInt(14);
  }
  
  // 0.3 um pm count / 0.1 L
  public int pm03Count(){
    return getInt(16);
  }
  
  // 0.5 um pm count / 0.1 L
  public int pm05Count(){
    return getInt(18);
  }
  
  // 1.0 um pm count / 0.1 L
  public int pm1Count(){
    return getInt(20);
  }
  
  // 2.5 um pm count / 0.1 L
  public int pm25Count(){
    return getInt(22);
  }
  // 5.0 um pm count / 0.1 L
  public int pm5Count(){
    return getInt(24);
  }
  // 10 um pm count / 0.1 L
  public int pm10Count(){
    return getInt(26);
  }
  
  private int getInt(int index){
    int val = (frame[index]<<8 | frame[index+1]);
    return val;
  }
  
}
