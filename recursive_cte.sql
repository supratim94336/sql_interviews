WITH RECURSIVE CTE AS (
    SELECT task_id, subtasks_count
    FROM Tasks
    UNION ALL
    SELECT task_id, subtasks_count - 1
    FROM CTE
    WHERE subtasks_count > 1
)

SELECT task_id, subtasks_count AS subtask_id
FROM CTE 
WHERE (task_id, subtasks_count) NOT IN (SELECT * FROM Executed)
