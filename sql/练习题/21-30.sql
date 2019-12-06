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
--  21. 查询不及格的课程
SELECT
    sc.*,
    c.*
FROM
    score AS sc
    LEFT JOIN course AS c ON sc.c_id = c.c_id
WHERE
    sc.s_score < 60;

-- 22.查询课程编号为01且课程成绩在80分以上的学生的学号和姓名
SELECT
    st.s_id,
    st.s_name,
    sc.s_score
FROM
    student AS st
    LEFT JOIN score AS sc USING(s_id)
WHERE
    sc.c_id = "01"
    AND sc.s_score > 80;

-- 23. 查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩
SELECT
    distinct sc.s_id,
    sc.c_id,
    sc.s_score
FROM
    score AS sc,
    score AS c
WHERE
    sc.c_id != c.c_id
    AND sc.s_score = c.s_score;

-- 24. 查询每门课程成绩最好的前两名
(
    SELECT
        sc.s_score,
        c.c_name
    FROM
        score AS sc
        LEFT JOIN course AS c ON sc.c_id = c.c_id
    WHERE
        sc.c_id = "01"
    ORDER BY
        sc.s_score DESC
    LIMIT
        2
)
UNION
(
    SELECT
        sc.s_score,
        c.c_name
    FROM
        score AS sc
        LEFT JOIN course AS c ON sc.c_id = c.c_id
    WHERE
        sc.c_id = "02"
    ORDER BY
        sc.s_score DESC
    LIMIT
        2
)
UNION
(
    SELECT
        sc.s_score,
        c.c_name
    FROM
        score AS sc
        LEFT JOIN course AS c ON sc.c_id = c.c_id
    WHERE
        sc.c_id = "03"
    ORDER BY
        sc.s_score DESC
    LIMIT
        2
)
UNION
(
    SELECT
        sc.s_score,
        c.c_name
    FROM
        score AS sc
        LEFT JOIN course AS c ON sc.c_id = c.c_id
    WHERE
        sc.c_id = "04"
    ORDER BY
        sc.s_score DESC
    LIMIT
        2
);

-- 25. 统计每门课程的学生选修人数（超过5人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，
-- 若人数相同，按课程号升序排列
SELECT
    sc.c_id,
    COUNT(sc.c_id) AS nums
FROM
    score AS sc
GROUP BY
    sc.c_id
HAVING
    COUNT(nums) > 5
ORDER BY
    nums DESC,
    c_id;

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