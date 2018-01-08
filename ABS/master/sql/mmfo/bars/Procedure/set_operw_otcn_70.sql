

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_OPERW_OTCN_70.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_OPERW_OTCN_70 ***

  CREATE OR REPLACE PROCEDURE BARS.SET_OPERW_OTCN_70 (
  p_ref    operw.ref%type,
  p_tag    operw.tag%type,
  p_value  operw.value%type )
is
l_ref_comm oper.ref%type;
l_kodf OTCN_TRACE_70.kodf%type;
procedure  set_op (
  p_ref operw.ref%type,
  p_tag operw.tag%type,
  p_value operw.value%type)  IS
  l_NAME_DA#70 operw.value%type;
  l_NAME_DD#70 operw.value%type;
  l_NAME_DA#E2 operw.value%type;
begin
     if p_value is null then
      delete from bars.operw where ref=p_ref and tag=p_tag;
     else
        BEGIN
           INSERT INTO operw (REF, tag, VALUE)
                VALUES (p_ref, p_tag, p_value);
        EXCEPTION
           WHEN DUP_VAL_ON_INDEX
           THEN
              UPDATE operw ow
                 SET ow.VALUE = p_value
               WHERE ow.REF = p_ref AND ow.tag = p_tag;
        END;

        if p_tag = 'D9#70' then
          begin
            SELECT name
              INTO l_NAME_DA#70
              FROM rc_bnk
             WHERE b010 = p_value;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN return;
          end;
          UPDATE operw ow
               SET ow.VALUE = l_NAME_DA#70
               WHERE ow.REF = p_ref AND ow.tag = 'DA#70';
           if sql%rowcount = 0 then
              INSERT INTO operw (REF, tag, VALUE)
              VALUES (p_ref, 'DA#70', l_NAME_DA#70);
           end if;

        end if;

        if p_tag = 'D1#D3' then
          begin
            SELECT txt
              INTO l_NAME_DD#70
              FROM  kod_d3_1
             WHERE p40 = p_value;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN return;
          end;
          UPDATE operw ow
               SET ow.VALUE = l_NAME_DD#70
               WHERE ow.REF = p_ref AND ow.tag = 'DD#70';
           if sql%rowcount = 0 then
              INSERT INTO operw (REF, tag, VALUE)
              VALUES (p_ref, 'DD#70', l_NAME_DD#70);
           end if;

        end if;

        if p_tag = 'D1#E2' then
          begin
            SELECT txt
              INTO l_NAME_DA#E2
              FROM kod_e2_1
             WHERE p40 = p_value;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN return;
          end;
          UPDATE operw ow
               SET ow.VALUE = l_NAME_DA#E2
               WHERE ow.REF = p_ref AND ow.tag = 'DA#E2';
           if sql%rowcount = 0 then
              INSERT INTO operw (REF, tag, VALUE)
              VALUES (p_ref, 'DA#E2', l_NAME_DA#E2);
           end if;

         end if;

         if p_tag = 'D1#C9' then
          begin
            SELECT txt
              INTO l_NAME_DD#70
              from kod_c9_1
             WHERE p40 = p_value;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN return;
          end;
          UPDATE operw ow
               SET ow.VALUE = l_NAME_DD#70
               WHERE ow.REF = p_ref AND ow.tag = 'DD#70';
           if sql%rowcount = 0 then
              INSERT INTO operw (REF, tag, VALUE)
              VALUES (p_ref, 'DD#70', l_NAME_DD#70);
           end if;

        end if;



     end if;
end set_op;

begin
    begin
        SELECT o.REF, T.KODF
          INTO l_ref_comm, l_kodf
          FROM V_OTCN_TRACE_70_ALL t, oper o
         WHERE t.REF = p_ref AND o.REF = TO_NUMBER (REPLACE (t.comm, ' ')) and rownum = 1;
    EXCEPTION
           WHEN NO_DATA_FOUND THEN l_ref_comm := null;
           WHEN OTHERS  THEN  l_ref_comm := null;
    end;

     set_op(p_ref, p_tag, p_value);

    if l_ref_comm is not null and p_ref<>l_ref_comm and l_kodf <> 'C9' then
     set_op(l_ref_comm, p_tag, p_value);
    elsif l_ref_comm is not null and p_ref<>l_ref_comm and l_kodf = 'C9' then
        begin
         for cur in (select distinct TO_NUMBER (REPLACE (nd, ' ')) ndref from OTCN_TRACE_70 where ref = p_ref and kodf= 'C9' and ND is not null)
          loop
           set_op(cur.ndref, p_tag, p_value);
          end loop;
        end;
    end if;


    IF p_tag IN ('D7#70', 'D8#70', 'D9#70', 'DA#70', 'DB#70', 'D6#70','D5#70','D4#70','D3#70','D2#70', 'D1#70')
       THEN
         bars_zay.upd_zay_params(p_ref,p_tag,p_value);
    END IF;
end;
/
show err;

PROMPT *** Create  grants  SET_OPERW_OTCN_70 ***
grant EXECUTE                                                                on SET_OPERW_OTCN_70 to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_OPERW_OTCN_70.sql =========***
PROMPT ===================================================================================== 
