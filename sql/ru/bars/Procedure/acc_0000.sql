

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ACC_0000.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ACC_0000 ***

  CREATE OR REPLACE PROCEDURE BARS.ACC_0000 (DAT_ date, BRANCH_ varchar2) is
-- процедура (ПЕРЕ)накопления приращения всех АВТОМАТИЧЕСКИХ ПОКАЗАТЕЛЕЙ из BS0
-- на внесистемных счетах типа 0000kBBBBIIII
  c int; i int; S_ number;
begin

PUL.Set_Mas_Ini( 'dPar1', to_char(DAT_,'dd.mm.yyyy'), 'Пар.Дата-1' );
PUL.Set_Mas_Ini( 'sPar1', BRANCH_,                    'Пар.Символи-1' );

c:=DBMS_SQL.OPEN_CURSOR;              --открыть курсор
--  F - цикл по показателям
for F in (select id,dsql,name from bs0 where nrep=2 and dsql is not null and id>0 )
loop
  begin
     DBMS_SQL.PARSE(c, f.DSQL, DBMS_SQL.NATIVE); --приготовить дин.SQL
     DBMS_SQL.DEFINE_COLUMN(c,1,S_);        --установить знач колонки в SELECT
     i:=DBMS_SQL.EXECUTE(c);                 --выполнить приготовленный SQL
     IF DBMS_SQL.FETCH_ROWS(c)>0 THEN        --прочитать
        DBMS_SQL.COLUMN_VALUE(c,1,S_);      --снять результирующую переменную
     else                         S_ :=0 ;
     end if;
  EXCEPTION WHEN NO_DATA_FOUND then s_:=0;
            WHEN others        then
     DBMS_SQL.CLOSE_CURSOR(c);                -- закрыть курсор
       raise_application_error( -(20000+333),
       '\ош.SQL-формула пок=' || f.id ||' '|| f.name, TRUE);
  end;
  S_:= nvl(S_,0);
  acc1_0000 ( branch_, F.id, dat_, s_ );
end loop;  -- конец цикла F по формулам

DBMS_SQL.CLOSE_CURSOR(c);                -- закрыть курсор
end ACC_0000;
/
show err;

PROMPT *** Create  grants  ACC_0000 ***
grant EXECUTE                                                                on ACC_0000        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ACC_0000        to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ACC_0000.sql =========*** End *** 
PROMPT ===================================================================================== 
