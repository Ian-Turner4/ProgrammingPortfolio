public class California implements Account {
  private double balance = 0.0;

  @Override
  public double deposit(double amount) {
    amount = amount * 0.9225;
    balance += amount;
    return balance;
  }
  
  @Override
  public double withdraw(double amount) {
    balance -= amount;
    return balance;
  }
  
  public String toString() {
    return "Greg's balance is $" + balance;
  }
}