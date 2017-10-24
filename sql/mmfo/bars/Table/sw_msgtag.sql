

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MSGTAG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MSGTAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MSGTAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_MSGTAG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_MSGTAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MSGTAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MSGTAG 
   (	MSGBLK VARCHAR2(1), 
	MSGTAG VARCHAR2(3), 
	MSGTAGNM VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MSGTAG ***
 exec bpa.alter_policies('SW_MSGTAG');


COMMENT ON TABLE BARS.SW_MSGTAG IS 'SWT. Поля сообщения';
COMMENT ON COLUMN BARS.SW_MSGTAG.MSGBLK IS '';
COMMENT ON COLUMN BARS.SW_MSGTAG.MSGTAG IS 'Код поля сообщения';
COMMENT ON COLUMN BARS.SW_MSGTAG.MSGTAGNM IS 'Наименование поля';




PROMPT *** Create  constraint PK_SWMSGTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGTAG ADD CONSTRAINT PK_SWMSGTAG PRIMARY KEY (MSGBLK, MSGTAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMSGTAG_SWMSGBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGTAG ADD CONSTRAINT FK_SWMSGTAG_SWMSGBLK FOREIGN KEY (MSGBLK)
	  REFERENCES BARS.SW_MSGBLK (MSGBLK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGTAG_MSGBLK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGTAG MODIFY (MSGBLK CONSTRAINT CC_SWMSGTAG_MSGBLK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGTAG_MSGTAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGTAG MODIFY (MSGTAG CONSTRAINT CC_SWMSGTAG_MSGTAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMSGTAG_MSGTAGNM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MSGTAG MODIFY (MSGTAGNM CONSTRAINT CC_SWMSGTAG_MSGTAGNM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMSGTAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMSGTAG ON BARS.SW_MSGTAG (MSGBLK, MSGTAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MSGTAG ***
grant SELECT                                                                 on SW_MSGTAG       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MSGTAG       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MSGTAG.sql =========*** End *** ===
PROMPT ===================================================================================== 
