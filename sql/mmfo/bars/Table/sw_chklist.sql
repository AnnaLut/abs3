

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_CHKLIST.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_CHKLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_CHKLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_CHKLIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_CHKLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_CHKLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_CHKLIST 
   (	IDCHK NUMBER(38,0), 
	 CONSTRAINT PK_SWCHKLIST PRIMARY KEY (IDCHK) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_CHKLIST ***
 exec bpa.alter_policies('SW_CHKLIST');


COMMENT ON TABLE BARS.SW_CHKLIST IS 'Группы визирования для сообщений';
COMMENT ON COLUMN BARS.SW_CHKLIST.IDCHK IS 'Код группы визирования';




PROMPT *** Create  constraint CC_SWCHKLIST_IDCHK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_CHKLIST MODIFY (IDCHK CONSTRAINT CC_SWCHKLIST_IDCHK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWCHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_CHKLIST ADD CONSTRAINT PK_SWCHKLIST PRIMARY KEY (IDCHK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWCHKLIST_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_CHKLIST ADD CONSTRAINT FK_SWCHKLIST_CHKLIST FOREIGN KEY (IDCHK)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWCHKLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWCHKLIST ON BARS.SW_CHKLIST (IDCHK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_CHKLIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_CHKLIST      to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_CHKLIST      to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_CHKLIST      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_CHKLIST      to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_CHKLIST ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_CHKLIST FOR BARS.SW_CHKLIST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_CHKLIST.sql =========*** End *** ==
PROMPT ===================================================================================== 
