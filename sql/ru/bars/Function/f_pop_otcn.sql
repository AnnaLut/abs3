
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pop_otcn.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_POP_OTCN (Dat_ DATE, type_ NUMBER,
                                       sql_acc_ VARCHAR2,
                                       datp_ IN DATE DEFAULT NULL,
                                       add_KP_ in number default 0,
                                       tp_sql_ in number default 0
                                          )
RETURN NUMBER IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	‘ункци€ наполнени€ таблиц дл€ формировани€ отчетности
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 03/03/2012 (09/08/2011)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры:
 Dat_ - отчетна€ дата
 type_- тип наполнени€ (1 - только остатки на дату
                        2 - остатки + корректирующие проводки
                        3 - остатки + корректирующие обороты
                            (за отчетный и предыд. мес€ц, и годовые)
                             + мес€чные обороты
                        4 - формирование годовых файлов (ј4, 81 и т.д.)
                        5 - формирование сальдовки (как тип 3, но дополнен
                            вход€щими остатками)
 sql_acc_ - запрос ограничивающий кол-во счетов участвующих в выборке
 datp_    - дата начала периода (дл€ type_ = 5)
 add_KP_  - наполнение таблиц REF_KOR и KOR_PROV (0 - нет, 1 - да)
 tp_sql_  - тип запроса в sql_acc_ (=0 - отбор по NBS, = 1 - по ACC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    ret_ number;
begin
    ret_ :=  F_Pop_Otcn_SNP(Dat_,  type_,  sql_acc_,  datp_, tp_sql_, add_KP_);

    return ret_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_POP_OTCN ***
grant EXECUTE                                                                on F_POP_OTCN      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_POP_OTCN      to RPBN001;
grant EXECUTE                                                                on F_POP_OTCN      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pop_otcn.sql =========*** End ***
 PROMPT ===================================================================================== 
 