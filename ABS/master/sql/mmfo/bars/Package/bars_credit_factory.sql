
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_credit_factory.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_CREDIT_FACTORY 
IS
   -- Author  : VITALIY.LEBEDINSKIY
   -- Created : 27/04/2015 15:33:50
   -- Purpose :

   -- Public constant declarations
   g_header_version    CONSTANT VARCHAR2 (64) := 'version 2.01 07/09/2018';
   g_awk_header_defs   CONSTANT VARCHAR2 (512) := '';

   --------------------------------------------------------------------------------
   -- header_version - возвращает версию заголовка пакета
   --
   FUNCTION header_version
      RETURN VARCHAR2;

   --------------------------------------------------------------------------------
   -- body_version - возвращает версию тела пакета
   --
   FUNCTION body_version
      RETURN VARCHAR2;

   FUNCTION get_crd_response (p_okpo     IN bars.customer.okpo%TYPE,
                              p_doctype  in number,
                              p_numdoc   IN bars.person.numdoc%TYPE,
                              p_bday     IN varchar2)
      RETURN CLOB;


   PROCEDURE set_bpk_credit (p_nd        bars.CC_DEAL.ND%TYPE,
                             p_branch    bars.BRANCH.BRANCH%TYPE,
                             p_kv        bars.accounts.kv%TYPE,
                             p_nls       bars.accounts.nls%TYPE,
                             p_dclass    VARCHAR2,
                             p_dvkr      VARCHAR2,
                             p_dsum      NUMBER,
                             p_ddate         in DATE,
                             p_education     in varchar2,
                             p_marriage      in varchar2,
                             p_dependents    in number,
                             p_codedrpou     in varchar2,
                             p_workplace     in varchar2,
                             p_worktype      in varchar2,
                             p_conf_income   in number,
                             p_unconf_income in number
                             );
END bars_credit_factory;

/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_CREDIT_FACTORY 
IS
   -- Private constant declarations
   g_body_version    CONSTANT VARCHAR2 (64) := 'version 2.4 04/02/2019';
   g_awk_body_defs   CONSTANT VARCHAR2 (512) := '';
   g_dbgcode         CONSTANT VARCHAR2 (20) := 'bars_credit_factory.';

   g_date_format     CONSTANT VARCHAR2 (10) := 'dd.mm.yyyy';

   --------------------------------------------------------------------------------
   -- header_version - возвращает версию заголовка пакета
   --
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package header BARS_CREDIT_FACTORY '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   END header_version;

   --------------------------------------------------------------------------------
   -- body_version - возвращает версию тела пакета
   --
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package body BARS_CREDIT_FACTORY '
             || g_body_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_body_defs;
   END body_version;

   PROCEDURE write_log (p_in_par VARCHAR2, p_out_par VARCHAR2)
   AS
   BEGIN
      INSERT INTO CF_LOG (id,
                          systime,
                          in_par,
                          out_par)
         SELECT S_CF_LOG.NEXTVAL,
                SYSDATE,
                p_in_par,
                p_out_par
           FROM DUAL;
   END write_log;


   PROCEDURE check_data (p_nd        bars.CC_DEAL.ND%TYPE,
                         p_branch    bars.BRANCH.BRANCH%TYPE,
                         p_kv        bars.accounts.kv%TYPE,
                         p_nls       bars.accounts.nls%TYPE,
                         p_dclass    VARCHAR2,
                         p_dvkr      VARCHAR2,
                         p_dsum      NUMBER,
                         p_ddate     DATE)
   AS
   l_nd       bars.CC_DEAL.ND%TYPE;
   BEGIN
      --перевірка null
      IF ( (p_dclass IS NULL) OR (p_dvkr IS NULL))
      THEN
         raise_application_error (-20001,
                                  'p_dclass or p_dvkr can`t be null!');
      END IF;

      IF ( (length(p_dclass)>1) OR (length(p_dvkr)>3)  )
      THEN
         raise_application_error (-20002,
                                  'p_dclass can`t be more than 1 character or p_dvkr can`t be more than 3 character!');
      END IF;


    /*begin
      select t1.nd
            into l_nd
            from w4_acc t1, accounts t2
            where T1.ACC_PK = t2.acc and t1.nd = p_nd
                    and T2.NLS = p_nls
                    and t2.kv = p_kv;
          exception
          when no_data_found
                then
         raise_application_error (-20002,
                                  'No data from ND = '|| to_char(p_nd)
                                       || ' and NLS =' ||p_nls  ||
                                       '    and KV =' || to_char(p_kv)  || '!');

      end;
    */
   END check_data;


