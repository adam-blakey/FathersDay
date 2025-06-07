import java.lang.reflect.Field;
import java.util.Collection;
import java.util.ArrayList;

public class _2025 {
    public static class Child {
        public String name;
        public Child(String name) {
            this.name = name;
        }
    }

    public static class Eldest extends Child {
        public boolean IsTheFavouriteChild = true;
        public Eldest(String name) {
            super(name);
        }
    }

    private static Collection<Child> children = new ArrayList<>();

    /**
     * This gets the favourite child from the collection of children. We use
     * reflection to access the private field 'IsTheFavouriteChild'; if it's
     * there and is true, then this child is undeniably the favourite child.
     * 
     * @return The favourite child if found, otherwise null.
     */
    public static Child GetFavouriteChild() {
        for (Child child : children) {
            Class<?> childClass = child.getClass();

            for (Field field : childClass.getDeclaredFields()) {
                if (field.getName().equals("IsTheFavouriteChild")) {
                    try {
                        if ((boolean) field.get(child)) {
                            return child;
                        }
                    } catch (IllegalAccessException e) {
                        System.err.println("Could not access field " + field.getName() + " on " + child.name);
                        e.printStackTrace();
                    }
                }
            }
        }
        return null;
    }
    
    public static void main(String[] args) {
        children.add(new Child("Lauren"));
        children.add(new Child("Ben"));
        children.add(new Eldest("Adam"));

        Child FavouriteChild = GetFavouriteChild();

        if (FavouriteChild == null) {
            System.out.println("No favourite child found.");
            return;
        }

        System.out.printf("%s is officially the favourite child!", FavouriteChild.name);
    }
}