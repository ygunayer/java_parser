package com.yalingunayer.java_parser;

import com.yalingunayer.somepackage.SomeClass;
import com.yalingunayer.anotherpackage.*;

public class FooClass {
  // some comment
  private static final int serialVersionUid = 1;

  private int id;
  private String name;
  private final List<String> foos = List.of("foo", "bar");

  public int getId() {
    return this.id;
  }

  public String getName() {
    return this.name;
  }

  public List<String> getFooFoos() {
    return this.foos.stream().filter(foo -> "foo".equals(foo)).collect(Collectors::toList());
  }
}
