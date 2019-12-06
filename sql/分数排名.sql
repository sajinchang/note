-- 编写一个 SQL 查询来实现分数排名。如果两个分数相同，则两个分数排名（Rank）相同。请注意，平分后的下一个名次应该是下一个连续的整数值。换句话说，名次之间不应该有“间隔”。
-- +----+-------+
-- | Id | Score |
-- +----+-------+
-- | 1  | 3.50  |
-- | 2  | 3.65  |
-- | 3  | 4.00  |
-- | 4  | 3.85  |
-- | 5  | 4.00  |
-- | 6  | 3.65  |
-- +----+-------+
-- 例如，根据上述给定的 Scores 表，你的查询应该返回（按分数从高到低排列）：
-- +-------+------+
-- | Score | Rank |
-- +-------+------+
-- | 4.00  | 1    |
-- | 4.00  | 1    |
-- | 3.85  | 2    |
-- | 3.65  | 3    |
-- | 3.65  | 3    |
-- | 3.50  | 4    |
-- +-------+------+
-- 来源：力扣（LeetCode）
-- 链接：https://leetcode-cn.com/problems/rank-scores
-- 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
SELECT
    Score,
    (
        SELECT
            COUNT(DISTINCT Score)
        FROM
            Scores AS a
        WHERE
            a.Score >= b.Score
    ) AS Rank
FROM
    Scores AS b
ORDER BY
    Score DESC;


-- 解释
-- 首先我们要理解分数排名的目的，条件：两个分数排名（Rank）相同，也就是说如果班上有50个同学，全部的考分都是一样，那就只有一个排名（第一名）；如果考分只有90分和80分，那就只有两个排名（第一名和第二名）。【排名和人数无关】
-- 那我们将考分去重统计就知道有几个排名了。
-- 那我们是不是可以这样考虑：当前的分数在在班上排第几名，只要统计（去重）比我大的风数的个数就是我的排名。
-- 将分数按降序排序：select a.Score as score from Scores a order by Score DESC;
-- 要统计（去重）比我大的风数的个数就是我的排名：select count(distinct b.Score) from Scores b where b.Score >=我的分数
-- 结合：select a.Score as score ,(select count(distinct b.Score) from Scores b where b.Score =a.Score) as rank from Scores a order by Score DESC;

-- 作者：li-qiu-xin-yi
-- 链接：https://leetcode-cn.com/problems/rank-scores/solution/fen-shu-pai-ming-zhi-fen-shu-pai-ming-by-li-qiu-xi/
-- 来源：力扣（LeetCode）
-- 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。