

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOZ.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDOZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDOZ 
   (	ACC NUMBER, 
	FDAT DATE, 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOZ ***
 exec bpa.alter_policies('SALDOZ');


COMMENT ON TABLE BARS.SALDOZ IS '';
COMMENT ON COLUMN BARS.SALDOZ.ACC IS '';
COMMENT ON COLUMN BARS.SALDOZ.FDAT IS '';
COMMENT ON COLUMN BARS.SALDOZ.DOS IS '';
COMMENT ON COLUMN BARS.SALDOZ.KOS IS '';
COMMENT ON COLUMN BARS.SALDOZ.DOSQ IS '';
COMMENT ON COLUMN BARS.SALDOZ.KOSQ IS '';




PROMPT *** Create  constraint XPK_SALDOZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOZ ADD CONSTRAINT XPK_SALDOZ PRIMARY KEY (FDAT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644390 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOZ MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644389 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOZ MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644388 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOZ MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644387 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOZ MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644386 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOZ MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_SALDOZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_SALDOZ ON BARS.SALDOZ (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SALDOZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SALDOZ ON BARS.SALDOZ (FDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDOZ ***
grant SELECT                                                                 on SALDOZ          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOZ.sql =========*** End *** ======
PROMPT ===================================================================================== 
