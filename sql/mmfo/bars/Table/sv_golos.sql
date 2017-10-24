

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_GOLOS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_GOLOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_GOLOS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_GOLOS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_GOLOS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_GOLOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_GOLOS 
   (	ID NUMBER(10,0), 
	TO_NM1 VARCHAR2(254), 
	TO_NM2 VARCHAR2(50), 
	TO_NM3 VARCHAR2(50), 
	TO_COD VARCHAR2(10), 
	FROM_NM1 VARCHAR2(254), 
	FROM_NM2 VARCHAR2(50), 
	FROM_NM3 VARCHAR2(50), 
	FROM_COD VARCHAR2(10), 
	VIDSOTOK NUMBER(7,4), 
	GOLOS NUMBER(16,0), 
	NOMER VARCHAR2(20), 
	DT DATE, 
	PRICH VARCHAR2(254)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_GOLOS ***
 exec bpa.alter_policies('SV_GOLOS');


COMMENT ON TABLE BARS.SV_GOLOS IS 'Інформація про набуття права голосу';
COMMENT ON COLUMN BARS.SV_GOLOS.ID IS 'Ид.';
COMMENT ON COLUMN BARS.SV_GOLOS.TO_NM1 IS 'Особа, якій передали право голосу: Прізвище/найменування';
COMMENT ON COLUMN BARS.SV_GOLOS.TO_NM2 IS 'Особа, якій передали право голосу: Ім’я/скорочене найменування';
COMMENT ON COLUMN BARS.SV_GOLOS.TO_NM3 IS 'Особа, якій передали право голосу: По батькові';
COMMENT ON COLUMN BARS.SV_GOLOS.TO_COD IS 'Особа, якій передали право голосу: Ідентифікаційний код';
COMMENT ON COLUMN BARS.SV_GOLOS.FROM_NM1 IS 'Особа, яка передала право голосу: Прізвище/найменування';
COMMENT ON COLUMN BARS.SV_GOLOS.FROM_NM2 IS 'Особа, яка передала право голосу: Ім’я/скорочене найменування';
COMMENT ON COLUMN BARS.SV_GOLOS.FROM_NM3 IS 'Особа, яка передала право голосу: По батькові';
COMMENT ON COLUMN BARS.SV_GOLOS.FROM_COD IS 'Особа, яка передала право голосу: Ідентифікаційний код';
COMMENT ON COLUMN BARS.SV_GOLOS.VIDSOTOK IS 'Відсотки статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_GOLOS.GOLOS IS 'Кількість голосів';
COMMENT ON COLUMN BARS.SV_GOLOS.NOMER IS 'Номер доручення';
COMMENT ON COLUMN BARS.SV_GOLOS.DT IS 'Дата доручення';
COMMENT ON COLUMN BARS.SV_GOLOS.PRICH IS 'Причина передавання голосу';




PROMPT *** Create  constraint PK_SVGOLOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS ADD CONSTRAINT PK_SVGOLOS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_TOID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (ID CONSTRAINT CC_SVGOLOS_TOID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_PROCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (PRICH CONSTRAINT CC_SVGOLOS_PROCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_DT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (DT CONSTRAINT CC_SVGOLOS_DT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_NOMER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (NOMER CONSTRAINT CC_SVGOLOS_NOMER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_GOLOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (GOLOS CONSTRAINT CC_SVGOLOS_GOLOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_VIDSOTOK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (VIDSOTOK CONSTRAINT CC_SVGOLOS_VIDSOTOK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_FROMCOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (FROM_COD CONSTRAINT CC_SVGOLOS_FROMCOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_FROMNM2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (FROM_NM2 CONSTRAINT CC_SVGOLOS_FROMNM2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_FROMNM1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (FROM_NM1 CONSTRAINT CC_SVGOLOS_FROMNM1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_TOCOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (TO_COD CONSTRAINT CC_SVGOLOS_TOCOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_TONM2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (TO_NM2 CONSTRAINT CC_SVGOLOS_TONM2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVGOLOS_TONM1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_GOLOS MODIFY (TO_NM1 CONSTRAINT CC_SVGOLOS_TONM1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVGOLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVGOLOS ON BARS.SV_GOLOS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_GOLOS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_GOLOS        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_GOLOS        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_GOLOS.sql =========*** End *** ====
PROMPT ===================================================================================== 
