
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/newnbs.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NEWNBS is

  -- Author  : VITALII.KHOMIDA
  -- Created : 08.11.2017 14:00:57
  -- Purpose :

  -- перехідн на новий план рахунків 1 - включено, 0 - відлключено
  g_state constant number := 1;

  function get_state return number;

end newnbs;
/
CREATE OR REPLACE PACKAGE BODY BARS.NEWNBS is

  function get_state return number is
  begin
    return g_state;
  end;

end newnbs;
/
 show err;
 
PROMPT *** Create  grants  NEWNBS ***
grant EXECUTE                                                                on NEWNBS          to PUBLIC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/newnbs.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 