--  SELECT gaps.id + 1 as from
--         MIN(fr.id) - 1 as to
--  FROM gaps
--  LEFT JOIN gaps r on gaps.id = r.id - 1
--  LEFT JOIN gaps fr on gaps.id < fr.id
--  where r.id is null
--        and fr.id is not null
--  group by gaps.id,
--           r.id;

--  with gg as (
--       select id, lag(id) over () mn, lead(id) over () mx from gaps
--   )
--   select id + 1, mx - 1
--   from gg
--   where id + 1 < mx;

--  select prev_id + 1 as "from", id - 1 as "to"  from (
--      select gg.id, lag(id) over (order by id) as prev_id from gaps gg
--    ) tt
--  where id - prev_id > 1;

WITH cte AS (
  SELECT lag(id, 1) OVER (ORDER BY id) as l, id
    FROM gaps
)

SELECT (cte.l + 1) as "from", (cte.id - 1) as "to"
  FROM cte
 WHERE cte.l != (cte.id - 1);
