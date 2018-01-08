

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAAS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAAS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAAS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAAS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAAS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAAS ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAAS 
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




PROMPT *** ALTER_POLICIES to P_MIGRAAS ***
 exec bpa.alter_policies('P_MIGRAAS');


COMMENT ON TABLE BARS.P_MIGRAAS IS 'Справочник импорта АСВО6.3';
COMMENT ON COLUMN BARS.P_MIGRAAS.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRAAS.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRAAS.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRAAS.ORDNUNG IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.P_MIGRAAS.PROV_SQL IS 'Имя вюшки - Проверочный SQL';



PROMPT *** Create  grants  P_MIGRAAS ***
grant SELECT                                                                 on P_MIGRAAS       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAAS       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAAS ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAAS FOR BARS.P_MIGRAAS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAAS.sql =========*** End *** ===
PROMPT ===================================================================================== 
