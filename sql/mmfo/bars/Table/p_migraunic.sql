

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAUNIC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAUNIC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAUNIC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAUNIC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAUNIC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAUNIC ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAUNIC 
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




PROMPT *** ALTER_POLICIES to P_MIGRAUNIC ***
 exec bpa.alter_policies('P_MIGRAUNIC');


COMMENT ON TABLE BARS.P_MIGRAUNIC IS '���������� ������� Unicorn';
COMMENT ON COLUMN BARS.P_MIGRAUNIC.ACTION IS '��������';
COMMENT ON COLUMN BARS.P_MIGRAUNIC.PROCNAME IS '������������ ��������� �������';
COMMENT ON COLUMN BARS.P_MIGRAUNIC.ERRMASK IS '����� ������';
COMMENT ON COLUMN BARS.P_MIGRAUNIC.ORDNUNG IS '������� ����������';



PROMPT *** Create  grants  P_MIGRAUNIC ***
grant SELECT                                                                 on P_MIGRAUNIC     to BARSREADER_ROLE;
grant SELECT                                                                 on P_MIGRAUNIC     to BARS_DM;
grant SELECT                                                                 on P_MIGRAUNIC     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAUNIC     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAUNIC ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAUNIC FOR BARS.P_MIGRAUNIC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAUNIC.sql =========*** End *** =
PROMPT ===================================================================================== 
