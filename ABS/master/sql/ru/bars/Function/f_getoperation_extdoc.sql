
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getoperation_extdoc.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETOPERATION_EXTDOC (p_doc  oper%rowtype) return varchar2
is
   -- ... ��������� ��� ����������� ���� �������� ��� ��������� ��� ������� �� ������� �������
   l_nbsa   varchar2(4);
   l_nbsb   varchar2(4);
   l_tt     varchar2(3);
   G_MODULE varchar2(3) := 'IMP';
begin

   l_nbsa := substr(p_doc.nlsa,1,4);
   l_nbsb := substr(p_doc.nlsb,1,4);


   if p_doc.mfoa = p_doc.mfob then
      --�����
      if l_nbsa = '1001' or l_nbsa = '1002' or
         l_nbsb = '1001' or l_nbsb = '1002' then
         -- ������
         if p_doc.kv = '980' then
            -- ��
            if  l_nbsb = '1001' or l_nbsb = '1002' then
                case p_doc.dk when 0 then  l_tt := 'I02';  -- ������ �����
                              when 1 then  l_tt := 'I03';  -- ������ �����
                end case;
            else
                case p_doc.dk when 1 then  l_tt := 'I02';  -- ������ �����
                              when 0 then  l_tt := 'I03';  -- ������ �����
                end case;
            end if;

         --������
         else
            -- ��
            if  l_nbsb = '1001' or l_nbsb = '1002' then
               case p_doc.dk when 0 then  l_tt := 'I04';  -- ������ �����
                             when 1 then  l_tt := 'I05';  -- ������ �����
                             else bars_error.raise_nerror(G_MODULE, 'CASH_NOINFODK', p_doc.nd, p_doc.nlsa, p_doc.nlsb);
               end case;
            else
               case p_doc.dk when 1 then  l_tt := 'I04';  -- ������ �����
                             when 0 then  l_tt := 'I05';  -- ������ �����
                             else bars_error.raise_nerror(G_MODULE, 'CASH_NOINFODK', p_doc.nd, p_doc.nlsa, p_doc.nlsb);
               end case;
            end if;

         end if;
      -- �� ��������
      else
         l_tt := 'I00';
      end if;
   -- �������
   else
      case p_doc.dk when  0 then l_tt := 'I07';  -- �������� ����� �������
                    when  2 then l_tt := 'I06';  -- �������������� ����� �������
                    when  1 then l_tt := 'I01';  -- �������� ������ �������
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
 