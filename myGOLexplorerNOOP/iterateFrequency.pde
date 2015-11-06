//void iterateFrequency(int interval, boolean pause, boolean iterateStepy) {  

void iterateFrequency() { 
  
  // Iterate if timer ticks                    run iteration function every 100mills 
  if (millis()-lastRecordedTime>interval) {          // if 100 mills passed since lastRecordedTime,
  
    if (!pause) {                         // if user didn't pause it
    
      iteration();                        // do iteration
      lastRecordedTime = millis();             // mark this moment as lastRecordedTime (for iteration)
      
      
    } else if (iterateStepy) {
      // println(iterateStepy);
      iteration(); 
      iterateStepy = !iterateStepy;
    } else {
      // nothing happens, no iteration
    }
  }
  
}