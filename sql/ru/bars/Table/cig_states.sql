

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_STATES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_STATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_STATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_STATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_STATES 
   (	STATE_ID NUMBER(4,0), 
	GROUP_ID NUMBER(4,0), 
	STATE_NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_STATES ***
 exec bpa.alter_policies('CIG_STATES');


COMMENT ON TABLE BARS.CIG_STATES IS '������� ����� ������� �����';
COMMENT ON COLUMN BARS.CIG_STATES.STATE_ID IS '��� �����';
COMMENT ON COLUMN BARS.CIG_STATES.GROUP_ID IS '';
COMMENT ON COLUMN BARS.CIG_STATES.STATE_NAME IS '���� �����';




PROMPT *** Create  constraint FK_CIGSTATES_CIGSTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_STATES ADD CONSTRAINT FK_CIGSTATES_CIGSTGROUPS FOREIGN KEY (GROUP_ID)
	  REFERENCES BARS.CIG_STATE_GROUPS (GROUP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIGSTATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_STATES ADD CONSTRAINT PK_CIGSTATES PRIMARY KEY (STATE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGSTATES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_STATES MODIFY (STATE_NAME CONSTRAINT CC_CIGSTATES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGSTATES_GROUPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_STATES MODIFY (GROUP_ID CONSTRAINT CC_CIGSTATES_GROUPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGSTATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGSTATES ON BARS.CIG_STATES (STATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_STATES.sql =========*** End *** ==
PROMPT ===================================================================================== 
