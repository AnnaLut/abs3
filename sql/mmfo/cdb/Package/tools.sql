
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/tools.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.TOOLS is
    procedure hide_hint(p_number in number);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.TOOLS as

    procedure hide_hint(p_number in number)
    is
    begin
        null;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/tools.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 