
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getoperation_extdoc.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETOPERATION_EXTDOC (p_doc  oper%rowtype) return varchar2
is
   -- ... процедура для определения кода опреации для документа при импорте из внешней системы
   l_nbsa   varchar2(4);
   l_nbsb   varchar2(4);
   l_tt     varchar2(3);
   G_MODULE varchar2(3) := 'IMP';
begin

   l_nbsa := substr(p_doc.nlsa,1,4);
   l_nbsb := substr(p_doc.nlsb,1,4);


   if p_doc.mfoa = p_doc.mfob then
      --касса
      if l_nbsa = '1001' or l_nbsa = '1002' or
         l_nbsb = '1001' or l_nbsb = '1002' then
         -- гривна
         if p_doc.kv = '980' then
            -- ДК
            if  l_nbsb = '1001' or l_nbsb = '1002' then
                case p_doc.dk when 0 then  l_tt := 'I02';  -- Приход кассы
                              when 1 then  l_tt := 'I03';  -- расход кассы
                end case;
            else
                case p_doc.dk when 1 then  l_tt := 'I02';  -- Приход кассы
                              when 0 then  l_tt := 'I03';  -- расход кассы
                end case;
            end if;

         --валюта
         else
            -- ДК
            if  l_nbsb = '1001' or l_nbsb = '1002' then
               case p_doc.dk when 0 then  l_tt := 'I04';  -- Приход кассы
                             when 1 then  l_tt := 'I05';  -- расход кассы
                             else bars_error.raise_nerror(G_MODULE, 'CASH_NOINFODK', p_doc.nd, p_doc.nlsa, p_doc.nlsb);
               end case;
            else
               case p_doc.dk when 1 then  l_tt := 'I04';  -- Приход кассы
                             when 0 then  l_tt := 'I05';  -- расход кассы
                             else bars_error.raise_nerror(G_MODULE, 'CASH_NOINFODK', p_doc.nd, p_doc.nlsa, p_doc.nlsb);
               end case;
            end if;

         end if;
      -- не кассовые
      else
         l_tt := 'I00';
      end if;
   -- межбанк
   else
      case p_doc.dk when  0 then l_tt := 'I07';  -- реальный дебет межбанк
                    when  2 then l_tt := 'I06';  -- информационный дебет межбанк
                    when  1 then l_tt := 'I01';  -- реальный кредит межбанк
                    else  bars_error.raise_nerror(G_MODULE, 'NO_DK3', p_doc.nd, p_doc.nlsa, p_doc.nlsb);
      end case;
   end if;

   return l_tt;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getoperation_extdoc.sql =========
 PROMPT ===================================================================================== 
 