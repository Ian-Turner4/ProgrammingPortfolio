public class Delaware implements Account {
  private double balance = 0.0;

  @Override
  public double deposit(double amount) {
    double tax = amount*0.07;
    if(tax < 50000000){
      amount -= tax;
    } else {
      amount -= 50000000;
    }
    balance += amount;
    return balance;
  }
  @Override
  public double withdraw(double amount) {
    balance -= (amount + (amount*0.06));
    return balance;
  }
  public String toString() {
    return "James' balance is $" + (Math.floor(balance*100)/100);
  }
}