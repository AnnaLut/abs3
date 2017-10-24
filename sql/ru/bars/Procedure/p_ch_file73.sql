

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE73.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE73 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE73 (kodf_ varchar2,dat_ date,userid_ number) is
-- 30.09.2010 ��������� �������� ��� ����� #73 � ����� 1-��
-- 22.07.2009 (18.10.2005)
-- ������� !!! �������� ����� 261,262,263 #73 � ���� "1210" ����� #39 �� �����
-- ������� !!! �������� ����� 361,362,363 #73 � ���� "1220" ����� #39 �� �����

 c_      number;
 kol_    number;
 s_210   number;
 s_220   number;
 s_2343  number;
 s_2344  number;
 nbs_    Varchar2(4);
 kv1_    Varchar2(3);
 Dat1_   Date;

begin

Dat1_:= TRUNC(Dat_,'MM');
kv1_:='000';

delete from otcn_log
where userid = userid_ AND kodf = '73';

insert into otcn_log (kodf,userid,txt) VALUES
                     (kodf_,userid_,'�����i��� ����� #73  �  ������ #39');

for k in
( select substr(kodp,1,1)  kod,
	 substr(kodp,4,3)  kv,
	 SUM(to_number(znap)) zna
  from tmp_nbu
  where kodf=kodf_ and datf=dat_ and
        substr(kodp,1,3) in ('261','262','263','361','362','363')
  group by substr(kodp,1,1), substr(kodp,4,3)
  order by 2)
loop

 s_210 := 0;
 s_220 := 0;
 begin
    if k.kod='2' then
       select NVL(SUM(to_number(znap)),0) into s_210
       from tmp_nbu
       where kodf='39' and substr(kodp,1,4)='1210' and
             substr(kodp,5,3)=k.kv and
             datf between Dat1_ and Dat_ ;
    end if;
    if k.kod='3' then
       select NVL(SUM(to_number(znap)),0) into s_220
       from tmp_nbu
       where kodf='39' and substr(kodp,1,4)='1220' and
             substr(kodp,5,3)=k.kv and
             datf between Dat1_ and Dat_ ;
    end if;

    if kv1_<>k.kv then
       insert into otcn_log (kodf,userid,txt)
              values(kodf_,userid_,'');
       insert into otcn_log (kodf,userid,txt)
              values ('73', userid_,' ������ ' || k.kv);
       kv1_:=k.kv;
    end if;

    if k.kod='2' and k.zna <> s_210 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 210 �� ����� #39 �� ����� ����� 261,262,263 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 210 �� ����� ����� #39 = '|| to_char(s_210) ||
          ' ���� 261,262,263 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_210-k.zna));
    end if;

    if k.kod='2' and k.zna = s_210 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 210 �� ����� ����� #39 = '|| to_char(s_210) ||
          ' ���� 261,262,263 ����� #73 = ' || to_char(k.zna));
    end if;

    if k.kod='3' and k.zna <> s_220 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 220 �� ����� #39 �� ����� ����� 361,362,363 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 220 �� ����� ����� #39 = '|| to_char(s_220) ||
          ' ���� 361,362,363 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_220-k.zna));
    end if;

    if k.kod='3' and k.zna = s_220 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 220 �� ����� ����� #39 = '|| to_char(s_220) ||
          ' ���� 361,362,363 ����� #73 = ' || to_char(k.zna));
    end if;

 end;

end loop;

-- #73 � 1-��
kv1_:='000';

insert into otcn_log (kodf,userid,txt) values
   ('73', userid_, ' ');

insert into otcn_log (kodf,userid,txt) VALUES
                     (kodf_,userid_,'�����i��� ����� #73  i ����� 1-��');

for k in
( select substr(kodp,1,1)  kod,
	 substr(kodp,4,3)  kv,
	 SUM(to_number(znap)) zna
  from tmp_nbu
  where kodf=kodf_ and datf=dat_ and
        substr(kodp,1,3) in ('261','262','263','361','362','363')
  group by substr(kodp,1,1), substr(kodp,4,3)
  order by 2)
