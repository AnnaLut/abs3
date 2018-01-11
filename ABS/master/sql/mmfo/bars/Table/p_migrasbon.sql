

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRASBON.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRASBON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRASBON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASBON'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASBON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRASBON ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRASBON 
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




PROMPT *** ALTER_POLICIES to P_MIGRASBON ***
 exec bpa.alter_policies('P_MIGRASBON');


COMMENT ON TABLE BARS.P_MIGRASBON IS 'Справочник импорта СБОН';
COMMENT ON COLUMN BARS.P_MIGRASBON.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRASBON.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRASBON.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRASBON.ORDNUNG IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.P_MIGRASBON.PROV_SQL IS 'Имя вюшки - Проверочный SQL';



PROMPT *** Create  grants  P_MIGRASBON ***
grant SELECT                                                                 on P_MIGRASBON     to BARSREADER_ROLE;
grant SELECT                                                                 on P_MIGRASBON     to BARS_DM;
grant SELECT                                                                 on P_MIGRASBON     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRASBON     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRASBON ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRASBON FOR BARS.P_MIGRASBON;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRASBON.sql =========*** End *** =
PROMPT ===================================================================================== 
