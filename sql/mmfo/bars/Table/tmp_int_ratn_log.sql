PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_LOG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_INT_RATN_LOG ***

begin 
  execute immediate 
    ' create table TMP_INT_RATN_LOG'||
    ' ('||
    '   acc    NUMBER(38) not null,'||
    '   id     NUMBER not null,'||
    '   bdat   DATE not null,'||
    '   ir     NUMBER,'||
    '   br     NUMBER(38),'||
    '   op     NUMBER(4),'||
    '   idu    NUMBER(38) not null,'||
    '   kf     VARCHAR2(6) not null,'||
    '   row_id NUMBER(4) not null,'||
    '   col    VARCHAR2(20),'||
    '   dat    DATE default sysdate'||
    ' )';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/
 
comment on table TMP_INT_RATN_LOG is 'Лог истории % ставки';


PROMPT *** Create_grants  TMP_INT_RATN_LOG ***

grant select, insert, update, delete on TMP_INT_RATN_LOG to BARS_ACCESS_DEFROLE;
grant select on TMP_INT_RATN_LOG to BARS_DM;
grant select, insert, update, delete on TMP_INT_RATN_LOG to START1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INT_RATN_LOG.sql =========*** End *** =====
PROMPT ===================================================================================== 
