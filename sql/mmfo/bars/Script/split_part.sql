prompt == ���������� �������� �������� P_DEFAULT �� ���� P_DATEOFKK � ����� P_DEFAULT
begin
execute immediate 'ALTER TABLE BARS.ACCOUNTSW
   SPLIT PARTITION P_DEFAULT VALUES (''DATEOFKK'')
   into
    (PARTITION P_DATEOFKK  TABLESPACE BRSMDLD,
      PARTITION P_DEFAULT STORAGE (INITIAL 8M))
    UPDATE INDEXES';
exception
   when others then
     if sqlcode=-14313 then null;
     else 
        raise;
     end if;
end;
/
prompt == rebuild_index ������� ������ 
