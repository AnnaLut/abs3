create or replace view v3_cp_tag as
select tag, name from cp_tag where id=3
union
select tag,name from cc_tag where tag in ('BUS_MOD','IFRS','SPPI');
