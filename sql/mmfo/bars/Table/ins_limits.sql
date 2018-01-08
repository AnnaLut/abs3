

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_LIMITS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_LIMITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_LIMITS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_LIMITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_LIMITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_LIMITS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	SUM_VALUE NUMBER, 
	PERC_VALUE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_LIMITS ***
 exec bpa.alter_policies('INS_LIMITS');


COMMENT ON TABLE BARS.INS_LIMITS IS 'Ліміти по договорах страхування';
COMMENT ON COLUMN BARS.INS_LIMITS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_LIMITS.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.INS_LIMITS.KF IS '';
COMMENT ON COLUMN BARS.INS_LIMITS.SUM_VALUE IS 'Cума';
COMMENT ON COLUMN BARS.INS_LIMITS.PERC_VALUE IS 'Процент';




PROMPT *** Create  constraint SYS_C0033286 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_LIMITS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSLIMITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_LIMITS ADD CONSTRAINT PK_INSLIMITS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSLIMITS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSLIMITS ON BARS.INS_LIMITS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_LIMITS.sql =========*** End *** ==
PROMPT ===================================================================================== 
