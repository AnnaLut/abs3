

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_TT_IMPORT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_TT_IMPORT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_TT_IMPORT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_TT_IMPORT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_TT_IMPORT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_TT_IMPORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_TT_IMPORT 
   (	TT CHAR(3), 
	IO_IND CHAR(1), 
	ORD NUMBER(10,0), 
	 CONSTRAINT PK_SWTTIMPORT PRIMARY KEY (TT, IO_IND) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_TT_IMPORT ***
 exec bpa.alter_policies('SW_TT_IMPORT');


COMMENT ON TABLE BARS.SW_TT_IMPORT IS 'SWT. Типы операций для обработки сообщений';
COMMENT ON COLUMN BARS.SW_TT_IMPORT.TT IS 'Код типа операции';
COMMENT ON COLUMN BARS.SW_TT_IMPORT.IO_IND IS 'Тип сообщения Входящее/Исходящее';
COMMENT ON COLUMN BARS.SW_TT_IMPORT.ORD IS 'Сортировка операций';




PROMPT *** Create  constraint CC_SWTTIMPORT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_IMPORT MODIFY (TT CONSTRAINT CC_SWTTIMPORT_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWTTIMPORT_IOIND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_IMPORT MODIFY (IO_IND CONSTRAINT CC_SWTTIMPORT_IOIND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWTTIMPORT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_IMPORT ADD CONSTRAINT PK_SWTTIMPORT PRIMARY KEY (TT, IO_IND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWTTIMPORT_IOIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_IMPORT ADD CONSTRAINT CC_SWTTIMPORT_IOIND CHECK (io_ind in (''O'', ''I'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWTTIMPORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWTTIMPORT ON BARS.SW_TT_IMPORT (TT, IO_IND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_TT_IMPORT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TT_IMPORT    to BARS013;
grant SELECT                                                                 on SW_TT_IMPORT    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TT_IMPORT    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_TT_IMPORT    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_TT_IMPORT ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_TT_IMPORT FOR BARS.SW_TT_IMPORT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_TT_IMPORT.sql =========*** End *** 
PROMPT ===================================================================================== 
