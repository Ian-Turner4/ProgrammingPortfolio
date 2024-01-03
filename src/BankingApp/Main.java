// By Oliver Gibbons, Ian Turner, John Evern McCullough, Jack Wakefield
class Main {
  public static void main(String[] args) {
    Utah annie = new Utah();
    California greg = new California();
    Delaware james = new Delaware();
    
    System.out.println("Annie is from Utah.");
    System.out.println(annie.toString());
    annie.deposit(200);
    System.out.println(annie.toString());
    annie.withdraw(25);
    System.out.println(annie.toString());
    
    System.out.println("James is from Delaware.");
    System.out.println(james.toString());
    james.deposit(100003);
    System.out.println(james.toString());
    james.withdraw(700);
    System.out.println(james.toString());
    
    System.out.println("Greg is from California.");
    System.out.println(greg.toString());
    greg.deposit(20);
    System.out.println(greg.toString());
    greg.withdraw(500); // gambling adiction
    System.out.println(greg.toString() + " (Greg is in debt)");
    
  }
}