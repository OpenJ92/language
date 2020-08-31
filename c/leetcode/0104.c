/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */


int maxDepth(struct TreeNode* root)
{
    if (root == NULL) { return 0; }
    int right = 1 + maxDepth(root->right);
    int left  = 1 + maxDepth(root->left);
    return right > left ? right : left;
}
