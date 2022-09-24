#include <Wire.h> 
/*
  Description:


  Prepared by: Juan Tlilayatzi 
  Date: September 23 2022 
*/

int dev_address = 0x50 << 1; // Left shifted dev address 
byte tx_data[4]; // transmitting data 4 bytes  
byte rx_data[6]; // receiving data 6 bytes 


void setup() {
  Serial.begin(9600); // begin serial communication at 9600 baud rate per second  

}

void loop() {
  // put your main code here, to run repeatedly:
}

void dataWriteMessage(byte address, byte command, byte* tx_data, int n_bytes){
  Wire.beginTransmission(address); // begin transmission to the I2C peripheral device with given address 
  Wire.write(command); // write command data from a peripheral device in response to a request from controller device 
  Wire.write(tx_data, n_bytes);  
  Wire.endTransmission(); // ends a transmission to a peripheral device
}

void dataRequestMessage(byte address, byte command, byte* rx_data, int n_bytes){
  // Setup Request Message 
  Wire.beginTransmission(address); 
  Wire.write(command);
  Wire.endTransmission(); 

  Wire.requestFrom(address, n_bytes); //request bytes from a peripheral device. 
  
  // returns the number of bytes available for retrieval 
  while(Wire.available()){
    *rx_data++ = Wire.read(); 
  }  

  Wire.write(rx_data, n_bytes); 
}
