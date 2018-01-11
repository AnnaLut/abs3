

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAUNIF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAUNIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAUNIF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAUNIF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAUNIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAUNIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAUNIF 
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




PROMPT *** ALTER_POLICIES to P_MIGRAUNIF ***
 exec bpa.alter_policies('P_MIGRAUNIF');


COMMENT ON TABLE BARS.P_MIGRAUNIF IS 'Справочник импорта Unicorn(ф)';
COMMENT ON COLUMN BARS.P_MIGRAUNIF.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRAUNIF.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRAUNIF.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRAUNIF.ORDNUNG IS 'Порядок сортировки';



PROMPT *** Create  grants  P_MIGRAUNIF ***
grant SELECT                                                                 on P_MIGRAUNIF     to BARSREADER_ROLE;
grant SELECT                                                                 on P_MIGRAUNIF     to BARS_DM;
grant SELECT                                                                 on P_MIGRAUNIF     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAUNIF     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAUNIF ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAUNIF FOR BARS.P_MIGRAUNIF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAUNIF.sql =========*** End *** =
PROMPT ===================================================================================== 
