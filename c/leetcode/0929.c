typedef struct Email
{
    char* start;
    char* end;
} Email;

Email* construct_string(Email* string, char* start, char* end)
{
    string->start = start;
    string->end = end;
    return string;
}

Email* append_string(Email* string_1, Email* string_2)
{
    Email* new_string;
    if ((new_string = (Email*)malloc(sizeof(Email))) == NULL){ return NULL; }
    construct_string(new_string, string_1->start, string_2->end);
    return new_string;
}

// Dynamic Alocation
Email** split(Email* string, int (*compare)(char*), int max_splits)
{
    Email** container;
    if ((container = (Email**)malloc(sizeof(Email*)*(max_splits+1))) == NULL) 
    { return NULL; }
    Email* container_position = *container;

    char* cursor = string->start;
    char* temp_start = string->start;
    int num_split = 0;
    
    while (cursor != string->end)
    {
        if (compare(cursor) == 0)
        {
            Email* string; 
            if ((string = (Email*)malloc(sizeof(Email))) == NULL) 
            { 
                for (Email* string_cursor = *container; string_cursor != container_position; string_cursor++)
                {
                    free(string_cursor);
                }
                free(container);
                return NULL;
            }
            container_position = *container + num_split;
            container_position = construct_string(string, temp_start, cursor);
            if (num_split == max_splits)
            {
                break;
            }
            temp_start = --cursor;
            num_split++;
        }
        cursor++;
    }
    
    return container;
}

int compare_at(char* letter)
{
    return (*letter == '@') ? 1 : 0;
}
int compare_dot(char* letter)
{
    return (*letter == '.') ? 1 : 0;
}
int compare_plus(char* letter)
{
    return (*letter == '+') ? 1 : 0;
}

char* find_end(char* email)
{
    do
    {
        printf("Stuck in here. %c\n", *email);
        email++;
    } while (*email != '\0');
    return --email;
}

int numUniqueEmails(char ** emails, int emailsSize)
{
    //String** split_strings;
    //if ((split_strings = (String**)malloc(sizeof(String*)*emailsSize)) == NULL) { return NULL; }
    
    for (int email = 0; email < emailsSize; email++)
    {
        Email* current_email;
        if ((current_email = (Email*)malloc(sizeof(Email))) == NULL) { return -1; }
        char* end = find_end(*emails + email);
        printf("\n%p : %p == %c : %c\n", *emails + email, end, *(*emails + email), *end);
        current_email = construct_string(current_email,(*emails + email),end);
        
        Email** split_at = split(current_email, compare_at, 1);
        printf("%p", (split_at + 1));
        Email** split_plus = split(*split_at, compare_plus, 1);
        printf("here?");
        Email** split_dot = split(*split_plus, compare_dot, -1);
        
        Email* collect_dot = append_string(*split_dot, *split_dot + 1);
        Email* collect_address = append_string(*split_at + 1, collect_dot);
        //split_strings[email] = collect_address;
    }
    return 0;
}
