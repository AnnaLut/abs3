

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_OBU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_OBU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_OBU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_OBU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_OBU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_OBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_OBU 
   (	BRANCH VARCHAR2(30), 
	RID NUMBER(22,0), 
	RU VARCHAR2(254), 
	NAME VARCHAR2(254), 
	OPENDATE DATE, 
	CLOSEDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_OBU ***
 exec bpa.alter_policies('BRANCH_OBU');


COMMENT ON TABLE BARS.BRANCH_OBU IS 'Підрозділи банку';
COMMENT ON COLUMN BARS.BRANCH_OBU.BRANCH IS 'Код підрозділу';
COMMENT ON COLUMN BARS.BRANCH_OBU.RID IS 'Ід. РУ';
COMMENT ON COLUMN BARS.BRANCH_OBU.RU IS 'Назва РУ';
COMMENT ON COLUMN BARS.BRANCH_OBU.NAME IS 'Назва підрозділу';
COMMENT ON COLUMN BARS.BRANCH_OBU.OPENDATE IS '';
COMMENT ON COLUMN BARS.BRANCH_OBU.CLOSEDATE IS '';




PROMPT *** Create  constraint PK_BRANCHOBU ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_OBU ADD CONSTRAINT PK_BRANCHOBU PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCHOBU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCHOBU ON BARS.BRANCH_OBU (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_OBU ***
grant SELECT                                                                 on BRANCH_OBU      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_OBU.sql =========*** End *** ==
PROMPT ===================================================================================== 
