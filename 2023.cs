using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

class fd_2023
{
	static void Main()
	{
		RunToTheCar().Wait();
	}

	static async Task RunToTheCar()
	{
		int noChildren = 3;

    Child[] children = new Child[noChildren];

    children[0] = new Child("Adam",   25);
    children[1] = new Child("Ben",    21);
    children[2] = new Child("Lauren", 17);

		string[] seatingOptions = {"sits in front", "is in the back", "has to walk home"};

		List<int> seatingOrder = new List<int>();

		// List of processes to run in parallel
		List<Task<int>> saidShotgun = new List<Task<int>>
		{
			Task.Run(() => SayShotgun(2, children[2])),
			Task.Run(() => SayShotgun(1, children[1])),
			Task.Run(() => SayShotgun(0, children[0]))
		};

		while (saidShotgun.Count > 0)
		{
			Task<int> completedShotgun = await Task.WhenAny(saidShotgun);
			int result = await completedShotgun;
			seatingOrder.Add(result);
			saidShotgun.Remove(completedShotgun); 
		}

		for (int i = 0; i < seatingOrder.Count; i++)
		{
			Console.WriteLine($"{children[seatingOrder[i]].GetName()} {seatingOptions[i]}.");
		}
	}

	static async Task<int> SayShotgun(int childNumber, Child child)
	{
		await Task.Delay(child.TimeToShotgun());
		return childNumber;
	}
}

class Child {
  private string name;
  private int age;
  public Child(string name, int age) {
    this.name = name;
    this.age = age;
  }
  public string GetName() {
    return name;
  }
  // You only get faster at shotgunning as you get older.
  public int TimeToShotgun() {
    return (int)Math.Ceiling((1.0/age)*1000);
  }
}