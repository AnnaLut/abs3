

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/R1191.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure R1191 ***

  CREATE OR REPLACE PROCEDURE BARS.R1191 (
 ref_  INTEGER,   -- референция
 tt_   CHAR,      -- тип транзакции
 dk0_  NUMBER,    -- признак дебет-кредит
 kva_  SMALLINT,  -- код валюты А
 nls1_ VARCHAR2,  -- номер счета А
 sa_   DECIMAL ,  -- сумма в валюте А
 kvb_ SMALLINT,  -- код валюты Б
 nls2_ VARCHAR2  -- номер счета Б
) IS

-------
FUNCTION f_GetNSC (p_nazn IN VARCHAR2)  RETURN   VARCHAR2  IS
    tmp_   VARCHAR2(200);   L_  NUMBER;  NSC_    VARCHAR2(200);
BEGIN
    L_   := instr (p_nazn, ';');   tmp_ := substr(p_nazn, L_+1,200  );
    L_   := instr (tmp_,   ';');   NSC_ := substr(tmp_  , 1   , L_-1);
    RETURN NSC_;
END f_GetNSC;
--------
FUNCTION f_GetDBCODE (p_nazn IN VARCHAR2) RETURN  VARCHAR2  IS
    tmp_     VARCHAR2(200);  L_ NUMBER;  DBCODE_  VARCHAR2(200);
BEGIN
    L_   := instr (p_nazn, ';');   tmp_   := substr(p_nazn, L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   DBCODE_:= substr(tmp_  , 1   ,L_-1);
    RETURN  DBCODE_;
END f_GetDBCODE;
---------

BEGIN
  --------------
  If gl.aMFO  ='300465' and  dk0_=1 and
     (   tt_  ='TK '    and nls1_='2906401'
      OR tt_  ='TK2'    and nls1_='2906603'
      OR tt_  ='TK3'    and nls1_='29067003'
      ) THEN

/*
    Перехват операций по разработке
    картотеки кредиторов по поверненню Компенсац.виплат
    для проверки и синхронного сворачивания по DB_LINK
    в депoзитной системе

    1. Операция 'TK ', счет картотеки nls1_='2906401'   , его тип = NLA
       Обычная Комп.випл              nls2_='2906301301', его тип = TK

    2. Операция 'TK2', счет картотеки nls1_='2906603'   , его тип = NLP
       Комп.випл на поховання         nls2_='2906501202 , его тип = TK2

    3. Операция 'TK3', счет картотеки nls1_='29067003'  , его тип = NL3
       Комп.випл через УКРПОЧТУ       nls2_='2906301301', его тип = TK3

*/
     declare
         p_ND     oper.nd%type  ; -- он же реф первичного документа
         p_REF    oper.ref%type ; --
         p_nazn   oper.nazn%type; -- новое назнач.платежа
         tmp_     varchar2(200);  L_    int;
         p_DBCODE varchar2(160);  -- код клиента          в БД по DB_LINK
         L_DBCODE int;            -- реальная длина кодa клиента
         p_NSC    varchar(160) ;  -- № счета (сберкнижки) в БД по DB_LINK
         L_NSC    int;            -- реальная длина № счета (сберкнижки)
         S_RET    number;         -- сумма документа
         KV_RET   number;         -- валюта документа
         l_tip    char(3);        -- тип счета
     -- ссылка на первоначальный реф платежа
     begin
        select nd, nazn, s, kv into p_ND, p_nazn, S_RET, KV_RET from oper where ref= ref_;

        If S_RET <> SA_ then
           RAISE_APPLICATION_ERROR (-20001, 'Ош.суммы '|| SA_/100 ||' HE= '||S_RET/100);
        end if;

        If KV_RET <> KVA_ then
           RAISE_APPLICATION_ERROR (-20001, 'Ош.вал. '|| KVA_ ||' HE= '||KV_RET);
        end if;

        begin
           p_REF :=p_ND;
        EXCEPTION  WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20001, 'Ош.№ док(не число) ='|| p_ND);
        end;

        select tip into l_tip from accounts where nls=nls2_ and kv=kvb_;

--        if l_tip = 'TK3' and substr(p_nazn,1,1) = 'П' then
--           RAISE_APPLICATION_ERROR (-20001, 'Ош.: невозможно вернуть документ (TK3-П)');
--        end if;

        if ( l_tip <> 'TK3' and substr(p_nazn,1,1) =  'П' ) or
           ( l_tip =  'TK3' and substr(p_nazn,1,1) <> 'П' ) then
           RAISE_APPLICATION_ERROR (-20001, 'Ош. несответствие счета(TK3)-назначения платежа(П)');
        end if;

        p_NSC   := f_GetNSC   (p_nazn);     L_NSC   := Nvl(length(p_NSC   ),0);
        If L_NSC <1 OR L_NSC >19 then
           RAISE_APPLICATION_ERROR (-20001, 'Ош.№ счета');
        end if;

        If tt_ in ('TK ','TK3')  then

           p_DBCODE:= f_GetDBCODE(p_nazn);  L_DBCODE:= Nvl(length(p_DBCODE),0);
           If L_DBCODE <1 OR L_DBCODE >11 then
              RAISE_APPLICATION_ERROR (-20001, 'Ош.DBCODE');
           end if;

           execute immediate
            'begin USSR_PAYOFF.payoff_back@DEPDB(:p_REF, :p_DBCODE, :p_NSC); end;'
             using p_ref, p_dbcode, p_nsc;

        ElsIf tt_='TK2' then
           -- компенсация на поховання 500 грн (читаем детали назначения платежа)
           execute immediate
            'begin USSR_PAYOFF.payoff_back2@DEPDB(:p_REF, :p_NSC); end;'
             using p_ref, p_nsc;
        end if;

     end;
  end if;
  --------------

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/R1191.sql =========*** End *** ===
PROMPT ===================================================================================== 
