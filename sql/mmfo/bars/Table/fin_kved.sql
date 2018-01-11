

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_KVED.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_KVED ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_KVED'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_KVED'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_KVED ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_KVED 
   (	OKPO NUMBER, 
	DAT DATE, 
	KVED VARCHAR2(5), 
	VOLME_SALES NUMBER, 
	WEIGHT NUMBER, 
	FLAG NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_KVED ***
 exec bpa.alter_policies('FIN_KVED');


COMMENT ON TABLE BARS.FIN_KVED IS '������ ���������� ��������� �� �볺����';
COMMENT ON COLUMN BARS.FIN_KVED.OKPO IS '���� �볺���';
COMMENT ON COLUMN BARS.FIN_KVED.DAT IS '����� ����';
COMMENT ON COLUMN BARS.FIN_KVED.KVED IS '����';
COMMENT ON COLUMN BARS.FIN_KVED.VOLME_SALES IS '����� ���������� ���������';
COMMENT ON COLUMN BARS.FIN_KVED.WEIGHT IS '������ ����';
COMMENT ON COLUMN BARS.FIN_KVED.FLAG IS '���� ��������� 0-� 1-���';




PROMPT *** Create  constraint PK_FINKVED ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KVED ADD CONSTRAINT PK_FINKVED PRIMARY KEY (OKPO, DAT, KVED)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINKVED ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINKVED ON BARS.FIN_KVED (OKPO, DAT, KVED) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_KVED ***
grant SELECT                                                                 on FIN_KVED        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_KVED        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_KVED        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_KVED.sql =========*** End *** ====
PROMPT ===================================================================================== 
