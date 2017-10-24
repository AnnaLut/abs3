
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/compression_ratio.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.COMPRESSION_RATIO (tabname varchar2)
return number is 
pct number := 0.000099;
blkcnt number := 0; blkcntc number; 
begin
execute immediate ' create table TEST$$FOR_TEST pctfree 0 as select * from ' || tabname ||' where rownum < 1';
while ((pct < 100) and (blkcnt < 1000)) loop
execute immediate 'truncate table TEST$$FOR_TEST';
execute immediate 'insert into TEST$$FOR_TEST select * from ' ||tabname|| ' sample block (' ||pct|| ',10)';
execute immediate 'select count(distinct(dbms_rowid.rowid_block_number(rowid))) from TEST$$FOR_TEST' into blkcnt;
pct := pct * 10;
end loop;
execute immediate 'alter table TEST$$FOR_TEST move compress for oltp';
execute immediate 'select count(distinct(dbms_rowid.rowid_block_number(rowid))) from TEST$$FOR_TEST' into blkcntc;
execute immediate 'drop table TEST$$FOR_TEST';
return (blkcnt/blkcntc);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/compression_ratio.sql =========*** 
 PROMPT ===================================================================================== 
 