begin 
  BPA.ALTER_POLICY_INFO( 'IBX_RECS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'IBX_RECS', 'FILIAL', null, null, null, null ); 
end;
/
begin 
   execute immediate('create table IBX_RECS( test_column number ) 
    tablespace BRSDYND pctfree 10 initrans 1 maxtrans 255 storage( initial 131072 next 131072 minextents 1 maxextents 2147483645 pctincrease 0)');
exception when others then 
if sqlcode = -955 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create table IBX_RECS'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "TYPE_ID" VARCHAR2(256 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column TYPE_ID'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "EXT_REF" VARCHAR2(200 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column EXT_REF'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "EXT_DATE" DATE ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column EXT_DATE'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "EXT_SOURCE" VARCHAR2(300 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column EXT_SOURCE'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "DEAL_ID" VARCHAR2(25 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column DEAL_ID'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "SUMM" NUMBER ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column SUMM'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "ABS_REF" NUMBER ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column ABS_REF'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "FILE_NAME" VARCHAR2(256 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column FILE_NAME'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add "KWT" NUMBER ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column KWT'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS drop column test_column');
exception when others then 
if sqlcode = -904 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: removing dummy-column'); 
end if;
end;
/
begin 
   execute immediate('create UNIQUE index PK_IBXRECS on IBX_RECS(TYPE_ID,EXT_REF) 
    tablespace BRSDYND pctfree 10 initrans 2 maxtrans 255 storage(  initial 65536 minextents 1 maxextents 2147483645)');
exception when others then 
if sqlcode = -955 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create index PK_IBXRECS'); 
end if;
end;
/
begin  
 for cc_con in (select c.TABLE_NAME, c.CONSTRAINT_NAME, c.SEARCH_CONDITION, cc.COLUMN_NAME 
   from user_constraints c join user_cons_columns cc 
   on c.constraint_name = cc.constraint_name and c.owner = cc.owner 
   where c.table_name = 'IBX_RECS' and c.constraint_type = 'C' and cc.COLUMN_NAME not in 
    (select cc1.COLUMN_NAME from user_constraints c1 join user_cons_columns cc1 
    on c1.constraint_name = cc1.constraint_name and c1.owner = cc1.owner 
    where c1.table_name = 'IBX_RECS' and c1.constraint_type = 'P')) 
 loop 
   execute immediate('alter table IBX_RECS drop constraint ' || cc_con.CONSTRAINT_NAME); 
 end loop; 
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint FK_IBXRS_FNAME_IBXFS FOREIGN KEY (TYPE_ID, FILE_NAME) references BARS.IBX_FILES(TYPE_ID,FILE_NAME)');
exception when others then 
if sqlcode = -2275 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint FK_IBXRS_FNAME_IBXFS'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint FK_IBXRS_ABSREF_OPER FOREIGN KEY (ABS_REF) references BARS.OPER(REF)');
exception when others then 
if sqlcode = -2275 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint FK_IBXRS_ABSREF_OPER'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint PK_IBXRECS PRIMARY KEY (TYPE_ID,EXT_REF)');
exception when others then 
if sqlcode = -2260 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint PK_IBXRECS'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint CC_IBXRECS_TID_NN check ("TYPE_ID" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXRECS_TID_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint CC_IBXRECS_SUMM_NN check ("SUMM" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXRECS_SUMM_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint CC_IBXRECS_EXTREF_NN check ("EXT_REF" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXRECS_EXTREF_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint CC_IBXRECS_EXTDATE_NN check ("EXT_DATE" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXRECS_EXTDATE_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint CC_IBXRECS_DEALID_NN check ("DEAL_ID" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXRECS_DEALID_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_RECS add constraint CC_IBXRS_KWT check (kwt is null or kwt in (0, 1))');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXRS_KWT'); 
end if;
end;
/
begin 
   execute immediate('comment on table IBX_RECS is ''Таблица квитовки IBOX и АБС''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column IBX_RECS'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.TYPE_ID is ''Тип интерфейса''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column TYPE_ID'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.EXT_REF is ''Реф. пл. в IBOX''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column EXT_REF'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.EXT_DATE is ''Дата/время в IBOX''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column EXT_DATE'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.EXT_SOURCE is ''Источник платежа в IBOX (№ терминала и тп)''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column EXT_SOURCE'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.DEAL_ID is ''Ид. сделки''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column DEAL_ID'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.SUMM is ''Сумма в целых''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column SUMM'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.ABS_REF is ''Реф. пл. в АБC''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column ABS_REF'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.FILE_NAME is ''Имя файла''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column FILE_NAME'); 
end;
/
begin 
   execute immediate('comment on column IBX_RECS.KWT is ''КВТ: 1 - OK, 0 - ERR, Null - не обр''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column KWT'); 
end;
/