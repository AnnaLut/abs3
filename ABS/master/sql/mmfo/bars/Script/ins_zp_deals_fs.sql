merge into bars.zp_deals_fs a using
 (select
  2 as id,
  'Суб’єкти господарювання' as name,
  '54' as ob22
  from dual) b
on (a.id = b.id)
when not matched then 
insert (
  id, name,ob22)
values (
  b.id, b.name,b.ob22)
when matched then
update set 
  a.name = b.name, a.ob22=b.ob22;
/
merge into bars.zp_deals_fs a using
 (select
  1 as id,
  'Бюджетна' as name,
  '56' as ob22
  from dual) b
on (a.id = b.id)
when not matched then 
insert (
  id, name,ob22)
values (
  b.id, b.name,b.ob22)
when matched then
update set 
  a.name = b.name, a.ob22=b.ob22;
/
commit;
/