

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPS_SPR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPS_SPR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPS_SPR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPS_SPR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPS_SPR ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPS_SPR 
   (  SPS NUMBER, 
  SPS_NAME VARCHAR2(255), 
  DESCRIPTION VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPS_SPR ***
 exec bpa.alter_policies('SPS_SPR');


COMMENT ON TABLE BARS.SPS_SPR IS 'Спосіб обчислення суми';
COMMENT ON COLUMN BARS.SPS_SPR.SPS IS 'SPS';
COMMENT ON COLUMN BARS.SPS_SPR.SPS_NAME IS 'Назва SPS';
COMMENT ON COLUMN BARS.SPS_SPR.DESCRIPTION IS 'Опис SPS';




PROMPT *** Create  constraint SYS_C0031279 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_SPR MODIFY (SPS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0031280 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_SPR MODIFY (SPS_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPS_SPR_SPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_SPR ADD CONSTRAINT PK_SPS_SPR_SPS PRIMARY KEY (SPS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SPS_SPR_SPS_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_SPR ADD CONSTRAINT UK_SPS_SPR_SPS_NAME UNIQUE (SPS_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPS_SPR_SPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPS_SPR_SPS ON BARS.SPS_SPR (SPS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SPS_SPR_SPS_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SPS_SPR_SPS_NAME ON BARS.SPS_SPR (SPS_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPS_SPR ***
grant SELECT                                                                 on SPS_SPR         to START1;
grant SELECT                                                                 on SPS_SPR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPS_SPR         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPS_SPR.sql =========*** End *** =====
PROMPT ===================================================================================== 
