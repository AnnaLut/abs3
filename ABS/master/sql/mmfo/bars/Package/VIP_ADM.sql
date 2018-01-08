
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/vip_adm.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.VIP_ADM is

type row_VIP_PARAMS_TEMPLATE is record(
l_day VIP_PARAMS_TEMPLATE.day%TYPE
);

type tbl_VIP_PARAMS_TEMPLATE is table of row_VIP_PARAMS_TEMPLATE;

FUNCTION VIP_PARAMS (P_ID_PAR VARCHAR2 )
      RETURN tbl_VIP_PARAMS_TEMPLATE
      PIPELINED;
procedure add_flags;
end VIP_ADM;
/
CREATE OR REPLACE PACKAGE BODY BARS.VIP_ADM is


FUNCTION VIP_PARAMS (P_ID_PAR VARCHAR2 )
      RETURN tbl_VIP_PARAMS_TEMPLATE
      PIPELINED
   IS

BEGIN

         FOR curr
            IN (select  substr(a, instr(a, ',', 1, level) + 1, instr(a, ',', 1, level + 1) - instr(a, ',', 1, level) - 1) a_i
                    from ( select ',' ||  day || ',' a from VIP_PARAMS_TEMPLATE where ID_PAR = P_ID_PAR)
                  connect by level < length(a) - length(replace(a, ','))
                       )
         LOOP
            PIPE ROW (curr);
         END LOOP;

END VIP_PARAMS;

procedure add_flags is
   l_mfo  varchar2(6);
--   l_rnk  NUMBER;
--   l_accountmanager NUMBER;

begin
      --l_mfo := sys_context('bars_context', 'user_mfo');

	for k in (select kf from mv_kf where kf <> '324805')
	 loop
      bc.go(k.kf);
      for cur in (SELECT *
              FROM customer c
             WHERE     bars.attribute_utl.get_number_value (c.rnk,
                                                            'CUSTOMER_SEGMENT_FINANCIAL',
                                                            bankdate) IN (1, 2)
                   AND c.date_off IS NULL
				   and c.kf  = k.kf
                   AND NOT EXISTS
                              (SELECT 1
                                 FROM vip_flags
                                WHERE     rnk = c.rnk
                                      AND mfo = k.kf))
      loop
           begin
                insert into vip_flags(mfo, rnk, fio_manager, phone_manager, mail_manager, account_manager, datbeg, datend)
                values(k.kf, to_char(cur.rnk), NULL, NULL, NULL , cur.isp, sysdate, null);
           EXCEPTION
              WHEN DUP_VAL_ON_INDEX
              THEN
              null;
           end;
      end loop;
     end loop;
end add_flags;

end VIP_ADM;
/
 show err;
 
PROMPT *** Create  grants  VIP_ADM ***
grant EXECUTE                                                                on VIP_ADM         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/vip_adm.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 