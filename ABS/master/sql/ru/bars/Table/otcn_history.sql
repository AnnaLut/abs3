

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_HISTORY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_HISTORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_HISTORY 
   (	KODF VARCHAR2(2), 
	DATF DATE, 
	RECID NUMBER, 
	USERID NUMBER, 
	NLS VARCHAR2(16), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(20), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	MDATE DATE, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_HISTORY ***
 exec bpa.alter_policies('OTCN_HISTORY');


COMMENT ON TABLE BARS.OTCN_HISTORY IS '';
COMMENT ON COLUMN BARS.OTCN_HISTORY.KODF IS '��� �����';
COMMENT ON COLUMN BARS.OTCN_HISTORY.DATF IS '���� ������������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.RECID IS 'ID';
COMMENT ON COLUMN BARS.OTCN_HISTORY.USERID IS '��� ������������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.NLS IS '����';
COMMENT ON COLUMN BARS.OTCN_HISTORY.KV IS '������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.ODATE IS '���� ������������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.KODP IS '��� ����������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.ZNAP IS '�������� ����������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.NBUC IS '��� ������� (���)';
COMMENT ON COLUMN BARS.OTCN_HISTORY.ISP IS '��� �����������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.RNK IS '���. ����� �����������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.ACC IS '������������� �����';
COMMENT ON COLUMN BARS.OTCN_HISTORY.MDATE IS '���� ��������� ������� �� �����';
COMMENT ON COLUMN BARS.OTCN_HISTORY.REF IS '����� ���������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.COMM IS '�����������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.ND IS '����� ��������';
COMMENT ON COLUMN BARS.OTCN_HISTORY.BRANCH IS '';




PROMPT *** Create  constraint FK_OTCN_HISTORY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_HISTORY ADD CONSTRAINT FK_OTCN_HISTORY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010756 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_HISTORY ADD PRIMARY KEY (RECID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNHISTORY_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_HISTORY MODIFY (BRANCH CONSTRAINT CC_OTCNHISTORY_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0010756 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0010756 ON BARS.OTCN_HISTORY (RECID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_HISTORY ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_HISTORY    to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_HISTORY    to RPBN002;
grant SELECT                                                                 on OTCN_HISTORY    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_HISTORY    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to OTCN_HISTORY ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_HISTORY FOR BARS.OTCN_HISTORY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_HISTORY.sql =========*** End *** 
PROMPT ===================================================================================== 
