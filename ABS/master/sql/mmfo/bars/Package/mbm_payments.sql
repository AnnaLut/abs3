
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mbm_payments.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MBM_PAYMENTS is

  -----------------------------------------------------------------
  --
  --    Типы
  --
  -----------------------------------------------------------------



   type t_doc is record( doc  xml_impdocs%rowtype,       --платнжные реквизитв документа
                         drec bars_xmlklb.array_drec);  --список доп. реквизитов


	procedure create_payment(
								p_date oper.vdat%type default trunc(sysdate),
								p_vdate oper.vdat%type default trunc(sysdate),
								p_mfoa oper.mfoa%type,
								p_mfob oper.mfob%type,
								p_nlsa oper.nlsa%type,
								p_nlsb oper.nlsb%type,
								p_okpoa oper.id_a%type,
								p_okpob oper.id_b%type,
								p_kv tabval.lcv%type,
								p_s oper.s%type,
								p_nama oper.nam_a%type,
								p_namb oper.nam_b%type,
								p_nazn oper.nazn%type,
								p_sk oper.sk%type,
								p_dk oper.dk%type default 1,
								p_vob oper.vob%type default 6,
								p_drec varchar2 default null,
                                p_nd oper.nd%type default null,
								p_sign oper.sign%type default null,
                p_cl_id number default null,
								p_ref out oper.ref%type,
                                p_creating_date out OPER.PDAT%type,
								p_errcode out number,
								p_errmsg out varchar2
								);
end mbm_payments;
/
CREATE OR REPLACE PACKAGE BODY BARS.MBM_PAYMENTS is

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   g_awk_body_defs constant varchar2(512) := ''
          ||'    - Сбербанк'    || chr(10);

   G_BODY_VERSION    constant varchar2(64) := 'version 13.11 18.05.2016';

   G_MODULE          constant char(3)      := 'KLB';    -- код модуля
   G_TRACE           constant varchar2(50) := 'MBM_PAYMENTS.';


   --
   -- статусы документа, кот. находится в промежуточной таблице импорта
   --
   G_IMPORTED        constant smallint  := 0;  -- только импортированный
   G_NOVALID         constant smallint  := 4;  -- валидирован с ошибкми
   G_VALIDATED       constant smallint  := 1;  -- валидированный
   G_PAYED           constant smallint  := 2;  -- оплаченный
   G_DELETED         constant smallint  := 3;  -- удаленный

   G_ACT_DEL         constant smallint  := 0;  -- удалить
   G_ACT_UPD         constant smallint  := 1;  -- изменить
   G_ACT_ADD         constant smallint  := 2;  -- добавить


   -- коды ошибок проверки ОКПО
   -- плательщик

   G_OKPO_NONUMBER_A  constant smallint  := 88;  -- не числовое значение
   G_OKPO_NOLENGTH_A  constant smallint  := 89;  -- длинна < 8-ми
   G_OKPO_NOVALID_A   constant smallint  := 87;  -- не прошла проверку v_okpo
   -- получатель
   G_OKPO_NONUMBER_B  constant smallint  := 92;  -- не числовое значение
   G_OKPO_NOLENGTH_B  constant smallint  := 93;  -- длинна < 8-ми
   G_OKPO_NOVALID_B   constant smallint  := 94;  -- не прошла проверку v_okpo

   G_OKPO_OK          constant smallint  := 0;   -- все ОК



   -- таблица кодировки непечатаемых символов
   G_x00_x1F constant varchar2(32)   := chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||chr(08)||chr(09)||chr(10)||
                                        chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||
                    chr(22)||chr(23)||chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31);


   G_VALIDATE_OK     constant number := 0;  -- код успешной обработки

   G_FILEBUFF        blob     := null;  -- переменная содержащая файл для импорта

   l_nls_card number := 0;


    function get_kv(p_lcv tabval.lcv%type) return tabval.kv%type
        is
        l_kv tabval.kv%type;
      begin
        begin
             select kv into l_kv
                    from tabval where upper(lcv)=upper(p_lcv);
                   exception when no_data_found then
                      raise_application_error(-20000, 'Недопустимый код валюты '||p_lcv);
             end;

        return l_kv;
      end;

 procedure parse_str(p_str varchar2, p_name out varchar2, p_val out varchar2)
    is
    begin
      p_name := substr(p_str,0,instr(p_str,'=')-1);
      p_val := substr(p_str,instr(p_str,'=')+1);
    end;

   -----------------------------------------------------------------
   --    IS_CASH
   --
   --    Проверка балансового на пренадлежность к кассе
   --
   --
   function is_cash(p_nbs  varchar2) return number
   is
   begin
      if p_nbs = '1001' or p_nbs = '1002' or p_nbs = '1003' or p_nbs = '1004' then
         return 1;
      else
         return 0;
      end if;
   end;

   -----------------------------------------------------------------
   --    IS_BISTAG
   --
   --    Является ли тег допревизита, тегом биса
   --    return 0 - нет, 1- да, это тег БИС-а
   --
   function is_bistag (p_tag varchar2) return smallint
   is
   begin
       if regexp_like( trim(p_tag) ,'(C|П)[0-9]{1,2}$') or trim(p_tag) = 'П'  then
          return 1;
       else
          return 0;
       end if;
   end;

   -----------------------------------------------------------------
   --    VALIDATE_OKPO
   --
   --    Валидировать значение ОКПО
   --
   --    p_okpo     - МФО счета
   --    p_dk       - 0 - ОКПО А,  1-ОКПО Б (для соответсвующего кода ошибки)
   --    return     number error code
   --
   function validate_okpo(p_okpo varchar2, p_dk smallint) return number
   is
      l_int number;
      l_trace        varchar2(1000) := G_TRACE||'validate_okpo: ';
   begin
      begin
         l_int := to_number(p_okpo);
      exception when others then
         bars_audit.error(l_trace||'Ошибка преобразования в число значения: '||p_okpo);
     return (case p_dk when 0 then G_OKPO_NONUMBER_A else G_OKPO_NONUMBER_B end);
      end;

      if length(p_okpo) < 8 and p_okpo<>'99999' then
         bars_audit.error(l_trace||'Длинна ОКПО < 8: '||p_okpo);
     return (case p_dk when 0 then G_OKPO_NOLENGTH_A else G_OKPO_NOLENGTH_B end);
      end if;

      if v_okpo(p_okpo) <> p_okpo then
         bars_audit.error(l_trace||'Ошибка валидации ф-цией v_okpo: '||v_okpo(p_okpo)||' <> '||p_okpo);
     return (case p_dk when 0 then G_OKPO_NOVALID_A else G_OKPO_NOVALID_B end);
      end if;

      return G_OKPO_OK;

   end;

   -----------------------------------------------------------------
   --    GET_PARTICIPANT_DETAILS
   --
   --    По лицевому счету и валюте получить наименование и ОКПО клиента
   --
   --    p_mfo      - МФО счета
   --    p_nls      - лицевой счет
   --    p_kv       - валюта
   --    p_dk       - 0 - сторона А, 1- сторона Б (для соотв. вывода ошибки)
   --    p_force    - 1  - c сообщениями об ошибках, 0- просто подставить найденное значение
   --
   procedure get_participant_details(
           p_mfo   in  varchar2,
           p_nls   in  varchar2,
           p_kv    in  number,
           p_dk    in  number,
           p_force in  number,
           p_nmk   in  out varchar2,
           p_okpo  in  out varchar2
           )
   is
      l_okpochk_code number;
      l_rnk          number;
      l_trace        varchar2(1000) := G_TRACE||'get_participant_details: ';
   begin
      if p_mfo = gl.amfo then
         begin
            select nvl(p_nmk, substr(nvl(p_nmk, nmk),1,38)), nvl(p_okpo, okpo), c.rnk
              into p_nmk, p_okpo, l_rnk
              from customer c, accounts a
             where c.rnk = a.rnk
               and a.nls =  p_nls
               and a.kv = p_kv;

         exception when no_data_found then
            if p_force = 1 then
               bars_error.raise_nerror(G_MODULE, 'NO_ACCOUNT_FOUND', p_nls, to_char(p_kv ));
        end if;
         end;
      else
         begin
            select nvl(p_nmk, substr(nvl(p_nmk, name),1,38)), nvl(p_okpo, okpo)
              into p_nmk, p_okpo
              from alien
         where mfo = p_mfo and nls = p_nls
               and kv = p_kv
               and okpo is not null
               and name is not null
               and rownum = 1;
     exception when no_data_found then
        if p_force = 1 then
           bars_error.raise_nerror(G_MODULE, 'NO_ALIEN_FOUND', to_char(p_mfo), p_nls, to_char(p_kv ));
        end if;
     end;
      end if;

      if p_force = 1 then
         l_okpochk_code := validate_okpo(p_okpo, p_dk);
         bars_audit.trace(l_trace||' Нашли ОКПО='||p_okpo||' Код валидации: '||l_okpochk_code);
         if l_okpochk_code <> 0 then
            if p_mfo = gl.amfo then
           bars_error.raise_nerror(G_MODULE, 'CUST_OKPO_NOTCORRECT',  to_char(l_rnk), p_nls, to_char(p_kv), bars_error.get_error_text(G_MODULE, l_okpochk_code, p_okpo));
        else
           bars_error.raise_nerror(G_MODULE, 'ALIEN_OKPO_NOTCORRECT', p_nls, to_char(p_kv), bars_error.get_error_text(G_MODULE, l_okpochk_code, p_okpo));
        end if;
         end if;
      end if;
