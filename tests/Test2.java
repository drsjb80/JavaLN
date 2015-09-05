import edu.mscd.cs.javaln.*;

public class Test2
{
    static JavaLN logger = new JavaLN();

    private static void foo()
    {
        logger.severe ("I'm in foo");
    }

    private static void bar()
    {
        logger.severe ("I'm in bar");
    }

    public static void main(String[] args)
    {
        MethodFilter mf = new MethodFilter ("Test2.foo");
        logger.setFilter (mf);

        foo();
        bar();
    }
}
