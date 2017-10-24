
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_get_tip.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_GET_TIP (p_code in varchar2) RETURN  varchar2
IS
  v_code varchar2(100);
  v_res varchar2(100);
  n pls_integer;
  g_char     varchar2(100) := 'ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞß².,_"';
  g_numb varchar2(100) := '0123456789';
BEGIN

SELECT f.name into  v_code  from  W4_acc b, w4_card c , w4_subproduct f  where  C.CODE=B.CARD_CODE  and b.ACC_PK=p_code  and c.sub_code=f.code and rownum=1;

--dbms_output.put_line((g_char||lower(g_char)||g_numb)||' '||v_code);
--1)
    if instr(upper(v_code),'MAST')>0 then 
        v_res:='MasterCard';
    end if;

    if instr(upper(v_code),'VIS')>0 then 
        v_res:='VISA';
    end if;

    if instr(upper(v_code),'MAE')>0 then 
        v_res:='Maestro';
    end if;


    if instr(upper(v_code),'MAST')>0 then 
        v_res:='MasterCard';
    end if;

--2)
    if instr(upper(v_code),'DEB')>0 then 
        v_res:=v_res||' Debit';
    end if;

    if instr(upper(v_code),'GOL')>0 then 
        v_res:=v_res||' Gold';
    end if;

    if instr(upper(v_code),'PLAT')>0 then 
        v_res:=v_res||' Platinum';
    end if;


    if instr(upper(v_code),' ELEC')>0 then 
        if instr(upper(v_res), 'MAS')>0 then v_res:=v_res||' Electronic'; else v_res:=v_res||' Electron'; end if;
    end if;

    if instr(upper(v_code),'CLAS')>0 then 
        v_res:=v_res||' Classic';
    end if;

    if instr(upper(v_code),'WORL')>0 then 
        v_res:=v_res||' World';
    end if;

    if instr(upper(v_code),'ELIT')>0 then 
        v_res:=v_res||' Elite';
    end if;

    if instr(upper(v_code),'BUS')>0 then 
        v_res:=v_res||' Business';
    end if;


    if instr(upper(v_code),'CORP')>0 then 
        v_res:=v_res||' Corporate';
    end if;

    if instr(upper(v_code),'STAND')>0 then 
        v_res:=v_res||' Standard';
    end if;

    if instr(upper(v_code),'DOME')>0 then 
        v_res:=v_res||' Domestic';
    end if;


    if instr(upper(v_code),'VIRT')>0 then 
        v_res:=v_res||' Virtual';
    end if;

    if instr(upper(v_code),'SIGN')>0 then 
        v_res:=v_res||' Signia';
    end if;

if v_res is not null then return v_res;
else return v_code;
end if;

END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_get_tip.sql =========*** End **
 PROMPT ===================================================================================== 
 