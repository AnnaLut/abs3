

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_IORULE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_IORULE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_IORULE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_IORULE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_IORULE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_IORULE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_IORULE 
   (	MT NUMBER(38,0), 
	IO_IND CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_IORULE ***
 exec bpa.alter_policies('SW_IORULE');


COMMENT ON TABLE BARS.SW_IORULE IS 'SWT. Допустимые типы сообщений для импорта';
COMMENT ON COLUMN BARS.SW_IORULE.MT IS 'Код типа сообщения';
COMMENT ON COLUMN BARS.SW_IORULE.IO_IND IS 'Код направления';




PROMPT *** Create  constraint CC_SWIORULE_IOIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_IORULE ADD CONSTRAINT CC_SWIORULE_IOIND CHECK (io_ind in (''O'', ''I'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWIORULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_IORULE ADD CONSTRAINT PK_SWIORULE PRIMARY KEY (MT, IO_IND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWIORULE_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_IORULE ADD CONSTRAINT FK_SWIORULE_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIORULE_MT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_IORULE MODIFY (MT CONSTRAINT CC_SWIORULE_MT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIORULE_IOIND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_IORULE MODIFY (IO_IND CONSTRAINT CC_SWIORULE_IOIND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWIORULE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWIORULE ON BARS.SW_IORULE (MT, IO_IND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_IORULE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_IORULE       to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_IORULE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_IORULE       to BARS_DM;
grant SELECT                                                                 on SW_IORULE       to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_IORULE       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_IORULE       to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_IORULE ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_IORULE FOR BARS.SW_IORULE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_IORULE.sql =========*** End *** ===
PROMPT ===================================================================================== 
