

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_PERSON.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_PERSON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_PERSON'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_PERSON'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_PERSON'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_PERSON ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_PERSON 
   (	RNK NUMBER(38,0), 
	SEX CHAR(1), 
	PASSP NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PDATE DATE, 
	ORGAN VARCHAR2(70), 
	BDAY DATE, 
	BPLACE VARCHAR2(70), 
	TELD VARCHAR2(20), 
	TELW VARCHAR2(20), 
	CELLPHONE VARCHAR2(20), 
	ACTUAL_DATE DATE, 
	EDDR_ID VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_PERSON ***
 exec bpa.alter_policies('CLV_PERSON');


COMMENT ON TABLE BARS.CLV_PERSON IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.RNK IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.SEX IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.PASSP IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.SER IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.NUMDOC IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.PDATE IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.ORGAN IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.BDAY IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.BPLACE IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.TELD IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.TELW IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.CELLPHONE IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.ACTUAL_DATE IS '';
COMMENT ON COLUMN BARS.CLV_PERSON.EDDR_ID IS '';




PROMPT *** Create  constraint PK_CLVPERSON ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_PERSON ADD CONSTRAINT PK_CLVPERSON PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVPERSON_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_PERSON MODIFY (RNK CONSTRAINT CC_CLVPERSON_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVPERSON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVPERSON ON BARS.CLV_PERSON (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_PERSON ***
grant SELECT                                                                 on CLV_PERSON      to BARSREADER_ROLE;
grant SELECT                                                                 on CLV_PERSON      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_PERSON      to BARS_DM;
grant SELECT                                                                 on CLV_PERSON      to CUST001;
grant SELECT                                                                 on CLV_PERSON      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_PERSON.sql =========*** End *** ==
PROMPT ===================================================================================== 
