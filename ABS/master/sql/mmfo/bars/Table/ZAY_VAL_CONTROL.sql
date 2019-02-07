PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_VAL_CONTROL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_VAL_CONTROL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_VAL_CONTROL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_VAL_CONTROL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_VAL_CONTROL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/



PROMPT *** Create  table ZAY_VAL_CONTROL ***
begin 
  execute immediate '
create table ZAY_VAL_CONTROL
(
  zay_id    NUMBER not null,
  zay_date  DATE default trunc(sysdate),
  sos       NUMBER(2,1),
  viza      NUMBER,
  rnk       NUMBER(38),
  nmk       VARCHAR2(70),
  okpo      VARCHAR2(14),
  ser_pasp  VARCHAR2(10),
  nom_pasp  VARCHAR2(20),
  summa_val NUMBER,
  kv2       NUMBER,
  rate_o    NUMBER,
  summa     NUMBER,
  mfo       VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  branch    VARCHAR2(30) default sys_context(''bars_context'',''user_branch''),
  zay_date_v DATE,
  custtype   NUMBER(1)

)tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )'
;
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Alter  table ZAY_VAL_CONTROL ***
begin 
  execute immediate '
  alter table zay_val_control add f092 char(3byte)'
;
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/


PROMPT ***  Create/Recreate indexes  table ZAY_VAL_CONTROL *** 
begin 
  execute immediate '
create index IDX_VAL_CONT_OKPO on ZAY_VAL_CONTROL (OKPO)
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255';
exception when others then       
  if sqlcode=-00955 then null; else raise; end if; 
end; 
/

PROMPT ***  Create/Recreate primary key  table ZAY_VAL_CONTROL *** 
begin 
  execute immediate '
alter table ZAY_VAL_CONTROL
  add constraint PK_ZAY_VAL_CONTROL primary key (ZAY_ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
';
exception when others then       
  if sqlcode=-02260 then null; else raise; end if; 
end; 
/


-- Add comments to the table 
comment on table ZAY_VAL_CONTROL   is 'Таблиця контролю добового ліміту купівлі безготівкової валюти';
-- Add comments to the columns 
comment on column ZAY_VAL_CONTROL.zay_id    is 'ID заявки';
comment on column ZAY_VAL_CONTROL.zay_date  is 'Дата заявки';
comment on column ZAY_VAL_CONTROL.zay_date_v  is 'Дата візування заявки';
comment on column ZAY_VAL_CONTROL.sos       is 'Стан заявки';
comment on column ZAY_VAL_CONTROL.viza      is 'Віза';
comment on column ZAY_VAL_CONTROL.rnk       is 'РНК';
comment on column ZAY_VAL_CONTROL.nmk       is 'Назва клієнта';
comment on column ZAY_VAL_CONTROL.okpo      is 'ОКПО';
comment on column ZAY_VAL_CONTROL.ser_pasp  is 'серія паспорта ';
comment on column ZAY_VAL_CONTROL.nom_pasp  is 'Номер паспорта';
comment on column ZAY_VAL_CONTROL.summa     is 'Сума еквівалента заявки';
comment on column ZAY_VAL_CONTROL.custtype  is 'Тип контрагента';
comment on column ZAY_VAL_CONTROL.f092	    is 'Значення F092';


PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_VAL_CONTROL.sql =========*** END **
PROMPT ===================================================================================== 
