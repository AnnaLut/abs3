

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAASME.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAASME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAASME'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAASME ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAASME 
   (	ACTION VARCHAR2(64), 
	PROCNAME VARCHAR2(64), 
	ERRMASK VARCHAR2(64), 
	ORDNUNG NUMBER(*,0), 
	PROV_SQL VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P_MIGRAASME ***
 exec bpa.alter_policies('P_MIGRAASME');


COMMENT ON TABLE BARS.P_MIGRAASME IS '���������� ������� ��������������� ������� ����������';
COMMENT ON COLUMN BARS.P_MIGRAASME.ACTION IS '��������';
COMMENT ON COLUMN BARS.P_MIGRAASME.PROCNAME IS '������������ ��������� �������';
COMMENT ON COLUMN BARS.P_MIGRAASME.ERRMASK IS '����� ������';
COMMENT ON COLUMN BARS.P_MIGRAASME.ORDNUNG IS '������� ����������';
COMMENT ON COLUMN BARS.P_MIGRAASME.PROV_SQL IS '��� ����� - ����������� SQL';



PROMPT *** Create  grants  P_MIGRAASME ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAASME     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAASME ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAASME FOR BARS.P_MIGRAASME;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAASME.sql =========*** End *** =
PROMPT ===================================================================================== 
