

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MAKW_DET.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MAKW_DET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MAKW_DET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MAKW_DET'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MAKW_DET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MAKW_DET ***
begin 
  execute immediate '
  CREATE TABLE BARS.MAKW_DET 
   (	ID NUMBER, 
	GRP NUMBER, 
	TT CHAR(3 CHAR), 
	NLSA VARCHAR2(14 CHAR), 
	NLSB VARCHAR2(14 CHAR), 
	MFOB VARCHAR2(6 CHAR), 
	OKPOB VARCHAR2(10), 
	NAZN VARCHAR2(160 CHAR), 
	SUMP NUMBER, 
	NAM_B VARCHAR2(70 CHAR), 
	BRANCH VARCHAR2(22), 
	VOB NUMBER, 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MAKW_DET ***
 exec bpa.alter_policies('MAKW_DET');


COMMENT ON TABLE BARS.MAKW_DET IS '';
COMMENT ON COLUMN BARS.MAKW_DET.ID IS 'ID ПЛАТЕЖУ';
COMMENT ON COLUMN BARS.MAKW_DET.GRP IS 'ГРУПА МАКЕТУ';
COMMENT ON COLUMN BARS.MAKW_DET.TT IS 'КОД ОПЕРАЦІЇ';
COMMENT ON COLUMN BARS.MAKW_DET.NLSA IS 'РАХУНОК А';
COMMENT ON COLUMN BARS.MAKW_DET.NLSB IS 'РАХУНОК Б';
COMMENT ON COLUMN BARS.MAKW_DET.MFOB IS 'МФО Б';
COMMENT ON COLUMN BARS.MAKW_DET.OKPOB IS 'ОКПО Б';
COMMENT ON COLUMN BARS.MAKW_DET.NAZN IS 'ПРИЗНАЧЕННЯ ПЛАТЕЖУ';
COMMENT ON COLUMN BARS.MAKW_DET.SUMP IS 'СУМА ПЛАТЕЖУ';
COMMENT ON COLUMN BARS.MAKW_DET.NAM_B IS ' НАЗВА РАХУНКУ Б';
COMMENT ON COLUMN BARS.MAKW_DET.BRANCH IS 'БРАНЧ ДЛЯ ДОПРЕКВІЗИТУ ФІНЗВІТНОСТІ';
COMMENT ON COLUMN BARS.MAKW_DET.VOB IS 'ВОБ КВИТАНЦІЇ';
COMMENT ON COLUMN BARS.MAKW_DET.ORD IS 'Порядок сортування';




PROMPT *** Create  constraint PK_MAKW_DET_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET ADD CONSTRAINT PK_MAKW_DET_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006965 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006964 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (NAM_B NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006963 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006962 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (OKPOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006961 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006960 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006959 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006958 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_DET MODIFY (GRP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MAKW_DET_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MAKW_DET_ID ON BARS.MAKW_DET (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_MAKW_GRP ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_MAKW_GRP ON BARS.MAKW_DET (GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MAKW_DET ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MAKW_DET        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MAKW_DET.sql =========*** End *** ====
PROMPT ===================================================================================== 
