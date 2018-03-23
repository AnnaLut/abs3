BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_TRADE_POINT'', ''WHOLE'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TRADE_POINT'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
 
-- Create table
begin 
   execute immediate('create table ibx_trade_point
(
  trade_point varchar2(20),
  mfo         varchar2(6),
  nls         varchar2(20)
)
tablespace BRSDYND pctfree 10 initrans 1 maxtrans 255');
exception when others then 
if sqlcode = -955 then null;
else
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create table ibx_trade_point'); 
end if;
end;
/

-- Add comments to the table 
comment on table ibx_trade_point
  is 'Скписок терминалов томас';
-- Add comments to the columns 
comment on column ibx_trade_point.trade_point
  is 'Код устройства TOMAS';
comment on column ibx_trade_point.mfo
  is 'Код банка';
comment on column ibx_trade_point.nls
  is 'Номер лицевого счета 1004';
  
/  
GRANT all ON BARS.IBX_TRADE_POINT TO BARS_ACCESS_DEFROLE;
/
--ПК на справочник терминалов
begin 
  execute immediate '
alter table IBX_TRADE_POINT
  add constraint TRADE_POINT_PK primary key (TRADE_POINT)  
  ';
exception when others then       
  if sqlcode in(-955,-02260,-02275) then null; else raise; end if; 
end;
/
begin 
  execute immediate ' alter table ibx_trade_point  add  comm  VARCHAR2(200)';
exception when others then       
  if sqlcode=-955 or  sqlcode=-01430 then null; else raise; end if; 
end;
/
comment on column IBX_TRADE_POINT.COMM is 'Коментарий';
/
