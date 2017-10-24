
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/obs23_bpk.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OBS23_BPK (p_dat01 date, p_acc2207 number, p_acc2209 number)  return number is

/* �� ��� ������, ��������������� ������������ �������� S080 ��� ������� ������������ �����.
   ��� ���������� ��������� ������������ ����� ����� ���������� ���������� ����������� �����.

�� ����������� ���������� ������� � ������������� ���������� ������� ������������ ��������� ������� �������� �� ��������� ���,
������� ����������� �� ������ 2202,  2203 � �� ������� ������ ������� ��������� ������������ �����,
���������� ������������ ��������� ��������:
-  ��� ��������, �� ������� ��� �������������, ������������ �� ������ ������������ �������������,
   ��������� ������������ ����� ��������� �� ������ ��������;
-  ��� ��������, �� ������� ���� �������������, ������������ �� ������ ������������ �������������,
   ��������� ������������ ����� ��������� �� ������ �������������.
*/

nbs_    varchar2 (4);
SP_     number;
i_      number;
acc_    number;
--z23.dat01_ date;
dat01_  date  := p_dat01;
dat31_  date  := Dat_last (dat01_ - 4, dat01_-1 ) ;  -- ��������� ������� ���� ������;
KOL_    int   ;
FDAT_   date  := p_dat01;
DAT_P   date  ;
OBS_    int   ;
OBS_bpk int   ;
SUM_KOS number;

--begin
--  if p_acc2207 is not null or  p_acc2209 is not null then
--     begin
--       select 5 into l_obs23 from saldoa s where s.acc in ( p_acc2207, p_acc2209 )
--          and s.fdat = (select max(ss.fdat) from saldoa ss where ss.acc = s.acc and ss.fdat< p_dat01)
--          and (s.ostf-s.dos+s.kos) <0 and rownum=1;
--     exception when no_data_found then null;
--     end;
--  end if;
--  RETURN l_obs23;
--end obs23_BPK;
--/

begin
   --z23.dat01_:=p_dat01;
   i_     :=1;
   obs_   :=1;
   obs_bpk:=1;

   while  i_<3
   loop
      if i_=1 then
         acc_:=p_acc2207;
      else
         acc_:=p_acc2209;
      end if;
      if acc_ is not null THEN
      nbs_:='2207';
      SP_ := -nvl(ost_korr(acc_,dat31_,z23.di_,nbs_),0) ;
      If SP_>0 THEN
         -- ������ �� ������� ���� ����������
         KOL_:=0;
         FDAT_:= DAT01_;

         -- ������ ����� ���� ���������� ��������
         select sum(s.kos)  into   SUM_KOS   from   saldoa s,accounts a
         where  acc_=s.acc and a.acc=acc_ and s.FDAT<=DAT31_;

         -- case ������ �� ��  ���� ������������ ��� ������ � ������� ������� ���������� ��� ��������
         for p in (select s.fdat,
                          sum((case when fdat=(select min(fdat) from saldoa where acc=a.acc) then greatest(-s.ostf,s.dos)
                               else s.dos end)) DOS
                   from   saldoa s,accounts a
                   where  acc_=s.acc and a.acc=acc_ and s.FDAT<=DAT31_                              group by s.fdat
                   order by s.fdat)
         loop

            SUM_KOS:= SUM_KOS - p.DOS;
            -- -10  ��� ���������� ����������� ������ �� �� ������������� ��� ������
            If SUM_KOS < 0 THEN
               -- (SUM_KOS < -10 and k.kv<>980) or (SUM_KOS < 0 and k.kv=980) THEN -- or DAT31_- p.FDAT > 180 then
               DAT_P := p.FDAT;
               KOL_ := DAT01_- DAT_P;
               EXIT;
            end if;
         end loop;
         if KOL_ is not null THEN
            -- ���������
            If    KOL_<= 7  then OBS_:=1;
            ElsIf KOL_<=30  then OBS_:=2;
            ElsIf KOL_<=90  then OBS_:=3;
            ElsIf KOL_<=180 then OBS_:=4;
            Else                 OBS_:=5;
            end if;
         end if;
         obs_bpk:= greatest (obs_,obs_bpk);
      end if;
    end if;
    i_ := i_+1;
   end loop;
  RETURN obs_bpk;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/obs23_bpk.sql =========*** End *** 
 PROMPT ===================================================================================== 
 