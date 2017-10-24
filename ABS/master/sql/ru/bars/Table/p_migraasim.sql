

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAASIM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAASIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAASIM'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAASIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAASIM 
   (	ACTION VARCHAR2(64), 
	PROCNAME VARCHAR2(64), 
	ERRMASK VARCHAR2(64), 
	ORDNUNG NUMBER(*,0), 
	PROV_SQL VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P_MIGRAASIM ***
 exec bpa.alter_policies('P_MIGRAASIM');


COMMENT ON TABLE BARS.P_MIGRAASIM IS '���������� ������� ����������� ������� ����';
COMMENT ON COLUMN BARS.P_MIGRAASIM.ACTION IS '��������';
COMMENT ON COLUMN BARS.P_MIGRAASIM.PROCNAME IS '������������ ��������� �������';
COMMENT ON COLUMN BARS.P_MIGRAASIM.ERRMASK IS '����� ������';
COMMENT ON COLUMN BARS.P_MIGRAASIM.ORDNUNG IS '������� ����������';
COMMENT ON COLUMN BARS.P_MIGRAASIM.PROV_SQL IS '��� ����� - ����������� SQL';



PROMPT *** Create  grants  P_MIGRAASIM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAASIM     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAASIM ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAASIM FOR BARS.P_MIGRAASIM;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAASIM.sql =========*** End *** =
PROMPT ===================================================================================== 
