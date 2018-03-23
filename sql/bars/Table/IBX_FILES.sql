begin 
  BPA.ALTER_POLICY_INFO( 'IBX_FILES', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'IBX_FILES', 'FILIAL', null, null, null, null ); 
end;
/
begin 
   execute immediate('create table IBX_FILES( test_column number ) 
    tablespace BRSDYND pctfree 10 initrans 1 maxtrans 255');
exception when others then 
if sqlcode = -955 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create table IBX_FILES'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add "TYPE_ID" VARCHAR2(256 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column TYPE_ID'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add "FILE_NAME" VARCHAR2(256 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column FILE_NAME'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add "FILE_DATE" DATE ');
exception when others then 
if sqlcode = -1430 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column FILE_DATE'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add "TOTAL_COUNT" NUMBER ');
exception when others then 
if sqlcode = -1430 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column TOTAL_COUNT'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add "TOTAL_SUM" NUMBER ');
exception when others then 
if sqlcode = -1430 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column TOTAL_SUM'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add "LOADED" DATE ');
exception when others then 
if sqlcode = -1430 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column LOADED'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES drop column test_column');
exception when others then 
if sqlcode = -904 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: removing dummy-column'); 
end if;
end;
/
begin 
   execute immediate('create UNIQUE index PK_IBXFILES on IBX_FILES(TYPE_ID,FILE_NAME) 
    tablespace BRSDYND pctfree 10 initrans 2 maxtrans 255');
exception when others then 
if sqlcode = -955 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create index PK_IBXFILES'); 
end if;
end;
/
begin  
 for cc_con in (select c.TABLE_NAME, c.CONSTRAINT_NAME, c.SEARCH_CONDITION, cc.COLUMN_NAME 
   from user_constraints c join user_cons_columns cc 
   on c.constraint_name = cc.constraint_name and c.owner = cc.owner 
   where c.table_name = 'IBX_FILES' and c.constraint_type = 'C' and cc.COLUMN_NAME not in 
    (select cc1.COLUMN_NAME from user_constraints c1 join user_cons_columns cc1 
    on c1.constraint_name = cc1.constraint_name and c1.owner = cc1.owner 
    where c1.table_name = 'IBX_FILES' and c1.constraint_type = 'P')) 
 loop 
   execute immediate('alter table IBX_FILES drop constraint ' || cc_con.CONSTRAINT_NAME); 
 end loop; 
end;
/
begin 
   execute immediate('alter table IBX_FILES add constraint PK_IBXFILES PRIMARY KEY (TYPE_ID,FILE_NAME)');
exception when others then
if sqlcode = -2260 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint PK_IBXFILES'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add constraint FK_IBXFILES_ID_IBXTYPES FOREIGN KEY (TYPE_ID) references BARS.IBX_TYPES(ID)');
exception when others then 
if sqlcode = -2275 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint FK_IBXFILES_ID_IBXTYPES'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add constraint CC_IBXFILES_TSUM_NN check ("TOTAL_SUM" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXFILES_TSUM_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add constraint CC_IBXFILES_IBOXTYPE_NN check ("TYPE_ID" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXFILES_IBOXTYPE_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add constraint CC_IBXFILES_FILENAME_NN check ("FILE_NAME" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXFILES_FILENAME_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add constraint CC_IBXFILES_FDATE_NN check ("FILE_DATE" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXFILES_FDATE_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_FILES add constraint CC_IBXFILES_TCOUNT_NN check ("TOTAL_COUNT" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXFILES_TCOUNT_NN'); 
end if;
end;
/

begin 
   execute immediate('comment on table IBX_FILES is ''Таблица импортированных IBOX-файлов''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column IBX_FILES'); 
end;
/
begin 
   execute immediate('comment on column IBX_FILES.TYPE_ID is ''Тип интерфейса''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column TYPE_ID'); 
end;
/
begin 
   execute immediate('comment on column IBX_FILES.FILE_NAME is ''Имя файла''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column FILE_NAME'); 
end;
/
begin 
   execute immediate('comment on column IBX_FILES.FILE_DATE is ''Дата файла''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column FILE_DATE'); 
end;
/
begin 
   execute immediate('comment on column IBX_FILES.TOTAL_COUNT is ''Всего записей''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column TOTAL_COUNT'); 
end;
/
begin 
   execute immediate('comment on column IBX_FILES.TOTAL_SUM is ''Всего сумма''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column TOTAL_SUM'); 
end;
/
begin 
   execute immediate('comment on column IBX_FILES.LOADED is ''Дата/время принятия''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column LOADED'); 
end;
/