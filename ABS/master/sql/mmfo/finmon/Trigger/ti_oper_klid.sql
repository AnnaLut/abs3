

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TI_OPER_KLID.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_OPER_KLID ***

  CREATE OR REPLACE TRIGGER FINMON.TI_OPER_KLID 
BEFORE INSERT
ON FINMON.OPER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare

    newid    number;
    iddate   date;
    d_branch varchar2(200);

    procedure getklid is
    begin
        select kl_id, kl_id_date into newid, iddate from sequence;
        if trunc(iddate, 'YEAR') < trunc(sysdate, 'YEAR') then
            newid := 1;
        else
            newid := newid + 1;
        end if;
        update sequence set kl_id=newid, kl_id_date=sysdate;
    end;--getklid

begin
    if (:new.kl_id is null) then
            getklid;
            :new.kl_id_branch_id := to_char(newid);
            :new.kl_id           := to_char(newid);
            :new.kl_date         := trunc(sysdate);
            :new.kl_date_branch_id := :new.kl_date;
    end if;

    if (:new.kl_id_branch_id is null) then
            :new.kl_id_branch_id := :new.kl_id;
            :new.kl_date_branch_id := :new.kl_date;
    end if;
/*
    if (dbms_reputil.from_remote = false and dbms_snapshot.i_am_a_refresh = false) then

        if (:new.kl_id_branch_id is null or :new.kl_id_branch_id = '0') then

            getklid;
            :new.kl_id_branch_id := to_char(newid);
            :new.kl_id           := to_char(newid);
            :new.kl_date         := trunc(sysdate);

        else
            begin
                select upper(trim(val)) into d_branch
                  from params
                 where par = 'D_BRANCH';
            exception
                when NO_DATA_FOUND then d_branch := 'FALSE';
            end;

            if (d_branch = 'TRUE') then

                getklid;
                :new.kl_id   := to_char(newid);
                :new.kl_date := trunc(sysdate);

            end if;
        end if;

        if (:new.kl_date_branch_id is null) then
           :new.kl_date_branch_id := trunc(sysdate);
        end if;

    end if; -- repl
*/
end;
/
ALTER TRIGGER FINMON.TI_OPER_KLID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TI_OPER_KLID.sql =========*** End 
PROMPT ===================================================================================== 
