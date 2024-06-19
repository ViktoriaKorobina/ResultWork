package org.example;
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        MenuNavigator menuNavigator = new MenuNavigator();
        menuNavigator.displayMenu();
        menuNavigator.handleUserInput();
        for (Map.Entry<String, String> entry : menuNavigator.pets.hashMapPets.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
        for (Map.Entry<String, String> entry : menuNavigator.livestocks.hashMapLivestocks.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
    }
}