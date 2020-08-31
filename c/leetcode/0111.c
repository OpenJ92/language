/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int minDepth(struct TreeNode* root)
{
    if (root == NULL) { return 0; }
    int right = minDepth(root->right);
    int left  = minDepth(root->left);
    return right > left && left > 0 || right < 1 ? 1 + left : 1 + right;
}
