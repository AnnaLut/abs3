
 
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

  procedure set_auto_visa (p_ref      in number,
                           p_key      in varchar2,
                           p_int_sign in varchar2,
                           p_sep_sign in varchar2);

  procedure set_payment_payed(p_ref oper.ref%type);


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
                            p_attachment number default null,
                            p_ref out oper.ref%type,
                            p_creating_date out OPER.PDAT%type,
                            p_errcode out number,
                            p_errmsg out varchar2
                            );

procedure create_fc_application(
    cl_doc_id                       number, -- идентификатор платежа в системе CorpLight
    p_date                          bars.oper.vdat%type default trunc(sysdate), -- указанная клиентом дата создания
    p_nd                            bars.oper.nd%type default null, -- номер документа

    p_nama                          bars.oper.nam_a%type, -- имя счета отправителя
    p_nlsa                          bars.oper.nlsa%type, -- номер счета отправителя
    p_mfoa                          bars.oper.mfoa%type, -- код банка отправителя (kv)
    p_okpoa                         bars.oper.id_a%type, -- ЕДРПО отправителя

    p_namb                          bars.oper.nam_b%type, -- имя счета получателя
    p_nlsb                          bars.oper.nlsb%type, -- номер счета получателя
    p_mfob                          bars.oper.mfob%type, -- код банка получателя (kf)
    p_okpob                         bars.oper.id_b%type, -- ЕДРПО получателя

    p_nazn                          bars.oper.nazn%type, --назначение заявки

    p_curid                         tabval.lcv%type, -- лат.код валюты которая покупается
    p_curconvid                     tabval.lcv%type, -- лат.код валюты за которую покупается

    p_s                             bars.oper.s%type, -- сумма заявленной валюты (в коп.)
    p_rate                          number default null, -- курс заявки
    p_reqtype                       number, -- тип заявки (1-покупка, 2-продажа, 3-конверсия)
    p_clcdate                       date default trunc(sysdate), -- дата создания заявки в CL
    p_clbanksend                    date default trunc(sysdate), -- дата отправки в банк
    p_clbankreceived                date default trunc(sysdate), -- дата получения банком

    p_contactfio                    varchar2, --контактное лицо
    p_contacttel                    varchar2, --телефон контактного лица
    p_dk                            number   default 1,
    p_signes                        varchar2 default null,
    p_attachment                    number   default null,

    p_zay_id out number,
    p_errcode out number,
    p_errmsg out varchar2
);

procedure create_payment_swift(
    p_doc_id                       number, -- идентификатор платежа в системе CorpLight
    p_date                          bars.oper.vdat%type default trunc(sysdate), -- указанная клиентом дата создания
    p_vdate                         bars.oper.vdat%type default trunc(sysdate), -- указанная дата валютирования
    p_nd                            bars.oper.nd%type default null, -- номер документа
    p_nama                          bars.oper.nam_a%type, -- имя счета отправителя
    p_nlsa                          bars.oper.nlsa%type, -- номер счета отправителя
    p_mfoa                          bars.oper.mfoa%type, -- код банка отправителя (kv)
    p_okpoa                         bars.oper.id_a%type, -- ЕДРПО отправителя
    p_kv                            tabval.kv%type, -- цифровой код валюты
    p_s                             bars.oper.s%type, -- сумма платежа
    p_nazn                          bars.oper.nazn%type, --назначение платежа
    p_sk                            bars.oper.sk%type,
    p_dk                            bars.oper.dk%type default 1, -- дебет/кредит
    p_vob                           bars.oper.vob%type default 1,
    p_sign                          bars.oper.sign%type default null, -- подпись

    p_clcdate                       date default trunc(sysdate), -- дата создания плаежа в CL
    p_clbanksend                    date default trunc(sysdate), -- дата отправки в банк
    p_clbankreceived                date default trunc(sysdate), -- дата получения банком

    p_fnamea                        bars.operw.value%type, -- наименование отправителя
    p_adresa                        bars.operw.value%type, -- местонахождение отправителя
    p_ccodea                        bars.operw.value%type, -- код страны отправителя
    p_sw71a                         bars.operw.value%type, --комиссионные за счет
    p_swiftib                       bars.operw.value%type default null, -- свифт банка-посредника
    p_swiftbb                       bars.operw.value%type, -- свифт банка-бенифициара
    p_coracbb                       bars.operw.value%type, -- корсчет банка-бенифициара
    p_fnameb                        bars.operw.value%type, -- наименование бенифициара
    p_nlsb                          bars.operw.value%type, -- номер счета/ибан бенифициара
    p_adresb                        bars.operw.value%type, -- местонахождение бенифициара
    p_dopreq                        bars.operw.value%type, -- доп реквизиты.инше
    p_signes                        varchar2, -- строка с информацией о подписях
    p_attachment                    number default null,

    p_ref                       out bars.oper.ref%type, -- идентификатор созданного платежа
    p_creating_date             out OPER.PDAT%type, -- дата создания
    p_errcode                   out number, -- код ошибки
    p_errmsg                    out varchar2 -- собщение об ошибке
);

end mbm_payments;
/
CREATE OR REPLACE PACKAGE BODY BARS.MBM_PAYMENTS is

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   g_awk_body_defs constant varchar2(512) := ''
          ||'    - Сбербанк'    || chr(10);

   G_BODY_VERSION    constant varchar2(64) := 'version 13.15 09.08.2018';

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
   procedure  pay_extern_doc(p_doc       in out t_doc,
                             p_auto_visa in number,
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
            if p_auto_visa != 1 then
               glpay_doc(l_impdoc, l_ref);
               bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' оплачен рефом '||l_ref);
            end if;
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

   function trans_value(p_value in varchar2, kv in number) return varchar2 is
    l_value varchar2(200);
begin
    l_value := substr(replace(p_value,'$nl$',chr(13)||chr(10)),1,200);

    -- замена укр. букв на соответствующие латинские (из-за проблем с транслитерацией)
    l_value := replace(l_value, 'і', 'i');
    l_value := replace(l_value, 'І', 'I');

    if kv!=643 then
        l_value := substr(bars.bars_swift.StrToSwift(l_value,'TRANS'),1,200);
    end if;
    return l_value;
end;

procedure add_dop_req(
    p_ref           bars.oper.ref%type,
    p_tag           bars.operw.tag%type,
    p_value         bars.operw.value%type,
    p_s             bars.oper.s%type,
    p_s2            bars.oper.s2%type,
    p_kv            tabval.kv%type,
    p_kv2           tabval.kv%type,
    p_nlsa          bars.oper.nlsa%type,
    p_nlsb          bars.oper.nlsb%type,
    p_mfoa          bars.oper.mfoa%type,
    p_mfob          bars.oper.mfob%type,
    p_tt            bars.oper.tt%type
) is
    l_tag_info      bars.op_field%rowtype;
    l_errmod        bars.err_codes.errmod_code%type;
    l_value         bars.operw.value%type;
    l_result        number;
begin
    begin
        select * into l_tag_info from bars.op_field where tag=p_tag;
    exception when no_data_found then
        bars.bars_error.raise_nerror(l_errmod, 'TAG_NOT_FOUND', p_tag);
    end;
    if l_tag_info.chkr is not null then
        -- проверка доп. реквизита на корректность
        l_result := bars.bars_alien_privs.check_op_field(
            p_tag, p_value,
            p_s, p_s2, p_kv, p_kv2, p_nlsa, p_nlsb, p_mfoa, p_mfob, p_tt
        );
        if l_result=0 then
            bars.bars_error.raise_nerror(l_errmod, 'TAG_INVALID_VALUE', p_tag);
        end if;
    end if;
    l_value := trans_value(p_value,p_kv);
		merge into bars.operw ow
		using (select * from dual)
		on (ow.ref = p_ref and ow.tag = p_tag)
		when matched then
			update set ow.value = l_value
		when not matched then
			insert (ref, tag, value) values (p_ref, p_tag, l_value);
