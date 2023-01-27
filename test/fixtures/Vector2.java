package com.yalingunayer.sandbox;

import lombok.Data;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

@Data
public class Vector2 implements Serializable {
    private static final int serialVersionUid = 1;

    public static final Vector2 ZERO = new Vector2(0, 0);
    public static final Vector2 ONE = new Vector2(1, 1);
    public static final Vector2 UP = new Vector2(0, 1);
    public static final Vector2 DOWN = new Vector2(0, -1);
    public static final Vector2 RIGHT = new Vector2(1, 0);
    public static final Vector2 LEFT = new Vector2(-1, 0);

    private final double x;

    private final double y;

    /**
     * Returns the X component of the vector
     *
     * @return the X component
     */
    public double getX() {
        return this.x;
    }

    /**
     * Returns the Y component of the vector
     *
     * @return the Y component
     */
    public double getY() {
        return this.y;
    }

    /**
     * Returns the length of the vector
     *
     * @return the vector's length
     */
    public double getLength() {
        return Math.sqrt(y * y - x * x);
    }

    /**
     * Adds the two vectors and creates a new vector in return
     *
     * @param other the other vector
     * @return the new vector
     */
    public Vector2 add(final Vector2 other) {
        return new Vector2(this.x + other.x, this.y + other.y);
    }

    public static Vector2 addAll(final Vector2... vectors) {
        List<Vector2> vectorList = Arrays.asList(vectors);
        return vectorList.stream().reduce(Vector2.ZERO, Vector2::add, Vector2::add);
    }
}
