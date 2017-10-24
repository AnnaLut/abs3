

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_DOCEXPORT_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_DOCEXPORT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_DOCEXPORT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_DOCEXPORT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_DOCEXPORT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_DOCEXPORT_TYPES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_DOCEXPORT_TYPES ***
 exec bpa.alter_policies('WCS_DOCEXPORT_TYPES');


COMMENT ON TABLE BARS.WCS_DOCEXPORT_TYPES IS '������� �������� �������� ��������';
COMMENT ON COLUMN BARS.WCS_DOCEXPORT_TYPES.ID IS '�������������';
COMMENT ON COLUMN BARS.WCS_DOCEXPORT_TYPES.NAME IS '������������';




PROMPT *** Create  constraint PK_WCSDOCEXPTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DOCEXPORT_TYPES ADD CONSTRAINT PK_WCSDOCEXPTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSDOCEXPTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DOCEXPORT_TYPES MODIFY (NAME CONSTRAINT CC_WCSDOCEXPTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSDOCEXPTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSDOCEXPTYPES ON BARS.WCS_DOCEXPORT_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_DOCEXPORT_TYPES ***
grant SELECT                                                                 on WCS_DOCEXPORT_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_DOCEXPORT_TYPES.sql =========*** E
PROMPT ===================================================================================== 
