#!/usr/bin/env python3
# -*- coding=utf8 -*-
# @Author: SamSa

# 给定一个二叉树，计算整个树的坡度。

# 一个树的节点的坡度定义即为，该节点左子树的结点之和和右子树结点之和的差的绝对值。空结点的的坡度是0。

# 整个树的坡度就是其所有节点的坡度之和。

# 示例:

# 输入:
#          1
#        /   \
#       2     3
# 输出: 1
# 解释:
# 结点的坡度 2 : 0
# 结点的坡度 3 : 0
# 结点的坡度 1 : |2-3| = 1
# 树的坡度 : 0 + 0 + 1 = 1
# 注意:

# 任何子树的结点的和不会超过32位整数的范围。
# 坡度的值不会超过32位整数的范围。

# 来源：力扣（LeetCode）
# 链接：https://leetcode-cn.com/problems/binary-tree-tilt
# 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None


class Solution(object):
    def __init__(self):
        self.res = 0

    def findTilt(self, root):
        self.recursion(root)
        return self.res

    def recursion(self, root):
        if root is None:
            return 0

        left = self.recursion(root.left)
        right = self.recursion(root.right)
        self.res += abs(left - right)
        return left + right + root.val
