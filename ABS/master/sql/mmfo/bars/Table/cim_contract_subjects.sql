

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_SUBJECTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACT_SUBJECTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACT_SUBJECTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACT_SUBJECTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CONTRACT_SUBJECTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACT_SUBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACT_SUBJECTS 
   (	SUBJECT_ID NUMBER, 
	SUBJECT_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACT_SUBJECTS ***
 exec bpa.alter_policies('CIM_CONTRACT_SUBJECTS');


COMMENT ON TABLE BARS.CIM_CONTRACT_SUBJECTS IS 'Предмети торгового контракту version 1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACT_SUBJECTS.SUBJECT_ID IS 'ID предмета контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACT_SUBJECTS.SUBJECT_NAME IS 'Найменування предмета';




PROMPT *** Create  constraint PK_CIMCONTRSUBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_SUBJECTS ADD CONSTRAINT PK_CIMCONTRSUBJECTS PRIMARY KEY (SUBJECT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONTRSUBJECTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONTRSUBJECTS ON BARS.CIM_CONTRACT_SUBJECTS (SUBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACT_SUBJECTS ***
grant SELECT                                                                 on CIM_CONTRACT_SUBJECTS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_SUBJECTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACT_SUBJECTS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_SUBJECTS to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACT_SUBJECTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_SUBJECTS.sql =========***
PROMPT ===================================================================================== 
