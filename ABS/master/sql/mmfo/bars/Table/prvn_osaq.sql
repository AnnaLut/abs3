PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_OSAQ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_OSAQ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_OSAQ'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_OSAQ'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_OSAQ ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_OSAQ 
   (	RNK NUMBER, 
	TIP NUMBER(*,0), 
	ND NUMBER, 
	REZB NUMBER(24,2), 
	REZ9 NUMBER(24,2), 
	ID_PROV_TYPE VARCHAR2(2), 
	IS_DEFAULT NUMBER(*,0), 
	COMM VARCHAR2(100), 
	FV_ABS NUMBER, 
	REZB_R NUMBER(24,2), 
	REZ9_R NUMBER(24,2), 
	AIRC_CCY NUMBER, 
	VIDD NUMBER(*,0), 
	KV NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to PRVN_OSAQ ***
 exec bpa.alter_policies('PRVN_OSAQ');

begin
 execute immediate   'alter table PRVN_OSAQ add (IRC_CCY NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.IRC_CCY IS 'IRC_CCY~РУХ~НЕприз.дох';

begin
 execute immediate   'alter table PRVN_OSAQ add (S1  NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S1 IS 'Кориг.~бал.варт.~до справедливої~S1';

begin
 execute immediate   'alter table PRVN_OSAQ add (S2  NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S2 IS 'Амортиз.кориг.~бал.варт.~до справедливої~S2';

begin
 execute immediate   'alter table PRVN_OSAQ add (B1  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.B1 IS 'Неамортиз.диск/прем.~за кориг.бал.варт.~до справедливої~B1';

begin
 execute immediate   'alter table PRVN_OSAQ add (S3  NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S3 IS 'Результат~від модиф.договору~~S3';

begin
 execute immediate   'alter table PRVN_OSAQ add (S4  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S4 IS 'Амортиз.~модиф.договору~~S4';

begin
 execute immediate   'alter table PRVN_OSAQ add (B3  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.B3 IS 'Неамортиз.~диск/прем.~за модиф.договору~B3';
begin
 execute immediate   'alter table PRVN_OSAQ add (S5  NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S5 IS 'Формування~"грошового"~дисконту/премії~S5';
begin
 execute immediate   'alter table PRVN_OSAQ add (S6  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S6 IS 'Амортиз.~"грошового"~дисконту/премії~S6';
begin
 execute immediate   'alter table PRVN_OSAQ add (B5  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.B5 IS 'Неамортиз.~"грошовий"~дисконт/премія~B5';

begin
 execute immediate   'alter table PRVN_OSAQ add (S7  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S7 IS 'Формування~"технічного"~дисконту/премії~S7';
begin
 execute immediate   'alter table PRVN_OSAQ add (S8  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.S8 IS 'Амортиз.~"технічного"~дисконту/премії~S8';
begin
 execute immediate   'alter table PRVN_OSAQ add (B7  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.B7 IS 'Неамортиз.~"технічний"~дисконт/премія~B7';
begin
 execute immediate   'alter table PRVN_OSAQ add (F1  NUMBER(1)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.F1 IS 'Ознака припинення~визнання фінансового~інструменту~F1';
begin
 execute immediate   'alter table PRVN_OSAQ add (IRR  NUMBER(20,7)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.IRR IS 'Ефективна~процентна~ставка~E1';
begin
 execute immediate   'alter table PRVN_OSAQ add (FV_CCY  NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_OSAQ.FV_CCY IS 'Переоценка';

COMMENT ON TABLE BARS.PRVN_OSAQ IS 'Стиснена Вітрина "Резерв-МСФЗ-екв"';
COMMENT ON COLUMN BARS.PRVN_OSAQ.RNK IS 'RNK_CLIENT~РНК~клиента';
COMMENT ON COLUMN BARS.PRVN_OSAQ.TIP IS 'UNIQUE_BARS_IS~Ключ/*~в АБС';
COMMENT ON COLUMN BARS.PRVN_OSAQ.ND IS 'UNIQUE_BARS_IS~*/Ключ~в АБС';
COMMENT ON COLUMN BARS.PRVN_OSAQ.REZB IS 'PROV_BALANCE_CCY~Резерв по~бал.акт';
COMMENT ON COLUMN BARS.PRVN_OSAQ.REZ9 IS 'PROV_OFFBALANCE_CCY~Резерв по~вне/бал.акт';
COMMENT ON COLUMN BARS.PRVN_OSAQ.ID_PROV_TYPE IS 'ID_PROV_TYPE~Кол/Инд~основа';
COMMENT ON COLUMN BARS.PRVN_OSAQ.IS_DEFAULT IS 'Метка~дефолта';
COMMENT ON COLUMN BARS.PRVN_OSAQ.COMM IS 'COMM~Протокол обр~NBU23_REZ';
COMMENT ON COLUMN BARS.PRVN_OSAQ.FV_ABS IS 'FV-ABS~НЕ прийнято~резерву';
COMMENT ON COLUMN BARS.PRVN_OSAQ.REZB_R IS 'Ручной~Резерв по~бал.акт';
COMMENT ON COLUMN BARS.PRVN_OSAQ.REZ9_R IS 'Ручной~Резерв по~вне/бал.акт';
COMMENT ON COLUMN BARS.PRVN_OSAQ.AIRC_CCY IS 'AIRC_CCY~Итого~НЕприз.дох';
COMMENT ON COLUMN BARS.PRVN_OSAQ.VIDD IS 'Вид кредиту';
COMMENT ON COLUMN BARS.PRVN_OSAQ.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.PRVN_OSAQ.KF IS '';




PROMPT *** Create  constraint CC_PRVNOSAQ_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_OSAQ MODIFY (KF CONSTRAINT CC_PRVNOSAQ_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_PRVN_OSAQ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_PRVN_OSAQ ON BARS.PRVN_OSAQ (kf,tip) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_OSAQ ***
grant SELECT,UPDATE                                                          on PRVN_OSAQ       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_OSAQ       to BARS_DM;
grant SELECT,UPDATE                                                          on PRVN_OSAQ       to START1;
grant SELECT                                                                 on PRVN_OSAQ       to UPLD;

CREATE OR REPLACE PUBLIC SYNONYM TEST_PRVN_OSA FOR BARS.PRVN_OSAQ ;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_OSAQ.sql =========*** End *** ===
PROMPT ===================================================================================== 
