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
-- 11. 查询没有学全所有课程的同学的信息 
-- 解法1
SELECT
    a.*
FROM
    student AS a
    LEFT JOIN score AS b ON a.s_id = b.s_id
GROUP BY
    a.s_id
HAVING
    COUNT(b.c_id) < (
        SELECT
            COUNT(c_id)
        FROM
            course
    );

-- 解法二
SELECT
    *
FROM
    student
WHERE
    s_id NOT IN (
        SELECT
            s_id
        FROM
            score
        GROUP BY
            s_id
        HAVING
            COUNT(c_id) = (
                SELECT
                    COUNT(*)
                FROM
                    course
            )
    );

-- 12. 查询至少有一门课与学号为"01"的同学所学相同的同学的信息 
SELECT
    s.*
FROM
    student AS s
WHERE
    s.s_id IN (
        SELECT
            DISTINCT s_id
        FROM
            score
        WHERE
            c_id IN (
                SELECT
                    a.c_id
                FROM
                    score AS a
                WHERE
                    a.s_id = "01"
            )
    );

-- 13. 查询男生、女生人数
SELECT
    s.s_sex,
    COUNT(s.s_id)
FROM
    student AS s
GROUP BY
    s.s_sex;

-- 14. 查询出只有两门课程的全部学生的学号和姓名
SELECT
    s.s_id,
    s.s_name
FROM
    student AS s
WHERE
    s.s_id IN (
        SELECT
            s_id
        FROM
            score
        GROUP BY
            s_id
        HAVING
            COUNT(c_id) = 2
    );

-- 15. 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
SELECT
    s.s_id,
    s.s_name,
    AVG(b.s_score) AS '平均成绩'
FROM
    student AS s
    join score AS b ON s.s_id = b.s_id
WHERE
    s.s_id IN (
        SELECT
            s_id
        FROM
            score
        WHERE
            s_score <= 60
        GROUP BY
            s_id
        HAVING
            COUNT(s_id) >= 2
    )
GROUP BY
    s.s_id;

-- 16. 检索"01"课程分数小于60，按分数降序排列的学生信息(asc升序 desc降序)
SELECT
    s.*,
    sc.s_score
FROM
    student AS s
    LEFT JOIN score AS sc ON s.s_id = sc.s_id
WHERE
    sc.s_score < 60
    AND sc.c_id = "01"
GROUP BY
    s.s_id
ORDER BY
    sc.s_score DESC;

-- 17. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
select
    sc.*,
    (
        select
            avg(s_score)
        from
            score
        where
            s_id = sc.s_id
        group by
            s_id
    ) as avg_score
from
    score as sc
order by
    avg_score desc,
    sc.s_id desc,
    sc.c_id;

-- 18. 查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT
    st.s_name,
    s.s_score
FROM
    score AS s
    LEFT JOIN student AS st ON s.s_id = st.s_id
WHERE
    s.c_id = (
        SELECT
            c_id
        FROM
            course AS c
        WHERE
            c.c_name = '数学'
    )
    AND s.s_score < 60;

-- 19. 查询所有学生的课程及分数情况
SELECT
    st.*,
    SUM(
        CASE
            c.c_name
            WHEN "语文" THEN sc.s_score
            ELSE 0
        END
    ) AS "语文",
    SUM(
        CASE
            c.c_name
            WHEN "数学" THEN sc.s_score
            ELSE 0
        END
    ) AS "数学",
    SUM(
        CASE
            c.c_name
            WHEN "英语" THEN sc.s_score
            ELSE 0
        END
    ) as "英语",
    SUM(
        case
            c.c_name
            WHEN "物理" THEN sc.s_score
            ELSE 0
        END
    ) AS "物理",
    SUM(sc.s_score) AS "总分"
FROM
    student AS st
    LEFT JOIN score AS sc ON st.s_id = sc.s_id
    LEFT JOIN course AS c ON sc.c_id = c.c_id
GROUP BY
    st.s_id;

-- 20. 查询任何一门课程成绩在70分以上的姓名、课程名称和分数
SELECT
    st.s_name,
    c.c_name,
    sc.s_score
FROM
    student AS st
    LEFT JOIN score AS sc using(s_id)
    LEFT JOIN course AS c ON c.c_id = sc.c_id
WHERE
    sc.s_score > 70;
