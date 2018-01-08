

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOA_DEL_ROWS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOA_DEL_ROWS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDOA_DEL_ROWS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOA_DEL_ROWS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOA_DEL_ROWS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOA_DEL_ROWS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDOA_DEL_ROWS 
   (	ACC NUMBER(*,0), 
	FDAT DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSSALD 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P20110101  VALUES LESS THAN (TO_DATE('' 2011-01-02 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSSALD ) ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOA_DEL_ROWS ***
 exec bpa.alter_policies('SALDOA_DEL_ROWS');


COMMENT ON TABLE BARS.SALDOA_DEL_ROWS IS 'Удаленные строки из SALDOA
    используется для определения макс даты изменения по SALDOA с помощью ora_rowscn
    наполняется триггером TAD_SALDOA';
COMMENT ON COLUMN BARS.SALDOA_DEL_ROWS.ACC IS 'ACC счета';
COMMENT ON COLUMN BARS.SALDOA_DEL_ROWS.FDAT IS 'Дата партиции(оборотов по счету)';




PROMPT *** Create  constraint CC_SALDOADELROWS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_DEL_ROWS MODIFY (ACC CONSTRAINT CC_SALDOADELROWS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOADELROWS_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_DEL_ROWS MODIFY (FDAT CONSTRAINT CC_SALDOADELROWS_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDOA_DEL_ROWS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOA_DEL_ROWS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDOA_DEL_ROWS to BARS_DM;
grant SELECT                                                                 on SALDOA_DEL_ROWS to DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOA_DEL_ROWS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOA_DEL_ROWS.sql =========*** End *
PROMPT ===================================================================================== 
