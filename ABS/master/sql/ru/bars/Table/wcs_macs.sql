

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_MACS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_MACS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_MACS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_MACS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_MACS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_MACS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	APPLY_LEVEL VARCHAR2(100) DEFAULT ''CA'', 
	MANDATORY NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_MACS ***
 exec bpa.alter_policies('WCS_MACS');


COMMENT ON TABLE BARS.WCS_MACS IS '����';
COMMENT ON COLUMN BARS.WCS_MACS.ID IS '�������������';
COMMENT ON COLUMN BARS.WCS_MACS.NAME IS '������������';
COMMENT ON COLUMN BARS.WCS_MACS.TYPE_ID IS '���';
COMMENT ON COLUMN BARS.WCS_MACS.APPLY_LEVEL IS '����*������� ��� �� � (1-���,0-�)';
COMMENT ON COLUMN BARS.WCS_MACS.MANDATORY IS '';




PROMPT *** Create  constraint FK_MACS_TID_MACTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS ADD CONSTRAINT FK_MACS_TID_MACTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_MAC_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MACS_APLEV_SRVHRCH_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS ADD CONSTRAINT FK_MACS_APLEV_SRVHRCH_ID FOREIGN KEY (APPLY_LEVEL)
	  REFERENCES BARS.WCS_SRV_HIERARCHY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSMACS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS ADD CONSTRAINT PK_WCSMACS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177124 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS MODIFY (MANDATORY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177123 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSMACS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MACS ADD CONSTRAINT CC_WCSMACS_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSMACS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSMACS ON BARS.WCS_MACS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_MACS.sql =========*** End *** ====
PROMPT ===================================================================================== 
