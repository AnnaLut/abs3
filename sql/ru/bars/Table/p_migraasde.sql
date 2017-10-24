

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAASDE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAASDE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAASDE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRAASDE ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRAASDE 
   (	ACTION VARCHAR2(64), 
	PROCNAME VARCHAR2(64), 
	ERRMASK VARCHAR2(64), 
	ORDNUNG NUMBER(*,0), 
	PROV_SQL VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P_MIGRAASDE ***
 exec bpa.alter_policies('P_MIGRAASDE');


COMMENT ON TABLE BARS.P_MIGRAASDE IS 'Справочник импорта компенсационных вкладов ДЕЛЬТАБАНК';
COMMENT ON COLUMN BARS.P_MIGRAASDE.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRAASDE.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRAASDE.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRAASDE.ORDNUNG IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.P_MIGRAASDE.PROV_SQL IS 'Имя вюшки - Проверочный SQL';



PROMPT *** Create  grants  P_MIGRAASDE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRAASDE     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRAASDE ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRAASDE FOR BARS.P_MIGRAASDE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAASDE.sql =========*** End *** =
PROMPT ===================================================================================== 
