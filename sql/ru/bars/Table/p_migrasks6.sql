

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRASKS6.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRASKS6 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRASKS6'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRASKS6 ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRASKS6 
   (	ACTION VARCHAR2(64), 
	PROCNAME VARCHAR2(64), 
	ERRMASK VARCHAR2(64), 
	ORDNUNG NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P_MIGRASKS6 ***
 exec bpa.alter_policies('P_MIGRASKS6');


COMMENT ON TABLE BARS.P_MIGRASKS6 IS '���������� ������� �����6(�)';
COMMENT ON COLUMN BARS.P_MIGRASKS6.ACTION IS '��������';
COMMENT ON COLUMN BARS.P_MIGRASKS6.PROCNAME IS '������������ ��������� �������';
COMMENT ON COLUMN BARS.P_MIGRASKS6.ERRMASK IS '����� ������';
COMMENT ON COLUMN BARS.P_MIGRASKS6.ORDNUNG IS '������� ����������';



PROMPT *** Create  grants  P_MIGRASKS6 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRASKS6     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRASKS6 ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRASKS6 FOR BARS.P_MIGRASKS6;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRASKS6.sql =========*** End *** =
PROMPT ===================================================================================== 
