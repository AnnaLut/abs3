

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_DATA_DOC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_DATA_DOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_DATA_DOC'', ''CENTER'' , null, null, ''E'', null);
               bpa.alter_policy_info(''OB_CORP_DATA_DOC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OB_CORP_DATA_DOC'', ''WHOLE'' , null, null, ''E'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_DATA_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_DATA_DOC
   (SESS_ID NUMBER,
    ACC NUMBER, 
    KF VARCHAR2(6), 
    REF NUMBER, 
    STMT NUMBER, 
    DK NUMBER, 
    POSTDAT DATE, 
    DOCDAT DATE, 
    VALDAT DATE, 
    ND VARCHAR2(10), 
    VOB NUMBER, 
    MFOA VARCHAR2(6), 
    NLSA VARCHAR2(14), 
    KVA NUMBER, 
    NAMA VARCHAR2(70), 
    OKPOA VARCHAR2(14), 
    MFOB VARCHAR2(6), 
    NLSB VARCHAR2(14), 
    KVB NUMBER, 
    NAMB VARCHAR2(70), 
    OKPOB VARCHAR2(14), 
    S NUMBER, 
    DOCKV NUMBER, 
    SQ NUMBER, 
    NAZN VARCHAR2(160), 
    TT VARCHAR2(3),
	NBSA VARCHAR2(4),
	NBSB VARCHAR2(4)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD COMPRESS
  PARTITION BY RANGE (SESS_ID)
  INTERVAL(1000)
 (PARTITION P_SID_0000 VALUES LESS THAN (1000),
  PARTITION P_SID_1000 VALUES LESS THAN (2000),
  PARTITION P_SID_2000 VALUES LESS THAN (3000),
  PARTITION P_SID_3000 VALUES LESS THAN (4000),
  PARTITION P_SID_4000 VALUES LESS THAN (5000),
  PARTITION P_SID_5000 VALUES LESS THAN (6000),
  PARTITION P_SID_6000 VALUES LESS THAN (7000),
  PARTITION P_SID_7000 VALUES LESS THAN (8000),
  PARTITION P_SID_8000 VALUES LESS THAN (9000),
  PARTITION P_SID_9000 VALUES LESS THAN (10000),
  PARTITION P_SID_10000 VALUES LESS THAN (11000),
  PARTITION P_SID_11000 VALUES LESS THAN (12000),
  PARTITION P_SID_12000 VALUES LESS THAN (13000),
  PARTITION P_SID_13000 VALUES LESS THAN (14000),
  PARTITION P_SID_14000 VALUES LESS THAN (15000),
  PARTITION P_SID_15000 VALUES LESS THAN (16000),
  PARTITION P_SID_16000 VALUES LESS THAN (17000),
  PARTITION P_SID_17000 VALUES LESS THAN (18000),
  PARTITION P_SID_18000 VALUES LESS THAN (19000),
  PARTITION P_SID_19000 VALUES LESS THAN (20000),
  PARTITION P_SID_20000 VALUES LESS THAN (21000),
  PARTITION P_SID_21000 VALUES LESS THAN (22000),
  PARTITION P_SID_22000 VALUES LESS THAN (23000),
  PARTITION P_SID_23000 VALUES LESS THAN (24000),
  PARTITION P_SID_24000 VALUES LESS THAN (25000),
  PARTITION P_SID_25000 VALUES LESS THAN (26000),
  PARTITION P_SID_26000 VALUES LESS THAN (27000),
  PARTITION P_SID_27000 VALUES LESS THAN (28000),
  PARTITION P_SID_28000 VALUES LESS THAN (29000),
  PARTITION P_SID_29000 VALUES LESS THAN (30000),
  PARTITION P_SID_30000 VALUES LESS THAN (31000),
  PARTITION P_SID_31000 VALUES LESS THAN (32000),
  PARTITION P_SID_32000 VALUES LESS THAN (33000),
  PARTITION P_SID_33000 VALUES LESS THAN (34000),
  PARTITION P_SID_34000 VALUES LESS THAN (35000),
  PARTITION P_SID_35000 VALUES LESS THAN (36000),
  PARTITION P_SID_36000 VALUES LESS THAN (37000),
  PARTITION P_SID_37000 VALUES LESS THAN (38000),
  PARTITION P_SID_38000 VALUES LESS THAN (39000),
  PARTITION P_SID_39000 VALUES LESS THAN (40000),
  PARTITION P_SID_40000 VALUES LESS THAN (41000),
  PARTITION P_SID_41000 VALUES LESS THAN (42000),
  PARTITION P_SID_42000 VALUES LESS THAN (43000),
  PARTITION P_SID_43000 VALUES LESS THAN (44000))';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'alter table OB_CORP_DATA_DOC add nbsa varchar2(4)';                          
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin  
    execute immediate 'alter table OB_CORP_DATA_DOC add nbsb varchar2(4)';                          
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/




PROMPT *** ALTER_POLICIES to OB_CORP_DATA_DOC ***
 exec bpa.alter_policies('OB_CORP_DATA_DOC');


COMMENT ON TABLE BARS.OB_CORP_DATA_DOC IS '���� �-����� � ����� ���������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.SESS_ID IS '������������� ��� ������������ ����� � ��';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.ACC IS '�� �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.KF IS '��� �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.REF IS '��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.STMT IS '������������� ����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.DK IS '�����/������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.POSTDAT IS '���� ���������� � ��� (���� ���� �� ������� ��� ������� �� �������)';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.DOCDAT IS '���� ���������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.VALDAT IS '���� �����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.ND IS '����� ���������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.MFOA IS '��� ����� ��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.NLSA IS '�������� ������� ��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.KVA IS '������ ��������� ������� ��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.NAMA IS '������������ �볺��� ��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.OKPOA IS '������������� �볺��� ��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.MFOB IS '��� ����� ����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.NLSB IS '�������� ������� ����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.KVB IS '������ ��������� ������� ����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.NAMB IS '������������ �볺��� ����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.OKPOB IS '������������� �볺��� ����������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.S IS '���� ������� � �����';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.DOCKV IS '������ �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.SQ IS '���� ������� (��������� � ������������ �����)';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.TT IS '��� ��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.NBSA IS '���������� ������� ��������';
COMMENT ON COLUMN BARS.OB_CORP_DATA_DOC.NBSB IS '���������� ������� ����������';


PROMPT *** Create  index PK_OB_CORP_DATA_DOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORP_DATA_DOC ON BARS.OB_CORP_DATA_DOC (SESS_ID, ACC, REF, STMT, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI LOCAL';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint PK_OB_CORP_DATA_DOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_DATA_DOC ADD CONSTRAINT PK_OB_CORP_DATA_DOC PRIMARY KEY (SESS_ID, ACC, REF, STMT, DK) using index PK_OB_CORP_DATA_DOC ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/







PROMPT *** Create  grants  OB_CORP_DATA_DOC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OB_CORP_DATA_DOC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_DATA_DOC.sql =========*** End 
PROMPT ===================================================================================== 