FUNCTION get_crd_response_new (p_okpo     IN bars.customer.okpo%TYPE,
                              p_doctype  IN number,
                              p_numdoc   IN bars.person.numdoc%TYPE,
                              p_bday     IN VARCHAR2)
      RETURN CLOB
   IS
      v_rnk            bars.customer.rnk%TYPE;
      v_res            XMLTYPE;
      v_doctype        NUMBER;
      v_txt            varchar2(2000);
   BEGIN

     logger.info('CF: user_id = '||user_id||', branch = '||bc.current_branch_code);
      BEGIN
         write_log (


               'p_okpo='
            || TO_CHAR (p_okpo)
            || ',p_doctype='
            || TO_CHAR (p_doctype)
            || ',p_numdoc='
            || p_numdoc
            || ',p_bday='
            ||                                             /*TO_CHAR (trunc(*/
              p_bday                                                    /*))*/
                    ,
            NULL);
         COMMIT;
      END;

      DBMS_OUTPUT.put_line (
            'p_okpo='
         || TO_CHAR (p_okpo)
         || ',p_doctype='
         || TO_CHAR (p_doctype)
         || ',p_numdoc='
         || p_numdoc
         || ',p_bday='
         ||                                                /*TO_CHAR (trunc(*/
           p_bday                                                       /*))*/
                 );

      BEGIN
       SELECT md.type_abs
         INTO v_doctype
         FROM bars.cf_mapping_doctype md
        WHERE md.type_cf = p_doctype;
      EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          bars_audit.info (
                'bars_credit_factory.get_crd_response p_doctype - '
             || p_doctype
             || ' not defined for ABS');
          RETURN '<Client>No list</Client>';
      END;

      BEGIN
         SELECT c.rnk into v_rnk
           FROM customer c, person p
          WHERE c.rnk = p.rnk
            and c.date_off is null
            and c.okpo = p_okpo
            and c.k050 != '910'
            and p.numdoc = p_numdoc
            and p.passp =  v_doctype
            and trunc(p.bday) = TO_DATE (p_bday, g_date_format);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
           RETURN '<Client>No list</Client>';
         when TOO_MANY_ROWS then
           RETURN '<Client>для МФО '||gl.aMFO||' є декілька записів по вказаним параметрам пошуку. Необхідно виконати об"єднання клієнтів!</Client>';
      END;

      select xmlelement("Client",
               xmlelement("FIO",c.nmk),
               xmlelement("INSIDER",c.prinsider),
               xmlelement("PUBLIC",nvl((select case upper(cw.value)
                                      when 'ТАК' THEN 'Y'
                                      else 'N'
                                    end
                               from  customerw cw
                               where cw.rnk = c.rnk AND cw.tag = 'PUBLP'),'N')),
               xmlelement("RNKDATECR",to_char(c.date_on,g_date_format)),
               xmlelement("RNK"      ,c.rnk),
               xmlelement("MFO", c.kf),
                 (select xmlagg(xmlelement("DOGOVOR",
                           xmlelement("DNUM"       ,dnum),
                           xmlelement("DSYSTEM"    ,dsystem),
                           xmlelement("DBRANCH"    ,dbranch),
                           xmlelement("DSTATUS"    ,dstatus),
                           xmlelement("DCUR"       ,dcur),
                           xmlelement("DTAX"       ,to_char(dtax)),
                           xmlelement("DSUM"       ,to_char(dsum)),
                           xmlelement("DNEXTPAYM"  , dnextpaym),
                           xmlelement("DSTARTDATE" ,to_char(v.dstartdate,g_date_format)),
                           xmlelement("DFINISHDATE",to_char(v.dfinishdate,g_date_format)),
                           xmlelement("DLMPAYMENT" ,dlmpayment),
                           xmlelement("DPAWN"      ,dpawn),--(select listagg(pawn,'; ') within group (order by ndz)  from v_cck_pawn cp where cp.nd = cd.nd)),
                           xmlelement("DCODE"      ,v.DCODE),
                           (select xmlagg(
                                     xmlelement("ACC",
                                       xmlelement("ACCTYPE",acc.acctype),
                                       xmlelement("ACCNUM" ,acc.accnum),
                                       xmlelement("OB22"   ,acc.ob22),
                                       xmlelement("ACCAMOUNT",acc.accamount),
                                       xmlelement("ACCCUR"   ,acc.acccur),
                                       xmlelement("ACCAMUAH" ,acc.accamuah),
                                       xmlelement("ACCPDATE" ,to_char(acc.accpdate,g_date_format))
                                         )
                                         )

                              from v_cf_acc_dogovor acc
                              where acc.nd = v.nd
                           )
                               )
                           )

                     from v_cf_dogovor_new v
                      where c.rnk = v.rnk
/*                        and cd.sos<15
                        and cd.sos = csos.sos
                        and cd.nd = ca.nd
                        and cd.nd = n.nd
                        and n.acc = a.acc
                        and a.tip = 'LIM'
                        and a.dazs is null*/
                      ),
                     (select xmlagg(
                              xmlelement("DOGOVORDEPOSIT",
                                xmlelement("DDNUM"   , dep.DDNUM),
                                xmlelement("DDPROD"  , dep.DDPROD),
                                xmlelement("DDBRANCH", dep.DDBRANCH),
                                xmlelement("DDSTATUS", dep.DDSTATUS),
                                xmlelement("DDADDDOC", dep.DDADDOC),
                                xmlelement("DDCUR"   , dep.DDCUR),
                                xmlelement("DDTAX"   , dep.DDTAX),
                                xmlelement("DDSUM"   , dep.DDSUM),
                                xmlelement("DDSTARTDATE", to_char(dep.DDSTARTDATE, g_date_format)),
                                xmlelement("DDLASTDATE" , to_char(dep.DDLASTDATE, g_date_format)),
                                xmlelement("DDFINISHDATE",to_char(dep.DDFINISHDATE, g_date_format)),
                                xmlelement("DDTERM"      ,dep.DDTERM),
                                xmlelement("DDPROLN"     ,dep.DDPROLN),
                                xmlelement("DACCAMUAH"   ,dep.DACCAMUAH),
                                xmlelement("DDACCAMOUNT" ,dep.DDACCAMOUNT)
                               )
                              )
                        from v_cf_deposit dep
                        where dep.rnk = c.rnk
                      )
                     )
        into v_res
        from customer c
        where c.rnk = v_rnk;

        return v_res.getClobVal;
   exception
     when others then
       v_txt := sqlerrm;
       select xmlelement("ERROR",v_txt) into v_res from dual;
       return v_res.getClobVal;
   END get_crd_response_new;



   FUNCTION get_crd_response_old (p_okpo     IN bars.customer.okpo%TYPE,
                              p_doctype  IN number,
                              p_numdoc   IN bars.person.numdoc%TYPE,
                              p_bday     IN VARCHAR2)
      RETURN CLOB
   IS
      l_rnk            bars.customer.rnk%TYPE;
      l_res            XMLTYPE;
      l_resd           XMLTYPE;
      l_tmp            VARCHAR2 (400);
      l_temp_clob      CLOB;
      l_temp_varchar   VARCHAR2 (2000);
      l_iterator       NUMBER := 1;
      l_str_length     NUMBER := 2000;
      l_doctype        NUMBER;
   BEGIN
      BEGIN
         write_log (


               'p_okpo='
            || TO_CHAR (p_okpo)
            || ',p_doctype='
            || TO_CHAR (p_doctype)
            || ',p_numdoc='
            || p_numdoc
            || ',p_bday='
            ||                                             /*TO_CHAR (trunc(*/
              p_bday                                                    /*))*/
                    ,
            NULL);
         COMMIT;
      END;

      DBMS_OUTPUT.put_line (
            'p_okpo='
         || TO_CHAR (p_okpo)
         || ',p_doctype='
         || TO_CHAR (p_doctype)
         || ',p_numdoc='
         || p_numdoc
         || ',p_bday='
         ||                                                /*TO_CHAR (trunc(*/
           p_bday                                                       /*))*/
                 );

      BEGIN
       SELECT md.type_abs
         INTO l_doctype
         FROM bars.cf_mapping_doctype md
        WHERE md.type_cf = p_doctype;
      EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          bars_audit.info (
                'bars_credit_factory.get_crd_response p_doctype - '
             || p_doctype
             || ' not defined for ABS');
          RETURN '<Client>No list</Client>';
      END;

      BEGIN
         SELECT XMLAGG (
                   XMLELEMENT (
                      "Client",
                      XMLELEMENT ("FIO", v_cfd.fio),
                      XMLELEMENT ("INSIDER", v_cfd.INSIDER),
                      XMLELEMENT ("PUBLIC", v_cfd.PUB),
		      XMLELEMENT ("RNKDATECR", TO_CHAR (v_cfd.RNKDATECR, g_date_format)),
                      XMLELEMENT ("RNK", v_cfd.rnk),
                      XMLELEMENT ("MFO", v_cfd.mfonum),
                      XMLELEMENT (
                         "DOGOVOR",
                         XMLELEMENT ("DNUM", v_cfd.dnum),
                         XMLELEMENT ("DSYSTEM", v_cfd.dsystem),
                         XMLELEMENT ("DBRANCH", v_cfd.dbranch),
                         XMLELEMENT ("DSTATUS", v_cfd.dstatus),
                         XMLELEMENT ("DCUR", v_cfd.dcur),
                         XMLELEMENT ("DTAX", v_cfd.dtax),
                         XMLELEMENT ("DSUM", v_cfd.dsum),
                         XMLELEMENT ("DNEXTPAYM", v_cfd.DNEXTPAYM),
                         XMLELEMENT (
                            "DSTARTDATE",
                            TO_CHAR (v_cfd.dstartdate, g_date_format)),
                         XMLELEMENT (
                            "DFINISHDATE",
                            TO_CHAR (v_cfd.dfinishdate, g_date_format)),
                         XMLELEMENT ("DLMPAYMENT", v_cfd.dlmpayment),
                         XMLELEMENT ("DPAWN", v_cfd.dpawn),
                         XMLELEMENT ("DCODE", v_cfd.DCODE),
                         (SELECT XMLAGG (
                                    XMLELEMENT (
                                       "ACC",
                                       XMLELEMENT ("ACCTYPE", v_cad.acctype),
                                       XMLELEMENT ("ACCNUM", v_cad.accnum),
                                       XMLELEMENT ("OB22", v_cad.ob22),
                                       XMLELEMENT ("ACCAMOUNT",
                                                   v_cad.accamount),
                                       XMLELEMENT ("ACCCUR", v_cad.acccur),
                                       XMLELEMENT ("ACCAMUAH",
                                                   v_cad.accamuah),
                                       XMLELEMENT (
                                          "ACCPDATE",
                                          TO_CHAR (v_cad.accpdate,
                                                   g_date_format))))
                            FROM v_cf_acc_dogovor v_cad
                           WHERE v_cad.nd = v_cfd.nd))))
           INTO l_res--l_temp_clob
           FROM v_cf_dogovor v_cfd
          WHERE     v_cfd.okpo = p_okpo
                AND v_cfd.paspnum = p_numdoc
                AND v_cfd.doctype = l_doctype
                AND TRUNC (v_cfd.birthdate) = TO_DATE (p_bday, g_date_format)                ;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_res:=null;
      END;

      begin
            SELECT XMLAGG (
                   XMLELEMENT (
                      "Client",
                      XMLELEMENT ("FIO", v_cdd.fio),
                      XMLELEMENT ("INSIDER", v_cdd.INSIDER),
                      XMLELEMENT ("PUBLIC", v_cdd.PUB),
	              XMLELEMENT ("RNKDATECR", TO_CHAR (v_cdd.RNKDATECR, g_date_format)),
                      XMLELEMENT ("RNK", v_cdd.rnk),
                      XMLELEMENT ("MFO", v_cdd.mfonum),
                           XMLELEMENT (
                                       "DOGOVORDEPOSIT",
                                       XMLELEMENT ("DDNUM", v_cdd.DDNUM),
                                       XMLELEMENT ("DDPROD", v_cdd.DDPROD),
                                       XMLELEMENT ("DDBRANCH", v_cdd.DDBRANCH),
                                       XMLELEMENT ("DDSTATUS", v_cdd.DDSTATUS),
                                       XMLELEMENT ("DDADDDOC", v_cdd.DDADDDOC),
                                       XMLELEMENT ("DDCUR", v_cdd.DDCUR),
                                       XMLELEMENT ("DDTAX", v_cdd.DDTAX),
                                       XMLELEMENT ("DDSUM", v_cdd.DDSUM),
                                       XMLELEMENT (
                                          "DDSTARTDATE",
                                          TO_CHAR (v_cdd.DDSTARTDATE,
                                                   g_date_format)),
                                       XMLELEMENT (
                                          "DDLASTDATE",
                                          TO_CHAR (v_cdd.DDLASTDATE,
                                                   g_date_format)),
                                       XMLELEMENT (
                                          "DDFINISHDATE",
                                          TO_CHAR (v_cdd.DDFINISHDATE,
                                                   g_date_format)),
                                       XMLELEMENT ("DDTERM", v_cdd.DDTERM),
                                       XMLELEMENT ("DDPROLN", v_cdd.DDPROLN),
                                       XMLELEMENT ("DACCAMUAH", v_cdd.DACCAMUAH),
                                       XMLELEMENT ("DDACCAMOUNT", v_cdd.DDACCAMOUNT))))
                           into l_resd
                            FROM V_CF_DOGOVOR_DEPOSIT v_cdd
                              WHERE     v_cdd.okpo = p_okpo
                                AND v_cdd.paspnum = p_numdoc
                                AND v_cdd.doctype = l_doctype
                                AND TRUNC (v_cdd.birthdate) = TO_DATE (p_bday, g_date_format);
      EXCEPTION
              WHEN NO_DATA_FOUND
                 THEN l_resd := null;
      end;


      BEGIN
         SELECT XMLCONCAT (l_res, l_resd) INTO l_res FROM DUAL;
      END;

         /*танці з бубном: clob не конвертиться адекватно в utf-8, тому ми ріжемо його по 2000 в строку, конвертимо строку, строку клеїмо назад в clob*/
         /*IF (l_temp_clob IS NOT NULL)
         THEN
            DBMS_LOB.createtemporary (l_res, TRUE);

            WHILE (DBMS_LOB.GETLENGTH (l_temp_clob) > 0)
            LOOP
               l_temp_varchar :=
                  CONVERT (DBMS_LOB.SUBSTR (l_temp_clob, l_str_length),
                           'UTF8',
                           'CL8MSWIN1251');
               DBMS_LOB.APPEND (l_res, l_temp_varchar);
               l_temp_clob :=
                  DBMS_LOB.SUBSTR (
                     l_temp_clob,
                     DBMS_LOB.GETLENGTH (l_temp_clob) - l_str_length,
                     (l_iterator * l_str_length) + 1);
               l_iterator := +l_iterator;
            END LOOP;
         END IF;*/

         /*кінець танців з бубном*/
     RETURN (case when l_res is null then '<Client>No list</Client>' else l_res.getClobVal() end);

         /*RETURN (CASE
                    WHEN l_res IS NULL THEN '<Client>No list</Client>'
                    ELSE l_res
                 END);*/
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN '<Client>No list</Client>';
--      END;
   END get_crd_response_old;

   FUNCTION get_crd_response (p_okpo     IN bars.customer.okpo%TYPE,
                              p_doctype  IN number,
                              p_numdoc   IN bars.person.numdoc%TYPE,
                              p_bday     IN VARCHAR2)
      RETURN CLOB
   is
   begin
     return get_crd_response_new(p_okpo,p_doctype,p_numdoc,p_bday);
   end;

