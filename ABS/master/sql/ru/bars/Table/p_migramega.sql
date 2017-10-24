

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAMEGA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAMEGA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAMEGA'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAMEGA ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAMEGA 
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




PROMPT *** ALTER_POLICIES to P_MIGRAMEGA ***
 exec bpa.alter_policies('P_MIGRAMEGA');


COMMENT ON TABLE BARS.P_MIGRAMEGA IS '���������� ������� ��������';
COMMENT ON COLUMN BARS.P_MIGRAMEGA.ACTION IS '��������';
COMMENT ON COLUMN BARS.P_MIGRAMEGA.PROCNAME IS '������������ ��������� �������';
COMMENT ON COLUMN BARS.P_MIGRAMEGA.ERRMASK IS '����� ������';
COMMENT ON COLUMN BARS.P_MIGRAMEGA.ORDNUNG IS '������� ����������';
COMMENT ON COLUMN BARS.P_MIGRAMEGA.PROV_SQL IS '��� ����� - ����������� SQL';



PROMPT *** Create  grants  P_MIGRAMEGA ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAMEGA     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAMEGA ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAMEGA FOR BARS.P_MIGRAMEGA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAMEGA.sql =========*** End *** =
PROMPT ===================================================================================== 
