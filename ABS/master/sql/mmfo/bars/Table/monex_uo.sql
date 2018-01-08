

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEX_UO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEX_UO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEX_UO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX_UO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEX_UO ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEX_UO 
   (	ID NUMBER, 
	NAME VARCHAR2(38), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(15), 
	OKPO VARCHAR2(10), 
	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEX_UO ***
 exec bpa.alter_policies('MONEX_UO');


COMMENT ON TABLE BARS.MONEX_UO IS '������� ��, �� �������� � ���';
COMMENT ON COLUMN BARS.MONEX_UO.RNK IS '���';
COMMENT ON COLUMN BARS.MONEX_UO.ID IS '� ��';
COMMENT ON COLUMN BARS.MONEX_UO.NAME IS '����� ��, �� ������ � ���';
COMMENT ON COLUMN BARS.MONEX_UO.MFO IS '��.����.���';
COMMENT ON COLUMN BARS.MONEX_UO.NLS IS '��.����.���.';
COMMENT ON COLUMN BARS.MONEX_UO.OKPO IS '��.����.��.���';




PROMPT *** Create  constraint CC_MONEXUO_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_UO MODIFY (ID CONSTRAINT CC_MONEXUO_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_MONEXUO ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_UO ADD CONSTRAINT XPK_MONEXUO PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MONEXUO_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_UO MODIFY (NAME CONSTRAINT CC_MONEXUO_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEXUO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MONEXUO ON BARS.MONEX_UO (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX_UO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX_UO        to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MONEX_UO        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEX_UO.sql =========*** End *** ====
PROMPT ===================================================================================== 
