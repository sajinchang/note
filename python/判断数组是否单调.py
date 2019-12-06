#!/usr/bin/env python3
# -*- coding: utf8 -*-
# @Author: SamSa
"""
如果数组是单调递增或单调递减的，那么它是单调的。

如果对于所有 i <= j，A[i] <= A[j]，那么数组 A 是单调递增的。 如果对于所有 i <= j，A[i]> = A[j]，那么数组 A 是单调递减的。

当给定的数组 A 是单调数组时返回 true，否则返回 false。
示例 1：
输入：[1,2,2,3]
输出：true

示例 2：
输入：[1,3,2]
输出：false
"""


class Solution(object):
    def isMonotonic(self, A):
        """
        param: A: 数组
        判断数组是否单调
        """
        # 递增
        is_inc = True
        # 递减
        is_dec = True
        for i in range(len(A) - 1):
            is_inc = is_inc and A[i] <= A[i + 1]
            is_dec = is_dec and A[i] >= A[i + 1]

        return is_inc or is_dec


if __name__ == '__main__':
    test = [1, 5, 2, 4]
    S = Solution()
    res = S.isMonotonic(A=test)
    print(res)
