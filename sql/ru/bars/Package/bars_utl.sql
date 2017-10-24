CREATE OR REPLACE PACKAGE BODY "BARS_UTL"
is

   ------------------------------------------------------------------
   -- Global variables
   --
   --
   --
    g_restDate   date;




   ------------------------------------------------------------------
   -- FILL_CRTX()
   --
   --    ��������� ���������� ������ �� ��������� ������� TMP_CRTX
   --    p_restDate - �������� ����
   --    ������ ��� �������� - ��������� �� �������� ����� �����
   --
    procedure fill_crtx(
        p_restDate    in  date )
    is
    PRAGMA AUTONOMOUS_TRANSACTION;

    begin

        -- ��������� ��������� �� ��� ������� ��
        -- ��� ����
        if (nvl(g_restDate, to_date('01011900', 'ddmmyyyy')) = p_restDate) then
            return;
        end if;

        -- ������� �������
        execute immediate 'truncate table tmp_crtx';

        -- ��������� �������
        insert into tmp_crtx(ref, dk, acc, fdat, vdat, vob, s)
        select /*+INDEX(o) */ o.ref, o.dk, o.acc, o.fdat, p.vdat, p.vob, sum( decode(o.dk,1,o.S,-o.S) )
        from   opldok o, oper p
        where  o.ref = p.ref
          and  o.sos = 5
          and  p.vob in (96, 99)
	  and  o.fdat between add_months(trunc(p_restDate, 'mm'), 1) and add_months(trunc(p_restDate, 'mm'), 2) - 1
	group by o.ref, o.dk, o.acc, o.fdat, p.vdat, p.vob;

        commit;

        g_restDate := trunc(p_restDate);

    end fill_crtx;





    -------------------------------------------------------
    -- get_accRest()
    --
    --     ������� ���������� ������� �� ����� � ������
    --     �������������� �������� � ��������������
    --     ��������
    --
    --
     function get_accRest(
        p_accCode    in  accounts.acc%type,
        p_restDate   in  saldoa.fdat%type,
        p_exclFnTurn in  number           ) return saldoa.ostf%type
     is

     l_rest    saldoa.ostf%type := 0;
     l_crSum   opldok.s%type    := 0;
     l_crFin   opldok.s%type    := 0;
     l_finTx   opldok.s%type    := 0;

     begin

         -- ��������� ��������� �������
         fill_crtx(p_restDate);

         begin

             -- �������� ����������� ������� �� �����
             select ostf - dos + kos
               into l_rest
               from saldoa
              where acc  = p_accCode
                and fdat = (select max(fdat)
                              from saldoa
                             where acc   = p_accCode
                               and fdat <= p_restDate);

             -- ������������ ������� ��������������� ����������
             select nvl(sum(decode(t.dk, 1, t.s, -t.s)), 0)
               into l_crSum
               from tmp_crtx t
              where t.acc = p_accCode
                and fdat  > p_restDate
                and vdat <= p_restDate;

         exception
             when NO_DATA_FOUND then null;
         end;



             -- ���� ������� �� ��������� �������� �� �������� ����
             if (p_exclFnTurn = 1) then

                 begin

                     -- ��������������
                     select nvl(sum(decode(t.dk, 1, t.s, -t.s)), 0)
                       into l_crFin
                       from tmp_crtx t, oper o
                      where t.acc = p_accCode
                        and t.fdat  > p_restDate
                        and o.vdat <= p_restDate
                        and t.ref = o.ref
                        and o.tt  like 'ZG%'
                        and (o.nlsa like '5%' or o.nlsb like '5%');

                 exception
                     when NO_DATA_FOUND then l_crFin := 0;
                 end;

                 -- �������� �� 31.12
                 if (to_char(p_restDate, 'ddmm') = '3112') then

                     begin

                         select nvl(sum(decode(o.dk, 1, o.s, -o.s)), 0)
                           into l_finTx
                           from opldok o, oper p
                          where o.fdat = p_restDate
                            and o.sos  = 5
                            and o.acc  = p_accCode
                            and o.ref = p.ref
                            and p.tt like 'ZG%'
                            and (p.nlsa like '5%' or p.nlsb like '5%');

                     exception
                         when NO_DATA_FOUND then l_finTx := 0;
                     end;

                 end if;

             end if;

         l_rest := l_rest + l_crSum - l_crFin - l_finTx;

        return l_rest;

     end get_accRest;


end bars_utl;
/

