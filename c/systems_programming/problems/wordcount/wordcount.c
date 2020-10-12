#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main(void)
{
	char* str = NULL; 
	int capacity = 10; 
	int size = 0; int wordcount = 1;
	int ch;

	if ((str = realloc(str, sizeof(*str) * (capacity + 1))) == NULL)
	{
		return -1;
	}

	while ((ch = getchar()) && ch != '\n')
	{
		if (isspace(ch))
		{
			wordcount++;
		}

		if (size == capacity)
		{
			if ((str = realloc(str, sizeof(*str) * (capacity + 1))) == NULL)
			{
				return -1;
			}
		}
		str[size] = (char)ch; size++;
	}

	str[size] = '\0'; 
	printf("%s :: has %d words\n", str, wordcount);
	
	return 0;
}