--проверка на соответсвие счета клиенту, считанного из файла, проверка по ОКПО клиента
      if p_mfo = gl.amfo then
            begin
                select c.okpo into p_okpo
                  from accounts a,
                       customer c
                 where a.rnk  = c.rnk
                   and c.okpo = p_okpo
                   and a.nls  = p_nls
                   and kv     = p_kv;
            exception when no_data_found then
               if p_force = 1 then
                   bars_error.raise_nerror(G_MODULE, 'CUST_OKPO_NOTCORRECT',  to_char(l_rnk), p_nls, to_char(p_kv));
               end if;
            end;
       end if;
   end;


   -----------------------------------------------------------------
   --    VALIDATE_DOC_FIELDS
   --
   --    Провалидировать часть полей док-та(при импорте) на корректность
   --    Некоторые поля корректируются
   --    При ошибке проверки  - выкидывает исключение
   --
   --    p_impdoc      - структура док-та
   --
   procedure validate_doc_fields(p_impdoc  in out xml_impdocs%rowtype)
   is
      l_trace         varchar2(1000) := G_TRACE||'validate_doc_fields: ';
      l_int           number;
      l_blk           number;
      l_mfo           varchar2(6);
      l_iscashA       smallint;
      l_iscashB       smallint;
      l_okpohk_code   number;
      l_dazs          date;
   begin

      if p_impdoc.s = 0 then
         bars_error.raise_nerror(G_MODULE, 'NULLABLE_SUM');
      end if;


      -- проверка того, что мы можем дебетовать толко счет своего МФО
      if  p_impdoc.dk = 1 then
         if p_impdoc.mfoa <> gl.amfo then
            bars_error.raise_nerror(G_MODULE, 'NOT_OUR_MFO', p_impdoc.mfoa);
         end if;
      else
      if p_impdoc.dk = 0 then
        -- проверим, может мы дебетуем свое нижестоящее МФО - тогда можно
        if p_impdoc.mfob <> gl.amfo then
           begin
              select mfo into l_mfo
            from banks
               where mfop  = gl.kf and mfo  = p_impdoc.mfob and kodn = 6;
           exception when no_data_found then
               bars_error.raise_nerror(G_MODULE, 'NOT_OUR_MFO', p_impdoc.mfob);
           end;
        end if;
         end if;
      end if;


      -- проверка стороны А
      if p_impdoc.mfoa is null then
         bars_error.raise_error(G_MODULE, 68, p_impdoc.nlsa, to_char(p_impdoc.kv ));
      end if;


      if p_impdoc.nlsa is null then
         bars_error.raise_error(G_MODULE, 10);
      end if;

      -- проверка контрольного разряда
      if p_impdoc.nlsa <> vkrzn( substr(p_impdoc.mfoa,1,5), p_impdoc.nlsa ) then
         bars_error.raise_nerror(G_MODULE, 'NOTCORECT_CHECK_DIGIT_A', p_impdoc.nlsa );
      end if;

      -- иногда наименов клиента и его ОКПО отсутствует в импортируемом документе
      if p_impdoc.id_a is null or p_impdoc.nam_a  is null then
         get_participant_details(
           p_mfo   => p_impdoc.mfoa,
           p_nls   => p_impdoc.nlsa,
           p_kv    => p_impdoc.kv,
           p_dk    => 0,
           p_force => 1,
           p_nmk   => p_impdoc.nam_a,
           p_okpo  => p_impdoc.id_a);
      end if;

      begin
         select blk,  mfo into l_blk, p_impdoc.mfoa
         from banks where mfo = p_impdoc.mfoa;
         if l_blk > 0 then
            bars_error.raise_error(G_MODULE, 91, p_impdoc.mfoa);
         end if;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 90, p_impdoc.mfoa);
      end;


      if p_impdoc.mfoa = gl.amfo then
         begin
            select nls, dazs
              into p_impdoc.nlsa, l_dazs
             from accounts where nls = p_impdoc.nlsa and kv = p_impdoc.kv;

            if l_dazs is not null then
               bars_error.raise_nerror(G_MODULE, 'CLOSE_PAYER_ACCOUNT', p_impdoc.nlsa, to_char(p_impdoc.kv));
            end if;


         exception when no_data_found then
            bars_error.raise_error(G_MODULE, 168, p_impdoc.nlsa||'('||p_impdoc.kv||')' );
         end;
      else
         if p_impdoc.nlsa <> vkrzn(substr(p_impdoc.mfoa,1,5), p_impdoc.nlsa) then
            bars_error.raise_error(G_MODULE, 85, p_impdoc.nlsa);
         end if;
      end if;


      p_impdoc.id_a := trim(p_impdoc.id_a);
      l_okpohk_code := validate_okpo(p_impdoc.id_a, 0);
      if l_okpohk_code <> 0 then
         bars_error.raise_error(G_MODULE, l_okpohk_code, p_impdoc.id_a);
      end if;



      -- проверка стороны Б

       if p_impdoc.mfob is null then
          bars_error.raise_error(G_MODULE, 100, p_impdoc.nlsa, to_char(p_impdoc.kv ));
       end if;


       if p_impdoc.kv2 is null then
          bars_error.raise_error(G_MODULE, 23);
       end if;


       if p_impdoc.id_b is null or p_impdoc.nam_b  is null then
         get_participant_details(
           p_mfo   => p_impdoc.mfob,
           p_nls   => p_impdoc.nlsb,
           p_kv    => p_impdoc.kv2,
           p_dk    => 1,
           p_force => 1,
           p_nmk   => p_impdoc.nam_b,
           p_okpo  => p_impdoc.id_b);
     end if;


      if p_impdoc.nlsb is null then
         bars_error.raise_error(G_MODULE, 14);
      end if;

      -- проверка контрольного разряда
      if p_impdoc.nlsb <> vkrzn( substr(p_impdoc.mfob,1,5), p_impdoc.nlsb ) then
         bars_error.raise_nerror(G_MODULE, 'NOTCORECT_CHECK_DIGIT_B', p_impdoc.nlsb );
      end if;

      if p_impdoc.nlsb = p_impdoc.nlsa and p_impdoc.mfoa = p_impdoc.mfob then
         bars_error.raise_error(G_MODULE, 173);
      end if;

      if (p_impdoc.mfoa = p_impdoc.mfob and (p_impdoc.dk = 2  or  p_impdoc.dk = 3)) then
          bars_error.raise_nerror(G_MODULE, 'INNER_INFO_NOTALLOWED');
      end if;


      begin
         select blk,  mfo into l_blk, p_impdoc.mfob
         from banks where mfo = p_impdoc.mfob;
         if l_blk > 0 then
            bars_error.raise_error(G_MODULE, 95, p_impdoc.mfob);
         end if;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 96, p_impdoc.mfob);
      end;


      if p_impdoc.mfob = gl.amfo then
         begin
            select nls, dazs into p_impdoc.nlsb, l_dazs
            from accounts where nls = p_impdoc.nlsb and kv = p_impdoc.kv2;

            if l_dazs is not null then
               bars_error.raise_nerror(G_MODULE, 'CLOSE_PAYEE_ACCOUNT', p_impdoc.nlsa, to_char(p_impdoc.kv));
            end if;



         exception when no_data_found then
            bars_error.raise_error(G_MODULE, 169, p_impdoc.nlsb||'('||p_impdoc.kv2||')' );
         end;
      else
        if p_impdoc.nlsb <> vkrzn(substr(p_impdoc.mfob,1,5), p_impdoc.nlsb) then
           bars_error.raise_error(G_MODULE, 86, p_impdoc.nlsb);
        end if;
      end if;




      p_impdoc.id_b := trim(p_impdoc.id_b);

      l_okpohk_code := validate_okpo(p_impdoc.id_b, 1);
      if l_okpohk_code <> 0 then
         bars_error.raise_error(G_MODULE, l_okpohk_code, p_impdoc.id_b);
      end if;


      begin
         l_int := to_number(p_impdoc.id_b);
      exception when others then
         bars_error.raise_error(G_MODULE, 92, p_impdoc.id_b);
      end;

      if length(p_impdoc.id_b) < 8 and p_impdoc.id_b<>'99999' then
         bars_error.raise_error(G_MODULE, 93, p_impdoc.id_b);
      end if;

      if v_okpo(p_impdoc.id_b) <> p_impdoc.id_b then
         bars_error.raise_error(G_MODULE, 94, p_impdoc.id_b);
      end if;


      -- Общие реквизиты
      if p_impdoc.nd is null then
         bars_error.raise_error(G_MODULE, 6);
      end if;

      if p_impdoc.datd is null then
         --bars_error.raise_error(G_MODULE, 7);
         p_impdoc.datd := gl.bd;
      end if;

      if p_impdoc.vdat is null then
         --bars_error.raise_error(G_MODULE, 7);
         p_impdoc.vdat := gl.bd;
      end if;

      if p_impdoc.s is null then
         bars_error.raise_error(G_MODULE, 16);
      end if;

      if p_impdoc.kv is null then
         bars_error.raise_error(G_MODULE, 17);
      end if;


      if p_impdoc.nazn is null or length(p_impdoc.nazn) < 3 then
         bars_error.raise_error(G_MODULE, 20);
      end if;
      --удалиь все лидирующие, конечные пробелы и непечатные символы
      p_impdoc.nazn := trim(translate(p_impdoc.nazn, G_x00_x1F, rpad(' ',32)));


      if p_impdoc.tt is null then
         bars_error.raise_error(G_MODULE, 21);
      end if;
      if p_impdoc.dk is null then
         bars_error.raise_error(G_MODULE, 22);
      end if;



      bars_audit.trace(l_trace||'sk = '||p_impdoc.sk);


      l_iscashA := is_cash(substr(p_impdoc.nlsa,1,4));
      l_iscashB := is_cash(substr(p_impdoc.nlsb,1,4));

      -- случай,  когда  подкрепление/изъятие банкоомата без дороги (1004-1001(тогда 66) или  1001-1004(тогда 39) )

      -- ( касса - касса)пополнение банкомата
      if l_iscashA = 1 and l_iscashB = 1 then
         if  ( ( substr(p_impdoc.nlsa,1,4) = '1004' and
                 substr(p_impdoc.nlsb,1,4) in ('1001','1002') and
                 p_impdoc.dk = 1
                 ) or
                 (substr(p_impdoc.nlsb,1,4) = '1004' and
                  substr(p_impdoc.nlsa,1,4) in ('1001','1002') and
                  p_impdoc.dk = 0
                 )
             ) and p_impdoc.sk <> 66 then
             bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_CASH66', to_char(p_impdoc.sk));
         end if;

         -- изъятие банкомата
         if  ( (substr(p_impdoc.nlsa,1,4) in ('1001','1002')  and
                 substr(p_impdoc.nlsb,1,4) = '1004' and
                 p_impdoc.dk = 1
                 ) or
                 (substr(p_impdoc.nlsb,1,4) in ('1001','1002')  and
                 substr(p_impdoc.nlsa,1,4) = '1004' and
                 p_impdoc.dk = 0
                 )
             ) and p_impdoc.sk <> 39 then
             bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_CASH39', to_char(p_impdoc.sk));
         end if;
      else
         if (  l_iscashA = 1  and p_impdoc.kv  = 980 )
            or
            (  l_iscashB = 1  and p_impdoc.kv2 = 980) then

            bars_audit.trace(l_trace||'кассовый документ');
            if p_impdoc.sk is null then
               bars_error.raise_error(G_MODULE, 165);
            end if;

            begin
               bars_audit.trace(l_trace||'проверяем наличие СКП');
               select sk into p_impdoc.sk from  sk
                where sk = p_impdoc.sk;
               bars_audit.trace(l_trace||'есть');
               -- прихiд каси
               if ( l_iscashA = 1 and p_impdoc.dk = 1)
                  or
                  ( l_iscashB = 1 and p_impdoc.dk = 0) then

                  if p_impdoc.sk < 2 or p_impdoc.sk > 39 then
                     bars_error.raise_error(G_MODULE, 97, to_char(p_impdoc.sk));
                  end if;
               else
               -- видаток каси
                  if ( l_iscashA = 1  and p_impdoc.dk = 0)
                     or
                     ( l_iscashB = 1  and p_impdoc.dk = 1) then

                     if p_impdoc.sk < 40 or p_impdoc.sk > 73 then
                        bars_error.raise_error(G_MODULE, 98, to_char(p_impdoc.sk));
                     end if;
                  end if;
               end if;

            exception when no_data_found then
               bars_audit.trace(l_trace||'даного ск не сущ');
               bars_error.raise_error(G_MODULE, 84, to_char(p_impdoc.sk));
            end;
         else
            p_impdoc.sk := null;
            --null;
         end if;
      end if;






      if (p_impdoc.kv2 <> p_impdoc.kv ) then
         if p_impdoc.s2 is null then
            bars_error.raise_error(G_MODULE, 24);
         end if;
      end if;



      --проверка на непечатные символы в назначении и наименовании
      if  translate(p_impdoc.nazn, G_x00_x1F, rpad(' ',32)) <> p_impdoc.nazn then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAZN');
      end if;

      if  translate(p_impdoc.nam_a, G_x00_x1F, rpad(' ',32)) <> p_impdoc.nam_a then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAMA');
      end if;

      if  translate(p_impdoc.nam_b, G_x00_x1F, rpad(' ',32)) <> p_impdoc.nam_b then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAMB');
      end if;


   exception when others then
      bars_audit.error(l_trace||'Ошибка при валидации полей док-та №'||p_impdoc.nd);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;

   -----------------------------------------------------------------
   --    VALIDATE_PAY_RIGHTS
   --
   --    Проверить может ли текущий пользователь оплатить данный документ
   --
   --    p_impdoc      - структура док-та
   --
   procedure validate_pay_rights(p_impdoc  in xml_impdocs%rowtype)
   is
      l_nlsdb    varchar2(14);
      l_nlskr    varchar2(14);
      l_nls      varchar2(14);
      l_kvdb     number;
      l_kvkr     number;
      l_mfodb    varchar2(6);
      l_mfokr    varchar2(6);

   begin
      if p_impdoc.dk = 1 then
         l_nlsdb := p_impdoc.nlsa;
         l_kvdb  := p_impdoc.kv;
         l_mfodb := p_impdoc.mfoa;

     l_nlskr := p_impdoc.nlsb;
         l_kvkr  := p_impdoc.kv2;
         l_mfokr := p_impdoc.mfob;
      else
         l_nlsdb := p_impdoc.nlsb;
         l_kvdb  := p_impdoc.kv2;
         l_mfodb := p_impdoc.mfob;

     l_nlskr := p_impdoc.nlsa;
         l_kvkr  := p_impdoc.kv;
         l_mfokr := p_impdoc.mfoa;
      end if;

      if l_mfodb = gl.amfo then
         begin
            null;
         end;
      else
         null;
      end if;

     -- begin
     --    select nls into l_nls
     --     from saldok
     --    where nls =  l_nlskr and l_kvkr = kv;
     -- exception when no_data_found then
     --   bars_error.raise_nerror(G_MODULE, 'NO_KREDIT_RIGHTS', l_nlskr, to_char(l_kvkr));
     -- end;

   end;

   -----------------------------------------------------------------
   --    VALIDATE_DOC_ATTR
   --
   --    Провалидировать доп. реквизиты док-та
   --    Возвращает код ошибки или '0000' если все ОК
   --
   --    p_impref  - реф импортированного докумнета
   --
   --
   procedure  validate_doc_attr(
                  p_impdoc   xml_impdocs%rowtype,
                  p_dreclist bars_xmlklb.array_drec
    )
   is
   begin
      bars_xmlklb.validate_attribs(
                  p_dreclist => p_dreclist    ,
                  p_s        => p_impdoc.s    ,
                  p_s2       => p_impdoc.s2   ,
                  p_kv       => p_impdoc.kv   ,
                  p_kv2      => p_impdoc.kv2  ,
                  p_nlsa     => p_impdoc.nlsa ,
                  p_nlsb     => p_impdoc.nlsb ,
                  p_mfoa     => p_impdoc.mfoa ,
                  p_mfob     => p_impdoc.mfob ,
                  p_tt       => p_impdoc.tt);

   end;


      -----------------------------------------------------------------
   --    INSERT_DOC_TO_OPER
   --
   --    Вставить док-т в oper и в operw
   --
   --    p_impdoc      - структура док-та
   --
   procedure insert_doc_to_oper(
                  p_impdoc    in out xml_impdocs%rowtype,
                  p_creating_date out OPER.PDAT%type,
                  p_ref              number,
                  p_dreclist     bars_xmlklb.array_drec
)
   is
      l_trace     varchar2(1000) := G_TRACE||'insert_doc_to_oper: ';
   begin

      p_creating_date := sysdate;

      gl.in_doc2(
             ref_   =>  p_ref,
             tt_    =>  p_impdoc.tt,
             vob_   =>  p_impdoc.vob,
             nd_    =>  p_impdoc.nd,
             pdat_  =>  p_creating_date, -- дата системная вставки в OPER
             vdat_  =>  p_impdoc.vdat,   -- банковская дата ипорта файла
             dk_    =>  p_impdoc.dk,
             kv_    =>  p_impdoc.kv,
             s_     =>  p_impdoc.s,
             kv2_   =>  p_impdoc.kv2,
             s2_    =>  p_impdoc.s2,
             sq_    =>  0,
             sk_    =>  p_impdoc.sk,
             data_  =>  p_impdoc.datd,   -- дата документа (из файла импорта)
             datp_  =>  p_impdoc.datp,   -- дата прихода в банк (из файла импорта)
             nam_a_ =>  p_impdoc.nam_a,
             nlsa_  =>  p_impdoc.nlsa,
             mfoa_  =>  p_impdoc.mfoa,
             nam_b_ =>  p_impdoc.nam_b,
             nlsb_  =>  p_impdoc.nlsb,
             mfob_  =>  p_impdoc.mfob,
             nazn_  =>  p_impdoc.nazn,
             d_rec_ =>  p_impdoc.d_rec,
             id_a_  =>  p_impdoc.id_a,
             id_b_  =>  p_impdoc.id_b,
             id_o_  =>  null,
             sign_  =>  null,
             sos_   =>  0,
             prty_  =>  0,
             uid_   =>  p_impdoc.userid);


      for i in  0..p_dreclist.count-1 loop
          -- вставка доп. реквизитов
          if ( p_dreclist(i).tag is not null and
               p_dreclist(i).val is not null ) then
             begin
                bars_audit.trace(l_trace||'вставка реквизита <'||p_dreclist(i).tag||'>');
                insert into operw(ref, tag, value)
                values(p_ref, p_dreclist(i).tag, p_dreclist(i).val);
             exception when others then
                case sqlcode
                   when  -02291  then bars_error.raise_error(G_MODULE, 31, p_dreclist(i).tag); -- integrity constraint (BARS.FK_OPERW_OPFIELD) violated - parent key not found
                   when  -1      then bars_error.raise_error(G_MODULE, 62, p_dreclist(i).tag, to_char(p_ref) ); -- unique constraint
                   else raise;
               end case;
             end;
          else
             if  p_dreclist(i).tag is null then
                 bars_error.raise_error(G_MODULE, 32);
             end if;
             if  p_dreclist(i).val is null then
                 if is_bistag( p_dreclist(i).tag ) = 1 then
                    bars_error.raise_error(G_MODULE, 174, p_dreclist(i).tag);
                 else
                    bars_error.raise_error(G_MODULE, 163, p_dreclist(i).tag);
                 end if;
             end if;
          end if;

       end loop;


      if p_impdoc.bis = 1 then
         update oper set bis = p_impdoc.bis where ref = p_ref;
      end if;


      if p_impdoc.fn is not null then
         insert into operw(ref, tag, value)
         values(p_ref, 'IMPFL', p_impdoc.fn);
      end if;

   exception when others then
      bars_audit.error(l_trace||'Ошибка при вставке док-та в OPER док-та №'||p_impdoc.nd);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;

   -----------------------------------------------------------------
   --    GLPAY_DOC
   --
   --    Оплатить док-т кот. только что вставили в oper
   --
   --    p_impdoc      - структура док-та
   --
   procedure glpay_doc(p_impdoc    in out xml_impdocs%rowtype,
                       p_ref   number)
   is
      l_trace         varchar2(1000) := G_TRACE||'glpay_doc: ';
      l_int           number;
      l_blk           number;
      l_sos           smallint;
      l_paymode       number(1); -- как платить(по-факту, по-плану)
   begin

      -- 37 - Оплата по факт.залишку = 1 / По план.залишку = 0 / Не платити = 2
      begin
         select substr(flags,38,1) as flag37
         into   l_paymode from   tts
         where  tt = p_impdoc.tt;
      exception when no_data_found then
         l_paymode   := 0;
      end;


      bars_audit.trace(l_trace||'перед gl.dyntt2');
      gl.dyntt2 (
         sos_   => l_sos,
         mod1_  => l_paymode,
         mod2_  => 1,
         ref_   => p_ref,
         vdat1_ => p_impdoc.vdat,
         vdat2_ => p_impdoc.vdat,
         tt0_   => p_impdoc.tt,
         dk_    => p_impdoc.dk,
         kva_   => p_impdoc.kV,
         mfoa_  => p_impdoc.mfoa,
         nlsa_  => p_impdoc.nlsa,
         sa_    => p_impdoc.s,
         kvb_   => p_impdoc.kv2,
         mfob_  => p_impdoc.mfob,
         nlsb_  => p_impdoc.nlsb,
         sb_    => p_impdoc.s2,
         sq_    => 0,
         nom_   => 0);

   -- установка записи  в oper_list
   chk.put_visa (p_ref, p_impdoc.tt, null, 0, null, null, null);

   exception when others then
      bars_audit.error(l_trace||'ошибка  оплаты док-та:');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;


   -----------------------------------------------------------------
   --    PAY_EXTERN_DOC
   --
   --    Оплатить внешний докумнет
   --    p_doc     - структура документа с доп. реквизитами
   --    p_errcode - исходящий код ошибки
   --    p_errmsg  - исходящее сообщение об ошибке
   --
   --    В поле p_doc.doc.ref - будет находиться реф БАРС-а
   --
   procedure  pay_extern_doc(p_doc     in out t_doc,
                             p_creating_date out OPER.PDAT%type,
                             p_errcode    out number,  -- исходящий код ошибки
                             p_errmsg     out varchar2)  -- исходящее сообщение об ошибке
   is
      l_errcode   xml_impdocs.errcode%type;
      l_errmsg    xml_impdocs.errmsg%type;
      l_dreclist  bars_xmlklb.array_drec;
      l_impdoc    xml_impdocs%rowtype;
      l_ref       number;
      l_trace     varchar2(1000) := G_TRACE||'pay_extern_doc: ';
   begin

      l_impdoc   := p_doc.doc;
      l_dreclist := p_doc.drec;

      -- валидация реквизитов документа
      validate_doc_fields(l_impdoc);

      -- валидация полномочий на совершение оплаты
      validate_pay_rights(l_impdoc);

      -- валидация допреквизитов
      validate_doc_attr(l_impdoc, l_dreclist);

      begin
         savepoint before_pay;

         gl.ref(l_ref);

         insert_doc_to_oper(l_impdoc, p_creating_date, l_ref, l_dreclist);
         if l_impdoc.dk <= 1 then
            glpay_doc(l_impdoc, l_ref);
            bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' оплачен рефом '||l_ref);
         else
            bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' информационный - без оплаты');
         end if;


         p_errcode := G_VALIDATE_OK;
         bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' с рефом '||l_ref);

         p_doc.doc.ref := l_ref;

      exception when others then
         rollback to before_pay;
         raise;
      end;

   exception when others then
      bars_audit.error(l_trace||'Ошибка при оплате док-та с имп.рефом '||l_impdoc.impref);
      bars_audit.error(l_trace||sqlerrm);
      bars_xmlklb.get_process_error(sqlerrm, l_errcode, l_errmsg);
      -- если ошибка прикладная далее exception не выкидывается
      p_errcode := to_number(l_errcode);
      p_errmsg  := l_errmsg;
   end;
   
    function check_cl_id(p_cl_id number) return number is
      l_cnt  number;
    begin
       select 1
         into l_cnt
         from tmp_cl_payment t
        where t.cl_id = p_cl_id;
        return 1;
     exception
       when no_data_found then
          return 0;
    end;
    
    function get_ref(p_cl_id number) return number is
      l_ref number;
    begin
      select t.ref
        into l_ref
        from tmp_cl_payment t
       where t.cl_id = p_cl_id;
       return l_ref;
    end;
    
    procedure ins_cl_paym_id(p_cl_id number) is
      pragma autonomous_transaction;
    begin
      insert into tmp_cl_payment(cl_id)
      values(p_cl_id);
      commit;
    end;
    
    procedure upd_cl_paym(p_cl_id number,
                          p_ref   oper.ref%type) is
    begin
      update tmp_cl_payment t
         set t.ref = p_ref
       where t.cl_id = p_cl_id;
    end;
                          

    procedure create_payment(                               
                            p_date oper.vdat%type default trunc(sysdate),
                            p_vdate oper.vdat%type default trunc(sysdate),
                            p_mfoa oper.mfoa%type,
                            p_mfob oper.mfob%type,
                            p_nlsa oper.nlsa%type,
                            p_nlsb oper.nlsb%type,
                            p_okpoa oper.id_a%type,
                            p_okpob oper.id_b%type,
                            p_kv tabval.lcv%type,
                            p_s oper.s%type,
                            p_nama oper.nam_a%type,
                            p_namb oper.nam_b%type,
                            p_nazn oper.nazn%type,
                            p_sk oper.sk%type,
                            p_dk oper.dk%type default 1,
                            p_vob oper.vob%type default 6,
                            p_drec varchar2 default null,
                            p_nd oper.nd%type default null,
                            p_sign oper.sign%type default null,
                            p_cl_id number default null,
                            p_ref out oper.ref%type,
                            p_creating_date out OPER.PDAT%type,
                            p_errcode out number,
                            p_errmsg out varchar2
                            )
    is
    l_th constant varchar2(100) := 'corplight_pay_api';
    l_errcode number;
    l_errmsg varchar2(4000);
    l_ref number;
    l_tt oper.tt%type;
    l_rec_id sec_audit.rec_id%type;
    l_impdoc    xml_impdocs%rowtype;
    l_doc       t_doc;
    l_dreclist  bars_xmlklb.array_drec;
    l_userid staff.id%type;
    l_branch_acc staff.branch%type;
    l_branch_usr staff.branch%type;
    l_kv tabval.kv%type;
    l_length number;
    l_name operw.tag%type;
    l_val operw.value%type;
    l_tmp varchar2(32767);
    l_str varchar2(32767);

  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.info('corplight_pay_api(input parameters):'||
              ' p_date=>'||to_char(p_date, 'dd.mm.yyyy') ||chr(13)||chr(10)||
              ', p_vdate=>'||to_char(p_vdate, 'dd.mm.yyyy') ||chr(13)||chr(10)||
              ', p_mfoa=>'||p_mfoa||chr(13)||chr(10)||
              ', p_mfob=>'||p_mfob||chr(13)||chr(10)||
              ', p_nlsa=>'||p_nlsa||chr(13)||chr(10)||
              ', p_nlsb=>'||p_nlsb||chr(13)||chr(10)||
              ', p_okpoa=>'||p_okpoa||chr(13)||chr(10)||
              ', p_okpob=>'||p_okpob||chr(13)||chr(10)||
              ', p_kv=>'||p_kv||chr(13)||chr(10)||
              ', p_s=>'||to_char(p_s)||chr(13)||chr(10)||
              ', p_nama=>'||p_nama||chr(13)||chr(10)||
              ', p_namb=>'||p_namb||chr(13)||chr(10)||
              ', p_nazn=>'||p_nazn||chr(13)||chr(10)||
              ', p_sk=>'||to_char(p_sk)||chr(13)||chr(10)||
              ', p_dk=>'||to_char(p_dk)||chr(13)||chr(10)||
              ', p_vob=>'||to_char(p_vob)||chr(13)||chr(10)||
              ', p_drec=>'||p_drec||chr(13)||chr(10)||
              ', p_nd=>'||p_nd||chr(13)||chr(10)||
              ', p_cl_id=>'||p_cl_id||chr(13)||chr(10)||
              ', p_sign=>'||p_sign);
              
    if (check_cl_id(p_cl_id) = 0) then
      ins_cl_paym_id(p_cl_id);
      
          -- точка отката
          savepoint sp_paystart;

          begin
              --валідація дати валютування
              if (GL.BD > p_vdate) then
                  raise_application_error(-20000,
                      'Дата валютування документа менша банківської дати');
              end if;

              l_kv:=get_kv(p_kv);
              begin

                select a.isp,
                       a.branch,
                       s.branch
                  into l_userid,
                       l_branch_acc,
                       l_branch_usr
                  from
                      accounts a,
                      staff$base s
                  where
                      a.nls=case p_dk when 1 then p_nlsa else p_nlsb end
                      and a.kv=l_kv
                      and a.isp=s.id;
                  exception when no_data_found then
                      raise_application_error(-20000, 'Рахунок відправника не знайдено!');
              end;
              -- представляемся отделением
              
              --COBUMMFO-4647 согласно заявки докмент создается в бранче привязки счета. Бранч исполнителя не проверяется(код заккоментирован)
              /*if l_branch_usr = '/' then
                 l_branch_usr := case p_dk when 1 then '/'||p_mfoa||'/' else '/'||p_mfob||'/' end;
              end if;*/

  --            if l_branch_usr like l_branch_acc||'%' then
                 bc.subst_branch(l_branch_acc);
    /*          else
                 bc.subst_branch(l_branch_usr);
              end if;*/


         -- вычисление операции для оплаты документа
         /*l_tt := bars_xmlklb_imp.get_import_operation(
                  p_nlsa => p_nlsa,
                  p_mfoa => p_mfoa,
                  p_nlsb => p_nlsb,
                  p_mfob => p_mfob,
                  p_dk   => p_dk,
                  p_kv   =>get_kv(p_kv));
             bars_audit.trace('%s: l_tt = %s', l_th, l_tt);*/

          select decode(p_mfoa, p_mfob, 'CL1', 'CL2') into l_tt from dual;

