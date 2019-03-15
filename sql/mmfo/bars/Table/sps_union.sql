

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPS_UNION.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPS_UNION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPS_UNION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPS_UNION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPS_UNION ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPS_UNION 
   (  UNION_ID NUMBER, 
  UNION_NAME VARCHAR2(255), 
  SPS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPS_UNION ***
 exec bpa.alter_policies('SPS_UNION');


COMMENT ON TABLE BARS.SPS_UNION IS 'Групування';
COMMENT ON COLUMN BARS.SPS_UNION.SPS IS 'SPS';
COMMENT ON COLUMN BARS.SPS_UNION.UNION_ID IS 'ID групування';
COMMENT ON COLUMN BARS.SPS_UNION.UNION_NAME IS 'Назва групування';




PROMPT *** Create  constraint SYS_C0031275 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_UNION MODIFY (UNION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0031276 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_UNION MODIFY (UNION_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPS_UNION_UNION_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_UNION ADD CONSTRAINT PK_SPS_UNION_UNION_ID PRIMARY KEY (UNION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SPS_UNION_UNION_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_UNION ADD CONSTRAINT UK_SPS_UNION_UNION_NAME UNIQUE (UNION_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SPS_UNION_UNION_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SPS_UNION_UNION_NAME ON BARS.SPS_UNION (UNION_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPS_UNION_UNION_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPS_UNION_UNION_ID ON BARS.SPS_UNION (UNION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPS_UNION ***
grant FLASHBACK,SELECT                                                       on SPS_UNION       to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPS_UNION       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPS_UNION       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPS_UNION.sql =========*** End *** ===
PROMPT ===================================================================================== 
