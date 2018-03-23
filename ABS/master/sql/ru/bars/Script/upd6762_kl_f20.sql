--  cobusupabs-6762   
--  ������������� ����������� KL_F20 ��� #20

-- ����� ������ ��� ����������� 2601
declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='1' and S181 ='X' and R013 ='1';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '1',    'X',    '1',    '05826011  ', '2601 ����� �� ������, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='1' and S181 ='X' and R013 ='2';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '1',    'X',    '2',    '05826011  ', '2601 ����� �� ������, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='1' and S181 ='X' and R013 ='3';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '1',    'X',    '3',    '05826011  ', '2601 ����� �� ������, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='1' and S181 ='X' and R013 ='4';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '1',    'X',    '4',    '05926011  ', '2601 ������� �����, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='1' and S181 ='X' and R013 ='5';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '1',    'X',    '5',    '05926011  ', '2601 ������� �����, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='2' and S181 ='X' and R013 ='1';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '2',    'X',    '1',    '15826011  ', '2601 ����� �� ������, ����.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='2' and S181 ='X' and R013 ='2';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '2',    'X',    '2',    '15826011  ', '2601 ����� �� ������, ����.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='2' and S181 ='X' and R013 ='3';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '2',    'X',    '3',    '15826011  ', '2601 ����� �� ������, ����.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='2' and S181 ='X' and R013 ='4';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '2',    'X',    '4',    '15926011  ', '2601 ������� �����, ����.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2601'
       and T020 ='2' and K030 ='X' and R031 ='2' and S181 ='X' and R013 ='5';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2601', '2',    'X',    '2',    'X',    '5',    '15926011  ', '2601 ������� �����, ����.������' );
    end if;

end;
/


-- ����� ������ ��� ����������� 2706

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2706'
       and T020 ='2' and K030 ='2' and R031 ='1' and S181 ='X' and R013 ='2';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2706', '2',    '2',    '1',    'X',    '2',    '71927063  ', '2706 �������.������� �� ���������, �����, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2706'
       and T020 ='2' and K030 ='1' and R031 ='1' and S181 ='X' and R013 ='2';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2706', '2',    '1',    '1',    'X',    '2',    '71927064  ', '2706 �������.������� �� ���������, �����, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2706'
       and T020 ='2' and K030 ='X' and R031 ='1' and S181 ='X' and R013 ='1';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2706', '2',    'X',    '1',    'X',    '1',    '71927065  ', '2706 �������.������ �� ���������, �����, ���.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2706'
       and T020 ='2' and K030 ='2' and R031 ='1' and S181 ='X' and R013 ='2';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2706', '2',    '2',    '1',    'X',    '2',    '81927063  ', '2706 �������.������� �� ���������, �����, ����.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2706'
       and T020 ='2' and K030 ='1' and R031 ='1' and S181 ='X' and R013 ='2';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2706', '2',    '1',    '1',    'X',    '2',    '81927064  ', '2706 �������.������� �� ���������, �����, ����.������' );
    end if;

end;
/

declare
   is_rec      integer;
begin

    select count(*)  into is_rec
      from kl_f20
     where KF ='20' and R020 ='2706'
       and T020 ='2' and K030 ='X' and R031 ='1' and S181 ='X' and R013 ='1';

    if is_rec =0  then
insert into kl_f20 ( KF, R020, T020, K030, R031, S181, R013, DDD, TXT )
values ( '20', '2706', '2',    'X',    '1',    'X',    '1',    '81927065  ', '2706 �������.������ �� ���������, �����, ����.������' );
    end if;

end;
/


-- ���������� �������� ��� ������ 2706

  update KL_F20
     set s181 ='X', txt ='2706 �������.������� �� ���������, �����, ���.������'
   where r020= '2706' and ddd = '71927061  ';

  update KL_F20
     set s181 ='X', txt ='2706 �������.������� �� ���������, �����, ���.������'
   where r020= '2706' and ddd = '71927068  ';

  update KL_F20
     set s181 ='X', txt ='2706 �������.������ �� ���������, �����, ���.������'
   where r020= '2706' and ddd = '71927069  ';

  update KL_F20
     set s181 ='X', txt ='2706 �������.������� �� ���������, �����, ����.������'
   where r020= '2706' and ddd = '81927061  ';

  update KL_F20
     set s181 ='X', txt ='2706 �������.������� �� ���������, �����, ����.������'
   where r020= '2706' and ddd = '81927068  ';

  update KL_F20
     set s181 ='X', txt ='2706 �������.������ �� ���������, �����, ����.������'
   where r020= '2706' and ddd = '81927069  ';


-- ���������� �������� ��� ������ 2707

  update KL_F20
     set s181 ='X', txt ='2707 �������.����i� �� ���������, ���.������'
   where r020= '2707' and ddd = '71727071  ';

  update KL_F20
     set s181 ='X', txt ='2707 �������.����i� �� ���������, ���.������'
   where r020= '2707' and ddd = '71727078  ';

  update KL_F20
     set s181 ='X', txt ='2707 �������.����i� �� ���������, ���.������'
   where r020= '2707' and ddd = '71727079  ';

  update KL_F20
     set s181 ='X', txt ='2707 �������.����i� �� ���������, i���.������'
   where r020= '2707' and ddd = '81727071  ';

  update KL_F20
     set s181 ='X', txt ='2707 �������.����i� �� ���������, i���.������'
   where r020= '2707' and ddd = '81727078  ';

  update KL_F20
     set s181 ='X', txt ='2707 �������.����i� �� ���������, i���.������'
   where r020= '2707' and ddd = '81727079  ';

commit;


