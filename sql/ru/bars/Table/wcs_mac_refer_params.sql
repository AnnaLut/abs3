

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_MAC_REFER_PARAMS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_MAC_REFER_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_MAC_REFER_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_MAC_REFER_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_MAC_REFER_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_MAC_REFER_PARAMS 
   (	MAC_ID VARCHAR2(100), 
	TAB_NAME VARCHAR2(255), 
	KEY_FIELD VARCHAR2(255), 
	SEMANTIC_FIELD VARCHAR2(255), 
	SHOW_FIELDS VARCHAR2(255), 
	WHERE_CLAUSE VARCHAR2(255)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_MAC_REFER_PARAMS ***
 exec bpa.alter_policies('WCS_MAC_REFER_PARAMS');


COMMENT ON TABLE BARS.WCS_MAC_REFER_PARAMS IS '�������� ���� ���� REFER';
COMMENT ON COLUMN BARS.WCS_MAC_REFER_PARAMS.MAC_ID IS '������������� ����';
COMMENT ON COLUMN BARS.WCS_MAC_REFER_PARAMS.TAB_NAME IS '������������� ������� �����������';
COMMENT ON COLUMN BARS.WCS_MAC_REFER_PARAMS.KEY_FIELD IS '�������� ����';
COMMENT ON COLUMN BARS.WCS_MAC_REFER_PARAMS.SEMANTIC_FIELD IS '���� ���������';
COMMENT ON COLUMN BARS.WCS_MAC_REFER_PARAMS.SHOW_FIELDS IS '���� ��� ����������� (������������ ����� �������)';
COMMENT ON COLUMN BARS.WCS_MAC_REFER_PARAMS.WHERE_CLAUSE IS '������� ������ (������� ����� where)';




PROMPT *** Create  constraint FK_MACREFPARS_TID_MT_TID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_REFER_PARAMS ADD CONSTRAINT FK_MACREFPARS_TID_MT_TID FOREIGN KEY (TAB_NAME)
	  REFERENCES BARS.META_TABLES (TABNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MACREFPARS_TAB_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_REFER_PARAMS ADD CONSTRAINT CC_MACREFPARS_TAB_ID_NN CHECK (TAB_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MACREFPARS_SEMFIELD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_REFER_PARAMS ADD CONSTRAINT CC_MACREFPARS_SEMFIELD_NN CHECK (SEMANTIC_FIELD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MACREFPARS_KEYFIELD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_REFER_PARAMS ADD CONSTRAINT CC_MACREFPARS_KEYFIELD_NN CHECK (KEY_FIELD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MACREFPARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_REFER_PARAMS ADD CONSTRAINT PK_MACREFPARS PRIMARY KEY (MAC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177134 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_REFER_PARAMS MODIFY (MAC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MACREFPARS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MACREFPARS ON BARS.WCS_MAC_REFER_PARAMS (MAC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_MAC_REFER_PARAMS ***
grant SELECT                                                                 on WCS_MAC_REFER_PARAMS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_MAC_REFER_PARAMS.sql =========*** 
PROMPT ===================================================================================== 
