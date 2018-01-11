

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_AGRM_PRTFL_TP.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_AGRM_PRTFL_TP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_AGRM_PRTFL_TP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_AGRM_PRTFL_TP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_AGRM_PRTFL_TP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_AGRM_PRTFL_TP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_AGRM_PRTFL_TP 
   (	PRTFL_TP_ID CHAR(3), 
	PRTFL_TP_NM VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_AGRM_PRTFL_TP ***
 exec bpa.alter_policies('NBUR_REF_AGRM_PRTFL_TP');


COMMENT ON TABLE BARS.NBUR_REF_AGRM_PRTFL_TP IS 'Довідник типів портфелів договорів АБС';
COMMENT ON COLUMN BARS.NBUR_REF_AGRM_PRTFL_TP.PRTFL_TP_ID IS 'Назва типу портфеля договорів';
COMMENT ON COLUMN BARS.NBUR_REF_AGRM_PRTFL_TP.PRTFL_TP_NM IS '';




PROMPT *** Create  constraint CC_REFAGRMPRTFLTP_PRTFLTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_AGRM_PRTFL_TP MODIFY (PRTFL_TP_ID CONSTRAINT CC_REFAGRMPRTFLTP_PRTFLTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFAGRMPRTFLTP_PRTFLNM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_AGRM_PRTFL_TP MODIFY (PRTFL_TP_NM CONSTRAINT CC_REFAGRMPRTFLTP_PRTFLNM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_REFAGRMPRTFLTP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_AGRM_PRTFL_TP ADD CONSTRAINT PK_REFAGRMPRTFLTP PRIMARY KEY (PRTFL_TP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REFAGRMPRTFLTP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REFAGRMPRTFLTP ON BARS.NBUR_REF_AGRM_PRTFL_TP (PRTFL_TP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_AGRM_PRTFL_TP ***
grant SELECT                                                                 on NBUR_REF_AGRM_PRTFL_TP to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_REF_AGRM_PRTFL_TP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_REF_AGRM_PRTFL_TP to BARS_DM;
grant SELECT                                                                 on NBUR_REF_AGRM_PRTFL_TP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_AGRM_PRTFL_TP.sql =========**
PROMPT ===================================================================================== 
