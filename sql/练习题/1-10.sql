/**
 –1.学生表
 student(s_id,s_name,s_birth,s_sex) –学生编号,学生姓名, 出生年月,学生性别
 –2.课程表
 course(c_id,c_name,t_id) – –课程编号, 课程名称, 教师编号
 –3.教师表
 teacher(t_id,t_name) –教师编号,教师姓名
 –4.成绩表
 score(s_id,c_id,s_score) –学生编号,课程编号,分数
 */
/* 1. 查询"01"课程比"02"成绩高的学生的信息及课程分数 */
/* 解法1 */
SELECT
    a.*,
    b.s_score AS score_01从 c.s_score AS score_01
FROM
    student AS a,
    score AS b,
    score AS c
WHERE
    b.s_score > c.s_score
    AND b.c_id = "01"
    AND c.c_id = "02"
    AND a.s_id = b.s_id
    AND a.s_id = c.s_id;

/* 解法二 */
SELECT
    b.*,
    (
        SELECT
            s_score
        FROM
            score
        WHERE
            c_id = "01"
            AND s_id = a.s_id
    ) AS score_01,
    (
        SELECT
            s_score
        FROM
            score
        WHERE
            a.s_id = s_id
            AND c_id = "02"
    ) AS score_02
FROM
    score AS a
    LEFT JOIN student AS b ON a.s_id = b.s_id
GROUP BY
    a.s_id
HAVING
    score_01 > score_02;

-- 2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数
SELECT
    a.*,
    b.s_score AS score_01,
    c.s_score AS score_02
FROM
    student AS a,
    score AS b,
    score AS c
WHERE
    a.s_id = b.s_id
    AND a.s_id = c.s_id
    AND b.s_score < c.s_score
    AND b.c_id = "01"
    AND c.c_id = "02";

-- 3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
-- 解法1
SELECT
    a.s_id,
    a.s_name,
    avg(b.s_score) AS avg_score
FROM
    student AS a
    join score AS b ON a.s_id = b.s_id
GROUP BY
    a.s_id,
    a.s_name
HAVING
    avg_score >= 60;

-- 解法二
SELECT
    a.s_id,
    a.s_name,
    AVG(b.s_score) AS avg_score
FROM
    student AS a,
    score AS b
WHERE
    a.s_id = b.s_id
GROUP BY
    a.s_id
HAVING
    avg_score >= 60;

-- 4. 查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩 (包括有成绩的和无成绩的)
SELECT
    a.s_id,
    a.s_name,
    AVG(b.s_score) AS avg_score
FROM
    student AS a,
    score AS b
WHERE
    a.s_id = b.s_id
GROUP BY
    a.s_id
HAVING
    b.s_score < 60
UNION
SELECT
    a.s_id,
    a.s_name,
    0 AS avg_score
FROM
    student AS a
WHERE
    a.s_id NOT IN (
        SELECT
            DISTINCT b.s_id
        FROM
            score AS b
    );

-- 5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
SELECT
    a.s_id,
    a.s_name,
    COUNT(b.s_id) AS course_nums,
    SUM(b.s_score) AS total_score
FROM
    student AS a
    LEFT JOIN score AS b ON a.s_id = b.s_id
GROUP BY
    b.s_id;

-- 6. 查询不姓"李"姓老师的数量
-- 知识储备
/*
 %: 代替一个或者多个字符
 _: 仅仅代替一个字符
 regexp/not regexp [charlist]: 字符列中的任何单一字符
 */
SELECT
    COUNT(t.t_id)
FROM
    teacher AS t
WHERE
    t.t_name NOT LIKE "李%";

-- 7. 查询学过"张三"老师授课的同学的信息
SELECT
    a.*
FROM
    student AS a
    join score AS s ON a.s_id = s.s_id
WHERE
    s.c_id in (
        SELECT
            c.c_id
        FROM
            course AS c
        WHERE
            c.t_id =(
                SELECT
                    t_id
                FROM
                    teacher
                WHERE
                    t_name = "张三"
            )
    )
GROUP BY
    a.s_id;

-- 8. 查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
select
    a.*
from
    student as a
    join score as b on a.s_id = b.s_id
where
    b.c_id in (
        select
            c_id
        from
            course
        where
            c_id in ('01', '02')
    )
group by
    a.s_id;

-- 9、查询没学过"张三"老师授课的同学的信息 
SELECT
    a.*
FROM
    student AS a
WHERE
    a.s_id NOT IN (
        SELECT
            a.s_id
        FROM
            student AS a
            JOIN score AS b ON a.s_id = b.s_id
        WHERE
            b.c_id IN (
                SELECT
                    a.c_id
                FROM
                    course AS a
                    join teacher AS b ON a.t_id = b.t_id
                WHERE
                    t_name = "张三"
            )
    )
group by
    a.s_id;

-- 10. 查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息
-- 解法1
SELECT
    a.*
FROM
    student AS a
WHERE
    a.s_id IN (
        SELECT
            s_id
        FROM
            score
        WHERE
            c_id = "01"
    )
    AND a.s_id not IN (
        SELECT
            s_id
        FROM
            score
        WHERE
            c_id = "02"
    );

-- 解法二
SELECT
    a.*
FROM
    student AS a
    join score on AS b ON a.s_id = b.s_id
WHERE
    b.c_id = "01"
    AND b.s_id NOT IN (
        SELECT
            c.s_id
        FROM
            score AS c
        WHERE
            c.c_id = "02"
    );