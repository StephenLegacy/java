import java.util.Scanner;

public class BMI {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Prompt user for height
        System.out.print("Enter your height in meters: ");
        double height = scanner.nextDouble();

        // Prompt user for weight 2025
        System.out.print("Enter yur weight in kilograms: ");
        double weight = scanner.nextDouble();

        // Calculate BMI
        double bmi = weight / (height * height);
        System.out.println("Your BMI is: " + bmi);

        // Classify BMI
        if (bmi < 20) {
            System.out.println("Lower than normal.");
        } else if (bmi >= 20 && bmi <= 40) {
            System.out.println("Normal.");
        } else if (bmi >= 41 && bmi <= 50) {
            System.out.println("Overweight.");
        } else if (bmi >= 51 && bmi <= 60) {
            System.out.println("Obese.");
        } else {
            System.out.println("Extremely obese or invalid input range.");
        }

        scanner.close();
    }
}