end add_dop_req;


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

    procedure ins_cl_paym_id(p_cl_id number,
                             p_type  number) is
      pragma autonomous_transaction;
    begin
      insert into tmp_cl_payment(cl_id,type)
      values(p_cl_id, p_type);
      commit;
    end;

    procedure upd_cl_paym(p_cl_id       number,
                          p_ref         oper.ref%type,
                          p_is_auto_pay tmp_cl_payment.is_auto_pay%type) is
    begin
      update tmp_cl_payment t
         set t.ref = p_ref,
             t.is_auto_pay = p_is_auto_pay
       where t.cl_id = p_cl_id;
    end;

    function sdo_check_cl_rules(p_nlsa oper.nlsa%type,
                                  p_mfoa oper.mfoa%type,
                                  p_nlsb oper.nlsb%type,
                                  p_mfob oper.mfob%type,
                                  p_s    oper.s%type,
                                  p_nazn oper.nazn%type,
                                  p_id_a oper.id_a%type,
                                  p_id_b oper.id_b%type) return smallint is
    begin

       return sdo_autopay_check_cl(p_nlsa,
                                   p_mfoa,
                                   p_nlsb,
                                   p_mfob,
                                   p_s,
                                   p_nazn,
                                   p_id_a,
                                   p_id_b);
    end;

    procedure set_payment_payed(p_ref oper.ref%type) is
    begin
      update tmp_cl_payment tcp
         set tcp.is_payed = 1
       where tcp.ref = p_ref;
    end;

  ------------------------------------
  -- set_AUTO_VISA
  --
  -- Процедура для автообработки докумнетов корп2 вертушкой
  -- Установка виз с подписями, оплата по-факту
  --
  procedure set_auto_visa (p_ref      in number,
                           p_key      in varchar2,
                           p_int_sign in varchar2,
                           p_sep_sign in varchar2)
  is
     l_doc bars.oper%rowtype;
     l_chk_group    number;
     l_sep_rec      number;
     l_sep_err      number;
     l_seperr_text  varchar2(4000);

     l_bis_count    number;
     l_curr_bis     number;
     l_arc_row      bars.arc_rrp%rowtype;

  begin
     bars.bars_audit.trace('mbm_payments.set_auto_visa: старт формирования подписей и оплаты по-факту для документа REF = '||p_ref);

     select o.* into l_doc from oper o where o.ref = p_ref;

     bc.subst_branch(l_doc.branch);

     -- наложить нулевую подпись только с внутренней визой в oper_visa.sign и ключем корпа
     bars.chk.put_visa( ref_    => p_ref ,
                       tt_     => l_doc.tt,
                       grp_    => null,
                       status_ => 0,
                       keyid_  => p_key,
                       sign1_  => p_int_sign,
                       sign2_  => p_sep_sign);

     bars.bars_audit.trace('mbm_payments.set_auto_visa: первичная виза с внутренней подписью сформирована');

    -- документ внешний, требующий СЕП или ВПС
    if ( l_doc.mfoa <> l_doc.mfob and l_doc.tt = 'CL2') then

       select idchk into l_chk_group
         from bars.chklist_tts
        where priority = 1
          and tt = l_doc.tt;

       -- наложить вторую и последнюю визу но уже с подписью вертушки авто-СДО
       bars.chk.put_visa(ref_    => p_ref ,
                          tt_     => l_doc.tt,
                          grp_    => l_chk_group,
                          status_ => 2,
                          keyid_  => p_key,
                          sign1_  => p_int_sign,
                          sign2_  => p_sep_sign);

       bars.bars_audit.trace('mbm_payments.set_auto_visa: для внешнего докумнета виза с внешней подписью сформирована с группой визировнаия '||l_chk_group);

       -- оплачиваем документ принудительно до состяения "оплачен"

       bars.gl.pay( p_flag => 2,
                    p_ref  => p_ref,
                    p_vdat => l_doc.datp);

       select o.* into l_doc from oper o where o.ref = p_ref;

       -- если удалось оплатить
       if (l_doc.sos = 5 ) then
           bars.sep.in_sep(
                  err_   => l_sep_err,
                  rec_   => l_sep_rec,
                  mfoa_  => l_doc.mfoa,
                  nlsa_  => l_doc.nlsa,
                  mfob_  => l_doc.mfob,
                  nlsb_  => l_doc.nlsb,
                  dk_    => l_doc.dk,
                  s_     => l_doc.s,
                  vob_   => l_doc.vob,
                  nd_    => l_doc.nd,
                  kv_    => l_doc.kv,
                  data_  => l_doc.datd,
                  datp_  => l_doc.datp,
                  nam_a_ => l_doc.nam_a,
                  nam_b_ => l_doc.nam_b,
                  nazn_  => l_doc.nazn,
                  naznk_ => null,
                  nazns_ => case when trim(l_doc.d_rec) is null then  '10' else  '11' end,
                  id_a_  => l_doc.id_a,
                  id_b_  => l_doc.id_b,
                  id_o_  => l_doc.id_o,
                  ref_a_ => l_doc.ref_a,
                  bis_   => 0,
                  sign_  => l_doc.sign,
                  fn_a_  => null,
                  rec_a_ => null,
                  dat_a_ => null,
                  d_rec_ => l_doc.d_rec,
                  otm_i  => 0,
                  ref_i  => p_ref,
                  blk_i  => 0,
                  ref_swt_ => null);
           bars.bars_audit.trace('mbm_payments.set_auto_visa: документ REF = '||p_ref||' успешно оплачен по-факту, l_sep_err=<'||l_sep_err||'>');

           -- если ошибка вставки документа в arc_rrp - откатить всю оплату документа с ошибкой
           --
           if (l_sep_err <> '0') then
              begin
                 select  l_sep_err||': '||n_er into l_seperr_text from bars.s_er where k_er = l_sep_err;
              exception when no_data_found then
                 l_seperr_text := l_sep_err;
              end;
              bars.bars_error.raise_nerror( -2000, 'SDO_AUTO_PAY_INSEP_ERROR', l_seperr_text, p_ref);
           end if;
       else
           bars.bars_audit.trace('mbm_payments.set_auto_visa: при попытке автооплаты СЕП/ВПС документа, документ REF = '||p_ref||' не был оплачен по-факту, sos='||l_doc.sos);
       end if;
   else
       select idchk into l_chk_group
         from bars.chklist_tts
        where priority = 1
          and tt = l_doc.tt;

       -- наложить вторую и последнюю визу но уже с подписью вертушки авто-СДО
       bars.chk.put_visa(ref_    => p_ref ,
                          tt_     => l_doc.tt,
                          grp_    => l_chk_group,
                          status_ => 2,
                          keyid_  => p_key,
                          sign1_  => p_int_sign,
                          sign2_  => p_sep_sign);
       -- оплачиваем документ принудительно до состяения "оплачен"
       bars.gl.pay( p_flag => 2,
                    p_ref  => p_ref,
                    p_vdat => l_doc.datp);
       bars.bars_audit.trace('mbm_payments.set_auto_visa: документ REF = '||p_ref||' успешно оплачен по-факту');

       bc.set_context();

    end if;

    set_payment_payed(p_ref);

    exception when others
       then   bc.set_context();
       raise;

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
                            p_attachment number default null,
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
    l_acc accounts%rowtype;
    l_ser    person.ser%type;
    l_numdoc person.numdoc%type;
    l_is_auto_pay tmp_cl_payment.is_auto_pay%type;
    l_okpo customer.okpo%type;
    l_cnt  number;

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
              ', p_attachment=>'||p_attachment||chr(13)||chr(10)||
              ', p_sign=>'||p_sign);

    if (check_cl_id(p_cl_id) = 0) then
      ins_cl_paym_id(p_cl_id, 1);

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
              
              select count(*)
                into l_cnt
                from bars.accounts a
               where a.nls = p_nlsa
                 and ((a.nbs = 2600 and a.ob22 = 14) 
                   or (a.nbs = 2650 and a.ob22 = 12));
               if l_cnt > 0 then
                 raise_application_error(-20000, ' Счета БПК 2600/14 и 2650/12 заблокированы для списания!!!');
               end if;
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
            /*COBUBB-1480 start*/
            begin

                select *
                  into l_acc
                  from accounts a
                 where a.nls = p_nlsb
                   and a.kv = l_kv;

                select cust.okpo
                  into l_okpo
                  from customer cust
                 where cust.rnk = l_acc.rnk;

                if (l_okpo != p_okpob) then
                      raise_application_error(-20000,
                          'Вказиний ОКПО отримувача не вірний!');
                end if;
             exception when no_data_found  then
                raise_application_error(-20000,
                          'Вказиний рахунок отримувача не вірний!');
             end;
            /*COBUBB-1480 finish*/

            if l_acc.tip like 'W4%' then
               l_tt := 'CL5';
            end if;
          end if;

          bars_audit.trace('%s: l_tt = %s', l_th, l_tt);

          l_errcode := null;
          l_errmsg := null;
          l_ref := null;

          -- Проверка заполнения серии и номера паспорта в карточке клиента
          if (p_okpoa = '0000000000') then
              select p.ser,
                     p.numdoc
                into l_ser,
                     l_numdoc
                from person p,
                     accounts a
               where a.rnk = p.rnk
                 and a.nls = p_nlsa
                 and a.kv = l_kv;
              if (l_ser is null and l_numdoc is null) then
                 raise_application_error(-20000, 'Не заповнені паспортні данні в карточці клієнта!');
              end if;
          end if;

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

          l_is_auto_pay := sdo_check_cl_rules(l_impdoc.nlsa, l_impdoc.mfoa, l_impdoc.nlsb, l_impdoc.mfob, l_impdoc.s, l_impdoc.nazn, l_impdoc.id_a, l_impdoc.id_b);
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
                          p_auto_visa => l_is_auto_pay,
                          p_creating_date => p_creating_date,
                          p_errcode => l_errcode,
                          p_errmsg  => l_errmsg ) ;

          l_ref := l_doc.doc.ref;

          upd_cl_paym(p_cl_id,l_ref,l_is_auto_pay);
          p_ref:=to_char(l_ref);
          p_errcode:=l_errcode;
          p_errmsg:=l_errmsg;

          if p_attachment is not null and l_ref is not null then
            add_dop_req(l_ref, 'ATT_D', to_char(p_attachment),
            p_s, p_s, l_kv, l_kv, p_nlsa, p_nlsb, p_mfoa, p_mfob, l_tt);
          end if;

          if (p_okpoa = '0000000000') and l_ref is not null then
             merge into bars.operw ow
               using (select * from dual)
                  on (ow.ref = l_ref and ow.tag = 'Ф')
                when matched then
              update set ow.value = l_ser||to_char(l_numdoc)
                when not matched then
              insert (ref, tag, value) values (l_ref,'Ф', l_ser||to_char(l_numdoc));
             update oper op
                set op.d_rec = d_rec || '#Ф'||l_ser||to_char(l_numdoc)||'#'
              where op.ref = l_ref;
          end if;

          upd_cl_paym(p_cl_id,l_ref,l_is_auto_pay);
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