loop

 s_2343 := 0;
 s_2344 := 0;
 begin
    if k.kod='2' then
       select NVL(SUM(p.kre*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and p.kod='2343'
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='3' then
       select NVL(SUM(p.deb*100000),0)
          into s_2344
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and p.kod='2344'
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if kv1_<>k.kv then
       insert into otcn_log (kodf,userid,txt)
              values(kodf_,userid_,'');
       insert into otcn_log (kodf,userid,txt)
              values ('73', userid_,' ������ ' || k.kv);
       kv1_:=k.kv;
    end if;

    if k.kod='2' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 2343 1-�� �� ����� ����� 261,262,263 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2343 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 261,262,263 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='2' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2343 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 261,262,263 ����� #73 = ' || to_char(k.zna));
    end if;

    if k.kod='3' and k.zna <> s_2344 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 2344 �� ����� 1-�� �� ����� ����� 361,362,363 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2344 �� ����� 1-�� = '|| to_char(s_2344) ||
          ' ���� 361,362,363 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2344-k.zna));
    end if;

    if k.kod='3' and k.zna = s_2344 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2344 �� ����� 1-�� = '|| to_char(s_2344) ||
          ' ���� 361,362,363 ����� #73 = ' || to_char(k.zna));
    end if;

 end;

end loop;

for k in
( select substr(kodp,1,3)  kod,
	 substr(kodp,4,3)  kv,
	 SUM(to_number(znap)) zna
  from tmp_nbu
  where kodf=kodf_ and datf=dat_ and
        substr(kodp,1,3) in ('220','223','232','323','325','342')
  group by substr(kodp,1,3), substr(kodp,4,3)
  order by 2, 1)
loop

 s_2343 := 0;
 s_2344 := 0;
 begin
    if k.kod='220' then
       select NVL(SUM(p.kre*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and (p.kod='2310' or
              p.kod='8446' and p.oper like '%������%')
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='325' then
       select NVL(SUM(p.deb*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and (p.kod='2310' or
              p.kod='8446' and p.oper like '%������%')
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if kv1_<>k.kv then
       insert into otcn_log (kodf,userid,txt)
              values(kodf_,userid_,'');
       insert into otcn_log (kodf,userid,txt)
              values ('73', userid_,' ������ ' || k.kv);
       kv1_:=k.kv;
    end if;

    if k.kod='220' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 2310,8446 1-�� �� ����� ���� 220 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2310,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 220 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='220' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��������� ��i� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2310,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 220 ����� #73 = ' || to_char(k.zna));
    end if;

    if k.kod='325' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 2310,8446 1-�� �� ����� ���� 325 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2310,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 325 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='325' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ �� �i��������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 2310,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 325 ����� #73 = ' || to_char(k.zna));
    end if;

    /*
    if k.kod='220' then
       select NVL(SUM(p.kre*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and p.kod='8446'
         and p.oper like '%������%'
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='325' then
       select NVL(SUM(p.deb*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and p.kod='8446'
         and p.oper like '%������%'
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='220' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 8446 1-�� �� ����� ���� 220 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 220 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='220' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 220 ����� #73 = ' || to_char(k.zna));
    end if;

    if k.kod='325' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 8446 1-�� �� ����� ���� 325 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 325 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='325' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 325 ����� #73 = ' || to_char(k.zna));
    end if;
    */

    -- ���� 223, 323
    if k.kod='223' then
       select NVL(SUM(p.kre*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and p.kod='8445'
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='323' then
       select NVL(SUM(p.deb*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and p.kod='8445'
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='223' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 8445 1-�� �� ����� ���� 223 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8445 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 223 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='223' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� I� � i����� ����� ���. �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8445 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 223 ����� #73 = ' || to_char(k.zna));
    end if;

    if k.kod='323' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 8445 1-�� �� ����� ���� 323 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8445 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 323 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='323' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������� I� i����� ����� ���. �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8445 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 323 ����� #73 = ' || to_char(k.zna));
    end if;

    -- ���� 232, 342
    if k.kod='232' then
       select NVL(SUM(p.kre*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and (p.kod='8428' or
              p.kod='8446' and p.oper like '%�������%')
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='342' then
       select NVL(SUM(p.deb*100000),0)
          into s_2343
       from pb_1 p, tabval t
       where p.mec=to_number(to_char(Dat_,'MM'))
         and p.god=to_number(to_char(Dat_,'YY'))
         and (p.kod='8428' or
              p.kod='8446' and p.oper like '%�������%')
         and p.valkod=t.lcv
         and t.kv=k.kv;
    end if;

    if k.kod='232' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 8428,8446 1-�� �� ����� ���� 232 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8428,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 232 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='232' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' �������� ���i��� �� ��������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8428,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 232 ����� #73 = ' || to_char(k.zna));
    end if;

    if k.kod='342' and k.zna <> s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ !!! ��� 8428,8446 1-�� �� ����� ���� 342 #73');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8428,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ��� 342 ����� #73 = ' || to_char(k.zna) ||
          ' ������� = ' || to_char(s_2343-k.zna));
    end if;

    if k.kod='342' and k.zna = s_2343 THEN
       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ������ ���i��� �� ��������� �� !!!');

       insert into otcn_log (kodf,userid,txt) values
          ('73',userid_,' ��� 8428,8446 �� ����� 1-�� = '|| to_char(s_2343) ||
          ' ���� 342 ����� #73 = ' || to_char(k.zna));
    end if;

 end;

end loop;


end p_ch_file73;
/
show err;

PROMPT *** Create  grants  P_CH_FILE73 ***
grant EXECUTE                                                                on P_CH_FILE73     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE73.sql =========*** End *
PROMPT ===================================================================================== 
