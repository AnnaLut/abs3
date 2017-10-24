

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KONTROL2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KONTROL2 ***

  CREATE OR REPLACE PROCEDURE BARS.KONTROL2 (p_dat01 date, p_id varchar2 ) is

  -- подбор счета 2400
  ---------------
  TYPE OOOR IS RECORD (nbs_rez char(4), ob22_rez char(2) );
  TYPE OOOM IS TABLE  OF OOOR INDEX BY varchar2(13);
  ooo  OOOM ;
  kl_ varchar2(13);
  -----------
  aa        accounts%rowtype ;
  cc        customer%rowtype ;
  nn        nbu23_rez%rowtype;
  ----------------------------
  Dat01_ date := p_dat01     ;

/*
(NBS, OB22, S080, CUSTTYPE, KV, NAL)
 BBBBOOSCCVVVN
   4+2+1+2+3+1 =  13
  NBS       CHAR(4 BYTE),
  OB22      VARCHAR2(2 BYTE),
  S080      VARCHAR2(1 BYTE),
  CUSTTYPE  VARCHAR2(2 BYTE),
  KV        VARCHAR2(3 BYTE),
  NAL       VARCHAR2(1 BYTE)
  ------------
  NBS_REZ   CHAR(4 BYTE),
  OB22_REZ  VARCHAR2(2 BYTE),
*/

begin
for N in (select r.*, rowid RI from NBU23_REZ r where fdat= dat01_ and nls_rez is null and acc is not null and rez >0 and id like p_id ||'%')
loop

  begin
    select * into aa from accounts where acc = N.acc ;
    select * into cc from customer where rnk = aa.rnk;
    aa.branch := substr(N.branch||'000000/',1,15)    ;

    If N.kat = 1 then   NN.kat := 1;  else nn.kat := 2; end if;

    nn.NLS_REZ  := null;
    nn.NLS_REZN := null;

    If N.rez - N.rezn > 0 then
       -- есть общий рез.
       select substr( nbs_ob22_null ( o.nbs_rez,o.ob22_rez, aa.branch) , 1, 15 )
       into nn.NLS_REZ
       from  SREZERV_OB22 o
       where (o.nbs  = aa.nbs )
         and (o.ob22 = aa.ob22         or o.ob22     = '0' )
         and (o.kv   = aa.kv           or o.kv       = '0' )
         and (o.custtype = cc.custtype or o.custtype = '0' )
         and nn.kat  = decode( o.s080, '0', nn.KAT, o.s080 )
         and N.arjk  = decode( o.nal ,  2 , 1, 0 )
         and o.nal   = 1 ;
       If nn.NLS_REZ  is null then
          --надо отк счет
          null;
       end if;
    end if;

    If N.rezn > 0  then
       -- есть отщепленный рез.
       select substr( nbs_ob22_null ( o.nbs_rez, o.ob22_rez, aa.branch ), 1, 15 )
       into nn.NLS_REZN
       from  SREZERV_OB22 o
       where (o.nbs  = aa.nbs )
         and (o.ob22 = aa.ob22         or o.ob22     = '0' )
         and (o.kv   = aa.kv           or o.kv       = '0' )
         and (o.custtype = cc.custtype or o.custtype = '0' )
         and nn.KAT  = decode( o.s080, '0', nn.KAT, o.s080 )
         and N.arjk  = decode( o.nal ,  2 , 1, 0 )
         and o.nal  != 1 ;

       If nn.NLS_REZN  is null then
          --надо отк счет
          null;
       end if;
    end if;

    update NBU23_REZ set NLS_rez = nn.NLS_REZ,  NLS_rezN = nn.NLS_REZN  where rowid = n.RI;

  EXCEPTION WHEN NO_DATA_FOUND THEN  goto RecNext;
  end;
<<RecNext>> null;
end loop;

end kontrol2;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KONTROL2.sql =========*** End *** 
PROMPT ===================================================================================== 
