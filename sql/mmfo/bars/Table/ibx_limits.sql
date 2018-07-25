 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/table/ibx_limits.sql =========*** Run *** ==
 PROMPT ===================================================================================== 

BEGIN
        execute immediate
          'begin
               bpa.alter_policy_info(''IBX_LIMITS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_LIMITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_LIMITS'', ''WHOLE'' , null, null, null, null);
               null;
           end;
          ';
END;
/

begin 
  execute immediate' 
  CREATE TABLE BARS.IBX_LIMITS 
   (NBS VARCHAR2(4), 
	MIN_AMOUNT NUMBER, 
	MAX_AMOUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
 TABLESPACE "BRSDYND" 
';
exception when others then
  if sqlcode=-955 then null; else raise;end if;
end;
/
 
PROMPT *** Create  grants  IBX_LIMITS ***
grant ALTER,DEBUG,DELETE,INSERT,SELECT,UPDATE      on IBX_LIMITS      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/table/ibx_limits.sql =========*** End *** ==
 PROMPT ===================================================================================== 
/