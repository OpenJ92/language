/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

#include <stdio.h>

typedef enum _Queue_Res
{
    SUCC,
    FAIL,
    EMPTY
} Queue_Res;

typedef struct _Node
{
    struct TreeNode* node;
    struct _Node* next;
} Node;

typedef struct Queue
{
    int length;
    Node* head;
    Node* tail;
} Queue;

Queue_Res push(Queue* queue, struct TreeNode* node)
{
    if (queue->tail == NULL)
    {
        Node* container;
        if ((container = (Node*)malloc(sizeof(Node))) == NULL)
        {
            return FAIL;
        }
        
        container->node = node;
        container->next = NULL;
        queue->tail = container;
    }
    else
    {
        Node* container;
        if ((container = (Node*)malloc(sizeof(Node))) == NULL)
        {
            return FAIL;
        }
        
        container->node = node;
        queue->tail->next = container;
        if (queue->head == NULL)
        {
            queue->head = queue->tail;
        }
        queue->tail = container;
        container->next = NULL;
    }
    
    queue->length += 1;
    return SUCC;
}

// Queue_Res pop(Queue* queue, TreeNode** data)
// {
// }

void init(Queue* queue)
{
    queue->length = 0;
    queue->head = NULL;
    queue->tail = NULL;
    return;
}

void collect_preorder(struct TreeNode* root, Queue* queue)
{
    if (root == NULL)
    {
        return;
    }
    Queue_Res resolution = push(queue, root);
    collect_preorder(root->left, queue);
    collect_preorder(root->right, queue);
    
    return;
}

void flatten(struct TreeNode* root)
{
    Queue queue; init(&queue); Node* itt;

    collect_preorder(root, &queue);
    
    if ((&queue)->length == 0)
    {
        return;
    }
    
    itt = (&queue)->head;
    while (itt != (&queue)->tail->next)
    {
        if (itt->next != NULL)
        {
            itt->node->right = itt->next->node;
        }
        else
        {
            itt->node->right = NULL;
        }
        itt->node->left = NULL;
        itt = itt->next;
    } 
}
