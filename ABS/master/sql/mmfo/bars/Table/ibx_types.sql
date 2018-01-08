

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IBX_TYPES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IBX_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IBX_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.IBX_TYPES 
   (	ID VARCHAR2(256), 
	NAME VARCHAR2(1024), 
	NLS VARCHAR2(15), 
	EXT_OKPO VARCHAR2(14), 
	EXT_NLS VARCHAR2(15), 
	EXT_MFO VARCHAR2(12), 
	EXT_NAZN_MASK VARCHAR2(1024), 
	STAFF_ID NUMBER, 
	PROC_GETINFO VARCHAR2(100), 
	PROC_PAY VARCHAR2(100), 
	ABS_NAZN_MASK VARCHAR2(200)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IBX_TYPES ***
 exec bpa.alter_policies('IBX_TYPES');


COMMENT ON TABLE BARS.IBX_TYPES IS '������� ����� IBOX';
COMMENT ON COLUMN BARS.IBX_TYPES.ID IS '�������������';
COMMENT ON COLUMN BARS.IBX_TYPES.NAME IS '������������';
COMMENT ON COLUMN BARS.IBX_TYPES.NLS IS '����� �������������� �����';
COMMENT ON COLUMN BARS.IBX_TYPES.EXT_OKPO IS '�������� ����������������� ������� - ���';
COMMENT ON COLUMN BARS.IBX_TYPES.EXT_NLS IS '�������� ����������������� ������� - ����� �����';
COMMENT ON COLUMN BARS.IBX_TYPES.EXT_MFO IS '�������� ����������������� ������� - ���';
COMMENT ON COLUMN BARS.IBX_TYPES.EXT_NAZN_MASK IS '�������� ����������������� ������� - ����� ���������� �������';
COMMENT ON COLUMN BARS.IBX_TYPES.STAFF_ID IS '������������� ������������ ��� �������';
COMMENT ON COLUMN BARS.IBX_TYPES.PROC_GETINFO IS '��� ��������� ��������� ������� (���������: p_params in xmltype, p_result out xmltype)';
COMMENT ON COLUMN BARS.IBX_TYPES.PROC_PAY IS '��� ��������� ������ (���������: p_src_nls in varchar2 (����� ����� ��� ��������), p_deal_id in varchar2 (��. ������), p_sum in number (����� ������� � ���), p_date in date (���� �������), p_res_code out number (��� ����������), p_res_text out varchar2 (����� ����������), p_res_ref out oper.ref%type (��������))';
COMMENT ON COLUMN BARS.IBX_TYPES.ABS_NAZN_MASK IS '����� ���������� ����� �������';




PROMPT *** Create  constraint PK_WCSIBOXTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_TYPES ADD CONSTRAINT PK_WCSIBOXTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_IBX_TYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_TYPES ADD CONSTRAINT NN_IBX_TYPES_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXTYPES_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_TYPES ADD CONSTRAINT CC_IBXTYPES_NLS_NN CHECK (NLS IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_TYPES ADD CONSTRAINT CC_IBXTYPES_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSIBOXTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSIBOXTYPES ON BARS.IBX_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IBX_TYPES ***
grant SELECT                                                                 on IBX_TYPES       to UPLD;
grant FLASHBACK,SELECT                                                       on IBX_TYPES       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IBX_TYPES.sql =========*** End *** ===
PROMPT ===================================================================================== 
