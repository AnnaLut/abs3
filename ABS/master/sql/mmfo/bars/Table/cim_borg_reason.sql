

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_BORG_REASON.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_BORG_REASON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_BORG_REASON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_BORG_REASON'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_BORG_REASON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_BORG_REASON ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_BORG_REASON 
   (	ID NUMBER, 
	NAME VARCHAR2(256), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_BORG_REASON ***
 exec bpa.alter_policies('CIM_BORG_REASON');


COMMENT ON TABLE BARS.CIM_BORG_REASON IS 'Причина заборгованості';
COMMENT ON COLUMN BARS.CIM_BORG_REASON.ID IS 'ID причини заборгованості';
COMMENT ON COLUMN BARS.CIM_BORG_REASON.NAME IS 'Назва причини заборгованості';
COMMENT ON COLUMN BARS.CIM_BORG_REASON.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMBORGREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BORG_REASON ADD CONSTRAINT PK_CIMBORGREASON PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMBORGREASON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMBORGREASON ON BARS.CIM_BORG_REASON (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_BORG_REASON ***
grant SELECT                                                                 on CIM_BORG_REASON to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BORG_REASON to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_BORG_REASON to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BORG_REASON to CIM_ROLE;
grant SELECT                                                                 on CIM_BORG_REASON to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_BORG_REASON.sql =========*** End *
PROMPT ===================================================================================== 
