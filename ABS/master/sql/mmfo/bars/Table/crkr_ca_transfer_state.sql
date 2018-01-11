

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRKR_CA_TRANSFER_STATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRKR_CA_TRANSFER_STATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRKR_CA_TRANSFER_STATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRKR_CA_TRANSFER_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRKR_CA_TRANSFER_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRKR_CA_TRANSFER_STATE 
   (	STATE_ID NUMBER, 
	STATE_NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRKR_CA_TRANSFER_STATE ***
 exec bpa.alter_policies('CRKR_CA_TRANSFER_STATE');


COMMENT ON TABLE BARS.CRKR_CA_TRANSFER_STATE IS 'Опис статусів по переданій інформації';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER_STATE.STATE_ID IS '';
COMMENT ON COLUMN BARS.CRKR_CA_TRANSFER_STATE.STATE_NAME IS '';




PROMPT *** Create  constraint SYS_C00137530 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRKR_CA_TRANSFER_STATE MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CRKR_CA_TRANSFER_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRKR_CA_TRANSFER_STATE ADD CONSTRAINT PK_CRKR_CA_TRANSFER_STATE PRIMARY KEY (STATE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CRKR_CA_TRANSFER_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CRKR_CA_TRANSFER_STATE ON BARS.CRKR_CA_TRANSFER_STATE (STATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRKR_CA_TRANSFER_STATE ***
grant SELECT                                                                 on CRKR_CA_TRANSFER_STATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CRKR_CA_TRANSFER_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRKR_CA_TRANSFER_STATE.sql =========**
PROMPT ===================================================================================== 