procedure create_fc_application(
    cl_doc_id                       number, -- идентификатор платежа в системе CorpLight
    p_date                          bars.oper.vdat%type default trunc(sysdate), -- указанная клиентом дата создания
    p_nd                            bars.oper.nd%type default null, -- номер документа

    p_nama                          bars.oper.nam_a%type, -- имя счета отправителя
    p_nlsa                          bars.oper.nlsa%type, -- номер счета отправителя
    p_mfoa                          bars.oper.mfoa%type, -- код банка отправителя (kv)
    p_okpoa                         bars.oper.id_a%type, -- ЕДРПО отправителя

    p_namb                          bars.oper.nam_b%type, -- имя счета получателя
    p_nlsb                          bars.oper.nlsb%type, -- номер счета получателя
    p_mfob                          bars.oper.mfob%type, -- код банка получателя (kf)
    p_okpob                         bars.oper.id_b%type, -- ЕДРПО получателя

    p_nazn                          bars.oper.nazn%type, --назначение заявки

    p_curid                         tabval.lcv%type, -- лат.код валюты которая покупается
    p_curconvid                     tabval.lcv%type, -- лат.код валюты за которую покупается

    p_s                             bars.oper.s%type, -- сумма заявленной валюты (в коп.)
    p_rate                          number default null, -- курс заявки
    p_reqtype                       number, -- тип заявки (1-покупка, 2-продажа, 3-конверсия)

    p_clcdate                       date default trunc(sysdate), -- дата создания заявки в CL
    p_clbanksend                    date default trunc(sysdate), -- дата отправки в банк
    p_clbankreceived                date default trunc(sysdate), -- дата получения банком

    p_contactfio                    varchar2, --контактное лицо
    p_contacttel                    varchar2, --телефон контактного лица
    p_dk                            number   default 1,
    p_signes                        varchar2 default null, -- строка с информацией о подписях
    p_attachment                    number   default null,

    p_zay_id out number,
    p_errcode out number,
    p_errmsg out varchar2
)
is

    l_title    constant varchar2(61) := 'application_import_cur_exch';
    l_doc      bars.zayavka%rowtype;
    l_payer    accounts%rowtype;
    l_payee    accounts%rowtype;

    l_denom         number;
    l_acc0          bars.zayavka.acc0%type;
    l_acc1          bars.zayavka.acc1%type;
    l_userid        accounts.isp%type;
    l_taxflg   number  := null;

    -- реквизиты внутреннего счета получателя для операций swift
    l_namb     bars.oper.nam_b%type; -- имя счета
    l_nlsb     bars.oper.nlsb%type; -- номер счета
    l_mfob     bars.oper.mfob%type; -- код банка
    l_okpob    bars.oper.id_b%type; -- ЕДРПО

    l_branch varchar2(30) := null;
    l_branch_acc varchar2(30);
    l_branch_usr varchar2(30);

    l_str           varchar2(32767);
    l_length        number;
    l_name          operw.tag%type;
    l_val           operw.value%type;
    l_tmp           varchar2(32767);
