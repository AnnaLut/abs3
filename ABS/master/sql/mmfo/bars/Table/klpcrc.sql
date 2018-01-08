

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLPCRC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLPCRC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLPCRC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLPCRC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLPCRC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLPCRC ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLPCRC 
   (	SAB VARCHAR2(6), 
	TIP CHAR(1), 
	DFI DATE DEFAULT SYSDATE, 
	CRC NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLPCRC ***
 exec bpa.alter_policies('KLPCRC');


COMMENT ON TABLE BARS.KLPCRC IS '';
COMMENT ON COLUMN BARS.KLPCRC.SAB IS 'Электронный адрес клиента';
COMMENT ON COLUMN BARS.KLPCRC.TIP IS 'Тип файла';
COMMENT ON COLUMN BARS.KLPCRC.DFI IS 'Дата формирования';
COMMENT ON COLUMN BARS.KLPCRC.CRC IS 'контрольная сумма';
COMMENT ON COLUMN BARS.KLPCRC.KF IS '';




PROMPT *** Create  constraint CC_KLPCRC_SAB_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPCRC ADD CONSTRAINT CC_KLPCRC_SAB_CC CHECK (length(sab)=4) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KLPCRC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPCRC ADD CONSTRAINT PK_KLPCRC PRIMARY KEY (KF, SAB, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPCRC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPCRC ADD CONSTRAINT FK_KLPCRC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006482 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPCRC MODIFY (SAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006483 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPCRC MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPCRC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPCRC MODIFY (KF CONSTRAINT CC_KLPCRC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPCRC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPCRC ON BARS.KLPCRC (KF, SAB, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLPCRC ***
grant INSERT,SELECT,UPDATE                                                   on KLPCRC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLPCRC          to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on KLPCRC          to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPCRC          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLPCRC ***

  CREATE OR REPLACE PUBLIC SYNONYM KLPCRC FOR BARS.KLPCRC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLPCRC.sql =========*** End *** ======
PROMPT ===================================================================================== 
