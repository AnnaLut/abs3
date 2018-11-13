declare tt tips%rowtype ;
begin suda;
      tt.name := 'Переплачені Податки';        tt.tip  := 'RET';
      update  tips set name = tt.name where tip = tt.tip ; if SQL%rowcount = 0 then    Insert into tips (tip,NAME) values (tt.tip, tt.name) ; end if;
      COMMIT;
end;
/

declare   p4_ int;  aa accounts%rowtype ;
begin bc.go('300465');

  select * into aa from accounts where nbs= '3522' and ob22='29' and branch ='/300465/000000/060000/' and dazs is null and dapp is not null and kv= 980 and rownum =1 ;
  aa.nls := vkrzn('30046', '3522_29') ;
  aa.Nms := 'Переплата з податку на прибуток для врахування сплати ПДФО';
  op_reg (99, 0, 0, 0,  p4_, aa.RNK, aa.nls, 980, aa.nms, 'RET', aa.isp, aa.acc);
  Accreg.setAccountSParam(aa.Acc, 'OB22', aa.ob22);
  update accounts set tobo = '/300465/' where acc = aa.acc ;

  select * into aa from accounts where nbs= '3522' and ob22='30' and branch ='/300465/000000/060000/' and dazs is null and dapp is not null and kv= 980 and rownum =1 ;
  aa.nls := vkrzn('30046', '3522_30') ;
  aa.Nms := 'Переплата з податку на прибуток для врахування сплати ВЗ';
  op_reg (99, 0, 0, 0,  p4_, aa.RNK, aa.nls, 980, aa.nms, 'RET', aa.isp, aa.acc);
  Accreg.setAccountSParam(aa.Acc, 'OB22', aa.ob22);
  update accounts set tobo = '/300465/' where acc = aa.acc ;
  commit ;
  suda;
end;
/

