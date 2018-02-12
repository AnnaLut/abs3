create or replace view v3_cp_tag as
select tag, name, dict_name from cp_tag where id=3
union
select tag,name, null from cc_tag where tag in ('BUS_MOD','IFRS','SPPI');
