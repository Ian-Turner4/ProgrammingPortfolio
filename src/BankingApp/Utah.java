public class Utah implements Account {
  private double balance = 0.0;

  @Override
  public double deposit(double amount) {
    amount -= (amount * 0.01);
    balance += amount;
    return balance;
  }
  
  @Override
  public double withdraw(double amount) {
    amount += (amount / 0.15);
    balance -= amount;
    return balance;
  }
  public String toString() {
    return "Annie's balance is $" + (Math.floor(balance*100)/100);
  }
}