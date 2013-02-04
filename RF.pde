/******************************************************************************
* RF434 decode for ARDUINO/Energia
*
* Description: This RF434MHz decoding was retturn by Bharadwaaj for decoding the codes encoded by EV1527. This 
*              Code works fine with both MSP430 based Energia as well as Arduino. 
* 
* Author: Bharadwaaj RA
* Source: https://github.com/bharadwaaj
* Email: bhaaradwaaj@gmail.com
* Date: 04/01/2013
*
* Note: Any bug reports or issues feel free to contact the author. 
*       Also note that the Data pin should be connected to ground.
******************************************************************************/



#define PREAMBLE_PERIOD 10000
#define MIN_LOW_TIME 200
#define NO_OF_BITS 24
#define ADD_NO_OF_BITS 20
#define KEY_NO_OF_BITS 4
#define THER_LOW_PERIOD 700

void setup()
{
  Serial.begin(9600);
}
short unsigned int i=0;
short unsigned int a[24] ={0,};
short unsigned int temp=0;
short unsigned int add_val=0;
short unsigned int key = 0;
void loop()
{
  
    add_val=0;
    key=0;
    temp = pulseIn(2,LOW);
    
    if(temp>=PREAMBLE_PERIOD)
    {
      
      while(i<NO_OF_BITS)
      {
        temp = pulseIn(2,LOW);
        if(temp>MIN_LOW_TIME)
        {
          a[i++]=temp;
        }
      }
      for(i=0;i<NO_OF_BITS;i++)
      {
        if(i<ADD_NO_OF_BITS)
        {
          if(a[i]>THER_LOW_PERIOD)
            add_val |= (1<<i); 
        }
        else
        {
          if(a[i]>THER_LOW_PERIOD)
            key |= (1<<(i-ADD_NO_OF_BITS)); 
        }
      }
      i=0;
      Serial.print("Address is:");
      Serial.println(add_val);
      Serial.print("Key is:");
      Serial.println(key);
      
    }
}
