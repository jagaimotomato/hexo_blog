---
title: leetcode
date: 2022-08-06 21:19:37
description: 刷题
categories:
- [算法, leetcode]
- js
---

### 两数之和
- 给定一个整数数组`nums`和一个整数目标值`target`，请你在该数组中找出和为目标值的那两个整数，并返回它们的数组下标。
- 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。
- 你可以按任意顺序返回答案。

输入：nums = [2,7,11,15], target = 9  
输出：[0,1]  
解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。

#### my answer
{% codepen oNqdMBQ js 350 100% takoyakiccc light %}

#### 最佳解法
{% codepen vYRjajo js 350 100% takoyakiccc light %}

### 两数相加
- 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。请你将两个数相加，并以相同形式返回一个表示和的链表。  你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
#### 示例1
![img.png](/images/leetcode/2.jpg)

```
输入：l1 = [2,4,3], l2 = [5,6,4]
输出：[7,0,8]
解释：342 + 465 = 807.
```
#### 示例2
```
输入：l1 = [0], l2 = [0]
输出：[0]
```
#### 示例3
```
输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
输出：[8,9,9,9,0,0,0,1]
```
#### 提示
- 每个链表中的节点数在范围 [1, 100] 内
- 0 <= Node.val <= 9
- 题目数据保证列表表示的数字不含前导零

```python
class Solution:
    def addTwoNumbers(self, l1: Option[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        head = tree = ListNode()
```
