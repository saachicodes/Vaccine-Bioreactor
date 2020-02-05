//PIN ASSIGNMENTS - format - msp432 pin -> test board pin
//P3.2 -> LED1
//P4.7 -> speedsensor54
//GND -> -V
//3.3V -> +V

#define speedsensor A6                                           // define port where we're going to read motor values from
#define motor 3                                                  // so, as we can see on the msp432 docs file, only certain pins have got analogWrite capabilities, port 3.2 is one of them, that's where we're assigning our led

int rpm = Serial.read();                                                     // turns of motor per minute

void setup() {                                                   // initialize stuff, nothing out of ordinary
    pinMode(motor, OUTPUT);
    MAX_RPM = 1500
    Serial.begin(9600);

    while (Serial.available() == 0) { }      
}

void loop() {

    rpmoutput = (rpm/MAX_RPM) / (255);
    analogWrite(rpmoutput, 3);
    delay(30);
    analogWrite(0, 3);

}
