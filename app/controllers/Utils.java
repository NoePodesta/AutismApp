package controllers;

import java.util.StringTokenizer;

/**
 * Created with IntelliJ IDEA.
 * User: NoePodesta
 * Date: 22/10/13
 * Time: 14:57
 * To change this template use File | Settings | File Templates.
 */
public class Utils {

    public static String removeSpaces(String string) {
        StringTokenizer tokenizer = new StringTokenizer(string);
        StringBuilder newString = new StringBuilder();
        while(tokenizer.hasMoreTokens()){
            newString.append(tokenizer.nextToken());
        }
        return newString.toString();
    }
}
