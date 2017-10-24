

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_FIN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_FIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_FIN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEB_FIN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_FIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEB_FIN 
   (	NBS VARCHAR2(4), 
	KV NUMBER(3,0), 
	KAT NUMBER(*,0), 
	BV NUMBER, 
	BVQ NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	REZF NUMBER, 
	REZQF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_FIN ***
 exec bpa.alter_policies('DEB_FIN');


COMMENT ON TABLE BARS.DEB_FIN IS '��������� ��������� - ����';
COMMENT ON COLUMN BARS.DEB_FIN.NBS IS '���.���.';
COMMENT ON COLUMN BARS.DEB_FIN.KV IS '��� ������';
COMMENT ON COLUMN BARS.DEB_FIN.KAT IS '���. �����';
COMMENT ON COLUMN BARS.DEB_FIN.BV IS '��������� ������� ���.';
COMMENT ON COLUMN BARS.DEB_FIN.BVQ IS '��������� ������� ���.';
COMMENT ON COLUMN BARS.DEB_FIN.REZ IS '������ � ���.';
COMMENT ON COLUMN BARS.DEB_FIN.REZQ IS '������ � ���.';
COMMENT ON COLUMN BARS.DEB_FIN.REZF IS '';
COMMENT ON COLUMN BARS.DEB_FIN.REZQF IS '';




PROMPT *** Create  constraint PK_DEB_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_FIN ADD CONSTRAINT PK_DEB_FIN PRIMARY KEY (NBS, KV, KAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEB_FIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEB_FIN ON BARS.DEB_FIN (NBS, KV, KAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEB_FIN ***
grant SELECT                                                                 on DEB_FIN         to RCC_DEAL;
grant SELECT                                                                 on DEB_FIN         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_FIN.sql =========*** End *** =====
PROMPT ===================================================================================== 
