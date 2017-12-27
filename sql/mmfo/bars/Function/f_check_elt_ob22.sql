CREATE OR REPLACE FUNCTION F_CHECK_ELT_OB22
(p_id int, p_nbs varchar2, p_ob22 varchar2)
RETURN e_tarif.ob22_3570%type IS

-- *** ver 1.2 в_д 27/12-17 ***
-- Пошук допустимих OB22 по E_TARIF

l_ret   e_tarif.ob22_3570%type;
l_3570  number(10);
l_3579  number(10);

begin
if newnbs.g_state= 1 then  --переход на новый план счетов
if p_ob22 is null then l_ret:='-9'; return l_ret; end if;

  begin
  select count(*) into l_3570 from e_tarif e where e.ob22_3570 = p_ob22;
  exception when others then l_3570:=0;
  end;
  
  begin
  select count(*) into l_3579 from e_tarif e where e.ob22_3579 = p_ob22;
  exception when others then l_3579:=0;
  end;

 if p_id=0 then  -- id
    if p_nbs='3570' and l_3570>0 then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select '02' ob22_3570 from dual union all select ob22_3570 from e_tarif where ob22_3570 is not null)
          and rownum=1;
    exception when no_data_found then null; l_ret:='-5';
    end;
    RETURN l_ret;
    end if;

    if p_nbs='3570' and l_3579>0 then
    begin
    select p_ob22 into l_ret from e_tarif
    where p_ob22 in
    (select '38' ob22_3579 from dual union all select ob22_3579 from e_tarif where ob22_3579 is not null)
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
    if p_nbs='3570' and p_ob22='38' then RETURN p_ob22; end if;
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
