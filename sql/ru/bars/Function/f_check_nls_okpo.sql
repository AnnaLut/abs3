
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_nls_okpo.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_NLS_OKPO (p_kv    oper.kv%type,
                          p_nlsa  oper.nlsa%type   default null,
                          p_nlsb  oper.nlsb%type   default null)
RETURN NUMBER IS
   l_okpo_a         varchar (14);
   l_okpo_b         varchar (14);
   l_doca           varchar(15);
   l_docb           varchar(15);
-------------------------------------------------------------------------------
/*
LitvinSO Create10/09/2015
Задача:COBUSUPABS-3735
Функція для перевірки данних клієнта по рахунках, якщо клієнт один і той же вертає 0, якщо ні вертає 1
*/
    begin
        begin
            select c.okpo into l_okpo_a from accounts a, customer c where a.nls = p_nlsa and a.kv = p_kv and a.rnk = c.rnk;
            exception
                        when no_data_found then
                    begin
                        select upper(p.ser)||upper(p.numdoc) into l_doca from accounts a, person p where a.nls = p_nlsa and a.kv = p_kv and a.rnk = p.rnk;
                        exception
                            when no_data_found then
                            l_doca := null;
                    end;


        end;

                        if l_okpo_a like '000000000%'  then
                        begin
                            select upper(p.ser)||upper(p.numdoc) into l_doca from accounts a, person p where a.nls = p_nlsa and a.kv = p_kv and a.rnk = p.rnk;
                        exception
                            when no_data_found then
                            l_doca := null;
                        end;
                    end if;

        begin
                select c.okpo into l_okpo_b from accounts a, customer c where a.nls = p_nlsb and a.kv = p_kv and a.rnk = c.rnk;
                  exception
                        when no_data_found then
                    begin
                        select upper(p.ser)||upper(p.numdoc) into l_docb from accounts a, person p where a.nls = p_nlsb and a.kv = p_kv and a.rnk = p.rnk;
                    exception
                            when no_data_found then
                            l_docb := null;
                    end;


        end;

                    if l_okpo_b like '000000000%'  then
                    begin
                        select upper(p.ser)||upper(p.numdoc) into l_docb from accounts a, person p where a.nls = p_nlsb and a.kv = p_kv and a.rnk = p.rnk;
                    exception
                        when no_data_found then
                        l_docb := null;
                        end;
                  end if;
            --bars_audit.info('DEFAULT check_nls l_okpo_a = '||l_okpo_a||' l_okpo_b = '||l_okpo_b||' l_doca = '||l_doca||' l_docb = '||l_docb);

        if (l_okpo_a not like '000000000%') and  (l_okpo_b not like '000000000%') and (l_okpo_a = l_okpo_b)  then

                return 0;
        elsif (l_okpo_a like '000000000%') and  (l_okpo_b like '000000000%') and (l_doca = l_docb) then
                return 0;
        else
                return 1;
        end if;

      end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_nls_okpo.sql =========*** E
 PROMPT ===================================================================================== 
 