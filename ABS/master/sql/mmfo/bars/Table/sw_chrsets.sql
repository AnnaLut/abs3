

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_CHRSETS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_CHRSETS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_CHRSETS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_CHRSETS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_CHRSETS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_CHRSETS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_CHRSETS 
   (	SETID VARCHAR2(5), 
	SETNAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_CHRSETS ***
 exec bpa.alter_policies('SW_CHRSETS');


COMMENT ON TABLE BARS.SW_CHRSETS IS 'SWT. Таблицы перекодировки';
COMMENT ON COLUMN BARS.SW_CHRSETS.SETID IS 'Код таблицы перекодировки';
COMMENT ON COLUMN BARS.SW_CHRSETS.SETNAME IS 'Наименование таблицы перекодировки';




PROMPT *** Create  constraint CC_SWCHRSETS_SETID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_CHRSETS MODIFY (SETID CONSTRAINT CC_SWCHRSETS_SETID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWCHRSETS_SETNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_CHRSETS MODIFY (SETNAME CONSTRAINT CC_SWCHRSETS_SETNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWCHRSETS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_CHRSETS ADD CONSTRAINT PK_SWCHRSETS PRIMARY KEY (SETID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWCHRSETS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWCHRSETS ON BARS.SW_CHRSETS (SETID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_CHRSETS ***
grant SELECT                                                                 on SW_CHRSETS      to BARS013;
grant SELECT                                                                 on SW_CHRSETS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_CHRSETS      to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_CHRSETS      to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_CHRSETS ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_CHRSETS FOR BARS.SW_CHRSETS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_CHRSETS.sql =========*** End *** ==
PROMPT ===================================================================================== 
