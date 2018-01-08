

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CF_LOG.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CF_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CF_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CF_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CF_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CF_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CF_LOG 
   (	ID NUMBER, 
	SYSTIME DATE, 
	IN_PAR VARCHAR2(4000), 
	OUT_PAR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CF_LOG ***
 exec bpa.alter_policies('CF_LOG');


COMMENT ON TABLE BARS.CF_LOG IS 'Кредитна фабрика - таблиця протоколу запитів';
COMMENT ON COLUMN BARS.CF_LOG.ID IS '';
COMMENT ON COLUMN BARS.CF_LOG.SYSTIME IS '';
COMMENT ON COLUMN BARS.CF_LOG.IN_PAR IS '';
COMMENT ON COLUMN BARS.CF_LOG.OUT_PAR IS '';




PROMPT *** Create  constraint PK_CF_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CF_LOG ADD CONSTRAINT PK_CF_LOG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CF_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CF_LOG ON BARS.CF_LOG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CF_LOG ***
grant SELECT                                                                 on CF_LOG          to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CF_LOG.sql =========*** End *** ======
PROMPT ===================================================================================== 
