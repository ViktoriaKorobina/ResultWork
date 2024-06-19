package org.example;
import java.util.HashMap;
import java.util.Scanner;

public class MenuNavigator {
    public Object hashMapPets;
    private HashMap<Integer, String> menuOptions = new HashMap<>();
    Pets pets = new Pets();
    Livestocks livestocks = new Livestocks();

    public MenuNavigator() {
        menuOptions.put(1, "Добавить животное");
        menuOptions.put(2, "Удалить животное");
        menuOptions.put(3, "Получить команду для животного");
        menuOptions.put(4, "Добавить команду для животного");
    }

    public void displayMenu() {
        System.out.println("Меню:");
        for (Integer optionId : menuOptions.keySet()) {
            System.out.println(optionId + ". " + menuOptions.get(optionId));
        }
    }

    public void handleUserInput() {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Введите 1, если животное домашнее и 2 - если вьючное: ");
        int cl = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Введите номер опции: ");
        int choice = scanner.nextInt();
        scanner.nextLine();
        System.out.println("Введите имя животного: ");
        String name = scanner.nextLine();
        System.out.println("Введите вид животного: ");
        String type = scanner.nextLine();
        System.out.println("Введите команду: ");
        String command = scanner.nextLine();
        if (cl == 1) {
            switch (choice) {
                case 1:
                    pets.addAnimal(name, type);
                    break;
                case 2:
                    pets.delAnimal(name, type);
                    break;
                case 3:
                    pets.getCommand(type);
                    break;
                case 4:
                    pets.setCommand(type, command);
                    break;

                default:
                    System.out.println("Некорректный выбор.");
            }
        }
        else if (cl == 2) {
            switch (choice) {
                case 1:
                    livestocks.addAnimal(name, type);
                    break;
                    case 2:
                        livestocks.delAnimal(name, type);
                        break;
                    case 3:
                        livestocks.getCommand(type);
                        break;
                    case 4:
                        livestocks.setCommand(type, command);
                        break;

                    default:
                        System.out.println("Некорректный выбор.");
                }
            }
            else {
                System.out.println("Некорректный выбор.");
            }
        }
    }


