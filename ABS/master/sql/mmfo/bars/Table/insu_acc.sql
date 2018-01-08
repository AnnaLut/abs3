

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INSU_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INSU_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INSU_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INSU_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INSU_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INSU_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.INSU_ACC 
   (	ACC NUMBER(*,0), 
	RNKI NUMBER(*,0), 
	VID NUMBER(*,0), 
	DAT DATE, 
	S NUMBER, 
	SP NUMBER, 
	DATS DATE, 
	DOGS VARCHAR2(45), 
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




PROMPT *** ALTER_POLICIES to INSU_ACC ***
 exec bpa.alter_policies('INSU_ACC');


COMMENT ON TABLE BARS.INSU_ACC IS 'Дог.обеспечения и их Страховка';
COMMENT ON COLUMN BARS.INSU_ACC.ACC IS 'АСС счета обеспечения';
COMMENT ON COLUMN BARS.INSU_ACC.RNKI IS 'РНК страховой компании';
COMMENT ON COLUMN BARS.INSU_ACC.VID IS 'Код вида страховки';
COMMENT ON COLUMN BARS.INSU_ACC.DAT IS 'Дата действия';
COMMENT ON COLUMN BARS.INSU_ACC.S IS 'Сумма страховки';
COMMENT ON COLUMN BARS.INSU_ACC.SP IS 'План-Сумма страх.взносов';
COMMENT ON COLUMN BARS.INSU_ACC.DATS IS 'Дата заключения дог.страх';
COMMENT ON COLUMN BARS.INSU_ACC.DOGS IS 'Номер дог.страх';
COMMENT ON COLUMN BARS.INSU_ACC.DATP IS 'План-Дата страх.взноса';
COMMENT ON COLUMN BARS.INSU_ACC.SF IS 'Факт-Сумма страх.взносов';
COMMENT ON COLUMN BARS.INSU_ACC.KF IS '';




PROMPT *** Create  constraint XPK_INSU_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT XPK_INSU_ACC PRIMARY KEY (ACC, RNKI, VID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_ACC_RNKI ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSU_ACC_RNKI FOREIGN KEY (RNKI)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_ACC_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSU_ACC_VID FOREIGN KEY (VID)
	  REFERENCES BARS.INSU_VID (INSU) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSUACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSUACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSUACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSUACC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSUACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC MODIFY (KF CONSTRAINT CC_INSUACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_INSU_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_INSU_ACC ON BARS.INSU_ACC (ACC, RNKI, VID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INSU_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INSU_ACC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INSU_ACC        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INSU_ACC        to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INSU_ACC        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to INSU_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM INSU_ACC FOR BARS.INSU_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INSU_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
