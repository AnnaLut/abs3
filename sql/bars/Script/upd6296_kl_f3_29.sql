
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Script/UPD_KL_F3_29.sql =========*** Run ***
PROMPT ===================================================================================== 

--  корректировка списка балансовых для файла #F8 в kl_f3_29
exec BARS_LOGIN.LOGIN_USER('xxx',1,null,null);

exec tuda;


--exec bc.subst_mfo('315784');
--exec bc.home;

begin

delete from kl_f3_29
 where kf in ( 'F7', 'F8' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1502',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1508',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1502',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1508',  '03',  '1',  '11',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1510',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1513',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1516',  '12',  '2',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1518',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1510',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1513',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1516',  '12',  '2',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1518',  '03',  '1',  '11',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1520',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1521',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1522',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1523',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1524',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1526',  '12',  '2',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1528',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1520',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1521',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1522',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1523',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1524',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1526',  '12',  '2',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1528',  '03',  '1',  '11',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1532',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1533',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1534',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1535',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1535',  '13',  '2',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1536',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1536',  '13',  '2',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1538',  '11',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1532',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1533',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1534',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1535',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1535',  '13',  '2',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1536',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1536',  '13',  '2',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1538',  '11',  '1',  '11',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1542',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1543',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1545',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1545',  '13',  '2',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1546',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1546',  '13',  '2',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1548',  '11',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1542',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1543',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1545',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1545',  '13',  '2',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1546',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1546',  '13',  '2',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1548',  '11',  '1',  '11',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1600',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '1607',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1600',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '1607',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '3560',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '3566',  '03',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '3566',  '13',  '2',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '3568',  '11',  '1',  '11',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '3560',  '11',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '3566',  '03',  '1',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '3566',  '13',  '2',  '11',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '3568',  '11',  '1',  '11',  '1' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2010',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2016',  '12',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2018',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2010',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2016',  '12',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2018',  '03',  '1',  '21',  '8' );
                                                    
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2020',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2026',  '12',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2028',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2020',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2026',  '12',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2028',  '03',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2030',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2036',  '12',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2038',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2030',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2036',  '12',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2038',  '03',  '1',  '21',  '8' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2040',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2041',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2042',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2043',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2044',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2045',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2046',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2046',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2048',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2040',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2041',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2042',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2043',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2044',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2045',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2046',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2046',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2048',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2060',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2063',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2066',  '12',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2068',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2060',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2063',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2066',  '12',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2068',  '03',  '1',  '21',  '8' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2071',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2076',  '12',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2078',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2071',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2076',  '12',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2078',  '03',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2083',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2086',  '12',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2088',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2083',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2086',  '12',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2088',  '03',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2301',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2303',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2306',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2306',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2307',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2307',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2308',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2301',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2303',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2306',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2306',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2307',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2307',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2308',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2310',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2311',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2316',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2316',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2317',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2317',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2318',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2310',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2311',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2316',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2316',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2317',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2317',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2318',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2320',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2321',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2326',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2326',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2327',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2327',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2328',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2320',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2321',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2326',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2326',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2327',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2327',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2328',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2330',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2331',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2336',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2336',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2337',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2337',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2338',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2330',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2331',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2336',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2336',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2337',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2337',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2338',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2340',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2341',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2346',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2346',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2347',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2347',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2348',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2340',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2341',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2346',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2346',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2347',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2347',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2348',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2351',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2353',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2356',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2356',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2357',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2357',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2358',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2351',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2353',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2356',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2356',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2357',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2357',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2358',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2390',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2391',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2392',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2393',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2394',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2395',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2396',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2396',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2397',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2397',  '13',  '2',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2398',  '11',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2390',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2391',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2392',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2393',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2394',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2395',  '11',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2396',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2396',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2397',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2397',  '13',  '2',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2398',  '11',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2600',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2605',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2607',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2650',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2655',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2656',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2657',  '03',  '1',  '21',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2600',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2605',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2607',  '03',  '1',  '21',  '8' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2650',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2655',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2656',  '03',  '1',  '21',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2657',  '03',  '1',  '21',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2203',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2206',  '12',  '2',  '31',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2208',  '03',  '1',  '31',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2203',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2206',  '12',  '2',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2208',  '03',  '1',  '31',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2240',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2240',  '11',  '1',  '31',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2401',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2403',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2406',  '03',  '1',  '31',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2406',  '13',  '2',  '31',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2407',  '03',  '1',  '31',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2407',  '13',  '2',  '31',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2408',  '11',  '1',  '31',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2401',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2403',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2406',  '03',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2406',  '13',  '2',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2407',  '03',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2407',  '13',  '2',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2408',  '11',  '1',  '31',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2450',  '11',  '1',  '31',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2450',  '11',  '1',  '31',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2211',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2216',  '12',  '2',  '32',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2218',  '03',  '1',  '32',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2211',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2216',  '12',  '2',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2218',  '03',  '1',  '32',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2241',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2241',  '11',  '1',  '32',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2410',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2411',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2416',  '03',  '1',  '32',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2416',  '13',  '2',  '32',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2417',  '03',  '1',  '32',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2417',  '13',  '2',  '32',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2418',  '11',  '1',  '32',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2410',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2411',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2416',  '03',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2416',  '13',  '2',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2417',  '03',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2417',  '13',  '2',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2418',  '11',  '1',  '32',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2451',  '11',  '1',  '32',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2451',  '11',  '1',  '32',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2220',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2226',  '12',  '2',  '33',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2228',  '03',  '1',  '33',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2220',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2226',  '12',  '2',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2228',  '03',  '1',  '33',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2242',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2242',  '11',  '1',  '33',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2420',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2421',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2426',  '03',  '1',  '33',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2426',  '13',  '2',  '33',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2427',  '03',  '1',  '33',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2427',  '13',  '2',  '33',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2428',  '11',  '1',  '33',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2420',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2421',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2426',  '03',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2426',  '13',  '2',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2427',  '03',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2427',  '13',  '2',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2428',  '11',  '1',  '33',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2452',  '11',  '1',  '33',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2452',  '11',  '1',  '33',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2620',  '03',  '1',  '35',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2625',  '03',  '1',  '35',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2627',  '03',  '1',  '35',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2620',  '03',  '1',  '35',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2625',  '03',  '1',  '35',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2627',  '03',  '1',  '35',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2233',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2236',  '12',  '2',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2238',  '03',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2233',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2236',  '12',  '2',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2238',  '03',  '1',  '38',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2243',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2243',  '11',  '1',  '38',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2431',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2433',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2436',  '03',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2436',  '13',  '2',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2437',  '03',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2437',  '13',  '2',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2438',  '11',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2431',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2433',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2436',  '03',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2436',  '13',  '2',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2437',  '03',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2437',  '13',  '2',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2438',  '11',  '1',  '38',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2453',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2453',  '11',  '1',  '38',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2246',  '03',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2246',  '13',  '2',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2248',  '11',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2456',  '03',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2456',  '13',  '2',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2457',  '03',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2457',  '13',  '2',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2458',  '11',  '1',  '38',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2246',  '03',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2246',  '13',  '2',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2248',  '11',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2456',  '03',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2456',  '13',  '2',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2457',  '03',  '1',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2457',  '13',  '2',  '38',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2458',  '11',  '1',  '38',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2103',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2106',  '12',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2108',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2103',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2106',  '12',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2108',  '03',  '1',  '51',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2113',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2116',  '12',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2118',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2113',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2116',  '12',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2118',  '03',  '1',  '51',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2123',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2126',  '12',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2128',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2123',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2126',  '12',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2128',  '03',  '1',  '51',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2133',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2136',  '12',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2138',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2133',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2136',  '12',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2138',  '03',  '1',  '51',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2140',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2142',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2143',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2146',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2146',  '13',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2148',  '11',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2140',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2142',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2143',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2146',  '03',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2146',  '13',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2148',  '11',  '1',  '51',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2360',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2361',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2362',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2363',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2366',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2366',  '13',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2367',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2367',  '13',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2368',  '11',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2360',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2361',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2362',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2363',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2366',  '03',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2366',  '13',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2367',  '03',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2367',  '13',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2368',  '11',  '1',  '51',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2370',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2371',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2372',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2373',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2376',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2376',  '13',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2377',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2377',  '13',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2378',  '11',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2370',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2371',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2372',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2373',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2376',  '03',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2376',  '13',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2377',  '03',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2377',  '13',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2378',  '11',  '1',  '51',  '' );

insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2380',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2381',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2382',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2383',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2386',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2386',  '13',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2387',  '03',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2387',  '13',  '2',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F7', '2388',  '11',  '1',  '51',  '1' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2380',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2381',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2382',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2383',  '11',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2386',  '03',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2386',  '13',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2387',  '03',  '1',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2387',  '13',  '2',  '51',  '' );
insert into kl_f3_29 (kf, r020,r050,r012,ddd,s240)   values ( 'F8', '2388',  '11',  '1',  '51',  '' );
                                                    
commit;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Script/UPD_KL_F3_29.sql =========*** End ***
PROMPT ===================================================================================== 
