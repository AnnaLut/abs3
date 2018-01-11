

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_MT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_MT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MT 
   (	MT NUMBER(38,0), 
	NAME VARCHAR2(50), 
	FLAG CHAR(10) DEFAULT ''0000000000'', 
	CHKGRP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MT ***
 exec bpa.alter_policies('SW_MT');


COMMENT ON TABLE BARS.SW_MT IS 'SWT. Типы сообщений';
COMMENT ON COLUMN BARS.SW_MT.MT IS 'Код типа сообщения';
COMMENT ON COLUMN BARS.SW_MT.NAME IS 'Наименование типа сообщения';
COMMENT ON COLUMN BARS.SW_MT.FLAG IS 'Флаги сообщения';
COMMENT ON COLUMN BARS.SW_MT.CHKGRP IS '';




PROMPT *** Create  constraint PK_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MT ADD CONSTRAINT PK_SWMT PRIMARY KEY (MT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMT_MT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MT ADD CONSTRAINT CC_SWMT_MT CHECK (mt>0 and mt<999) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMT_MT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MT MODIFY (MT CONSTRAINT CC_SWMT_MT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMT_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MT MODIFY (NAME CONSTRAINT CC_SWMT_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMT_FLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MT MODIFY (FLAG CONSTRAINT CC_SWMT_FLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMT ON BARS.SW_MT (MT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MT ***
grant SELECT                                                                 on SW_MT           to BARS013;
grant SELECT                                                                 on SW_MT           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_MT           to BARS_DM;
grant SELECT                                                                 on SW_MT           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_MT           to SWIFT001;
grant SELECT                                                                 on SW_MT           to SWTOSS;
grant SELECT                                                                 on SW_MT           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MT           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_MT           to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_MT ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_MT FOR BARS.SW_MT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MT.sql =========*** End *** =======
PROMPT ===================================================================================== 
