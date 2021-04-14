SELECT gaps.id + 1 as start
FROM gaps
LEFT JOIN gaps r on gaps.id = r.id - 1
WHERE r.id is null;

