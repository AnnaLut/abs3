CREATE OR REPLACE FUNCTION F_CHECK_ELT_OB22
(p_id int, p_nbs varchar2, p_ob22 varchar2, p_tip varchar2)
RETURN e_tarif.ob22_3570%type IS

-- *** ver 1.1 в_д 16/02-16 ***
-- Пошук допустимих OB22 по E_TARIF

l_ret   e_tarif.ob22_3570%type;

begin
if newnbs.g_state= 1 then  --переход на новый план счетов
if p_ob22 is null then l_ret:='-9'; return l_ret; end if;

 if p_id=0 then  -- id
    if p_nbs='3570' and p_tip<>'OFR' then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select '02' ob22_3570 from dual union all select ob22_3570 from e_tarif where ob22_3570 is not null)
          and rownum=1;
    exception when no_data_found then null; l_ret:='-5';
    end;
    RETURN l_ret;
    end if;

    if p_nbs='3570' and p_tip='OFR' then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select '44' ob22_3579 from dual union all select ob22_3579 from e_tarif where ob22_3579 is not null)
          and rownum=1;
    exception when no_data_found then null; l_ret:='-5';
    end;
    RETURN l_ret;
    end if;

    if p_nbs='6510' then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select ob22_6110 from e_tarif where ob22_6110 is not null)
          and rownum=1;
    exception when no_data_found then null; l_ret:='-5';
    end;
    RETURN l_ret;
    end if;

 else -- id

    begin
    select decode(p_nbs,'3570',ob22_3570,'3575',ob22_3579,'6510',ob22_6110,'-7')
    into l_ret
    from e_tarif
    where id=p_id;
    --if p_ob22 != l_ret then l_ret:=null; end if;
    exception when no_data_found then null; l_ret:='-4';
    end;

 if l_ret is null then
    if p_nbs='6510' then RETURN l_ret; end if;
    if p_nbs='3570' and p_ob22='02' then RETURN p_ob22; end if;
    if p_nbs='3578' and p_ob22='44' then RETURN p_ob22; end if;
 end if;

 end if;  -- id  
else
 if p_ob22 is null then l_ret:='-9'; return l_ret; end if;

 if p_id=0 then  -- id
    if p_nbs='3570' then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select '02' ob22_3570 from dual union all select ob22_3570 from e_tarif where ob22_3570 is not null)
          and rownum=1;
    exception when no_data_found then null; l_ret:='-5';
    end;
    RETURN l_ret;
    end if;

    if p_nbs='3579' then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select '24' ob22_3579 from dual union all select ob22_3579 from e_tarif where ob22_3579 is not null)
          and rownum=1;
    exception when no_data_found then null; l_ret:='-5';
    end;
    RETURN l_ret;
    end if;

    if p_nbs='6110' then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select ob22_6110 from e_tarif where ob22_6110 is not null)
          and rownum=1;
    exception when no_data_found then null; l_ret:='-5';
    end;
    RETURN l_ret;
    end if;

 else -- id

    begin
    select decode(p_nbs,'3570',ob22_3570,'3579',ob22_3579,'6110',ob22_6110,'-7')
    into l_ret
    from e_tarif
    where id=p_id;
    --if p_ob22 != l_ret then l_ret:=null; end if;
    exception when no_data_found then null; l_ret:='-4';
    end;

 if l_ret is null then
    if p_nbs='6110' then RETURN l_ret; end if;
    if p_nbs='3570' and p_ob22='02' then RETURN p_ob22; end if;
    if p_nbs='3579' and p_ob22='24' then RETURN p_ob22; end if;
 end if;

 end if;  -- id
end if; 

RETURN l_ret;
end;
/