/*          select count(1) into l_nls_card
          from MBM_NBS_ACC_TYPES
          where TYPE_ID = 'CARD' and nbs = SUBSTR(p_nlsb,0,4);*/
          

          if (p_mfoa = p_mfob) then
            select * 
              into l_acc
              from accounts a
             where a.nls = p_nlsb;
            if l_acc.tip like 'W4%' then
               l_tt := 'CL5';
            end if;
          end if;

          bars_audit.trace('%s: l_tt = %s', l_th, l_tt);
          
          l_errcode := null;
          l_errmsg := null;
          l_ref := null;
          
          
          
          l_impdoc.nd     := p_nd;
          l_impdoc.ref_a  := null ;
          l_impdoc.impref := null ;
          l_impdoc.datd   := trunc(p_date)  ;
          l_impdoc.vdat   := trunc(p_vdate) ;
          l_impdoc.nam_a  := substr(p_nama, 0, 38);
          l_impdoc.mfoa   := p_mfoa         ;
          l_impdoc.nlsa   := p_nlsa         ;
          l_impdoc.id_a   := p_okpoa        ;
          l_impdoc.nam_b  := substr(p_namb, 0, 38);
          l_impdoc.mfob   := p_mfob         ;
          l_impdoc.nlsb   := p_nlsb         ;
          l_impdoc.id_b   := p_okpob        ;
          l_impdoc.s      := p_s            ;
          l_impdoc.kv     := get_kv(p_kv)   ;
          l_impdoc.s2     := p_s            ;
          l_impdoc.kv2    := get_kv(p_kv)   ;
          l_impdoc.sk     := p_sk           ;
          l_impdoc.dk     := p_dk           ;
          l_impdoc.tt     := l_tt           ;
          l_impdoc.vob    := p_vob          ;
          l_impdoc.nazn   := p_nazn         ;
          l_impdoc.datp   := gl.bdate       ;
          l_impdoc.userid := l_userid       ;

          l_doc.doc  := l_impdoc;
          begin
              if p_drec is not null then
                  l_length := length(p_drec) - length(replace(p_drec,';'));
                  l_str :=p_drec;
                  for i in 0..l_length - 1 loop
                      l_tmp := substr(l_str, 0, instr(l_str,';')-1);
                      l_str := substr(l_str, instr(l_str,';')+1);
                      parse_str(l_tmp,l_name,l_val);
                      l_doc.drec(i).tag := l_name;
                      l_doc.drec(i).val := l_val;
                  end loop;
              end if;
          exception when others then
              raise_application_error(-20000, 'Не коректно сформовано параметр D_REC!');
          end;

          pay_extern_doc( p_doc  => l_doc,
                          p_creating_date => p_creating_date,
                          p_errcode => l_errcode,
                          p_errmsg  => l_errmsg ) ;

          l_ref := l_doc.doc.ref;

          upd_cl_paym(p_cl_id,l_ref);
          p_ref:=to_char(l_ref);
          p_errcode:=l_errcode;
          p_errmsg:=l_errmsg;

          bars_audit.trace('%s: pay_extern_doc done, l_errcode=%s, l_errmsg=%s',
             l_th, to_char(l_errcode), l_errmsg);

         -- возврат контекста
         bc.set_context;
      
          exception when others then
              bars_audit.trace('%s: exception block entry point', l_th);
              bars_audit.trace('%s: error detected sqlerrcode=%s, sqlerrm=%s', l_th, to_char(sqlcode), sqlerrm);
              --eсли exception запишем ошыбку в исх. параметр
              p_errcode:=sqlcode;
              p_errmsg:=substr(sqlerrm,1,4000);
              -- запись полного сообщения об ошибке в журнал
              bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
              dbms_utility.format_error_backtrace(), null, null, l_rec_id);
              -- откат к точке начала оплаты
              rollback to savepoint sp_paystart;
              -- возврат контекста
          bc.set_context;
       end;   
    else 
      bars_audit.info('Дублирующий документ: '|| p_cl_id);
      p_ref := get_ref(p_cl_id);
    end if;
    
    bars_audit.info('corplight_pay_api(output parameters):
              p_ref=>'||to_char(p_ref)||chr(13)||chr(10)||
            ',p_errcode=>'||to_char(p_errcode)||chr(13)||chr(10)||
            ',p_errmsg=>'||p_errmsg);
    bars_audit.trace('%s: done', l_th);
end create_payment;


end mbm_payments;
/
 show err;
 
PROMPT *** Create  grants  MBM_PAYMENTS ***
grant EXECUTE                                                                on MBM_PAYMENTS    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mbm_payments.sql =========*** End **
 PROMPT ===================================================================================== 
 