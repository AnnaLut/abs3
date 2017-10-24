

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DAT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DAT 
   (	ID NUMBER(38,0), 
	NPP NUMBER(38,0), 
	DOK DATE, 
	KUP NUMBER, 
	NOM NUMBER(12,2), 
	EXPIRY_DATE DATE, 
	IR NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DAT ***
 exec bpa.alter_policies('CP_DAT');


COMMENT ON TABLE BARS.CP_DAT IS '����i�� ��������� �����i�/���i����';
COMMENT ON COLUMN BARS.CP_DAT.IR IS '��������� ���� ��������� ������ � ��������� �����';
COMMENT ON COLUMN BARS.CP_DAT.EXPIRY_DATE IS '���� ���������� ������������';
COMMENT ON COLUMN BARS.CP_DAT.ID IS '��� �� (�����.)';
COMMENT ON COLUMN BARS.CP_DAT.NPP IS '� ���-�� ���_���';
COMMENT ON COLUMN BARS.CP_DAT.DOK IS '���� ������� ���-�� ���_���';
COMMENT ON COLUMN BARS.CP_DAT.KUP IS '���� ������ � ���_��_';
COMMENT ON COLUMN BARS.CP_DAT.NOM IS '��������� ���_���� � ���_��_';




PROMPT *** Create  constraint XPK_CP_DAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DAT ADD CONSTRAINT XPK_CP_DAT PRIMARY KEY (ID, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_DAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_DAT ON BARS.CP_DAT (ID, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DAT ***
grant SELECT                                                                 on CP_DAT          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DAT          to START1;
grant SELECT                                                                 on CP_DAT          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DAT.sql =========*** End *** ======
PROMPT ===================================================================================== 
