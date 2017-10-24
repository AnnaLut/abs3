

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_TRACE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_TRACE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.RNBU_TRACE 
   (	RECID NUMBER, 
	USERID NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(30), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	MDATE DATE, 
	TOBO VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_TRACE ***
 exec bpa.alter_policies('RNBU_TRACE');


COMMENT ON TABLE BARS.RNBU_TRACE IS '�������� ������������ ����������� ������ ����������';
COMMENT ON COLUMN BARS.RNBU_TRACE.RECID IS 'ID';
COMMENT ON COLUMN BARS.RNBU_TRACE.USERID IS '��� ������������';
COMMENT ON COLUMN BARS.RNBU_TRACE.NLS IS '����';
COMMENT ON COLUMN BARS.RNBU_TRACE.KV IS '������';
COMMENT ON COLUMN BARS.RNBU_TRACE.ODATE IS '���� ������������';
COMMENT ON COLUMN BARS.RNBU_TRACE.KODP IS '��� ����������';
COMMENT ON COLUMN BARS.RNBU_TRACE.ZNAP IS '�������� ����������';
COMMENT ON COLUMN BARS.RNBU_TRACE.NBUC IS '��� ������� (���)';
COMMENT ON COLUMN BARS.RNBU_TRACE.ISP IS '��� �����������';
COMMENT ON COLUMN BARS.RNBU_TRACE.RNK IS '���. ����� �����������';
COMMENT ON COLUMN BARS.RNBU_TRACE.ACC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE.REF IS '����� ���������';
COMMENT ON COLUMN BARS.RNBU_TRACE.COMM IS '�����������';
COMMENT ON COLUMN BARS.RNBU_TRACE.ND IS '����� ��������';
COMMENT ON COLUMN BARS.RNBU_TRACE.MDATE IS '���� �������';
COMMENT ON COLUMN BARS.RNBU_TRACE.TOBO IS '';




PROMPT *** Create  index IRNBU_TRACE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IRNBU_TRACE ON BARS.RNBU_TRACE (ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_RNBU_TRACE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_RNBU_TRACE ON BARS.RNBU_TRACE (NLS, KV) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_RNBU_TRACE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_RNBU_TRACE ON BARS.RNBU_TRACE (KODP) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_RNBU_TRACE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_RNBU_TRACE ON BARS.RNBU_TRACE (REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNBU_TRACE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_TRACE      to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE      to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_TRACE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE.sql =========*** End *** ==
PROMPT ===================================================================================== 
