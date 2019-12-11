/* 查询a表中不含在b表中的id */
# 解法1 (效率最低)
SELECT
    a.id
FROM
    tbl_a AS a NOT IN (
        SELECT
            b.id
        FROM
            tbl_b AS b
    );

# 解法2
SELECT
    a.id
FROM
    tbl_a AS a NOT EXISTS (
        SELECT
            b.id
        FROM
            tbl_b AS b
    );

# 解法3
SELECT
    a.id
FROM
    tbl_a AS a
    LEFT JOIN tbl_b AS b ON a.id = b.id
WHERE
    b.id IS NULL;

# 解法4 (效率最好)
SELECT
    a.id
FROM
    tbl_a AS a
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            tbl_b AS b
        WHERE
            a.id = b.id
    ) = 0;

/* count(1) 和 count(*) 的区别 */
https://blog.csdn.net/weixin_33766805/article/details/92543624
https://blog.csdn.net/qq_39135609/article/details/92983484