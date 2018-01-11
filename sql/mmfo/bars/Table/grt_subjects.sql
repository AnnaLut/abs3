

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_SUBJECTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_SUBJECTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_SUBJECTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_SUBJECTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_SUBJECTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_SUBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_SUBJECTS 
   (	SUBJ_ID NUMBER(10,0), 
	SUBJ_NAME VARCHAR2(150), 
	TYPE_ID NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_SUBJECTS ***
 exec bpa.alter_policies('GRT_SUBJECTS');


COMMENT ON TABLE BARS.GRT_SUBJECTS IS 'Справочник предметов обеспечения';
COMMENT ON COLUMN BARS.GRT_SUBJECTS.SUBJ_ID IS 'Идетнификатор предмета обеспечения';
COMMENT ON COLUMN BARS.GRT_SUBJECTS.SUBJ_NAME IS 'Наименование предмета обеспечения';
COMMENT ON COLUMN BARS.GRT_SUBJECTS.TYPE_ID IS 'Идентификатор типа обеспечения';




PROMPT *** Create  constraint PK_GRTSUBJ ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_SUBJECTS ADD CONSTRAINT PK_GRTSUBJ PRIMARY KEY (SUBJ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTSUBJ_SUBJNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_SUBJECTS MODIFY (SUBJ_NAME CONSTRAINT CC_GRTSUBJ_SUBJNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTSUBJ_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_SUBJECTS MODIFY (TYPE_ID CONSTRAINT CC_GRTSUBJ_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTSUBJ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTSUBJ ON BARS.GRT_SUBJECTS (SUBJ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_SUBJECTS ***
grant SELECT                                                                 on GRT_SUBJECTS    to BARSREADER_ROLE;
grant SELECT                                                                 on GRT_SUBJECTS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_SUBJECTS    to BARS_DM;
grant SELECT                                                                 on GRT_SUBJECTS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_SUBJECTS.sql =========*** End *** 
PROMPT ===================================================================================== 
