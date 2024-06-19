package org.example;

import java.io.IOException;
import java.util.HashMap;

public class Pets implements Animals{

    HashMap<String, String> hashMapPets = new HashMap<>();


    HashMap<String, String> hashMapCommands = new HashMap<>();

    @Override
    public void addAnimal(String name, String type) {
        if (name == null || type == null || name.isEmpty() || type.isEmpty()) {
            throw new IllegalArgumentException("Имя и вид животного должны быть заполнены.");
        }
        try(Counter counter = new Counter()) {
            hashMapPets.put(name, type);
            counter.add();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public void delAnimal(String name, String type) {
        hashMapPets.remove(name, type);

    }

    @Override
    public String getCommand(String type) {
        String command = hashMapCommands.get(type);
        return command;
    }

    @Override
    public void setCommand(String type, String command) {

        hashMapCommands.put(type, command);

    }



}
