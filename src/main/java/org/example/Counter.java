package org.example;

public class Counter implements AutoCloseable{
    @Override
    public void close() throws Exception {
        System.out.println("Counter closed. Final count: " + count);

    }
    private int count = 0;

    public void add() {
        count++;
    }

    public int getCount() {
        return count;
    }


}
