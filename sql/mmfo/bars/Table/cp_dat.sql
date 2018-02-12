

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DAT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DAT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
   (	ID NUMBER(*,0), 
	NPP NUMBER(*,0), 
	DOK DATE, 
	KUP NUMBER, 
	NOM NUMBER(12,2), 
	EXPIRY_DATE DATE, 
	IR NUMBER,
        KF varchar2(6) default sys_context(''bars_context'',''user_mfo'')        
   ) SEGMENT CREATION IMMEDIATE 
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
COMMENT ON COLUMN BARS.CP_DAT.ID IS '��� �� (�����.)';
COMMENT ON COLUMN BARS.CP_DAT.NPP IS '� ���-�� ���_���';
COMMENT ON COLUMN BARS.CP_DAT.DOK IS '���� ������� ���-�� ���_���';
COMMENT ON COLUMN BARS.CP_DAT.KUP IS '���� ������ � ���_��_';
COMMENT ON COLUMN BARS.CP_DAT.NOM IS '��������� ���_���� � ���_��_';
COMMENT ON COLUMN BARS.CP_DAT.EXPIRY_DATE IS '���� ���������� ������������ (���� ����� - ��������� CP_KOD.EXPIRY)';
COMMENT ON COLUMN BARS.CP_DAT.IR IS '��������� ���� ��������� ������ � ��������� �����';




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


begin
    execute immediate 'alter table CP_DAT add offer_date date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

COMMENT ON COLUMN BARS.CP_DAT.offer_date IS '���� ������';

begin   
 execute immediate 'ALTER TABLE BARS.CP_DAT ADD CONSTRAINT FK_CPDAT_ID_KF FOREIGN KEY (ID, KF)
	  REFERENCES BARS.CP_KOD (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CP_DAT ***
grant SELECT                                                                 on CP_DAT          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DAT          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_DAT          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DAT          to START1;
grant SELECT                                                                 on CP_DAT          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DAT.sql =========*** End *** ======
PROMPT ===================================================================================== 
