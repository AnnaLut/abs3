

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_VIDD_RU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_VIDD_RU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_VIDD_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_VIDD_RU 
   (	VIDD NUMBER(38,0), 
	CUSTTYPE NUMBER(1,0), 
	TIPD NUMBER(1,0), 
	NAME VARCHAR2(70), 
	SPS NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_VIDD_RU ***
 exec bpa.alter_policies('CC_VIDD_RU');


COMMENT ON TABLE BARS.CC_VIDD_RU IS '';
COMMENT ON COLUMN BARS.CC_VIDD_RU.VIDD IS '';
COMMENT ON COLUMN BARS.CC_VIDD_RU.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.CC_VIDD_RU.TIPD IS '';
COMMENT ON COLUMN BARS.CC_VIDD_RU.NAME IS '';
COMMENT ON COLUMN BARS.CC_VIDD_RU.SPS IS '';




PROMPT *** Create  constraint SYS_C006943 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD_RU MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006944 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD_RU MODIFY (CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006945 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD_RU MODIFY (TIPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006946 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD_RU MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_VIDD_RU ***
grant SELECT                                                                 on CC_VIDD_RU      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_VIDD_RU.sql =========*** End *** ==
PROMPT ===================================================================================== 
