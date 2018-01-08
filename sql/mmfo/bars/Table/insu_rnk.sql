

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INSU_RNK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INSU_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INSU_RNK'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INSU_RNK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INSU_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INSU_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.INSU_RNK 
   (	RNK NUMBER(*,0), 
	RNKI NUMBER(*,0), 
	VID NUMBER(*,0), 
	DAT DATE, 
	S NUMBER, 
	SP NUMBER, 
	DATS DATE, 
	DOGS VARCHAR2(20), 
	DATP DATE, 
	SF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INSU_RNK ***
 exec bpa.alter_policies('INSU_RNK');


COMMENT ON TABLE BARS.INSU_RNK IS 'Клиенты-Заемщики и их Страховка';
COMMENT ON COLUMN BARS.INSU_RNK.RNK IS 'РНК Заемщика';
COMMENT ON COLUMN BARS.INSU_RNK.RNKI IS 'РНК страховой компании';
COMMENT ON COLUMN BARS.INSU_RNK.VID IS 'Код вида страховки';
COMMENT ON COLUMN BARS.INSU_RNK.DAT IS 'Дата действия';
COMMENT ON COLUMN BARS.INSU_RNK.S IS 'Сумма страховки';
COMMENT ON COLUMN BARS.INSU_RNK.SP IS 'План-Сумма страх.взносов';
COMMENT ON COLUMN BARS.INSU_RNK.DATS IS 'Дата заключения дог.страх';
COMMENT ON COLUMN BARS.INSU_RNK.DOGS IS 'Номер дог.страх';
COMMENT ON COLUMN BARS.INSU_RNK.DATP IS 'План-Дата страх.взноса';
COMMENT ON COLUMN BARS.INSU_RNK.SF IS 'Факт-Сумма страх.взносов';
COMMENT ON COLUMN BARS.INSU_RNK.KF IS '';




PROMPT *** Create  constraint XPK_INSU_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT XPK_INSU_RNK PRIMARY KEY (RNK, RNKI, VID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_RNK_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSU_RNK_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_RNK_RNKI ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSU_RNK_RNKI FOREIGN KEY (RNKI)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_RNK_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSU_RNK_VID FOREIGN KEY (VID)
	  REFERENCES BARS.INSU_VID (INSU) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSURNK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSURNK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSURNK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK MODIFY (KF CONSTRAINT CC_INSURNK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_INSU_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_INSU_RNK ON BARS.INSU_RNK (RNK, RNKI, VID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INSU_RNK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INSU_RNK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INSU_RNK        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INSU_RNK        to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INSU_RNK        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to INSU_RNK ***

  CREATE OR REPLACE PUBLIC SYNONYM INSU_RNK FOR BARS.INSU_RNK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INSU_RNK.sql =========*** End *** ====
PROMPT ===================================================================================== 
