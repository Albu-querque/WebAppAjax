package com.web.goodswebapp.entities;

import java.time.LocalDate;

public class Product {
    private long id;
    private String name;
    private String description;
    private LocalDate create_date;
    private long place_storage;
    private boolean reserved;

    public Product() {}

    public Product(String name, String description, LocalDate create_date, long place_storage, boolean reserved) {
        this.name = name;
        this.description = description;
        this.create_date = create_date;
        this.place_storage = place_storage;
        this.reserved = reserved;
    }

    public Product(long id, String name, String description, LocalDate create_date, long place_storage, boolean reserved) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.create_date = create_date;
        this.place_storage = place_storage;
        this.reserved = reserved;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getCreate_date() {
        return create_date;
    }

    public void setCreate_date(LocalDate create_date) {
        this.create_date = create_date;
    }

    public long getPlace_storage() {
        return place_storage;
    }

    public void setPlace_storage(long place_storage) {
        this.place_storage = place_storage;
    }

    public boolean isReserved() {
        return reserved;
    }

    public void setReserved(boolean reserved) {
        this.reserved = reserved;
    }
}
