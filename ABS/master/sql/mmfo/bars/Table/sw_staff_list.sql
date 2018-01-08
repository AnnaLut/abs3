

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_STAFF_LIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_STAFF_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_STAFF_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_STAFF_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_STAFF_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_STAFF_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_STAFF_LIST 
   (	ID NUMBER(38,0), 
	IO CHAR(1), 
	 CONSTRAINT PK_SWSTAFFLIST PRIMARY KEY (ID, IO) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_STAFF_LIST ***
 exec bpa.alter_policies('SW_STAFF_LIST');


COMMENT ON TABLE BARS.SW_STAFF_LIST IS 'SWT. Пользователи, допущенные к разбору сообщений';
COMMENT ON COLUMN BARS.SW_STAFF_LIST.ID IS 'Код пользователя комплекса';
COMMENT ON COLUMN BARS.SW_STAFF_LIST.IO IS 'Тип сообщений Входящие/Исходящие';




PROMPT *** Create  constraint FK_SWSTAFFLIST_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STAFF_LIST ADD CONSTRAINT FK_SWSTAFFLIST_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTAFFLIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STAFF_LIST MODIFY (ID CONSTRAINT CC_SWSTAFFLIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTAFFLIST_IO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STAFF_LIST MODIFY (IO CONSTRAINT CC_SWSTAFFLIST_IO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWSTAFFLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STAFF_LIST ADD CONSTRAINT PK_SWSTAFFLIST PRIMARY KEY (ID, IO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTAFFLIST_IO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STAFF_LIST ADD CONSTRAINT CC_SWSTAFFLIST_IO CHECK (io in (''I'', ''O'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWSTAFFLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWSTAFFLIST ON BARS.SW_STAFF_LIST (ID, IO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_STAFF_LIST ***
grant DELETE,INSERT,SELECT                                                   on SW_STAFF_LIST   to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_STAFF_LIST   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_STAFF_LIST   to SWIFT001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_STAFF_LIST   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_STAFF_LIST   to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_STAFF_LIST ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_STAFF_LIST FOR BARS.SW_STAFF_LIST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_STAFF_LIST.sql =========*** End ***
PROMPT ===================================================================================== 
