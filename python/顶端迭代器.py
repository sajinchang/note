#!/usr/bin/env python3
# -*- coding: utf8 -*-
# @Author: SamSa

"""
给定一个迭代器类的接口，接口包含两个方法： next() 和 hasNext()。设计并实现一个支持 peek() 操作的顶端迭代器 -- 其本质就是把原本应由 next() 方法返回的元素 peek() 出来。

示例:

假设迭代器被初始化为列表 [1,2,3]。

调用 next() 返回 1，得到列表中的第一个元素。
现在调用 peek() 返回 2，下一个元素。在此之后调用 next() 仍然返回 2。
最后一次调用 next() 返回 3，末尾元素。在此之后调用 hasNext() 应该返回 false。
进阶：你将如何拓展你的设计？使之变得通用化，从而适应所有的类型，而不只是整数型？

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/peeking-iterator
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
"""


class PeekingIterator1:
    # 方案一
    def __init__(self, iterator):
        """
        Initialize your data structure here.
        :type iterator: Iterator
        """
        self.iterator = []
        while iterator.hasNext():
            self.iterator.append(iterator.next())

    def peek(self):
        """
        Returns the next element in the iteration without advancing the iterator.
        :rtype: int
        """
        return self.iterator[0]

    def next(self):
        """
        :rtype: int
        """
        return self.iterator.pop(0)

    def hasNext(self):
        """
        :rtype: bool
        """
        return len(self.iterator) > 0


class PeekingIterator2:
    # 方案二, 数据量大时,该方案性能更高
    def __init__(self, iterator):
        """
        Initialize your data structure here.
        :type iterator: Iterator
        """
        self.iterator = iterator
        self.peek_num = None

    def peek(self):
        """
        Returns the next element in the iteration without advancing the iterator.
        :rtype: int
        """
        if self.peek_num is None:
            self.peek_num = self.iterator.next()
            return self.peek_num
        return self.peek_num

    def next(self):
        """
        :rtype: int
        """
        if self.peek_num is None:
            return self.iterator.next()
        tmp = self.peek_num
        self.peek_num = None
        return tmp

        return self.peek_num

    def hasNext(self):
        """
        :rtype: bool
        """
        if self.peek_num is not None:
            return True
        return self.iterator.hasNext()


if __name__ == '__main__':
    pass
