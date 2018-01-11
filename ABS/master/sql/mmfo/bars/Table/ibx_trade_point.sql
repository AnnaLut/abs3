

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IBX_TRADE_POINT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IBX_TRADE_POINT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_TRADE_POINT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TRADE_POINT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IBX_TRADE_POINT ***
begin 
  execute immediate '
  CREATE TABLE BARS.IBX_TRADE_POINT 
   (	TRADE_POINT VARCHAR2(20), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IBX_TRADE_POINT ***
 exec bpa.alter_policies('IBX_TRADE_POINT');


COMMENT ON TABLE BARS.IBX_TRADE_POINT IS 'Скписок терминалов томас и счетов выделенных под них';
COMMENT ON COLUMN BARS.IBX_TRADE_POINT.TRADE_POINT IS 'Код устройства TOMAS';
COMMENT ON COLUMN BARS.IBX_TRADE_POINT.MFO IS 'Код банка';
COMMENT ON COLUMN BARS.IBX_TRADE_POINT.NLS IS 'Номер лицевого счета 1004';



PROMPT *** Create  grants  IBX_TRADE_POINT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on IBX_TRADE_POINT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IBX_TRADE_POINT to UPLD;
grant FLASHBACK,SELECT                                                       on IBX_TRADE_POINT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IBX_TRADE_POINT.sql =========*** End *
PROMPT ===================================================================================== 
