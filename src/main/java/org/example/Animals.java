package org.example;

public interface Animals {

    void addAnimal(String name, String type);

    void delAnimal(String name, String type);
    String getCommand(String type);
    void setCommand(String type, String command);




}
