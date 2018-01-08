

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_OPT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_OPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_OPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_OPT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_OPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_OPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_OPT 
   (	OPT CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_OPT ***
 exec bpa.alter_policies('SW_OPT');


COMMENT ON TABLE BARS.SW_OPT IS 'SWT. Допустимые опции полей сообщений';
COMMENT ON COLUMN BARS.SW_OPT.OPT IS 'Код опции';




PROMPT *** Create  constraint CC_SWOPT_OPT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPT MODIFY (OPT CONSTRAINT CC_SWOPT_OPT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPT ADD CONSTRAINT PK_SWOPT PRIMARY KEY (OPT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWOPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWOPT ON BARS.SW_OPT (OPT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_OPT ***
grant SELECT                                                                 on SW_OPT          to BARS013;
grant SELECT                                                                 on SW_OPT          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_OPT          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_OPT          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_OPT          to SWIFT001;
grant SELECT                                                                 on SW_OPT          to SWTOSS;
grant SELECT                                                                 on SW_OPT          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_OPT          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_OPT          to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_OPT ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_OPT FOR BARS.SW_OPT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_OPT.sql =========*** End *** ======
PROMPT ===================================================================================== 
