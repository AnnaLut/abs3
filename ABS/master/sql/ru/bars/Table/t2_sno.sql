SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO OFF
SET LINES 500
SET PAGES 500
SET FEEDBACK OFF
begin 
  BPA.ALTER_POLICY_INFO( 'T2_SNO', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'T2_SNO', 'FILIAL', null, null, null, null ); 
end;
/
begin 
   execute immediate('create table T2_SNO( test_column number ) 
    tablespace BRSDYND pctfree 10 initrans 1 maxtrans 255 storage( initial 65536 next 1048576 minextents 1 maxextents 2147483645)');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create table T2_SNO'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "ACC" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column ACC'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "OTM" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column OTM'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "SPN" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column SPN'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "ND" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column ND'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "KV" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column KV'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "NLS" VARCHAR2(15 BYTE  ) ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column NLS'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "ID" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column ID'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "DAT" DATE ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column DAT'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "S" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column S'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "OSTF" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column OSTF'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "SA" NUMBER ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column SA'); 
end;
/
begin 
   execute immediate('alter table T2_SNO add "FDAT" DATE ');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column FDAT'); 
end;
/
begin 
   execute immediate('alter table T2_SNO drop column test_column');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: removing dummy-column'); 
end;
/
begin  
 for cc_con in (select c.TABLE_NAME, c.CONSTRAINT_NAME, c.SEARCH_CONDITION, cc.COLUMN_NAME 
   from user_constraints c join user_cons_columns cc 
   on c.constraint_name = cc.constraint_name and c.owner = cc.owner 
   where c.table_name = 'T2_SNO' and c.constraint_type = 'C' and cc.COLUMN_NAME not in 
    (select cc1.COLUMN_NAME from user_constraints c1 join user_cons_columns cc1 
    on c1.constraint_name = cc1.constraint_name and c1.owner = cc1.owner 
    where c1.table_name = 'T2_SNO' and c1.constraint_type = 'P')) 
 loop 
   execute immediate('alter table T2_SNO drop constraint ' || cc_con.CONSTRAINT_NAME); 
 end loop; 
end;
/
begin 
   execute immediate('comment on table T2_SNO is ''"Временная" табл для хранения проекта ГПП''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column T2_SNO'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.ACC is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column ACC'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.OTM is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column OTM'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.SPN is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column SPN'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.ND is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column ND'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.KV is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column KV'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.NLS is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column NLS'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.ID is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column ID'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.DAT is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column DAT'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.S is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column S'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.OSTF is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column OSTF'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.SA is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column SA'); 
end;
/
begin 
   execute immediate('comment on column T2_SNO.FDAT is ''''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column FDAT'); 
end;
/
SET FEEDBACK     ON 