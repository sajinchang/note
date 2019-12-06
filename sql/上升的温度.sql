/*
 给定一个 Weather 表，编写一个 SQL 查询，来查找与之前（昨天的）日期相比温度更高的所有日期的 Id。
 
 +---------+------------------+------------------+
 | Id(INT) | RecordDate(DATE) | Temperature(INT) |
 +---------+------------------+------------------+
 |       1 |       2015-01-01 |               10 |
 |       2 |       2015-01-02 |               25 |
 |       3 |       2015-01-03 |               20 |
 |       4 |       2015-01-04 |               30 |
 +---------+------------------+------------------+
 例如，根据上述给定的 Weather 表格，返回如下 Id:
 
 +----+
 | Id |
 +----+
 |  2 |
 |  4 |
 +----+
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/rising-temperature
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
-- 知识储备
-- DATEDIFF, 该方法可以计算两个时间差
-- DATEDIFF 函数，可以计算两者的日期差
-- DATEDIFF('2007-12-31', '2007-12-30');    # 1
-- DATEDIFF('2010-12-30', '2010-12-31');    # -1
-- 解题
SELECT
    a.Id
FROM
    Weather AS a,
    Weather AS b
WHERE
    a.Temperature > b.Temperature
    AND datediff(a.RecordDate, b.RecordDate) = 1