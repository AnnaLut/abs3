

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REE2.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REE2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REE2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REE2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REE2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REE2 
   (	OKPO VARCHAR2(8), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(15), 
	NOM NUMBER, 
	CP_ID VARCHAR2(20), 
	KUPON NUMBER, 
	ZASTAVA NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REE2 ***
 exec bpa.alter_policies('CP_REE2');


COMMENT ON TABLE BARS.CP_REE2 IS '������� � ������ ������_� �� ��_�_� ������ ����� (�����)';
COMMENT ON COLUMN BARS.CP_REE2.OKPO IS '���� ������� ';
COMMENT ON COLUMN BARS.CP_REE2.MFO IS '��� ������� ';
COMMENT ON COLUMN BARS.CP_REE2.NLS IS '���-� ...';
COMMENT ON COLUMN BARS.CP_REE2.NOM IS '���� ���_���� �� ���������';
COMMENT ON COLUMN BARS.CP_REE2.CP_ID IS 'ISIN-��� ��';
COMMENT ON COLUMN BARS.CP_REE2.KUPON IS '���� ������ �� ���������';
COMMENT ON COLUMN BARS.CP_REE2.ZASTAVA IS '���-� �������';




PROMPT *** Create  constraint XPK_CP_REE2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2 ADD CONSTRAINT XPK_CP_REE2 PRIMARY KEY (CP_ID, MFO, ZASTAVA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685921 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2 MODIFY (ZASTAVA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685920 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2 MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685919 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REE2 MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_REE2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_REE2 ON BARS.CP_REE2 (CP_ID, MFO, ZASTAVA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_REE2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REE2         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REE2.sql =========*** End *** =====
PROMPT ===================================================================================== 
