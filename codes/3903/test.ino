const int PIN = A0;

void setup(){
    Serial.begin(9600);
}

void loop(){
    voltage = analogRead(PIN);
    Serial.println(voltage);
    delay(10);
}
