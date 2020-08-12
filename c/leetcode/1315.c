/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

#include <stdio.h>

void get_grandchildren_sum(struct TreeNode* grandparent, int* totalptr)
{
    if (grandparent->left != NULL)
    {
        if (grandparent->left->left != NULL)
        {
            *totalptr += grandparent->left->left->val;
        }
        if (grandparent->left->right != NULL)
        {
            *totalptr += grandparent->left->right->val;
        }
    }
    if (grandparent->right != NULL)
    {
        if (grandparent->right->left != NULL)
        {
            *totalptr += grandparent->right->left->val;
        }
        if (grandparent->right->right != NULL)  
        {
            *totalptr += grandparent->right->right->val;
        }
    }
    return;
}

void solve(struct TreeNode* root, int* totalptr)
{
    if (root == NULL)
    {
        return;
    }
    
    if (root->val % 2 == 0)
    {
        get_grandchildren_sum(root, totalptr);
        solve(root->left, totalptr);
        solve(root->right, totalptr);
    }
    else
    {
        solve(root->left, totalptr);
        solve(root->right, totalptr);
    }
}

int sumEvenGrandparent(struct TreeNode* root)
{
    int total = 0;
    int* totalptr = &total;
    
    solve(root, totalptr);
    
    return *totalptr;
    
}
