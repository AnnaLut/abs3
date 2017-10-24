
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fx_ifc.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FX_IFC (i number)
return varchar2
        IS
davit varchar2 (15);
begin
select account into davit from customer_ifc
    where ifc = i;
return davit;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fx_ifc.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 