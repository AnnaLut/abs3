

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_TMP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDGRAPH_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDGRAPH_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDGRAPH_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIM_CREDGRAPH_TMP 
   (	DAT DATE, 
	PSNT NUMBER, 
	RSNT NUMBER, 
	PSPT NUMBER, 
	RSPT NUMBER, 
	PSK NUMBER, 
	RSK NUMBER, 
	PSPE NUMBER, 
	RSPE NUMBER, 
	PZT NUMBER, 
	ZT NUMBER, 
	DT NUMBER, 
	SMP NUMBER, 
	SMPS NUMBER, 
	SP NUMBER, 
	SVP NUMBER, 
	ZP NUMBER, 
	DP NUMBER, 
	SD NUMBER, 
	ZPNBU NUMBER, 
	BT NUMBER, 
	XSP NUMBER, 
	XPSPT NUMBER, 
	I_RP NUMBER, 
	I_VP NUMBER, 
	KP NUMBER, 
	PERCENT NUMBER, 
	PERCENT_NBU NUMBER, 
	PERCENT_BASE NUMBER, 
	DY NUMBER, 
	Z NUMBER, 
	T_DELAY NUMBER, 
	P_DELAY NUMBER, 
	GET_DAY NUMBER, 
	PAY_DAY NUMBER, 
	ADAPTIVE NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDGRAPH_TMP ***
 exec bpa.alter_policies('CIM_CREDGRAPH_TMP');


COMMENT ON TABLE BARS.CIM_CREDGRAPH_TMP IS '������ ���������� ���������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DAT IS '����';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSNT IS '������� ���� ���������� �� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSNT IS '������� ���� ���������� �� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSPT IS '������� ���� ��������� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSPT IS '������� ���� ��������� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSK IS '������� ���� ����';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSK IS '������� ���� ����';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PSPE IS '������� ���� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.RSPE IS '������� ���� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PZT IS '������� ������������� �� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ZT IS '������������� �� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DT IS '����������� ������������� �� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SMP IS '��������� �������� �� �������� �������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SMPS IS '���� ����������� ��������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SP IS '���� ����������� �������� �� �������� ����� �� �������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SVP IS '���� ���������� ��������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ZP IS '������������� �� ���������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DP IS '����������� ������������� �� %';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.SD IS '���� ���������� �������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ZPNBU IS '���� ����������� �������� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.BT IS 'C��� ������������ ��������� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.XSP IS '���� ����������� �������� �� �������� ����� �� ������� ��� ���������� �������� ����������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.XPSPT IS '������� ���� ��������� ��� ��� ���������� �������� ����������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.I_RP IS '�������� �����';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.I_VP IS '������� ��������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.KP IS 'ʳ������ ������ �� ���� ��������� �������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PERCENT IS '��������� ������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PERCENT_NBU IS '��������� ������ ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PERCENT_BASE IS '���� ����������� ��������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.DY IS 'ʳ������ ��� � ����';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.Z IS '������� �� ����� ���������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.T_DELAY IS '�������� ������� ���';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.P_DELAY IS '�������� ������� %';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.GET_DAY IS '���������� ��� ������ �������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.PAY_DAY IS '���������� ��� ��������� �������';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_TMP.ADAPTIVE IS '���������� ������������ ��������� ���';



PROMPT *** Create  grants  CIM_CREDGRAPH_TMP ***
grant SELECT                                                                 on CIM_CREDGRAPH_TMP to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_TMP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_TMP to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_TMP.sql =========*** End
PROMPT ===================================================================================== 
