create or replace view v_sex as
select * from sex
where id in (1, 2);

GRANT SELECT ON v_sex TO BARS_ACCESS_DEFROLE;
