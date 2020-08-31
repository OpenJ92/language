/*
 * Note: The returned array must be malloced, assume caller calls free().
 */
bool* checkIfPrerequisite
(
    int n, 
    int** prerequisites, 
    int prerequisitesSize, 
    int* prerequisitesColSize, 
    int** queries, 
    int queriesSize, 
    int* queriesColSize, 
    int* returnSize
)
{
    bool* retval; bool** reachable;
    if ((retval = (bool*)malloc(sizeof(bool)*returnSize)) == NULL ) { return NULL; }
    
    for (int index = 0; index < n; index++)
    {
        bfs(index, index, reeachable, prerequisites);
    }
}

void bfs(int from, int to, bool** reachable, int** prerequisites)
{
    if (reachable[from][to]) { return; }
    int* num_children;       
    int* children = get_children(to, prerequisites, num_children);
    
    for (int child = 0; child < *num_children; child++)
    {
	if(!reachable[from][child])
	{
        	reachable[from][children[child]] = true; 
	}
    }

    
    for (int child = 0; child < *num_children; child++)
    {
         bfs(from, children[child], reachable, prerequisites);
    }
}

int* get_children(int to, int** prerequisites, int* num_children)
{
	for ()
}