begin

      -- точка отката
  bars_audit.trace('%s: entry point', l_title);
  bars_audit.info('corplight_pay_fc-application_api(input parameters):'||
      '  p_date=>'||to_char(p_clcdate, 'dd.mm.yyyy') ||chr(13)||chr(10)||
      ', p_mfoa=>'||p_mfoa||chr(13)||chr(10)||
      ', p_nlsa=>'||p_nlsa||chr(13)||chr(10)||
      ', p_okpoa=>'||p_okpoa||chr(13)||chr(10)||
      ', p_curid=>'||p_curid||chr(13)||chr(10)||
      ', p_s=>'||to_char(p_s)||chr(13)||chr(10)||
      ', p_nama=>'||p_nama||chr(13)||chr(10)||
      ', p_nazn=>'||p_nazn||chr(13)||chr(10)||
      ', p_dk=>'||to_char(p_reqtype)||chr(13)||chr(10)||
      ', p_rate=>'||to_char(p_rate)||chr(13)||chr(10)||
      ', p_clcdate=>'||to_char(p_clcdate, 'dd.mm.yyyy')||chr(13)||chr(10)||
      ', p_clbanksend=>'||to_char(p_clbanksend, 'dd.mm.yyyy')||chr(13)||chr(10)||
      ', p_clbankreceived=>'||to_char(p_clbankreceived, 'dd.mm.yyyy')||chr(13)||chr(10)||
      ', p_mfob=>'||p_mfob||chr(13)||chr(10)||
      ', p_nlsb=>'||p_nlsb||chr(13)||chr(10)||
      ', p_okpob=>'||p_okpob||chr(13)||chr(10)||
      ', p_curconvid=>'||p_curconvid||chr(13)||chr(10)||

      ', p_contactfio=>'||p_contactfio||chr(13)||chr(10)||
      ', p_contacttel=>'||p_contacttel||chr(13)||chr(10)||
      ', p_signes=>'||to_char(p_signes)||chr(13)||chr(10)||

      ', p_nd=>'||p_nd||chr(13)||chr(10));

    if (check_cl_id(cl_doc_id) = 0) then
        ins_cl_paym_id(cl_doc_id, 3);
        l_doc.dk   := p_reqtype;
        l_doc.kv2  := get_kv(p_curid);
        l_doc.kv_conv := get_kv(p_curconvid);
        l_doc.s2 := p_s;

     --   l_doc.dk := p_dk;

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
                a.nls = p_nlsa
                and a.kv = l_doc.kv_conv
                and a.isp=s.id;
            exception when no_data_found then
                raise_application_error(-20000, 'Рахунок відправника не знайдено!');
        end;

        --if l_branch_usr like l_branch_acc||'%' then

           bc.subst_branch(l_branch_acc);
      /*  else
           bc.subst_branch(l_branch_usr);
        end if;*/


        l_doc.nd := p_nd;
        l_doc.fdat := p_clcdate;
        l_doc.kurs_z := p_rate;
        l_doc.skom := null;
        l_doc.basis := p_nazn;

                -- точка отката
                bars_audit.trace('%s: entry point', l_title);
                bars_audit.info('corplight_pay_fc-application_api(input parameters):'||
                    '  p_date=>'||to_char(p_clcdate, 'dd.mm.yyyy') ||chr(13)||chr(10)||
                    ', p_mfoa=>'||p_mfoa||chr(13)||chr(10)||
                    ', p_nlsa=>'||p_nlsa||chr(13)||chr(10)||
                    ', p_okpoa=>'||p_okpoa||chr(13)||chr(10)||
                    ', p_curid=>'||p_curid||chr(13)||chr(10)||
                    ', p_s=>'||to_char(p_s)||chr(13)||chr(10)||
                    ', p_nama=>'||p_nama||chr(13)||chr(10)||
                    ', p_nazn=>'||p_nazn||chr(13)||chr(10)||
                    ', p_dk=>'||to_char(p_reqtype)||chr(13)||chr(10)||
                    ', p_rate=>'||to_char(p_rate)||chr(13)||chr(10)||
                    ', p_clcdate=>'||to_char(p_clcdate, 'dd.mm.yyyy')||chr(13)||chr(10)||
                    ', p_clbanksend=>'||to_char(p_clbanksend, 'dd.mm.yyyy')||chr(13)||chr(10)||
                    ', p_clbankreceived=>'||to_char(p_clbankreceived, 'dd.mm.yyyy')||chr(13)||chr(10)||
                    ', p_mfob=>'||p_mfob||chr(13)||chr(10)||
                    ', p_nlsb=>'||p_nlsb||chr(13)||chr(10)||
                    ', p_okpob=>'||p_okpob||chr(13)||chr(10)||
                    ', p_curconvid=>'||p_curconvid||chr(13)||chr(10)||

                    ', p_contactfio=>'||p_contactfio||chr(13)||chr(10)||
                    ', p_contacttel=>'||p_contacttel||chr(13)||chr(10)||

                    ', p_nd=>'||p_nd||chr(13)||chr(10));


            begin
                -- узнаем делитель валюты (10^dig)
                select denom into l_denom from bars.tabval where kv=l_doc.kv2;
                -- получим сумму и умножим на делитель
          --      l_doc.s2 := p_s*l_denom;
                -- реквизиты плательщика(счет списания)
                l_payer.kf  :=  p_mfoa;
                l_payer.nls :=  p_nlsa;
                l_payer.kv  :=  l_doc.kv_conv;
                -- ищем счет
                begin
                    select * into l_payer from accounts
                    where kf=l_payer.kf and nls=l_payer.nls and kv=l_payer.kv;
                exception when no_data_found then
                    raise_application_error(-20000, 'Рахунок списання не знайдено: kf='||l_payer.kf||', nls='||l_payer.nls||', kv='||l_payer.kv, true);
                end;
                l_payee.kf := p_mfob;
                l_payee.nls := p_nlsb;
                l_payee.kv := l_doc.kv2;

                if l_payee.kf = l_payer.kf then -- счет в нашем банке ? --> ищем счет
                    begin
                        select * into l_payee from accounts
                        where kf=l_payee.kf and nls=l_payee.nls and kv=l_payee.kv;
                    exception when no_data_found then
                        raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payee.kf||', nls='||l_payee.nls||', kv='||l_payee.kv, true);
                    end;

                    if l_doc.dk in (3) then
                        begin
                            select acc into l_acc0 from accounts
                            where kf=l_payer.kf and nls=l_payer.nls and kv=l_doc.kv_conv;
                        exception when no_data_found then
                            raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payer.kf||', nls='||l_payer.nls||', kv='||l_doc.kv_conv, true);
                        end;
                        l_doc.acc0 := l_acc0;
                        ---
                        begin
                            select acc into l_acc1 from accounts
                            where kf=l_payee.kf and nls=l_payee.nls and kv=l_doc.kv2;
                        exception when no_data_found then
                            raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payee.kf||', nls='||l_payee.nls||', kv='||l_doc.kv2, true);
                        end;
                        l_doc.acc1 := l_acc1;

                        l_doc.nls0 := l_payee.nls;
                    elsif l_doc.dk in (4) then
                        begin
                            select acc into l_acc0 from accounts
                            where kf=l_payee.kf and nls=l_payee.nls and kv=l_doc.kv2;
                        exception when no_data_found then
                            raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payee.kf||', nls='||l_payee.nls||', kv='||l_doc.kv2, true);
                        end;
                        l_doc.acc0 := l_acc0;
                        ---
                        begin
                            select acc into l_acc1 from accounts
                            where kf=l_payer.kf and nls=l_payer.nls and kv=l_doc.kv_conv;
                        exception when no_data_found then
                            raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payer.kf||', nls='||l_payer.nls||', kv='||l_doc.kv_conv, true);
                        end;
                        l_doc.acc1 := l_acc1;
                        l_doc.kv2 := get_kv(p_curconvid);
                        l_doc.kv_conv := get_kv(p_curid);
                        l_doc.nls0 := l_payer.nls;
                    else
                        -- внутр.№ счета в нац.вал.
                        l_doc.acc0 := case when l_doc.dk=1 then l_payer.acc else l_payee.acc end;

                        if l_doc.dk=1 then
                            l_doc.nls0 := l_payee.nls;
                        end if;
                    end if;
                    if l_doc.dk = 2 then
                      l_doc.kv2 := get_kv(p_curconvid);
                      l_doc.kv_conv := get_kv(p_curid);
                    end if;
                else
                    -- счет в чужом банке
                    l_doc.nls0 := l_payee.nls;
                    l_doc.mfo0 := l_payee.kf;
                    l_doc.okpo0 := p_okpob;
            end if;

            -- rnk клиента
            l_doc.rnk := l_payer.rnk;
            -- внутр.№ счета в ин.вал.
            ---l_doc.acc1 := case when l_doc.dk=1 then l_payee.acc else l_payer.acc end;
            l_doc.acc1 := case when l_doc.dk=1 then l_payee.acc when l_doc.dk=2 then l_payer.acc when l_doc.dk in (3,4) then l_acc1  end;
            -- код цели покупки/продажи
            l_doc.meta := null;

            /*begin
                 select branch into l_branch from v_accounts where acc = l_doc.acc1;
                 exception when no_data_found then null;
            end;*/

        /*    -- заполняем реквизиты стороны Б, реквизиты внутреннего счета
            if ( l_mfob is null or l_nlsb is null or l_namb is null or l_okpob is null or l_biccode is null) then
                -- вычитать параметры свифтовых операций если раньше они не вычитывались
                select val into l_mfob from bars.params where par='C2SW.BNK';
                select val into l_nlsb from bars.params where par='C2SW.NLS';
                select val into l_namb from bars.params where par='C2SW.NAM';
                select val into l_okpob from bars.params where par='C2SW.COD';
                select val into l_biccode from bars.params where par='BICCODE';
            end if;*/

            l_taxflg := 0;

            if l_doc.dk = 1 then
                l_taxflg := 1;
            end if;

            bars.bars_zay.create_request
               (p_reqtype       => l_doc.dk,                            -- тип заявки (1-покупка, 2 -продажа)
                p_custid        => l_doc.rnk,                           -- регистр.№ клиента
                p_curid         => l_doc.kv2,                           -- числ.код валюты которая покупается
                p_curconvid     => l_doc.kv_conv,                       -- числ.код валюты за которую покупается
                p_amount        => l_doc.s2,                            -- сумма заявленной валюты (в коп.)
                p_reqnum        => l_doc.nd,                            -- номер заявки (номер документа)
                p_reqdate       => trunc(l_doc.fdat),                   -- дата заявки
                p_reqrate       => l_doc.kurs_z,                        -- курс заявки
                p_frxaccid      => l_doc.acc1,                          -- внутр.№ счета в ин.вал.
                p_nataccid      => l_doc.acc0,                          -- внутр.№ счета в нац.вал.
                p_nataccnum     => l_doc.nls0,                          -- счет в нац.валюте в др.банке     (для dk = 2)
                p_natbnkmfo     => l_doc.mfo0,                          -- МФО банка счета в нац.валюте     (для dk = 2)
                p_okpo0         => l_doc.okpo0,                         -- ОКПО для зачисления грн на м/б при продаже (для dk = 2)
                p_cmssum        => l_doc.skom,                          -- фикс.сумма комиссии
                p_taxflg        => l_taxflg,                            -- BRSMAIN-2598 признак отчисления в ПФ (для dk = 1)
                p_aimid         => l_doc.meta,                          -- код цели покупки/продажи
                --p_contractid    => l_doc.pid,                         -- идентификатор контракта
                --p_contractnum   => l_doc.contract,                    -- номер контракта/кред.договора
                --p_contractdat   => l_doc.dat2_vmd,                    -- дата контракта/кред.договора
                --p_custdeclnum   => l_doc.num_vmd,                     -- номер последней тамож.декларации
                --p_custdecldat   => dat_vmd,                           -- дата последней тамож.декларации
                --p_prevdecldat   => dat5_vmd,                          -- даты предыдущ.тамож.деклараций    (для dk = 1)
                p_countryid     => l_doc.country,                             -- код страны перечисления валюты    (для dk = 1)
                p_details       => l_doc.basis,                               -- причина покупки
                p_contactfio    => p_contactfio,                        -- контактное лицо
                p_contacttel    => p_contacttel,                        -- телефон контактного лица
                p_branch        => l_branch_acc,                            -- отделение
                p_identkb       => -2,
                p_reqid         => l_doc.id);                           -- идентификатор заявки

            if p_attachment is not null then
              update zayavka z
                 set z.attachments_count = p_attachment
               where z.id = l_doc.id;
            end if;

            begin
                if p_signes is not null then
                    l_length := length(p_signes) - length(replace(p_signes,';'));
                    l_str :=p_signes;
                    for i in 0..l_length - 1 loop
                        l_tmp := substr(l_str, 0, instr(l_str,';')-1);
                        l_str := substr(l_str, instr(l_str,';')+1);
                        parse_str(l_tmp,l_name,l_val);
                        if l_name = 'CLV01' then
                          update zayavka z
                             set z.cl_person1 = l_val
                           where z.id = l_doc.id;
                        elsif l_name = 'CLV02' then
                          update zayavka z
                             set z.cl_person2 = l_val
                           where z.id = l_doc.id;
                        end if;
                    end loop;
                end if;
            exception when others then
                raise_application_error(-20000, 'Не коректно сформовано параметр P_SIGNES!');
            end;


            logger.trace('%s: finish', l_title);
            upd_cl_paym(cl_doc_id, l_doc.id, 0);
            p_zay_id := l_doc.id;
            -- возвращаемся в свой контекст для мульти-мфо
            bc.set_context;

            exception when others then
                bars_audit.trace('%s: exception block entry point', l_title);
                bars_audit.trace('%s: error detected sqlerrcode=%s, sqlerrm=%s', l_title, to_char(sqlcode), sqlerrm);
                --eсли exception запишем ошыбку в исх. параметр
                p_errcode:=sqlcode;
                p_errmsg:=substr(sqlerrm,1,4000);
                -- запись полного сообщения об ошибке в журнал
                bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
                dbms_utility.format_error_backtrace(), null, null, l_doc.id);
                -- откат к точке начала оплаты
         --       rollback to savepoint sp_paystart;
                -- возврат контекста
                bc.set_context;
            end;
    else
      bars_audit.info('Дублирующий документ: '|| cl_doc_id);
      p_zay_id := get_ref(cl_doc_id);
    end if;

    bars_audit.info('corplight_create_fc_application_api(output parameters):
            p_ref=>'||to_char(l_doc.id)||chr(13)||chr(10)||
            ',p_errcode=>'||to_char(p_errcode)||chr(13)||chr(10)||
            ',p_errmsg=>'||p_errmsg);

    bars_audit.trace('%s: done', l_doc.id);

