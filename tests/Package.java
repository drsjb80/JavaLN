import edu.mscd.cs.javaln.*;
import java.util.logging.Logger;

/**
 * Make sure getLogger returns the same logger with the same name.
 */
class One
{
    public static void One (Logger base)
    {
        Logger logger = JavaLN.getLogger ("Package");

        if (! logger.equals (base))
            throw new Error ("loggers not the same!");

        if (logger != base)
            throw new Error ("loggers not the same!");
    }
}

/**
 * Make sure a new JavaLN doesn't
 */
class Two
{
    public static void Two (Logger base)
    {
        Logger logger = new JavaLN ("Package");

        if (logger == base)
            throw new Error ("loggers the same!");
    }
}

public class Package
{
    public static void main (String args[])
    {
        Logger logger = JavaLN.getLogger ("Package");

        One.One (logger);
        Two.Two (logger);
    }
}
