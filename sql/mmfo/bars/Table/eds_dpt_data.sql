

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_DPT_DATA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_DPT_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_DPT_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DPT_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DPT_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_DPT_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_DPT_DATA 
   (    REQ_ID VARCHAR2(36), 
    RNK NUMBER, 
    ACC NUMBER(38,0), 
    NLS VARCHAR2(20), 
    KV NUMBER(3,0), 
    OPEN_IN VARCHAR2(100), 
    END_BAL NUMBER(10,0), 
    SUM_PROC NUMBER(10,0), 
    SUM_PDFO NUMBER(10,0), 
    SUM_MIL NUMBER(10,0), 
    SUM_TOTALY NUMBER(10,0), 
    KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_DPT_DATA ***
 exec bpa.alter_policies('EDS_DPT_DATA');


COMMENT ON TABLE BARS.EDS_DPT_DATA IS '��� �-���������� �� ���������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.REQ_ID IS '�� ������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.RNK IS '�� �볺���';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.ACC IS '�� �������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.NLS IS '����� �������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.KV IS '��� ������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.OPEN_IN IS '����� �������� ';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.END_BAL IS '������ �� �������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.SUM_PROC IS '���� �������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.SUM_PDFO IS '���� ����';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.SUM_MIL IS '���� ���������� �����';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.SUM_TOTALY IS '���� ������';
COMMENT ON COLUMN BARS.EDS_DPT_DATA.KF IS '';




PROMPT *** Create  index PK_EDS_DPT_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_DPT_DATA ON BARS.EDS_DPT_DATA (REQ_ID, ACC, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_EDS_DECL ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_DPT_DATA ADD CONSTRAINT PK_EDS_DPT_DATA PRIMARY KEY (REQ_ID, ACC, KF)
  USING INDEX PK_EDS_DPT_DATA ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
execute immediate'alter table eds_dpt_data add tip CHAR(3)';
exception when others then if sqlcode=-1430 then null;else raise; end if; 
end;
/

PROMPT *** Create  grants  EDS_DPT_DATA ***
grant SELECT                                                                 on EDS_DPT_DATA    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_DPT_DATA.sql =========*** End *** 
PROMPT ===================================================================================== 

