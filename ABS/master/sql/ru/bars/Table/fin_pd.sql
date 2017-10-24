

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_PD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_PD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_PD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_PD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_PD ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_PD 
   (	IDF NUMBER(*,0), 
	FIN NUMBER(2,0), 
	VNCRR NUMBER(3,0), 
	IP1 NUMBER(1,0), 
	IP2 NUMBER(1,0), 
	IP3 NUMBER(1,0), 
	IP4 NUMBER(1,0), 
	IP5 NUMBER(1,0), 
	K NUMBER(8,5), 
	K2 NUMBER(8,5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_PD ***
 exec bpa.alter_policies('FIN_PD');


COMMENT ON TABLE BARS.FIN_PD IS '�������� ��������� PD ��� ��������';
COMMENT ON COLUMN BARS.FIN_PD.IDF IS '50-��';
COMMENT ON COLUMN BARS.FIN_PD.FIN IS '���� �������� ��������� 351';
COMMENT ON COLUMN BARS.FIN_PD.VNCRR IS '̳������� �������� ���';
COMMENT ON COLUMN BARS.FIN_PD.IP1 IS '̳�. ��. �������� ������';
COMMENT ON COLUMN BARS.FIN_PD.IP2 IS '̳�. ��. ��������� �������� �����';
COMMENT ON COLUMN BARS.FIN_PD.IP3 IS '̳�. ��. ���������� �� �����';
COMMENT ON COLUMN BARS.FIN_PD.IP4 IS '̳�. ��. ��������� �� �� ���';
COMMENT ON COLUMN BARS.FIN_PD.IP5 IS '̳�. ��. ���� ��������� ����������';
COMMENT ON COLUMN BARS.FIN_PD.K IS '�������� ��������� ������';
COMMENT ON COLUMN BARS.FIN_PD.K2 IS '�������� ��������� ������ ��� �� �������� ���������� ��������� ';




PROMPT *** Create  constraint PK_FINPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_PD ADD CONSTRAINT PK_FINPD PRIMARY KEY (FIN, VNCRR, IDF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINPD ON BARS.FIN_PD (FIN, VNCRR, IDF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_PD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_PD          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_PD          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_PD.sql =========*** End *** ======
PROMPT ===================================================================================== 
