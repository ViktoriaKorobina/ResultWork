package org.example;

import java.util.HashMap;

public class Livestocks implements Animals{
    HashMap<String, String> hashMapLivestocks = new HashMap<>();

    HashMap<String, String> hashMapCommands = new HashMap<>();

    @Override
    public void addAnimal(String name, String type) {
        if (name == null || type == null || name.isEmpty() || type.isEmpty()) {
            throw new IllegalArgumentException("Имя и вид животного должны быть заполнены.");
        }
        try(Counter counter = new Counter()) {
            hashMapLivestocks.put(name, type);
            counter.add();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delAnimal(String name, String type) {
        hashMapLivestocks.remove(name, type);
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
