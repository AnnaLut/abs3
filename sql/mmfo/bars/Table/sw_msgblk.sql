

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MSGBLK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MSGBLK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MSGBLK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_MSGBLK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_MSGBLK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MSGBLK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MSGBLK 
   (	MSGBLK VARCHAR2(1), 
	MSGBLKNM VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MSGBLK ***
 exec bpa.alter_policies('SW_MSGBLK');


COMMENT ON TABLE BARS.SW_MSGBLK IS 'SWT. Блоки сообщения';
COMMENT ON COLUMN BARS.SW_MSGBLK.MSGBLK IS 'Код блока сообщения';
COMMENT ON COLUMN BARS.SW_MSGBLK.MSGBLKNM IS 'Наименование блока';




PROMPT *** Create  constraint CC_SWMSGBLK_MSGBLK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGBLK MODIFY (MSGBLK CONSTRAINT CC_SWMSGBLK_MSGBLK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGBLK_MSGBLKNM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGBLK MODIFY (MSGBLKNM CONSTRAINT CC_SWMSGBLK_MSGBLKNM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWMSGBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGBLK ADD CONSTRAINT PK_SWMSGBLK PRIMARY KEY (MSGBLK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMSGBLK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMSGBLK ON BARS.SW_MSGBLK (MSGBLK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MSGBLK ***
grant SELECT                                                                 on SW_MSGBLK       to BARSREADER_ROLE;
grant SELECT                                                                 on SW_MSGBLK       to BARS_DM;
grant SELECT                                                                 on SW_MSGBLK       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MSGBLK       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MSGBLK.sql =========*** End *** ===
PROMPT ===================================================================================== 
