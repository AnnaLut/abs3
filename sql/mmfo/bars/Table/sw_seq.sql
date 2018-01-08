

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_SEQ.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_SEQ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_SEQ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_SEQ'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_SEQ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_SEQ ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_SEQ 
   (	SEQ CHAR(1) DEFAULT ''A'', 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_SEQ ***
 exec bpa.alter_policies('SW_SEQ');


COMMENT ON TABLE BARS.SW_SEQ IS 'SWT. Допустимые фрагменты сообщений';
COMMENT ON COLUMN BARS.SW_SEQ.SEQ IS 'Код фрагмента';
COMMENT ON COLUMN BARS.SW_SEQ.NAME IS 'Наименование фрагмента';




PROMPT *** Create  constraint PK_SWSEQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SEQ ADD CONSTRAINT PK_SWSEQ PRIMARY KEY (SEQ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSEQ_SEQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SEQ MODIFY (SEQ CONSTRAINT CC_SWSEQ_SEQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSEQ_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SEQ MODIFY (NAME CONSTRAINT CC_SWSEQ_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWSEQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWSEQ ON BARS.SW_SEQ (SEQ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_SEQ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_SEQ          to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_SEQ          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_SEQ          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_SEQ          to SWIFT001;
grant SELECT                                                                 on SW_SEQ          to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_SEQ          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_SEQ          to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_SEQ ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_SEQ FOR BARS.SW_SEQ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_SEQ.sql =========*** End *** ======
PROMPT ===================================================================================== 
