

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_TT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_TT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_TT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_TT 
   (	SWTT CHAR(3), 
	TTNAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_TT ***
 exec bpa.alter_policies('SW_TT');


COMMENT ON TABLE BARS.SW_TT IS 'SWT. Типы транзакций';
COMMENT ON COLUMN BARS.SW_TT.SWTT IS 'Код типа транзакции';
COMMENT ON COLUMN BARS.SW_TT.TTNAME IS 'Наименование типа транзакции';




PROMPT *** Create  constraint PK_SWTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT ADD CONSTRAINT PK_SWTT PRIMARY KEY (SWTT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWTT_SWTT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT MODIFY (SWTT CONSTRAINT CC_SWTT_SWTT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWTT_TTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT MODIFY (TTNAME CONSTRAINT CC_SWTT_TTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWTT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWTT ON BARS.SW_TT (SWTT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_TT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TT           to BARS013;
grant SELECT                                                                 on SW_TT           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_TT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_TT           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TT           to SW_TT;
grant SELECT                                                                 on SW_TT           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_TT           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_TT           to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_TT ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_TT FOR BARS.SW_TT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_TT.sql =========*** End *** =======
PROMPT ===================================================================================== 
