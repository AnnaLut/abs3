

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_REGION.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_REGION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_REGION'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOTARY_REGION'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_REGION'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_REGION ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_REGION 
   (	NOTARY_ID NUMBER(10,0), 
	KF VARCHAR2(6 CHAR), 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_REGION ***
 exec bpa.alter_policies('NOTARY_REGION');


COMMENT ON TABLE BARS.NOTARY_REGION IS 'Зв'язок нотаріуса з його РНК, відкритими для нього в різних МФО';
COMMENT ON COLUMN BARS.NOTARY_REGION.NOTARY_ID IS 'Ідентифікатор нотаріуса з централізованого довідника';
COMMENT ON COLUMN BARS.NOTARY_REGION.KF IS 'МФО регіонального управління';
COMMENT ON COLUMN BARS.NOTARY_REGION.RNK IS 'Ідентифікатор клієнта, під яким нотаріус зареєстрований в даному МФО';




PROMPT *** Create  constraint FK_NOTARY_REGION_REF_NOTARY ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_REGION ADD CONSTRAINT FK_NOTARY_REGION_REF_NOTARY FOREIGN KEY (NOTARY_ID)
	  REFERENCES BARS.NOTARY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006793 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_REGION MODIFY (NOTARY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006794 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_REGION MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006795 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_REGION MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index NOTARY_REGION_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.NOTARY_REGION_IDX ON BARS.NOTARY_REGION (NOTARY_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_REGION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY_REGION   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTARY_REGION   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_REGION.sql =========*** End ***
PROMPT ===================================================================================== 
