begin 
  BPA.ALTER_POLICY_INFO( 'IBX_TYPES', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'IBX_TYPES', 'FILIAL', null, null, null, null ); 
end;
/
begin 
   execute immediate('create table IBX_TYPES( test_column number ) 
    tablespace BRSDYND pctfree 10 initrans 1 maxtrans 255 storage( initial 65536 next 65536 minextents 1 maxextents 2147483645 pctincrease 0)');
exception when others then 
if sqlcode = -955 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create table IBX_TYPES'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "ID" VARCHAR2(256 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column ID'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "NAME" VARCHAR2(1024 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column NAME'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "NLS" VARCHAR2(15 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column NLS'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "EXT_OKPO" VARCHAR2(14 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column EXT_OKPO'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "EXT_NLS" VARCHAR2(15 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column EXT_NLS'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "EXT_MFO" VARCHAR2(12 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column EXT_MFO'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "EXT_NAZN_MASK" VARCHAR2(1024 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column EXT_NAZN_MASK'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "STAFF_ID" NUMBER ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column STAFF_ID'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "PROC_GETINFO" VARCHAR2(100 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column PROC_GETINFO'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "PROC_PAY" VARCHAR2(100 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column PROC_PAY'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add "ABS_NAZN_MASK" VARCHAR2(200 BYTE  ) ');
exception when others then 
if sqlcode = -1430 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: add column ABS_NAZN_MASK'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES drop column test_column');
exception when others then 
if sqlcode = -904 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: removing dummy-column'); 
end if;
end;
/
begin 
   execute immediate('create UNIQUE index PK_WCSIBOXTYPES on IBX_TYPES(ID) 
    tablespace BRSDYND pctfree 10 initrans 2 maxtrans 255 storage(  initial 65536 minextents 1 maxextents 2147483645)');
exception when others then 
if sqlcode = -955 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create index PK_WCSIBOXTYPES'); 
end if;
end;
/
begin  
 for cc_con in (select c.TABLE_NAME, c.CONSTRAINT_NAME, c.SEARCH_CONDITION, cc.COLUMN_NAME 
   from user_constraints c join user_cons_columns cc 
   on c.constraint_name = cc.constraint_name and c.owner = cc.owner 
   where c.table_name = 'IBX_TYPES' and c.constraint_type = 'C' and cc.COLUMN_NAME not in 
    (select cc1.COLUMN_NAME from user_constraints c1 join user_cons_columns cc1 
    on c1.constraint_name = cc1.constraint_name and c1.owner = cc1.owner 
    where c1.table_name = 'IBX_TYPES' and c1.constraint_type = 'P')) 
 loop 
   execute immediate('alter table IBX_TYPES drop constraint ' || cc_con.CONSTRAINT_NAME); 
 end loop; 
end;
/
begin 
   execute immediate('alter table IBX_TYPES add constraint FK_WCSIBOXTYPES_ID_STAFF FOREIGN KEY (STAFF_ID) references BARS.STAFF$BASE(ID)');
exception when others then 
if sqlcode = -2275 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint FK_WCSIBOXTYPES_ID_STAFF'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add constraint PK_WCSIBOXTYPES PRIMARY KEY (ID)');
exception when others then 
if sqlcode = -2260 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint PK_WCSIBOXTYPES'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add constraint NN_IBX_TYPES_ID check ("ID" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint SYS_C00361461'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add constraint CC_IBXTYPES_NLS_NN check ("NLS" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXTYPES_NLS_NN'); 
end if;
end;
/
begin 
   execute immediate('alter table IBX_TYPES add constraint CC_IBXTYPES_NAME_NN check ("NAME" IS NOT NULL)');
exception when others then 
if sqlcode = -2264 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create constraint CC_IBXTYPES_NAME_NN'); 
end if;
end;
/
begin 
   execute immediate('comment on table IBX_TYPES is ''Таблица типов IBOX''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column IBX_TYPES'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.ID is ''Идентификатор''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column ID'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.NAME is ''Наименование''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column NAME'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.NLS is ''Номер накопительного счета''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column NLS'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.EXT_OKPO is ''Реквизит консолидированого платежа - ИНН''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column EXT_OKPO'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.EXT_NLS is ''Реквизит консолидированого платежа - номер счета''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column EXT_NLS'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.EXT_MFO is ''Реквизит консолидированого платежа - МФО''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column EXT_MFO'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.EXT_NAZN_MASK is ''Реквизит консолидированого платежа - маска назначения платежа''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column EXT_NAZN_MASK'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.STAFF_ID is ''Идентификатор пользователя для доступа''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column STAFF_ID'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.PROC_GETINFO is ''Имя процедуры получения справки (параметры: p_params in xmltype, p_result out xmltype)''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column PROC_GETINFO'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.PROC_PAY is ''Имя процедуры оплаты (параметры: p_src_nls in varchar2 (номер счета для списания), p_deal_id in varchar2 (ид. сделки), p_sum in number (сумма платежа в коп), p_date in date (дата платежа), p_res_code out number (код результата), p_res_text out varchar2 (текст результата), p_res_ref out oper.ref%type (референс))''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column PROC_PAY'); 
end;
/
begin 
   execute immediate('comment on column IBX_TYPES.ABS_NAZN_MASK is ''Маска назначения внутр платежа''');
exception when others then 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''commenting column ABS_NAZN_MASK'); 
end;
/