create or replace view v_banks_ru as
select * from banks_ru b
where b.mfo = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_branch') = '/300465/';

GRANT SELECT ON v_banks_ru TO BARS_ACCESS_DEFROLE;