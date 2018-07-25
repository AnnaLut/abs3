 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/table/ibx_tp_params_lst.sql=========*** Run *
 PROMPT ===================================================================================== 

BEGIN
        execute immediate
          'begin
               bpa.alter_policy_info(''IBX_TP_PARAMS_LST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TP_PARAMS_LST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TP_PARAMS_LST'', ''WHOLE'' , null, null, null, null);
               null;
           end;
          ';
END;
/

BEGIN
        execute immediate'
  CREATE TABLE BARS.IBX_TP_PARAMS_LST 
   (	"PARAMCODE" VARCHAR2(20), 
	"PARAMNAME" VARCHAR2(100), 
	"DEFVALUE" VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "BRSDYND"  
';
exception when others then
  if sqlcode=-955 then null;else raise;end if ;  
end;
/ 


PROMPT *** Create  grants  IBX_TP_PARAMS_LST ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on IBX_TP_PARAMS_LST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IBX_TP_PARAMS_LST to UPLD;
grant FLASHBACK,SELECT                                                       on IBX_TP_PARAMS_LST to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/table/ibx_tp_params_lst.sql=========*** End *
 PROMPT ===================================================================================== 
/