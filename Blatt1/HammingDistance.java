public class HammingDistance
{
	public static void main(String args[])
	{
		char[][] chars = new char[args.length][];
		for(int i = 0; i<args.length; i++)
		{
			chars[i] = args[i].toCharArray();
		}

		int max = distance(chars[0], chars[1]);
		for(int i = 0; i<args.length; i++)
		{
			for(int j=i+1; j<args.length; j++)
			{
				int temp = distance(chars[i], chars[j]);
				System.out.println("Von " + (i+1) + " zu " + (j+1) + " Distanz " + temp);
				if(temp<max)
				{
					max = temp;
				}
			}
		}
		System.out.println(max);
	}

	private static int distance(char[] a,char[] b)
	{
		int diff = 0;
		char[] longer, shorter;
		if(a.length > b.length)
		{
			longer = a;
			shorter= b;
		}else{

			longer = b;
			shorter= a;
		}
		for(int i = 0; i<shorter.length; i++)
		{
			if(longer[i]!=shorter[i])
			{
				diff++;
			}
		}
		diff += longer.length-shorter.length;
		return diff;
	}
}
