

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_FLD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_FLD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_FLD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_FLD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_FLD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_FLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_FLD 
   (	TAG CHAR(2), 
	TEMPL VARCHAR2(35), 
	ACC_ID VARCHAR2(15), 
	I_FLAG CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_FLD ***
 exec bpa.alter_policies('SW_FLD');


COMMENT ON TABLE BARS.SW_FLD IS 'SWT. Шаблоны полей';
COMMENT ON COLUMN BARS.SW_FLD.TAG IS 'Код поля';
COMMENT ON COLUMN BARS.SW_FLD.TEMPL IS 'Код шаблона';
COMMENT ON COLUMN BARS.SW_FLD.ACC_ID IS 'Код счета';
COMMENT ON COLUMN BARS.SW_FLD.I_FLAG IS 'Признак обработки';




PROMPT *** Create  constraint CC_SWFLD_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_FLD MODIFY (TAG CONSTRAINT CC_SWFLD_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWFLD_TEMPL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_FLD MODIFY (TEMPL CONSTRAINT CC_SWFLD_TEMPL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWFLD_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_FLD MODIFY (ACC_ID CONSTRAINT CC_SWFLD_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWFLD_IFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_FLD MODIFY (I_FLAG CONSTRAINT CC_SWFLD_IFLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWFLD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_FLD ADD CONSTRAINT PK_SWFLD PRIMARY KEY (TAG, TEMPL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWFLD_IFLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_FLD ADD CONSTRAINT CC_SWFLD_IFLAG CHECK (i_flag in (''t'', ''f'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWFLD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWFLD ON BARS.SW_FLD (TAG, TEMPL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_FLD ***
grant SELECT                                                                 on SW_FLD          to BARS013;
grant SELECT                                                                 on SW_FLD          to BARSREADER_ROLE;
grant SELECT                                                                 on SW_FLD          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_FLD          to BARS_DM;
grant SELECT                                                                 on SW_FLD          to SWTOSS;
grant SELECT                                                                 on SW_FLD          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_FLD          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_FLD ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_FLD FOR BARS.SW_FLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_FLD.sql =========*** End *** ======
PROMPT ===================================================================================== 
