

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAASCO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAASCO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAASCO'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAASCO ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAASCO 
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




PROMPT *** ALTER_POLICIES to P_MIGRAASCO ***
 exec bpa.alter_policies('P_MIGRAASCO');


COMMENT ON TABLE BARS.P_MIGRAASCO IS 'Справочник импорта неподвижных вкладов АСВО';
COMMENT ON COLUMN BARS.P_MIGRAASCO.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRAASCO.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRAASCO.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRAASCO.ORDNUNG IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.P_MIGRAASCO.PROV_SQL IS 'Имя вюшки - Проверочный SQL';



PROMPT *** Create  grants  P_MIGRAASCO ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAASCO     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAASCO ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAASCO FOR BARS.P_MIGRAASCO;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAASCO.sql =========*** End *** =
PROMPT ===================================================================================== 