-- сохранение параметров контрагента с проверкой согласно их описания
-- VPogoda, 2018-0905
  procedure save_cust_param (p_rnk   in customer.rnk%type
                            ,p_tag   in customerw.tag%type
                            ,p_value in customerw.value%type)
    is
    v_str varchar2(1000);
    v_ret integer;
    v_err varchar2(4000);
  begin
    begin
      for r in (select * from customer_field c where c.tag = p_tag)
      loop
        if r.tabname is not null then
          v_str := 'begin select count(1) into :1 from '||r.tabname||' where '||r.tabcolumn_check||' = :2; end;';
          execute immediate v_str using out v_ret, in p_value;
          if v_ret = 0 then
            v_err := 'Значення параметру '||p_tag||' - "'||r.name||'" ['||p_value||'] не знайдено в довіднику '||r.tabname;
          end if;
        else
          if r.type = 'N' then
            begin
              v_ret := to_number(p_value);
            exception
              when value_error then
                v_err := 'Ошибка в данных: параметр = '||p_tag||', значение = '||p_value||', ошибка = '||sqlerrm;
                logger.info(v_str);
            end;
          end if;
        end if;
      end loop;
    end;
    if v_err is not null then
      raise_application_error(-20001, v_err);
    else
    kl.setCustomerElement(Rnk_        => p_rnk,
                          Tag_        => p_tag,
                          Val_        => p_value,
                          Otd_        => null,
                          p_flag_visa => null);
    end if;

