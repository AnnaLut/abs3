

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_TAG.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_TAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_TAG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_TAG 
   (	TAG CHAR(2), 
	DESCRIPTION VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_TAG ***
 exec bpa.alter_policies('SW_TAG');


COMMENT ON TABLE BARS.SW_TAG IS 'SWT. Допустимые поля сообщений';
COMMENT ON COLUMN BARS.SW_TAG.TAG IS 'Код поля';
COMMENT ON COLUMN BARS.SW_TAG.DESCRIPTION IS 'Комментарий';




PROMPT *** Create  constraint CC_SWTAG_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TAG MODIFY (TAG CONSTRAINT CC_SWTAG_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TAG ADD CONSTRAINT PK_SWTAG PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWTAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWTAG ON BARS.SW_TAG (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_TAG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TAG          to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_TAG          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_TAG          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TAG          to SWIFT001;
grant INSERT                                                                 on SW_TAG          to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_TAG          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_TAG          to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_TAG ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_TAG FOR BARS.SW_TAG;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_TAG.sql =========*** End *** ======
PROMPT ===================================================================================== 