end create_fc_application;

function get_lcv(p_kv tabval.kv%type) return tabval.lcv%type
is
    l_lcv tabval.lcv%type;
begin
    begin
        select lcv into l_lcv
        from tabval where kv = p_kv;
    exception when no_data_found then
        raise_application_error(-20000, 'Недопустимый код валюты '||p_kv);
    end;

    return l_lcv;
end;

-----------------------------------
  -- GET_BIS_COUNT
  --
  -- Проверить наличие бис строк
  --
  function get_bis_count(p_ref      in number) return number
  is
     l_cnt number;
  begin
     select count(*) into l_cnt
                 from bars.operw w, bars.op_field v
                where w.ref = p_ref
                  and w.tag = v.tag
                  and v.vspo_char in ('F','П','C')
                order by v.vspo_char,w.tag;
     return l_cnt;
  end;

-- процедура создания swift платежа
procedure create_payment_swift(
    p_doc_id                       number, -- идентификатор платежа в системе CorpLight
    p_date                          bars.oper.vdat%type default trunc(sysdate), -- указанная клиентом дата создания
    p_vdate                         bars.oper.vdat%type default trunc(sysdate), -- указанная дата валютирования
    p_nd                            bars.oper.nd%type default null, -- номер документа
    p_nama                          bars.oper.nam_a%type, -- имя счета отправителя
    p_nlsa                          bars.oper.nlsa%type, -- номер счета отправителя
    p_mfoa                          bars.oper.mfoa%type, -- код банка отправителя (kv)
    p_okpoa                         bars.oper.id_a%type, -- ЕДРПО отправителя
    p_kv                            tabval.kv%type, -- цифровой код валюты
    p_s                             bars.oper.s%type, -- сумма платежа
    p_nazn                          bars.oper.nazn%type, --назначение платежа
    p_sk                            bars.oper.sk%type,
    p_dk                            bars.oper.dk%type default 1, -- дебет/кредит
    p_vob                           bars.oper.vob%type default 1,
    p_sign                          bars.oper.sign%type default null, -- подпись

    p_clcdate                       date default trunc(sysdate), -- дата создания плаежа в CL
    p_clbanksend                    date default trunc(sysdate), -- дата отправки в банк
    p_clbankreceived                date default trunc(sysdate), -- дата получения банком

    p_fnamea                        bars.operw.value%type, -- наименование отправителя
    p_adresa                        bars.operw.value%type, -- местонахождение отправителя
    p_ccodea                        bars.operw.value%type, -- код страны отправителя
    p_sw71a                         bars.operw.value%type, --комиссионные за счет
    p_swiftib                       bars.operw.value%type default null, -- свифт банка-посредника
    p_swiftbb                       bars.operw.value%type, -- свифт банка-бенифициара
    p_coracbb                       bars.operw.value%type, -- корсчет банка-бенифициара
    p_fnameb                        bars.operw.value%type, -- наименование бенифициара
    p_nlsb                          bars.operw.value%type, -- номер счета/ибан бенифициара
    p_adresb                        bars.operw.value%type, -- местонахождение бенифициара
    p_dopreq                        bars.operw.value%type, -- доп реквизиты.инше
    p_signes                        varchar2, -- строка с информацией о подписях
    p_attachment                    number default null,

    p_ref                       out bars.oper.ref%type, -- идентификатор созданного платежа
    p_creating_date             out OPER.PDAT%type, -- дата создания
    p_errcode                   out number, -- код ошибки
    p_errmsg                    out varchar2 -- собщение об ошибке
)
is
    l_th constant varchar2(100) := 'corplight_pay_swift_api';

    l_name          operw.tag%type;
    l_val           operw.value%type;
    l_tmp           varchar2(32767);
    l_str           varchar2(32767);
    l_length        number;
    l_dreclist      bars_xmlklb.array_drec;

    l_ref           bars.oper.ref%type;
    l_errcode       number;
    l_errmsg        varchar2(4000);
    l_errmod        bars.err_codes.errmod_code%type;

    l_userid        bars.staff$base.id%type; -- идентификатор исполнителя
    l_tt            bars.oper.tt%type; -- код операции

    l_blank_id_code varchar2(10) := '0000000000';
    l_sideA_tag     bars.operw.tag%type := 'Ф';
    l_blank_ser     varchar2(100);
    l_blank_num     varchar2(100);

    l_branch        varchar2(30);
    l_branch_isp    varchar2(30);

    l_cnt           number;

    l_tt_row        bars.tts%rowtype;
    l_d_rec         bars.oper.d_rec%type;
    l_needless      number;

    -- реквизиты внутреннего счета получателя для операций swift
    l_namb          bars.oper.nam_b%type; -- имя счета
    l_nlsb          bars.oper.nlsb%type; -- номер счета
    l_mfob          bars.oper.mfob%type; -- код банка
    l_okpob         bars.oper.id_b%type; -- ЕДРПО

    l_biccode       bars.params.par%type;
    l_sq            integer;

    l_lcv           tabval.lcv%type; -- символьный код валюты

    l_paymode       number(1); -- как платить(по-факту, по-плану)
    l_sos           smallint;

