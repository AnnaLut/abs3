 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/table/ibx_tp_params.sql =========*** Run ***
 PROMPT ===================================================================================== 

BEGIN
        execute immediate
          'begin
               bpa.alter_policy_info(''IBX_TP_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TP_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TP_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end;
          ';
END;
/

BEGIN
        execute immediate' 
  CREATE TABLE BARS.IBX_TP_PARAMS 
   (	"TRADE_POINT" VARCHAR2(20), 
	"PARAMVALUE" VARCHAR2(30), 
	"PARAMCODE" VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "BRSDYND" 
';
exception when others then
  if sqlcode=-955 then null;else raise;end if ;  
end;
/ 
PROMPT *** Create  grants  IBX_TP_PARAMS ***
grant ALTER,DEBUG,DELETE,INSERT,SELECT,UPDATE                                on IBX_TP_PARAMS   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/table/ibx_tp_params.sql =========*** End ***
 PROMPT ===================================================================================== 
/