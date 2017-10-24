
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_credit_factory.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_CREDIT_FACTORY 
IS
   -- Author  : VITALIY.LEBEDINSKIY
   -- Created : 27/04/2015 15:33:50
   -- Purpose :

   -- Public constant declarations
   g_header_version    CONSTANT VARCHAR2 (64) := 'version 1.03 04/08/2015';
   g_awk_header_defs   CONSTANT VARCHAR2 (512) := '';

   --------------------------------------------------------------------------------
   -- header_version - ���������� ������ ��������� ������
   --
   FUNCTION header_version
      RETURN VARCHAR2;

   --------------------------------------------------------------------------------
   -- body_version - ���������� ������ ���� ������
   --
   FUNCTION body_version
      RETURN VARCHAR2;

   FUNCTION get_crd_response (p_okpo     IN bars.customer.okpo%TYPE,
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
                             p_ddate     DATE);
END bars_credit_factory;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_CREDIT_FACTORY 
IS
   -- Private constant declarations
   g_body_version    CONSTANT VARCHAR2 (64) := 'version 1.11 07/10/2016';
   g_awk_body_defs   CONSTANT VARCHAR2 (512) := '';
   g_dbgcode         CONSTANT VARCHAR2 (20) := 'bars_credit_factory.';

   g_date_format     CONSTANT VARCHAR2 (10) := 'dd.mm.yyyy';

   --------------------------------------------------------------------------------
   -- header_version - ���������� ������ ��������� ������
   --
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package header mway_mgr '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   END header_version;

   --------------------------------------------------------------------------------
   -- body_version - ���������� ������ ���� ������
   --
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package body mway_mgr '
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
      --�������� null
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



   FUNCTION get_crd_response (p_okpo     IN bars.customer.okpo%TYPE,
                              p_numdoc   IN bars.person.numdoc%TYPE,
                              p_bday     IN VARCHAR2)
      RETURN CLOB
   IS
      l_rnk            bars.customer.rnk%TYPE;
      l_res            XMLTYPE;

      l_tmp            VARCHAR2 (400);
      l_temp_clob      CLOB;
      l_temp_varchar   VARCHAR2 (2000);
      l_iterator       NUMBER := 1;
      l_str_length     NUMBER := 2000;
   BEGIN
      BEGIN
         write_log (


               'p_okpo='
            || TO_CHAR (p_okpo)
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
         || ',p_numdoc='
         || p_numdoc
         || ',p_bday='
         ||                                                /*TO_CHAR (trunc(*/
           p_bday                                                       /*))*/
                 );

      BEGIN
         SELECT XMLAGG (
                   XMLELEMENT (
                      "Client",
                      XMLELEMENT ("FIO", v_cfd.fio),
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
                         XMLELEMENT (
                            "DSTARTDATE",
                            TO_CHAR (v_cfd.dstartdate, g_date_format)),
                         XMLELEMENT (
                            "DFINISHDATE",
                            TO_CHAR (v_cfd.dfinishdate, g_date_format)),
                         XMLELEMENT ("DLMPAYMENT", v_cfd.dlmpayment),
                         (SELECT XMLAGG (
                                    XMLELEMENT (
                                       "ACC",
                                       XMLELEMENT ("ACCTYPE", v_cad.acctype),
                                       XMLELEMENT ("ACCNUM", v_cad.accnum),
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
                AND TRUNC (v_cfd.birthdate) = TO_DATE (p_bday, g_date_format);

         /*����� � ������: clob �� ������������ ��������� � utf-8, ���� �� ����� ���� �� 2000 � ������, ���������� ������, ������ ����� ����� � clob*/
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

         /*����� ������ � ������*/
     RETURN (case when l_res is null then '<Client>No list</Client>' else l_res.getClobVal() end);
    
         /*RETURN (CASE
                    WHEN l_res IS NULL THEN '<Client>No list</Client>'
                    ELSE l_res
                 END);*/
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN '<Client>No list</Client>';
      END;
   END get_crd_response;

   PROCEDURE set_bpk_credit (p_nd        bars.CC_DEAL.ND%TYPE,
                             p_branch    bars.BRANCH.BRANCH%TYPE,
                             p_kv        bars.accounts.kv%TYPE,
                             p_nls       bars.accounts.nls%TYPE,
                             p_dclass    VARCHAR2,
                             p_dvkr      VARCHAR2,
                             p_dsum      NUMBER,
                             p_ddate     DATE)
   AS
      l_branch            bars.BRANCH.BRANCH%TYPE;
      l_dblink            VARCHAR2 (400);
      l_execute_command   VARCHAR2 (4000);
      l_RNK               bars.customer.RNK%TYPE;
      l_nd                bars.w4_acc.nd%TYPE;
   BEGIN
      --�������� ��� �����
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

      --��������� �� �� ����� ��� ��������, ���� ��� ����� �� ��������� � ��������
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

      --�������� �볺��� ����� �������� �� KF
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
     
     --��������� ������ w4_acc
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
                (CASE WHEN (p_dclass = '�') THEN 1
                    WHEN (p_dclass ='�') THEN 2
                    WHEN (p_dclass ='�') THEN 3
                    WHEN (p_dclass ='�') THEN 4
                    ELSE 4
                 END)
       WHERE acc_pk = (SELECT acc
                         FROM accounts
                        WHERE nls = p_nls AND kv = p_kv);

      -- ��� �������� ������:
      fin_nbu.record_fp_ND (KOD_   => 'KP0',
                            S_     => 2,
                            IDF_   => 5,
                            DAT_   => TRUNC (SYSDATE),
                            ND_    => l_nd,
                            RNK_   => l_RNK);


      -- �������� �������� ��������� �������
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
 