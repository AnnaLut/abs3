

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ACC_0000.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ACC_0000 ***

  CREATE OR REPLACE PROCEDURE BARS.ACC_0000 (DAT_ date, BRANCH_ varchar2) is
-- ��������� (����)���������� ���������� ���� �������������� ����������� �� BS0
-- �� ������������ ������ ���� 0000kBBBBIIII
  c int; i int; S_ number;
begin

PUL.Set_Mas_Ini( 'dPar1', to_char(DAT_,'dd.mm.yyyy'), '���.����-1' );
PUL.Set_Mas_Ini( 'sPar1', BRANCH_,                    '���.�������-1' );

c:=DBMS_SQL.OPEN_CURSOR;              --������� ������
--  F - ���� �� �����������
for F in (select id,dsql,name from bs0 where nrep=2 and dsql is not null and id>0 )
loop
  begin
     DBMS_SQL.PARSE(c, f.DSQL, DBMS_SQL.NATIVE); --����������� ���.SQL
     DBMS_SQL.DEFINE_COLUMN(c,1,S_);        --���������� ���� ������� � SELECT
     i:=DBMS_SQL.EXECUTE(c);                 --��������� �������������� SQL
     IF DBMS_SQL.FETCH_ROWS(c)>0 THEN        --���������
        DBMS_SQL.COLUMN_VALUE(c,1,S_);      --����� �������������� ����������
     else                         S_ :=0 ;
     end if;
  EXCEPTION WHEN NO_DATA_FOUND then s_:=0;
            WHEN others        then
     DBMS_SQL.CLOSE_CURSOR(c);                -- ������� ������
       raise_application_error( -(20000+333),
       '\��.SQL-������� ���=' || f.id ||' '|| f.name, TRUE);
  end;
  S_:= nvl(S_,0);
  acc1_0000 ( branch_, F.id, dat_, s_ );
end loop;  -- ����� ����� F �� ��������

DBMS_SQL.CLOSE_CURSOR(c);                -- ������� ������
end ACC_0000;
/
show err;

PROMPT *** Create  grants  ACC_0000 ***
grant EXECUTE                                                                on ACC_0000        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ACC_0000        to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ACC_0000.sql =========*** End *** 
PROMPT ===================================================================================== 
