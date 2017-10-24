
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nal_ob22.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NAL_OB22 is

   --------------------------------------------------------------
   --  Назначение: Процедуры и функции для модуля Налоговый учет
   --  в системе Сбербанка
   --------------------------------------------------------------
   G_HEADER_VERSION       constant varchar2(64)  := 'version 1.0 07.02.2009';
   -----------------------------------------------------------------
   --     Функция получения версии заголовка пакета
   function header_version return varchar2;
   -----------------------------------------------------------------
   --     Функция получения версии тела пакета
   function body_version return varchar2;
   --
  --------------------------------------------------------------
END nal_ob22;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.NAL_OB22 as
  --------------------------------------------------------------
  --  Назначение: Функции и процедуры модуля
  --  Налоговый учет в системе Сбербанка
  --------------------------------------------------------------
  G_BODY_VERSION    constant varchar2(64)  := 'version 1.0 07.02.2009';
  -----------------------------------------------------------------
  function header_version return varchar2
  is
  begin
     return G_HEADER_VERSION;
  end;
  -----------------------------------------------------------------
  function body_version return varchar2
  is
  begin
     return G_BODY_VERSION;
  end;
end nal_ob22;
/
 show err;
 
PROMPT *** Create  grants  NAL_OB22 ***
grant EXECUTE                                                                on NAL_OB22        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAL_OB22        to NALOG;
grant EXECUTE                                                                on NAL_OB22        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nal_ob22.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 