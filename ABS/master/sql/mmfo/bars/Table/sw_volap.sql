

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_VOLAP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_VOLAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_VOLAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_VOLAP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_VOLAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_VOLAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_VOLAP 
   (	RU_CHAR CHAR(1), 
	SW_CHAR CHAR(3), 
	CHRSET VARCHAR2(5), 
	 CONSTRAINT PK_SWVOLAP PRIMARY KEY (CHRSET, RU_CHAR, SW_CHAR) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_VOLAP ***
 exec bpa.alter_policies('SW_VOLAP');


COMMENT ON TABLE BARS.SW_VOLAP IS 'SWT. Таблицы перекодировки';
COMMENT ON COLUMN BARS.SW_VOLAP.RU_CHAR IS 'Недопустимый символ';
COMMENT ON COLUMN BARS.SW_VOLAP.SW_CHAR IS 'Символ(ы) SWIFT';
COMMENT ON COLUMN BARS.SW_VOLAP.CHRSET IS 'Код таблицы перекодировки';




PROMPT *** Create  constraint CC_SWVOLAP_RUCHAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VOLAP MODIFY (RU_CHAR CONSTRAINT CC_SWVOLAP_RUCHAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWVOLAP_SWCHAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VOLAP MODIFY (SW_CHAR CONSTRAINT CC_SWVOLAP_SWCHAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWVOLAP_CHRSET_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VOLAP MODIFY (CHRSET CONSTRAINT CC_SWVOLAP_CHRSET_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWVOLAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VOLAP ADD CONSTRAINT PK_SWVOLAP PRIMARY KEY (CHRSET, RU_CHAR, SW_CHAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWVOLAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWVOLAP ON BARS.SW_VOLAP (CHRSET, RU_CHAR, SW_CHAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_VOLAP ***
grant SELECT                                                                 on SW_VOLAP        to BARS013;
grant SELECT                                                                 on SW_VOLAP        to BARSREADER_ROLE;
grant SELECT                                                                 on SW_VOLAP        to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_VOLAP        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_VOLAP ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_VOLAP FOR BARS.SW_VOLAP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_VOLAP.sql =========*** End *** ====
PROMPT ===================================================================================== 
