

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PROC_SET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PROC_SET ***

  CREATE OR REPLACE PROCEDURE BARS.P_PROC_SET (p_kodf_ IN VARCHAR2, p_sheme_ IN VARCHAR2,
                                              o_nbuc_ OUT VARCHAR2, o_typ_ OUT NUMBER) IS
 ------------------------------------------------------------------------------------
 -- 16-10-2009 По умолчанию - схема С
 -- ВЕРСИЯ:  28/02/2017 (03.12.2004)
 ------------------------------------------------------------------------------------
 -- функция возвращает
 -- настраиваимые параметры для фрмирования отчетности
 -- параметры: p_kodf_ - код функции
 --            p_sheme_ - схема формирования
 -- возвращаемые значения: o_typ_ - способ формирования файлов в разрезе кодов
 --                 областей и кодов подразделений
 --        o_nbuc_ - код области, МФО или код области + код подразделения (для o_typ_=3)
 ------------------------------------------------------------------------------------
    b041_ VARCHAR2(20);
    kf_   VARCHAR2(20) := bc.current_mfo;
BEGIN
    begin
        SELECT DISTINCT ZZZ, NVL(pr_tobo,0)
        INTO o_nbuc_, o_typ_
        FROM KL_F00
        WHERE KODF=p_kodf_ AND
              A017 in (p_sheme_,'C');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             o_nbuc_:=kf_;
             o_typ_:=0;
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20001,'Error in procedure p_proc_set: '||SQLERRM);
    end;
    
    if kf_ in ('324805', '322669') and
       o_typ_ = 0
    then
       o_typ_ := 4;
    end if;    
END;
/
show err;

PROMPT *** Create  grants  P_PROC_SET ***
grant EXECUTE                                                                on P_PROC_SET      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PROC_SET.sql =========*** End **
PROMPT ===================================================================================== 