/*  exception
    when others then
      logger.error('Помилка збереження параметру клієнта: rnk = '||p_rnk||', tag = '||p_tag||', value = '||p_value||': '||sqlerrm);
      raise_application_error (-20101,'Помилка збереження параметру клієнта: rnk = '||p_rnk||', tag = '||p_tag||', value = '||p_value||': '||sqlerrm);*/
  end;
/*
Значення тегу EDUCATION має зберігатися в полі «Освіта».
Значення тегу MARRIAGE має зберігатися в полі «Сімейний стан боржника».
Значення тегу DEPENDENTS має зберігатися в полі «Кількість осіб, що перебувають на утриманні боржника».
Значення тегу CODEDRPOU має зберігатися в полі «ЄДРПОУ роботодавця»  місця роботи.
Значення тегу WORKPLACE має зберігатися в полі «Найменування роботодавця»  місця роботи.
Значення тегу WORKTYPE має зберігатися в полі «Тип роботодавця»  місця роботи.
Значення тегу CONFIRMED_INCOME має зберігатися в полі «Підтверджений дохід боржника».
Значення тегу UNCONFIRMED_INCOME має зберігатися в полі «Непідтверджений дохід боржника».*/
   PROCEDURE set_bpk_credit (p_nd            in bars.CC_DEAL.ND%TYPE,
                             p_branch        in bars.BRANCH.BRANCH%TYPE,
                             p_kv            in bars.accounts.kv%TYPE,
                             p_nls           in bars.accounts.nls%TYPE,
                             p_dclass        in VARCHAR2,
                             p_dvkr          in VARCHAR2,
                             p_dsum          in NUMBER,
                             p_ddate         in DATE,
                             p_education     in varchar2,
                             p_marriage      in varchar2,
                             p_dependents    in number,
                             p_codedrpou     in varchar2,
                             p_workplace     in varchar2,
                             p_worktype      in varchar2,
                             p_conf_income   in number,
                             p_unconf_income in number
                             )
   AS
      l_branch            bars.BRANCH.BRANCH%TYPE;
      l_dblink            VARCHAR2 (400);
      l_execute_command   VARCHAR2 (4000);
      l_RNK               bars.customer.RNK%TYPE;
      l_nd                bars.w4_acc.nd%TYPE;
   BEGIN
      --занотуємо для історії
      BEGIN
         write_log (
               'p_nd='
            || TO_CHAR (p_nd)
            || ',p_branch='
            || p_branch
            || ',p_kv='
            || TO_CHAR (p_kv)
            || ',p_nls='
            || TO_CHAR (p_nls)
            || ',p_dclass='
            || TO_CHAR (p_dclass)
            || ',p_dvkr='
            || TO_CHAR (p_dvkr)
            || ',p_dsum='
            || TO_CHAR (p_dsum)
            || ',p_ddate='
            || TO_CHAR (p_ddate, 'dd.mm.yyyy'),
            NULL);
         COMMIT;
      END;

      -- проверка данных договора
      BEGIN
         check_data (p_nd,
                     p_branch,
                     p_kv,
                     p_nls,
                     p_dclass,
                     p_dvkr,
                     p_dsum,
                     p_ddate);
      END;


      --знаядемо клієнта пошук виконуємо по KF
      begin
      SELECT t2.rnk
        INTO l_RNK
        FROM accounts t2
       WHERE t2.nls = p_nls
              AND t2.kf  = substr(p_branch,2,6)
              and t2.kv = p_kv
              and t2.dazs is NULL;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'No data for ACC ('|| TO_CHAR(p_nls) || ') AND kv ('||TO_CHAR(p_kv) || ') in MFO '|| substr(p_branch,2,6)  );
       end;

 -- сохранение параметров клиента
      if p_education is not null then
        save_cust_param(l_rnk,'EDUCA',case lower(p_education)
                                        when 'початкова освіта' then 1
                                        when 'базова загальна середня освіта' then 2
                                        when 'повна загальна середня освіта' then 3
                                        when 'професійно-технічна освіта' then 4
                                        when 'вища освіта' then 5
                                      end);
      end if;

      if p_marriage is not null then
        save_cust_param(l_rnk,'STAT',case lower(p_marriage)
                                       when 'одружений /заміжня' then 2 
                                       when 'неодружений /незаміжня' then 1
                                     end);
      end if;

      if p_dependents is not null then
        save_cust_param(l_rnk,'MEMB',p_dependents);
      end if;

      if p_codedrpou is not null then
        save_cust_param(l_rnk,'EDRPO',p_codedrpou);
      end if;

      if p_workplace is not null then
        save_cust_param(l_rnk,'NAMEW',p_workplace);
      end if;

      if p_worktype is not null then
        save_cust_param(l_rnk,'CIGPO',case lower(p_worktype)
                                        when 'юридична особа'	then 1
                                        when 'фізична особа – суб’єкт підприємницької діяльності' then 2
                                      end);
      end if;

      if p_conf_income is not null then
        save_cust_param(l_rnk,'REMO',p_conf_income);
      end if;

      if p_unconf_income is not null then
        save_cust_param(l_rnk,'NREMO',p_unconf_income);
      end if;
 --

     --знаходимо договір w4_acc
     begin
      SELECT t2.nd
        INTO l_nd
        FROM w4_acc t2
       WHERE t2.acc_pk = (SELECT acc
                         FROM accounts
                        WHERE nls = p_nls AND kv = p_kv);
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(-20001,'No card account for ACC ('|| TO_CHAR(p_nls) || ') AND kv ('||TO_CHAR(p_kv) || ')' );
       end;

      MERGE INTO bars.cm_credits t1
           USING (SELECT p_nd AS nd,
                         p_branch AS branch,
                         p_kv AS kv,
                         p_nls AS nls,
                         p_dclass AS dclass,
                         p_dvkr AS dvkr,
                         p_dsum AS dsum,
                         TO_DATE (p_ddate) AS ddate
                    FROM DUAL) t2
              ON (t1.nd = t2.nd AND t1.branch = t2.branch)
      WHEN MATCHED
      THEN
         UPDATE SET t1.dclass = t2.dclass,
                    t1.dvkr = t2.dvkr,
                    t1.dsum = t2.dsum,
                    t1.ddate = t2.ddate
      WHEN NOT MATCHED
      THEN
         INSERT     (t1.nd,
                     t1.branch,
                     t1.kv,
                     t1.nls,
                     t1.dclass,
                     t1.dvkr,
                     t1.dsum,
                     t1.ddate)
             VALUES (t2.nd,
                     t2.branch,
                     t2.kv,
                     t2.nls,
                     t2.dclass,
                     t2.dvkr,
                     t2.dsum,
                     t2.ddate);

      UPDATE w4_acc
         SET fin23 =
                (CASE WHEN (p_dclass = 'А') THEN 1
                    WHEN (p_dclass ='Б') THEN 2
                    WHEN (p_dclass ='В') THEN 3
                    WHEN (p_dclass ='Г') THEN 4
                    ELSE 4
                 END)
       WHERE acc_pk = (SELECT acc
                         FROM accounts
                        WHERE nls = p_nls AND kv = p_kv);

      -- для спрощеної оцінки:
      fin_nbu.record_fp_ND (KOD_   => 'KP0',
                            S_     => 2,
                            IDF_   => 5,
                            DAT_   => TRUNC (SYSDATE),
                            ND_    => l_nd,
                            RNK_   => l_RNK);


      -- зберігаємо внутрішній кредитний рейтинг
      fin_zp.set_nd_vncrr (p_ND => l_nd, p_rnk => l_RNK, p_TXT => trim(p_dvkr));
   END set_bpk_credit;
END bars_credit_factory;
/
 show err;
 
PROMPT *** Create  grants  BARS_CREDIT_FACTORY ***
grant EXECUTE                                                                on BARS_CREDIT_FACTORY to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_credit_factory.sql =========***
 PROMPT ===================================================================================== 
 