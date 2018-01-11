

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRASKS5.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRASKS5 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRASKS5'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASKS5'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRASKS5'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_MIGRASKS5 ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_MIGRASKS5 
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




PROMPT *** ALTER_POLICIES to P_MIGRASKS5 ***
 exec bpa.alter_policies('P_MIGRASKS5');


COMMENT ON TABLE BARS.P_MIGRASKS5 IS 'Справочник импорта СКАРБ5(ф)';
COMMENT ON COLUMN BARS.P_MIGRASKS5.ACTION IS 'Действие';
COMMENT ON COLUMN BARS.P_MIGRASKS5.PROCNAME IS 'Наименование процедуры импорта';
COMMENT ON COLUMN BARS.P_MIGRASKS5.ERRMASK IS 'Маска ошибок';
COMMENT ON COLUMN BARS.P_MIGRASKS5.ORDNUNG IS 'Порядок сортировки';



PROMPT *** Create  grants  P_MIGRASKS5 ***
grant SELECT                                                                 on P_MIGRASKS5     to BARSREADER_ROLE;
grant SELECT                                                                 on P_MIGRASKS5     to BARS_DM;
grant SELECT                                                                 on P_MIGRASKS5     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on P_MIGRASKS5     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to P_MIGRASKS5 ***

  CREATE OR REPLACE PUBLIC SYNONYM P_MIGRASKS5 FOR BARS.P_MIGRASKS5;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRASKS5.sql =========*** End *** =
PROMPT ===================================================================================== 
