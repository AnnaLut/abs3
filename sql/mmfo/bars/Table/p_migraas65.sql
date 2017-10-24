

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAAS65.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAAS65 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAAS65'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAAS65'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAAS65'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAAS65 ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAAS65 
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




PROMPT *** ALTER_POLICIES to P_MIGRAAS65 ***
 exec bpa.alter_policies('P_MIGRAAS65');


COMMENT ON TABLE BARS.P_MIGRAAS65 IS 'Справочник импорта АСВО6.5';
COMMENT ON COLUMN BARS.P_MIGRAAS65.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRAAS65.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRAAS65.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRAAS65.ORDNUNG IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.P_MIGRAAS65.PROV_SQL IS 'Имя вюшки - Проверочный SQL';



PROMPT *** Create  grants  P_MIGRAAS65 ***
grant SELECT                                                                 on P_MIGRAAS65     to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAAS65     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAAS65 ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAAS65 FOR BARS.P_MIGRAAS65;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAAS65.sql =========*** End *** =
PROMPT ===================================================================================== 
