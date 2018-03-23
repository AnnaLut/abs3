BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_TP_PARAMS'', ''WHOLE'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TP_PARAMS'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

--таблица параметров
begin 
  execute immediate '
create table IBX_TP_PARAMS
(
  trade_point VARCHAR2(20) not null,
  paramvalue  VARCHAR2(30),
  paramcode   VARCHAR2(20) not null
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )  ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
-- ПК таблицы параметров
begin 
  execute immediate '
alter table IBX_TP_PARAMS
  add constraint IBX_TP_PARAMS_PK primary key (TRADE_POINT, PARAMCODE)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ) ';
exception when others then       
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end; 
/
--ВК на справочник терминалов
begin 
  execute immediate '
alter table IBX_TP_PARAMS
  add constraint IBX_TP_PARAMS_TP foreign key (TRADE_POINT)
  references ibx_trade_point (TRADE_POINT)
  ';
exception when others then       
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end; 
/
--ВК на справочник парамтров
begin 
  execute immediate '
alter table IBX_TP_PARAMS
  add constraint IBX_TP_PARAMS_PARAMCODE foreign key (PARAMCODE)
  references ibx_tp_params_lst (PARAMCODE)
   ';
exception when others then       
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end; 
/
grant select, insert, update, delete, alter, debug on IBX_TP_PARAMS     to BARS_ACCESS_DEFROLE;
comment on table IBX_TP_PARAMS is 'Параметры терминалов Томас';
Comment on column IBX_TP_PARAMS.TRADE_POINT is 'Код устройства';
Comment on column IBX_TP_PARAMS.PARAMVALUE is 'Значение параметра';
Comment on column IBX_TP_PARAMS.PARAMCODE is 'Код параметра';

