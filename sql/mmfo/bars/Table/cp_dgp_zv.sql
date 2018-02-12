begin
  bpa.alter_policy_info( 'cp_dgp_zv', 'CENTER', null, null, null, null );
  bpa.alter_policy_info( 'cp_dgp_zv', 'FILIAL',  'M',  'M',  'M',  'M' );
  bpa.alter_policy_info( 'cp_dgp_zv', 'WHOLE' , null,  'E',  'E',  'E' );
end;
/

-- Create table
begin 
  execute immediate '
create table cp_dgp_zv
(
  g001       VARCHAR2(255),
  g002       VARCHAR2(255),
  g003       VARCHAR2(255),
  g004       VARCHAR2(255),
  g005       VARCHAR2(255),
  g006       VARCHAR2(255),
  g007       VARCHAR2(255),
  g008       VARCHAR2(255),
  g009       VARCHAR2(255),
  g010       VARCHAR2(255),
  g011       VARCHAR2(255),
  g012       VARCHAR2(255),
  g013       VARCHAR2(255),
  g014       VARCHAR2(255),
  g015       VARCHAR2(255),
  g016       VARCHAR2(255),
  g017       VARCHAR2(255),
  g018       VARCHAR2(255),
  g019       VARCHAR2(255),
  g020       VARCHAR2(255),
  g021       VARCHAR2(255),
  g022       VARCHAR2(255),
  g023       VARCHAR2(255),
  g024       VARCHAR2(255),
  g025       VARCHAR2(255),
  g026       VARCHAR2(255),
  g027       VARCHAR2(255),
  g028       VARCHAR2(255),
  g029       VARCHAR2(255),
  g030       VARCHAR2(255),
  g031       VARCHAR2(255),
  g032       VARCHAR2(255),
  g033       VARCHAR2(255),
  g034       VARCHAR2(255),
  g035       VARCHAR2(255),
  g036       VARCHAR2(255),
  g037       VARCHAR2(255),
  g038       VARCHAR2(255),
  g039       VARCHAR2(255),
  g040       VARCHAR2(255),
  g041       VARCHAR2(255),
  g042       VARCHAR2(255),
  g043       VARCHAR2(255),
  g044       VARCHAR2(255),
  g045       VARCHAR2(255),
  g046       VARCHAR2(255),
  g047       VARCHAR2(255),
  g048       VARCHAR2(255),
  g049       VARCHAR2(255),
  g050       VARCHAR2(255),
  g051       VARCHAR2(255),
  g052       VARCHAR2(255),
  g053       VARCHAR2(255),
  g054       VARCHAR2(255),
  g055       VARCHAR2(255),
  g056       VARCHAR2(255),
  g057       VARCHAR2(255),
  g058       VARCHAR2(255),
  g059       VARCHAR2(255),
  g060       VARCHAR2(255),
  g061       VARCHAR2(255),
  g062       VARCHAR2(255),
  g063       VARCHAR2(255),
  g064       VARCHAR2(255),
  g065       VARCHAR2(255),
  g066       VARCHAR2(255),
  g067       VARCHAR2(255),
  g068       VARCHAR2(255),
  g069       VARCHAR2(255),
  g070       VARCHAR2(255),
  g071       VARCHAR2(255),
  g072       VARCHAR2(255),
  g073       VARCHAR2(255),
  g074       VARCHAR2(255),
  g075       VARCHAR2(255),
  g076       VARCHAR2(255),
  g077       VARCHAR2(255),
  g078       VARCHAR2(255),
  g079       VARCHAR2(255),
  g080       VARCHAR2(255),
  g081       VARCHAR2(255),
  g082       VARCHAR2(255),
  g083       VARCHAR2(255),
  g084       VARCHAR2(255),
  g085       VARCHAR2(255),
  g086       VARCHAR2(255),
  g087       VARCHAR2(255),
  g088       VARCHAR2(255),
  g089       VARCHAR2(255),
  g090       VARCHAR2(255),
  g091       VARCHAR2(255),
  g092       VARCHAR2(255),
  g093       VARCHAR2(255),
  g094       VARCHAR2(255),
  g095       VARCHAR2(255),
  g096       VARCHAR2(255),
  g097       VARCHAR2(255),
  g098       VARCHAR2(255),
  g099       VARCHAR2(255),                  
  id         number,
  ref        number,
  ref_sale   number,
  type_id    number(2),
  date_from  date,
  date_to    date,
  user_id    number,
  date_reg   date default TRUNC(SYSDATE),
  kf         varchar2(6) default sys_context(''bars_context'',''user_mfo'')
)
tablespace brsdynd';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

-- Add comments to the table 
comment on table CP_DGP_ZV is 'Таблиця для форм DGP по ЦП';
-- Add comments to the columns 
comment on column CP_DGP_ZV.id  is 'ID ЦП';
comment on column CP_DGP_ZV.ref  is 'ref угоди купівлі';
comment on column CP_DGP_ZV.ref_sale  is 'ref угоди продажу';
comment on column CP_DGP_ZV.type_id  is 'вид звіт';


begin   
 execute immediate 'create unique index IDX_U_KF_TYPE_USER_ID on CP_DGP_ZV (kf, type_id, user_id, id, ref, ref_sale)';
exception when others then
  if  sqlcode=-955 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'alter table CP_DGP_ZV
  add constraint FK_TYPE_ID foreign key (TYPE_ID)
  references cp_dgp_zv_type (TYPE_ID)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_DGP_ZV
  add constraint FK_KF_ID foreign key (ID, KF)
  references cp_kod (ID, KF)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (DATE_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (DATE_TO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (DATE_REG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate '
  ALTER TABLE BARS.CP_DGP_ZV MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



grant SELECT,UPDATE,DELETE                                                          on CP_DGP_ZV  to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE,DELETE                                                          on CP_DGP_ZV  to CP_ROLE;
