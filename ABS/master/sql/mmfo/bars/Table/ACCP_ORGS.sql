begin
  execute immediate 'begin bpa.alter_policy_info(''accp_orgs'', ''whole'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''accp_orgs'', ''filial'', ''M'', ''M'', ''M'', ''M''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

/*
begin 
  execute immediate 
    'DROP TABLE BARS.ACCP_ORGS CASCADE CONSTRAINTS';
exception when others then null;
end;
/
*/

begin 
  execute immediate 
    ' create table accp_orgs'||
    ' ('||
    '    name         varchar2(70) constraint cc_accporgs_name_nn not null,'||
    '    ndog         varchar2(20) constraint cc_accporgs_ndog_nn not null,'||
    '    ddog         date constraint cc_accporgs_ddog_nn not null,'||
    '    okpo         varchar2 (10) constraint cc_accporgs_okpo_nn not null,'||
    '    scope_dog    number (2) constraint cc_accporgs_scope_nn not null,'||
	'    fee_type_id  number(1),   '||
    '    fee_by_tarif  number,   '||
    '    order_fee    number (2) constraint cc_accporgs_orderfee_nn not null,'||
    '    amount_fee   number (5,2) constraint cc_accporgs_amfee_nn not null,'||
    '    fee_mfo      varchar2 (6) constraint cc_accporgs_feemfo_nn not null,'||
    '    fee_nls      varchar2 (15) constraint cc_accporgs_feenls_nn not null,'||
    '    fee_okpo     varchar2 (10) constraint cc_accporgs_feeokpo_nn not null,'||
    '    constraint pk_accporgs primary key (okpo) using index tablespace brssmli,'||
    '    constraint fk_accporgs_orderfee foreign key (order_fee)'||
    '        references accp_order_fee (id)'||
    ' )'||
    ' tablespace brssmld';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/

begin
    execute immediate 'begin bpa.add_column_kf(''accp_orgs''); end;';
end;
/


begin 
  execute immediate 
    ' alter table accp_orgs add fee_by_tarif  number';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin
    execute immediate 'alter table accp_orgs add (  constraint fk_accporgs_feetarif   foreign key (kf,fee_by_tarif)   references tarif(kf,KOD))';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin 
  execute immediate 
    ' alter table accp_orgs add name  varchar2(70) constraint cc_accporgs_name_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    'alter table accp_orgs add fee_type_id  number(1)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

update accp_orgs set fee_type_id = 1 where fee_type_id is null;
commit;

begin 
  execute immediate 
    ' alter table accp_orgs modify fee_type_id number(1) constraint cc_accporgs_feetype_nn not null';
exception when others then 
  if sqlcode=-1442 then null; else raise; end if;
end;
/


begin
    execute immediate 'alter table accp_orgs add (  constraint fk_accporgs_feetype   foreign key (fee_type_id)   references accp_fee_types (fee_type_id))';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 



begin 
  execute immediate 
    ' alter table accp_orgs add name  varchar2(70) constraint cc_accporgs_name_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add ndog  varchar2(20) constraint cc_accporgs_ndog_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add ddog  date constraint cc_accporgs_ddog_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add okpo  varchar2 (10) constraint cc_accporgs_okpo_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add scope_dog  number (2) constraint cc_accporgs_scope_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add order_fee  number (2) constraint cc_accporgs_orderfee_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add amount_fee  number (5,2) constraint cc_accporgs_amfee_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add fee_mfo  varchar2 (6) constraint cc_accporgs_feemfo_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add fee_nls  varchar2 (15) constraint cc_accporgs_feenls_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add fee_okpo  varchar2 (10) constraint cc_accporgs_feeokpo_nn not null';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/


begin 
  execute immediate 
    ' alter table accp_orgs add constraint pk_accporgs primary key (okpo) using index tablespace brssmli';
exception when others then 
  if sqlcode=-2260 or sqlcode=-2261 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' alter table accp_orgs add constraint fk_accporgs_orderfee foreign key (order_fee)'||
    '        references accp_order_fee (id)';
exception when others then 
  if sqlcode=-2275 then null; else raise; end if;
end;
/





COMMENT ON TABLE ACCP_ORGS IS 'довідник організацій для автоматичного формування Актів виконаних робіт на відшкодування комісійної винагороди';

COMMENT ON COLUMN ACCP_ORGS.NAME IS 'Назва організації';
COMMENT ON COLUMN ACCP_ORGS.NDOG IS '№ договору';
COMMENT ON COLUMN ACCP_ORGS.ddog IS 'Дата договору ';
COMMENT ON COLUMN ACCP_ORGS.okpo IS 'Код ЄДРПОУ організації';
COMMENT ON COLUMN ACCP_ORGS.scope_dog IS 'Область дії договору';
COMMENT ON COLUMN ACCP_ORGS.order_fee IS 'Порядок зняття комісійної винагороди';
COMMENT ON COLUMN ACCP_ORGS.amount_fee IS 'Фіксований розмір комісійної винагороди';
COMMENT ON COLUMN ACCP_ORGS.fee_mfo IS 'Код банку (для перерахунку комісійної винагороди) ';
COMMENT ON COLUMN ACCP_ORGS.fee_nls IS 'Розрахунковий рахунок  банку (для перерахунку комісійної винагороди)';
COMMENT ON COLUMN ACCP_ORGS.fee_okpo     IS 'Код ЄДРПОУ банку (для перерахунку комісійної винагороди)';
COMMENT ON COLUMN ACCP_ORGS.fee_type_id  is 'Тип тарифу для коміс. винагороди (1-фіксований,2-ступінчатий(по тарифу))';
COMMENT ON COLUMN ACCP_ORGS.fee_by_tarif is 'Код тарифу' ;

    
begin
  execute immediate 'begin bpa.alter_policies(''ACCP_ORGS''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON ACCP_ORGS TO BARS_ACCESS_DEFROLE;
