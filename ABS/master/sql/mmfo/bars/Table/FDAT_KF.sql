

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FDAT_KF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FDAT_KF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FDAT_KF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FDAT_KF ***
begin 
  execute immediate '
  CREATE TABLE BARS.FDAT_KF 
   (	KF VARCHAR2(6), 
	 CONSTRAINT PK_FDATKF PRIMARY KEY (KF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 NOLOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FDAT_KF ***
 exec bpa.alter_policies('FDAT_KF');


COMMENT ON TABLE BARS.FDAT_KF IS 'МФО користувачам якого заборонено вхід в попередню банківську дату';
COMMENT ON COLUMN BARS.FDAT_KF.KF IS '';




PROMPT *** Create  constraint CC_FDATKF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FDAT_KF MODIFY (KF CONSTRAINT CC_FDATKF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FDATKF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FDAT_KF ADD CONSTRAINT PK_FDATKF PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FDATKF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FDATKF ON BARS.FDAT_KF (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FDAT_KF.sql =========*** End *** =====
PROMPT ===================================================================================== 
