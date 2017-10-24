begin
  bpa.alter_policy_info('V_BANKS_REPORT91', 'FILIAL',  null, null, null, null);
  bpa.alter_policy_info('V_BANKS_REPORT91', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/

Prompt Table V_BANKS_REPORT91;
begin
    execute immediate 'DROP TABLE V_BANKS_REPORT91';
exception
    when others then null;
end;
/    


begin
  execute immediate 
    'create table BARS.V_BANKS_REPORT91
(
  NBUC NUMBER(38), 
  KODF VARCHAR2(2),
  DATF DATE, 
  KODP VARCHAR2(35), 
  ZNAP VARCHAR2(70), 
  ERR_MSG  VARCHAR2(1000 BYTE),
  FL_MOD   NUMBER
)';
exception 
  when others then
    if (sqlcode = -955) then null;
    else raise;
    end if;
end;
/

COMMENT ON TABLE BARS.V_BANKS_REPORT91 IS '������� ��� ��������������� ��������� ����� �������';

COMMENT ON COLUMN BARS.V_BANKS_REPORT91.NBUC IS '��� ���.���������';

COMMENT ON COLUMN BARS.V_BANKS_REPORT91.KODF IS '��� �����';

COMMENT ON COLUMN BARS.V_BANKS_REPORT91.DATF IS '����� ����';

COMMENT ON COLUMN BARS.V_BANKS_REPORT91.KODP IS '��� ���������';

COMMENT ON COLUMN BARS.V_BANKS_REPORT91.ZNAP IS '�������� ���������';

COMMENT ON COLUMN BARS.V_BANKS_REPORT91.ERR_MSG IS '���� �������';

COMMENT ON COLUMN BARS.V_BANKS_REPORT91.FL_MOD IS '���� �������';


begin
    execute immediate 'DROP PUBLIC SYNONYM V_BANKS_REPORT91';
exception
    when others then null;
end;
/    

create public synonym V_BANKS_REPORT91 for bars.V_BANKS_REPORT91;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_BANKS_REPORT91 TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_BANKS_REPORT91 TO RPBN002;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.V_BANKS_REPORT91 TO WR_ALL_RIGHTS;

GRANT SELECT, FLASHBACK ON BARS.V_BANKS_REPORT91 TO WR_REFREAD;

--BEGIN
--   bpa.alter_policies('V_BANKS_REPORT91');
--END;
--/

