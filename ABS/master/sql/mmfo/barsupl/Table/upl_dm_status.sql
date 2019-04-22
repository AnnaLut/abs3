PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARSUPL/Table/UPL_DM_STATUS.sql =======*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to UPL_DM_STATUS ***


--BEGIN 
--        execute immediate  
--          'begin  
--               bars.bpa.alter_policy_info(''BARSUPL'', ''UPL_DM_STATUS'', ''CENTER'' , null, null, null, null);
--               bars.bpa.alter_policy_info(''BARSUPL'', ''UPL_DM_STATUS'', ''FILIAL'' , null, null, null, null);
--               bars.bpa.alter_policy_info(''BARSUPL'', ''UPL_DM_STATUS'', ''WHOLE''  , null, null, null, null);
--               null;
--           end; 
--          '; 
--END; 
--/


PROMPT *** Create  table UPL_DM_STATUS ***
begin 
  execute immediate '
CREATE TABLE BARSUPL.UPL_DM_STATUS (
  DM_CODE           VARCHAR2(30)                     NOT NULL,
  KF                VARCHAR2(6),
  ROWS_CNT          NUMBER,
  BANK_DATE         DATE,
  FILL_DATE         DATE,
  SID               VARCHAR2(30)
   )
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

--PROMPT *** ALTER_POLICIES to UPL_DM_STATUS ***
-- exec bars.bpa.alter_policies('BARSUPL', 'UPL_DM_STATUS');

COMMENT ON TABLE  BARSUPL.UPL_DM_STATUS           IS 'Протокон наполнения временных витрин.';
COMMENT ON COLUMN BARSUPL.UPL_DM_STATUS.DM_CODE   IS 'Текстовый код витрины';
COMMENT ON COLUMN BARSUPL.UPL_DM_STATUS.KF        IS 'Регион';
COMMENT ON COLUMN BARSUPL.UPL_DM_STATUS.ROWS_CNT  IS 'Количество строк';
COMMENT ON COLUMN BARSUPL.UPL_DM_STATUS.BANK_DATE IS 'Банковская дата выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_DM_STATUS.FILL_DATE IS 'Дата формирования (sysdate)';
COMMENT ON COLUMN BARSUPL.UPL_DM_STATUS.SID       IS 'SID сесии';

PROMPT *** Create  grants  UPL_DM_STATUS ***
grant DELETE,INSERT,SELECT,UPDATE                                on UPL_DM_STATUS   to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** =========== Scripts /Sql/BARSUPL/Table/UPL_DM_STATUS.sql =========*** End 
PROMPT ===================================================================================== 
