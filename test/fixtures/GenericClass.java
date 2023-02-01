package com.yalingunayer.java_parser;

import com.yalingunayer.somepackage.SomeClass;
import com.yalingunayer.anotherpackage.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@EqualsAndHashCode(callSuper = true)
public class GenericClass<T> extends SomeOtherClass<T> implements Serializable {
  // some comment
  private static final int serialVersionUid = 1;

  private int id;
  private String name;

  @Builder.Default
  private final List<String> foos = List.of("foo", "bar");

  private final List<Integer> bars = new ArrayList<>();

  /**
   * Some JavaDoc here
   *
   * @return int the ID
   */
  public int getId() {
    return this.id;
  }

  @Override
  public String getName() {
    return this.name;
  }

  public List<String> getFooFoos() {
    return this.foos.stream().filter(foo -> "foo".equals(foo)).collect(Collectors::toList());
  }

  public int maxId(FooClass a, FooClass b) {
    int idA = a.getId();
    int idB = b.getId();
    return Math.max(idA, idB);
  }
}
