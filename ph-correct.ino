#define pH A6
#define pumpAcid A0 //led 2
#define pumpAlkaline A1 //led1

float pH_value = 0.0f;
float wantedPh = 5.0f;
char inByte;
String tempHold = "";

void setup() {
 // put your setup code here, to run once:
    pinMode(pH, INPUT);
    pinMode(pumpAcid, OUTPUT);
    pinMode(pumpAlkaline, OUTPUT);
    // initialize serial communications:
    Serial.begin(9600);
}

void loop() {
    if (Serial.available() > 0) {
        // get incoming byte:
        inByte = (char) Serial.read();
        if(inByte == 'R') {
            readpHSensor();
        } else if (inByte != 'W') {
           tempHold += inByte;
           if (tempHold.length() == 4) {
               wantedPh = tempHold.toFloat();
               tempHold = "";
           }
        }
    }

    setpHPumps();
}

void setpHPumps() {
    if (pH_value > wantedPh + 0.5f){
        digitalWrite(pumpAcid, HIGH);
    } else {
        digitalWrite(pumpAcid, LOW);
    }

    if (pH_value < wantedPh - 0.5f){
        digitalWrite(pumpAlkaline, HIGH);
    } else {
        digitalWrite(pumpAlkaline, LOW);
    }
}

void readpHSensor() {
    for (int i = 0; i < 10; i++) {
        //Serial.println(digitalRead(pH));

        float analogValue = (analogRead(pH) / 1023.0) * 0.828 - 0.414;
        //Serial.println((analogRead(pH) / 1024.0) * 3.6);
        pH_value += 7.0 - ((analogValue * 9.6485309 * 10000) / (8.314510 * 298 * 2.30258509299));

        delay(100);
    }
    Serial.println(pH_value / 10.0);
    pH_value = 0.0f;
}

