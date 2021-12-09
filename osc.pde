void sendFloat(String name, float data){
    OscMessage message = new OscMessage("/"+name);
    message.add(data); 
    sendMessage(message);
}

void sendTrigger(String name){
    OscMessage message = new OscMessage("/"+name);
    sendMessage(message);
}

void sendMessage(OscMessage message){
  oscP5.send(message, remoteLocation); 
}
