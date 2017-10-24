

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS 
   (	NBS CHAR(4), 
	XAR NUMBER(2,0), 
	PAP NUMBER(1,0), 
	NAME VARCHAR2(175), 
	CLASS NUMBER(2,0), 
	CHKNBS NUMBER(1,0), 
	AUTO_STOP NUMBER(1,0), 
	D_CLOSE DATE, 
	SB CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS ***
 exec bpa.alter_policies('PS');


COMMENT ON TABLE BARS.PS IS '���� ������';
COMMENT ON COLUMN BARS.PS.NBS IS '���������� ����';
COMMENT ON COLUMN BARS.PS.XAR IS '��� ��������������';
COMMENT ON COLUMN BARS.PS.PAP IS '������� ������/�������';
COMMENT ON COLUMN BARS.PS.NAME IS '������������ ��� �����';
COMMENT ON COLUMN BARS.PS.CLASS IS '����� �� ��� ������-������
0 - ���������� �����
1 - ���������
2 - �������';
COMMENT ON COLUMN BARS.PS.CHKNBS IS '���� ����������:
1- �������� ��� ������������� �����
2- �������� ��� ���';
COMMENT ON COLUMN BARS.PS.AUTO_STOP IS '���� ������������';
COMMENT ON COLUMN BARS.PS.D_CLOSE IS '���� ��������';
COMMENT ON COLUMN BARS.PS.SB IS '';




PROMPT *** Create  constraint XFK_PSSB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT XFK_PSSB FOREIGN KEY (SB)
	  REFERENCES BARS.PS_SBFLAGS (SBFLAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PS_XAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT FK_PS_XAR FOREIGN KEY (XAR)
	  REFERENCES BARS.XAR (XAR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PS_CHKNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT FK_PS_CHKNBS FOREIGN KEY (CHKNBS)
	  REFERENCES BARS.CHKNBS (CHKNBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PS_PAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT FK_PS_PAP FOREIGN KEY (PAP)
	  REFERENCES BARS.PAP (PAP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_DCLOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT CC_PS_DCLOSE CHECK (d_close = trunc(d_close)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_AUTOSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT CC_PS_AUTOSTOP CHECK (auto_stop in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT PK_PS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_CLASS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (CLASS CONSTRAINT CC_PS_CLASS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (NAME CONSTRAINT CC_PS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_PAP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (PAP CONSTRAINT CC_PS_PAP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (NBS CONSTRAINT CC_PS_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PS ON BARS.PS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PS              to ABS_ADMIN;
grant SELECT                                                                 on PS              to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on PS              to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PS              to BARS_SUP;
grant SELECT                                                                 on PS              to CUST001;
grant SELECT                                                                 on PS              to DPT_ADMIN;
grant SELECT                                                                 on PS              to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS              to START1;
grant SELECT                                                                 on PS              to TECH005;
grant SELECT                                                                 on PS              to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS              to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PS              to WR_REFREAD;
grant SELECT                                                                 on PS              to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS.sql =========*** End *** ==========
PROMPT ===================================================================================== 
