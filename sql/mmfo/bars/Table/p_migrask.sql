

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRASK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRASK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRASK 
   (	ACTION VARCHAR2(64), 
	PROCNAME VARCHAR2(64), 
	ERRMASK VARCHAR2(64), 
	ORDNUNG NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P_MIGRASK ***
 exec bpa.alter_policies('P_MIGRASK');


COMMENT ON TABLE BARS.P_MIGRASK IS 'Справочник импорта СКАРБ6(голов.)';
COMMENT ON COLUMN BARS.P_MIGRASK.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRASK.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRASK.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRASK.ORDNUNG IS 'Порядок сортировки';



PROMPT *** Create  grants  P_MIGRASK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRASK       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRASK ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRASK FOR BARS.P_MIGRASK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRASK.sql =========*** End *** ===
PROMPT ===================================================================================== 
