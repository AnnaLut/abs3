

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINP_CONSUMPTION_RATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINP_CONSUMPTION_RATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINP_CONSUMPTION_RATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINP_CONSUMPTION_RATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINP_CONSUMPTION_RATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINP_CONSUMPTION_RATE 
   (	KVED VARCHAR2(5), 
	NAME VARCHAR2(400), 
	CON_RATE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINP_CONSUMPTION_RATE ***
 exec bpa.alter_policies('FINP_CONSUMPTION_RATE');


COMMENT ON TABLE BARS.FINP_CONSUMPTION_RATE IS '';
COMMENT ON COLUMN BARS.FINP_CONSUMPTION_RATE.KVED IS '';
COMMENT ON COLUMN BARS.FINP_CONSUMPTION_RATE.NAME IS '';
COMMENT ON COLUMN BARS.FINP_CONSUMPTION_RATE.CON_RATE IS '';




PROMPT *** Create  constraint SYS_C003177450 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINP_CONSUMPTION_RATE ADD PRIMARY KEY (KVED)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177449 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINP_CONSUMPTION_RATE MODIFY (KVED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C003177450 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C003177450 ON BARS.FINP_CONSUMPTION_RATE (KVED) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINP_CONSUMPTION_RATE ***
grant SELECT                                                                 on FINP_CONSUMPTION_RATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINP_CONSUMPTION_RATE.sql =========***
PROMPT ===================================================================================== 
