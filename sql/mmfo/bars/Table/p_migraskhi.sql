

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRASKHI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRASKHI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRASKHI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASKHI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASKHI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRASKHI ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRASKHI 
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




PROMPT *** ALTER_POLICIES to P_MIGRASKHI ***
 exec bpa.alter_policies('P_MIGRASKHI');


COMMENT ON TABLE BARS.P_MIGRASKHI IS 'Справочник импорта ХИТЦ (ф)';
COMMENT ON COLUMN BARS.P_MIGRASKHI.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRASKHI.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRASKHI.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRASKHI.ORDNUNG IS 'Порядок сортировки';



PROMPT *** Create  grants  P_MIGRASKHI ***
grant SELECT                                                                 on P_MIGRASKHI     to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRASKHI     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRASKHI ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRASKHI FOR BARS.P_MIGRASKHI;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRASKHI.sql =========*** End *** =
PROMPT ===================================================================================== 
