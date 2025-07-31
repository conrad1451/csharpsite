var counter = 0;

var isMaxSet = args.Length is not 0;

var max = isMaxSet ? Convert.ToInt32(args[0]) : -1;

// CHQ: if the max is set (eg. dotnet run -- 5) then the 
// program does not stop
if (isMaxSet)
{
    Console.WriteLine($"Time for an app that runs until count hits: {max}");
}
else
{
    Console.WriteLine($"Time for an app that runs forever");  
}


while (max is -1 || counter < max)
{
    Console.WriteLine($"Counter: {++counter}");

    await Task.Delay(TimeSpan.FromMilliseconds(1_000));
}