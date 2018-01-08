

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_DRB_TYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_DRB_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_DRB_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_DRB_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_DRB_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_DRB_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_DRB_TYPES 
   (	ID NUMBER, 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_DRB_TYPES ***
 exec bpa.alter_policies('WCS_DRB_TYPES');


COMMENT ON TABLE BARS.WCS_DRB_TYPES IS '���� ���';
COMMENT ON COLUMN BARS.WCS_DRB_TYPES.ID IS '�������������';
COMMENT ON COLUMN BARS.WCS_DRB_TYPES.NAME IS '������������';




PROMPT *** Create  constraint CC_WCSDRBTPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DRB_TYPES MODIFY (NAME CONSTRAINT CC_WCSDRBTPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSDRBTPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DRB_TYPES ADD CONSTRAINT PK_WCSDRBTPS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSDRBTPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSDRBTPS ON BARS.WCS_DRB_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_DRB_TYPES ***
grant SELECT                                                                 on WCS_DRB_TYPES   to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_DRB_TYPES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_DRB_TYPES   to BARS_DM;
grant SELECT                                                                 on WCS_DRB_TYPES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_DRB_TYPES.sql =========*** End ***
PROMPT ===================================================================================== 