begin

    -- точка отката
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.info('corplight_pay_swift_api(input parameters):'||
        ' p_doc_id=>'||to_char(p_doc_id)||chr(13)||chr(10)||
        ', p_date=>'||to_char(p_date, 'dd.mm.yyyy') ||chr(13)||chr(10)||
        ', p_vdate=>'||to_char(p_vdate, 'dd.mm.yyyy') ||chr(13)||chr(10)||
        ', p_nd=>'||p_nd||chr(13)||chr(10)||
        ', p_nama=>'||p_nama||chr(13)||chr(10)||
        ', p_nlsa=>'||p_nlsa||chr(13)||chr(10)||
        ', p_mfoa=>'||p_mfoa||chr(13)||chr(10)||
        ', p_okpoa=>'||p_okpoa||chr(13)||chr(10)||
        ', p_kv=>'||p_kv||chr(13)||chr(10)||
        ', p_s=>'||to_char(p_s)||chr(13)||chr(10)||
        ', p_nazn=>'||p_nazn||chr(13)||chr(10)||
        ', p_sk=>'||to_char(p_sk)||chr(13)||chr(10)||
        ', p_dk=>'||to_char(p_dk)||chr(13)||chr(10)||
        ', p_vob=>'||to_char(p_vob)||chr(13)||chr(10)||
        ', p_sign=>'||to_char(p_sign)||chr(13)||chr(10)||
        ', p_clcdate=>'||to_char(p_clcdate, 'dd.mm.yyyy')||chr(13)||chr(10)||
        ', p_clbanksend=>'||to_char(p_clbanksend, 'dd.mm.yyyy')||chr(13)||chr(10)||
        ', p_clbankreceived=>'||to_char(p_clbankreceived, 'dd.mm.yyyy')||chr(13)||chr(10)||
        ', p_fnamea=>'||to_char(p_fnamea)||chr(13)||chr(10)||
        ', p_adresa=>'||to_char(p_adresa)||chr(13)||chr(10)||
        ', p_ccodea=>'||to_char(p_ccodea)||chr(13)||chr(10)||
        ', p_sw71a=>'||to_char(p_sw71a)||chr(13)||chr(10)||
        ', p_swiftib=>'||to_char(p_swiftib)||chr(13)||chr(10)||
        ', p_swiftbb=>'||to_char(p_swiftbb)||chr(13)||chr(10)||
        ', p_coracbb=>'||to_char(p_coracbb)||chr(13)||chr(10)||
        ', p_fnameb=>'||to_char(p_fnameb)||chr(13)||chr(10)||
        ', p_nlsb=>'||to_char(p_nlsb)||chr(13)||chr(10)||
        ', p_adresb=>'||to_char(p_adresb)||chr(13)||chr(10)||
        ', p_dopreq=>'||to_char(p_dopreq)||chr(13)||chr(10)||
        ', p_signes=>'||to_char(p_signes)||chr(13)||chr(10)||
        ', p_attachment=>'||to_char(p_attachment)||chr(13)||chr(10));

  if (check_cl_id(p_doc_id) = 0) then
        ins_cl_paym_id(p_doc_id, 2);
    savepoint sp_paystart;

        begin

            -- перевірка дати валютування
            if (GL.BD > p_vdate) then
                raise_application_error(-20000,
                    'Дата валютування документа менша банківської дати');
            end if;

            l_lcv :=get_lcv(p_kv);

            -- ММФО: встановлюємо МФО з якого отримано документ
            if sys_context('bars_context','user_mfo') <> p_mfoa then
                bars.bars_context.subst_mfo(p_mfoa);
            end if;

            -- и другие общие параметры
            begin
                select isp into l_userid from accounts
                where kf=p_mfoa and nls=p_nlsa and kv=p_kv;
                if l_userid is null then
                    raise_application_error(-20000, 'Караул! Рахунок без виконавця: kf='||p_mfoa||', nls='||p_nlsa||', kv='||p_kv, true);
                end if;
            exception when no_data_found then
                raise_application_error(-20000, 'Рахунок платника не знайдено: kf='||p_mfoa||', nls='||p_nlsa||', kv='||p_kv, true);
            end;
            -- ищем пользователя, которому могли делегировать права исполнителя
            begin
                select st.id_who
                into l_userid
                from bars.staff_substitute st
                where st.id_whom = l_userid
                and bars.date_is_valid(st.date_start, st.date_finish, null, null)=1;
            exception
                when no_data_found then
                    null;
                when too_many_rows then
                    raise_application_error(-20000, 'Невизначена ситуація: права делеговано кільком користувачам.');
            end;

            -- после определения исполнителя, залогинится бранчом
            select branch into l_branch from bars.accounts
            where nls = p_nlsa and kv = p_kv and kf = p_mfoa;

            -- Ищем бранч пользователя-операциониста
            -- Для пользователя на '/' будет подставляться МФО плательщика
         --   select case when branch='/' then '/'||p_mfoa||'/' else branch end into l_branch_isp from bars.staff$base where id=l_userid;

            -- Если только бранч пользователя не выше чем счета
         --   if l_branch_isp like l_branch||'%' then
                -- представимся текущим отделением плательщика
                bars.bars_context.subst_branch(l_branch);
          /*  else
                -- представимся текущим отделением исполнителя
                bars.bars_context.subst_branch(l_branch_isp);
            end if;*/


            case p_sw71a
              when ('BEN') then
                l_tt        := 'CLB'; -- TODO CL oper types
              when ('OUR') then
                l_tt        := 'CL0'; -- TODO CL oper types
              when ('SHA') then
                l_tt        := 'CLS'; -- TODO CL oper types
            end case;

            -- проверка: операция d.tt существует ?
            begin
                select count(*) into l_cnt from bars.tts where tt=l_tt;
                if l_cnt = 0 then
                    bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_DOES_NOT_EXIST', l_tt);
                end if;
            end;
            -- проверка: пользователю разрешена операция d.tt ?
         /*    begin
                select count(*) into l_cnt from bars.tts t, bars.staff_tts s
                where t.tt=l_tt and t.tt=s.tt and t.fli<3 and substr(flags,1,1)='1'
                        and s.id in (select l_userid from dual
                                    union all
                                    select id_whom from bars.staff_substitute where id_who=l_userid
                                    and bars.date_is_valid(date_start, date_finish, null, null)=1
                                    )
                        and rownum=1;
                if l_cnt =0 then
                    bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_NOT_ALLOWED', l_tt);
                end if;
            end; */


            bars_audit.trace('%s: l_tt = %s', l_th, l_tt);

            -- заполняем реквизиты стороны Б
            if ( l_mfob is null or l_nlsb is null or l_namb is null or l_okpob is null or l_biccode is null) then
                -- вычитать параметры свифтовых операций если раньше они не вычитывались
                select val into l_mfob from bars.params where par='C2SW.BNK';
                select val into l_nlsb from bars.params where par='C2SW.NLS';
                select val into l_namb from bars.params where par='C2SW.NAM';
                select val into l_okpob from bars.params where par='C2SW.COD';
                select val into l_biccode from bars.params where par='BICCODE';
            end if;

            -- обрабатываем ид.код получателя 10 нулей - строна A
            if p_okpoa = l_blank_id_code then
                begin
                    select p.ser, p.numdoc into l_blank_ser, l_blank_num
                    from
                        bars.person p,
                        bars.customer c,
                        accounts a
                    where
                        c.rnk=a.rnk
                        and p.rnk=c.rnk
                        and a.kf=p_mfoa
                        and a.nls=p_nlsa
                        and a.kv=p_kv;
                exception when no_data_found then
                    raise_application_error(-20000, 'Для власника рахунку '||p_nlsa||'('||p_kv||') не знайдено паспортних данних', true);
                end;
                if (l_blank_ser is null or l_blank_num is null) then
                    raise_application_error(-20000, 'Для власника рахунку '||p_nlsa||'('||p_kv||') не вказано серію та номер паспорту', true);
                end if;
            end if;

            begin
                if p_signes is not null then
                    l_length := length(p_signes) - length(replace(p_signes,';'));
                    l_str :=p_signes;
                    for i in 0..l_length - 1 loop
                        l_tmp := substr(l_str, 0, instr(l_str,';')-1);
                        l_str := substr(l_str, instr(l_str,';')+1);
                        parse_str(l_tmp,l_name,l_val);
                        l_dreclist(i).tag := l_name;
                        l_dreclist(i).val := l_val;
                    end loop;
                end if;
            exception when others then
                raise_application_error(-20000, 'Не коректно сформовано параметр P_SIGNES!');
            end;


           /*  if not is_bankdate_open() then
                bars.bars_audit.trace('Банковский день закрыт, оплата невозможна');
                return;
            end if; */

            bars.gl.ref(l_ref);

            l_sq := case
                when p_kv=bars.gl.baseval then null
                else bars.gl.p_icurval(p_kv, p_s, GL.BD)
                end;

            p_creating_date := sysdate;

            bars.gl.in_doc2(
                ref_    => l_ref,
                tt_     => l_tt,
                vob_    => p_vob,
                nd_     => p_nd,
                pdat_   => p_creating_date,
                vdat_   => p_vdate,
                dk_     => p_dk,
                kv_     => p_kv,
                s_      => p_s,
                kv2_    => p_kv, --
                s2_     => p_s, --
                sq_     => l_sq,
                sk_     => p_sk,
                data_   => trunc(p_date),
                datp_   => trunc(p_clbanksend),
                nam_a_  => p_nama,
                nlsa_   => p_nlsa,
                mfoa_   => p_mfoa,
                nam_b_  => l_namb,
                nlsb_   => l_nlsb,
                mfob_   => l_mfob,
                nazn_   => p_nazn,
                d_rec_  => null,
                id_a_   => p_okpoa,
                id_b_   => l_okpob,
                id_o_   => null,
                sign_   => null,
                sos_    => 0,
                prty_   => 0,
                uid_    => l_userid
            );


            add_dop_req(l_ref, 'EXREF', to_char(p_doc_id),
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            add_dop_req(l_ref, 'f', 'MT 103',
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            add_dop_req(l_ref, 'NOS_A', '0',
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            if (p_sw71a = 'BEN') then
                add_dop_req(l_ref, '33B', l_lcv || trim(to_char(p_s,'99999999999,99')),
                    p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
                add_dop_req(l_ref, '71F', l_lcv || '0,',
                    p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            end if;
            add_dop_req(l_ref, case when p_kv = 840 then '50F'
                                    when p_kv = 978 then '50F'
                                    else '50K' end,
                '/'||p_nlsa||'$nl$1/'
                   ||substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_fnamea,'TRANS') else p_fnamea end,1,32)||'$nl$2/'
                   ||substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_adresa,'TRANS') else p_adresa end,1,32)||'$nl$3/'
                   ||substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(upper(p_ccodea),'TRANS') else upper(p_ccodea) end ,1,32),
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            add_dop_req(l_ref, '52A', l_biccode,
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            if (p_swiftib is not null and length(trim(p_swiftib)) > 0) then
                add_dop_req(l_ref, '56A', p_swiftib,
                    p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            end if;
            add_dop_req(l_ref, '57A', case when p_coracbb is null then p_swiftbb else
                '/'|| p_coracbb || '$nl$' || p_swiftbb end,
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
         
            add_dop_req(l_ref, '59',
                   case when substr(p_nlsb,1,1) = '/' then substr(upper(p_nlsb),1,32)||'$nl$'
                                                      else '/'||substr(upper(p_nlsb),1,32)||'$nl$' end
                   ||substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_fnameb,'TRANS') else p_fnameb end,1,32)||'$nl$'
                   ||case when length(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_fnameb,'TRANS') else p_fnameb end)>32 then substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_fnameb,'TRANS') else p_fnameb end,33,32)||'$nl$' else '' end 
                   ||substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_adresb,'TRANS') else p_adresb end,1,32)||'$nl$'
                   ||case when length(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_adresb,'TRANS') else p_adresb end)>32 then substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_adresb,'TRANS') else p_adresb end,33,32) else '' end,
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
                
            add_dop_req(l_ref, '70', 
            
            case when p_kv=643 then 
            trim(substr(p_nazn,1,34)||case when substr(p_nazn,35,34) is not null then '$nl$' else '' end  ||substr(p_nazn,35,34)||
            case when substr(p_nazn,69,34) is not null then  '$nl$' else '' end ||substr(p_nazn,69,34)||
            case when substr(p_nazn,102,34) is not null then '$nl$' else '' end||substr(p_nazn,102,34))
            else 
            trim(substr(bars.bars_swift.StrToSwift(p_nazn,'TRANS'),1,34)||case when substr(bars.bars_swift.StrToSwift(p_nazn,'TRANS'),35,34) is not null then '$nl$' else '' end  ||substr(bars.bars_swift.StrToSwift(p_nazn,'TRANS'),35,34)||
            case when substr(bars.bars_swift.StrToSwift(p_nazn,'TRANS'),69,34) is not null then  '$nl$' else '' end ||substr(bars.bars_swift.StrToSwift(p_nazn,'TRANS'),69,34)||
            case when substr(bars.bars_swift.StrToSwift(p_nazn,'TRANS'),102,34) is not null then '$nl$' else '' end||substr(bars.bars_swift.StrToSwift(p_nazn,'TRANS'),102,34)) 
            end,
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
                
            add_dop_req(l_ref, '71A', substr(p_sw71a,1,34),
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
                
            add_dop_req(l_ref, '72', substr(case when p_kv!=643 then bars.bars_swift.StrToSwift(p_dopreq,'TRANS') else p_dopreq end,1,32),
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);

            if (l_blank_ser is not null and l_blank_num is not null) then
                add_dop_req(l_ref, l_sideA_tag, 'серія ' || l_blank_ser || ' номер ' || l_blank_num,
                    p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            end if;

            for i in  0..l_dreclist.count-1 loop
                add_dop_req(l_ref, l_dreclist(i).tag, l_dreclist(i).val,
                    p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            end loop;


            add_dop_req(l_ref, 'IBTIM', to_char(p_clcdate, 'DD.MM.YYYY HH24:MI:SS'),
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            add_dop_req(l_ref, 'IBTSB', to_char(p_clbanksend, 'DD.MM.YYYY HH24:MI:SS'),
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            add_dop_req(l_ref, 'IBTRB', to_char(p_clbankreceived, 'DD.MM.YYYY HH24:MI:SS'),
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);

            if p_attachment is not null then
              add_dop_req(l_ref, 'ATT_D', p_attachment,
                p_s,p_s,p_kv,p_kv,p_nlsa,l_nlsb,p_mfoa, l_mfob, l_tt);
            end if;


        -- 37 - Оплата по факт.залишку = 1 / По план.залишку = 0 / Не платити = 2
          begin
             select substr(flags,38,1) as flag37
             into   l_paymode from   tts
             where  tt = l_tt;
          exception when no_data_found then
             l_paymode   := 0;
          end;

        if get_bis_count(l_ref) > 0 then
           update bars.oper set bis = 1
           where ref=l_ref;
           bars.bars_audit.trace('bars_docsync.post_document: найдены бис строки');
        end if;

        -- проверка: операция d.tt существует ?
        begin
            select * into l_tt_row from bars.tts where tt=l_tt;
        exception when no_data_found then
            bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_DOES_NOT_EXIST', l_tt);
        end;

        bars.bars_audit.trace('bars_docsync.post_document: старт формирования доп. реквизитов в СЕП');
        -- формируем доп. реквизиты в СЭП
        if l_tt_row.fli=1 then
            l_d_rec := '';
            for s in (select w.tag, w.value, f.vspo_char
                        from bars.operw w, bars.op_field f
                        where w.ref = l_ref
                          and w.tag = f.tag
                          and f.vspo_char is not null
                          and f.vspo_char not in ('F','C','П')
                      )
            loop
                -- тип сообщения  SWIFT
                if s.vspo_char = 'f' and p_mfoa = '300465' then continue;
                end if;

                l_d_rec := l_d_rec || '#'||s.vspo_char||s.value;
            end loop;

            if l_d_rec is not null and length(l_d_rec)>0 then
                l_d_rec := l_d_rec || '#';
            end if;
            update bars.oper set d_rec = l_d_rec where ref=l_ref;
        end if;

        -- контроль: наличие обязательных доп. реквизитов
        for c in (select * from bars.op_rules where tt=l_tt and opt='M') loop
            begin
                select ref into l_needless from bars.operw where ref=l_ref and tag=c.tag;
            exception when no_data_found then
                bars.bars_error.raise_nerror(l_errmod, 'MANDATORY_TAG_ABSENT', c.tag, l_tt);
            end;
        end loop;


          bars_audit.trace('перед gl.dyntt2');

          gl.dyntt2 (
             sos_   => l_sos,
             mod1_  => l_paymode,
             mod2_  => 1,
             ref_   => l_ref,
             vdat1_ => p_vdate,
             vdat2_ => p_vdate,
             tt0_   => l_tt,
             dk_    => p_dk,
             kva_   => p_kV,
             mfoa_  => p_mfoa,
             nlsa_  => p_nlsa,
             sa_    => p_s,
             kvb_   => p_kv,
             mfob_  => l_mfob,
             nlsb_  => l_nlsb,
             sb_    => p_s,
             sq_    => 0,
             nom_   => 0);

              -- установка записи  в oper_list
            chk.put_visa (l_ref, l_tt, null, 0, null, null, null);
            upd_cl_paym(p_doc_id, l_ref, 0);
            p_ref:=to_char(l_ref);

            -- возвращаемся в свой контекст для мульти-мфо
            bc.set_context;

        exception when others then
            bars_audit.trace('%s: exception block entry point', l_th);
            bars_audit.trace('%s: error detected sqlerrcode=%s, sqlerrm=%s', l_th, to_char(sqlcode), sqlerrm);
            --eсли exception запишем ошыбку в исх. параметр
            p_errcode:=sqlcode;
            p_errmsg:=substr(sqlerrm,1,4000);
            -- запись полного сообщения об ошибке в журнал
            bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
            dbms_utility.format_error_backtrace(), null, null, l_ref);
            -- откат к точке начала оплаты
            rollback to savepoint sp_paystart;
            -- возврат контекста
            bc.set_context;
        end;
    else
      bars_audit.info('Дублирующий документ: '|| p_doc_id);
      p_ref := get_ref(p_doc_id);
    end if;

    bars_audit.info('corplight_pay_swift_api(output parameters):
              p_ref=>'||to_char(l_ref)||chr(13)||chr(10)||
            ',p_errcode=>'||to_char(p_errcode)||chr(13)||chr(10)||
            ',p_errmsg=>'||p_errmsg);
    bars_audit.trace('%s: done', l_th);

end create_payment_swift;

end mbm_payments;
/
 show err;
 
PROMPT *** Create  grants  MBM_PAYMENTS ***
grant EXECUTE                                                                on MBM_PAYMENTS    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mbm_payments.sql =========*** End **
 PROMPT ===================================================================================== 
