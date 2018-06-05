create or replace type t_w4_sparam1 as object
(
  grp_code varchar2(32),
  tip      char(3),
  nbs      char(4),
  sp_id    number(22),
  value    varchar2(254),
  tipad    char(3),
  MAP MEMBER FUNCTION test1 RETURN varchar2
)
;
/
CREATE OR REPLACE TYPE BODY t_w4_sparam1 AS 
  MAP MEMBER FUNCTION test1 RETURN varchar2 IS
  BEGIN
     RETURN grp_code||tip||nbs||sp_id||tipad;
  END test1;
END;
/
declare
  type t_w4_sparam is table of t_w4_sparam1;
  l_w  t_w4_sparam;
begin
  begin
    execute immediate 'alter table W4_SPARAM drop constraint PK_W4SPARAM';
  exception
    when others then
      null;
  end;
  begin
    execute immediate 'drop index PK_W4SPARAM';
  exception
    when others then
      null;
  end;

  select t_w4_sparam1(t.grp_code, t.tip, t.nbs, t.sp_id, t.value, t.tipad)
    bulk collect
    into l_w
    from w4_sparam t;
  delete from w4_sparam;
  if l_w.count > 0 then
    for i in l_w.first .. l_w.last loop
      if l_w(i).nbs in ('2625', 2605, 2655) then
        l_w(i).tipad := l_w(i).tip;
        -- OB_2207
      elsif l_w(i).nbs = '2207' then
        l_w(i).nbs := '2203';
        l_w(i).tipad := 'KSP';
      elsif l_w(i).nbs = '2067' then
        l_w(i).nbs := '2063';
        l_w(i).tipad := 'KSP';
        -- OB_2208
      elsif l_w(i).nbs = '2208' then
        l_w(i).tipad := 'KKN';
      elsif l_w(i).nbs = '2068' then
        l_w(i).tipad := 'KKN';
        -- OB_2209
      elsif l_w(i).nbs = '2069' then
        l_w(i).nbs := '2068';
        l_w(i).tipad := 'KPN';
      elsif l_w(i).nbs = '2209' then
        l_w(i).nbs := '2208';
        l_w(i).tipad := 'KPN';
        -- OB_2627
      elsif l_w(i).nbs = '2627' then
        l_w(i).tipad := 'KON';
      elsif l_w(i).nbs = '2607' then
        l_w(i).tipad := 'KON';
      elsif l_w(i).nbs = '2657' then
        l_w(i).tipad := 'KON';
        -- OB_2628
      elsif l_w(i).nbs = '2548' then
        l_w(i).tipad := 'KDN';
      elsif l_w(i).nbs = '2658' then
        l_w(i).tipad := 'KDN';
      elsif l_w(i).nbs = '2608' then
        l_w(i).tipad := 'KDN';
      elsif l_w(i).nbs = '2628' then
        l_w(i).tipad := 'KDN';
      elsif l_w(i).nbs = '2528' then
        l_w(i).tipad := 'KDN';
        --OB_3570
      elsif l_w(i).nbs = '3570' then
        l_w(i).tipad := 'KK0';
        -- OB_3579
      elsif l_w(i).nbs = '3579' then
        l_w(i).tipad := 'KK9';
        l_w(i).nbs := '3570';
        -- OB_9129
      elsif l_w(i).nbs = '9129' then
        l_w(i).tipad := 'KR9';
        -- OB_OVR
      elsif l_w(i).nbs = '2062' then
        l_w(i).tipad := 'KSS';
        l_w(i).nbs := '2063';
      elsif l_w(i).nbs = '2202' then
        l_w(i).tipad := 'KSS';
        l_w(i).nbs := '2203';
      elsif l_w(i).nbs = '2063' then
        l_w(i).tipad := 'KSS';
      elsif l_w(i).nbs = '2203' then
        l_w(i).tipad := 'KSS';
      else
        l_w(i).tipad := 'ODB';
      end if;
    end loop;
  end if;
  dbms_output.put_line(l_w.count);
  l_w := set(l_w);
  dbms_output.put_line(l_w.count);  
  --l_w := l_w multiset union distinct l_w;
  --select * bulk collect into l_w1 from table(set(l_w));
  for a in l_w.first .. l_w.last loop
   insert into w4_sparam(grp_code,
                         tip,
                         nbs,
                         sp_id,
                         value,
                         tipad) values (l_w(a).grp_code,
                         l_w(a).tip,
                         l_w(a).nbs,
                         l_w(a).sp_id,
                         l_w(a).value,
                         l_w(a).tipad);
end loop;                         
   begin
   execute immediate 'alter table W4_SPARAM add constraint PK_W4SPARAM primary key (GRP_CODE, TIP, NBS, SP_ID, TIPAD) using index';
   
  exception
    when others then
      null;
   end;
end;
/
drop type t_w4_sparam1;

begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2620'', 247, ''8'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 4, ''B'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 1, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 4, ''E'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2208'', 1, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2208'', 3, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2208'', 4, ''E'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2208'', 56, ''33'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2208'', 247, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2627'', 20, ''08'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''9129'', 1, ''4'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''9129'', 2, ''9'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''9129'', 3, ''1'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''9129'', 4, ''B'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''9129'', 56, ''33'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''ECONOM'', ''W4W'', ''9129'', 247, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''INSTANT'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''INSTANT'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''INSTANT_MMSB'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''INSTANT_MMSB'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''LOCAL'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 11, ''3'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 244, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2620'', 247, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 4, ''B'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 4, ''E'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 11, ''3'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 20, ''08'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 244, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 1, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 3, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 4, ''B'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 20, ''08'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 56, ''33'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 244, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 247, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2627'', 20, ''08'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''9129'', 2, ''9'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''9129'', 3, ''1'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''9129'', 4, ''E'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''9129'', 11, ''3'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''9129'', 56, ''33'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''9129'', 244, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''MOYA_KRAYINA'', ''W4W'', ''9129'', 247, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 11, ''3'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 244, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2620'', 247, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 4, ''B'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 1, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 4, ''E'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 11, ''3'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 20, ''08'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 244, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 1, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 3, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 4, ''B'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 20, ''08'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 56, ''33'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 244, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 247, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2627'', 20, ''08'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 1, ''4'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 2, ''9'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 3, ''1'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 4, ''B'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 11, ''3'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 56, ''33'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 244, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PENSION'', ''W4W'', ''9129'', 247, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 11, ''3'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 244, ''8'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2620'', 247, ''8'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 4, ''B'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 1, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 4, ''E'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 11, ''3'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 20, ''08'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 244, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 1, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 3, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 4, ''B'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 20, ''08'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 56, ''33'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 244, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 247, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2627'', 20, ''08'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 1, ''4'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 2, ''9'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 3, ''1'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 4, ''B'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 11, ''3'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 56, ''33'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 244, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''PREMIUM'', ''W4W'', ''9129'', 247, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 21, ''12'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2620'', 247, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 4, ''B'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 4, ''D'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 9, ''D'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 20, ''08'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 21, ''12'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 218, ''0'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 1, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 2, ''3'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 3, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 4, ''D'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 9, ''5'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 21, ''12'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 56, ''33'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 219, ''0'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 247, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2627'', 20, ''08'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''9129'', 2, ''9'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''9129'', 3, ''1'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''9129'', 4, ''B'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''9129'', 9, ''D'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''9129'', 56, ''33'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SALARY'', ''W4W'', ''9129'', 247, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 11, ''3'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 244, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2620'', 247, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SHIDNIY'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 11, ''3'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 244, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2620'', 247, ''7'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''SOCIAL'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 11, ''3'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 244, ''8'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2620'', 247, ''8'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 4, ''B'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 3, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 4, ''E'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 11, ''3'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 20, ''08'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 56, ''33'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 244, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 247, ''1'', ''KSS'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 1, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 3, ''1'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 4, ''E'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 11, ''3'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 20, ''08'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 56, ''33'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 244, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 247, ''4'', ''KKN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2627'', 20, ''08'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''9129'', 2, ''9'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''9129'', 3, ''1'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''9129'', 4, ''E'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''9129'', 11, ''3'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''9129'', 56, ''33'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''9129'', 244, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''STANDARD'', ''W4W'', ''9129'', 247, ''0'', ''KR9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2620'', 1, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2620'', 2, ''9'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2620'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2620'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2620'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2620'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2620'', 247, ''8'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2203'', 1, ''1'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2208'', 1, ''1'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2627'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2627'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2627'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2628'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''2628'', 2, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''VIRTUAL'', ''W4W'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPOBU'', ''W4B'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPOBU'', ''W4B'', ''3550'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPOBU'', ''W4B'', ''3550'', 4, ''5'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPOBU'', ''W4B'', ''3550'', 5, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPOBU'', ''W4B'', ''3550'', 9, ''5'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPOBU'', ''W4B'', ''3550'', 203, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2520'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2541'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2542'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2520'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2528'', 4, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2541'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2542'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2548'', 4, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2520'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2528'', 9, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2541'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2542'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2548'', 9, ''1'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2520'', 11, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2541'', 11, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2542'', 11, ''2'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2520'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2541'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2542'', 20, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2520'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2541'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2542'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2520'', 244, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2528'', 244, ''08'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2541'', 244, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2542'', 244, ''08'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4A'', ''2548'', 244, ''08'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2063'', 1, ''4'', ''KSP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2068'', 1, ''8'', ''KPN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2607'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2608'', 1, ''6'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2605'', 2, ''1'', ''W4G'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''3570'', 2, ''3'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2605'', 3, ''1'', ''W4G'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2605'', 4, ''1'', ''W4G'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2607'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''3570'', 4, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''3570'', 4, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2605'', 9, ''1'', ''W4G'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2607'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''3570'', 9, ''5'', ''KK0'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''3570'', 9, ''1'', ''KK9'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2605'', 56, ''33'', ''W4G'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4G'', ''2605'', 247, ''8'', ''W4G'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2657'', 1, ''2'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2658'', 1, ''4'', ''KDN'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2650'', 2, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2650'', 3, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2650'', 4, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2657'', 4, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2650'', 9, ''1'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2657'', 9, ''1'', ''KON'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2650'', 56, ''33'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID, VALUE, TIPAD)
values (''CORPORATE'', ''W4S'', ''2650'', 247, ''8'', ''ODB'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;
