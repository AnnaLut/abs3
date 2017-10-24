

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_9900V.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_9900V ***

  CREATE OR REPLACE PROCEDURE BARS.OP_9900V ( p_MFO varchar2, p_DAT date) is
  -- Авто-открытие счетов-вешалок пр начальном внедрении
  -- Переоценка вал счетов

  branch_ varchar2(30) := '/'|| p_MFO || '/' ;
  rnk_ int := 1        ;  isp_ int := 20094  ;   grp_ int := 39 ;
  acc_ int             ;  nls_ varchar2(15)  ;   p4_  int ;
  nms_ varchar2(38)    :='Для техн.переоц.позабалансу';
begin

  bars_context.subst_branch(branch_);

  for k in (select * from tabval where d_close is null and kv <>980)
  loop
     nls_ := vkrzn (substr (gl.amfo,1,5), '99000');
     nms_ := substr('000'||k.kv,-3)||'/'||k.lcv||' Техн.переоц.позабалансу';
     op_reg (99,0,0,GRP_,p4_,RNK_,NLS_,k.kv, NMS_, 'ODB', isp_,ACC_);
     update tabval set s0009=nls_ where kv=k.kv;

     P_REV_8(k.KV, p_DAT, '8');

  end loop;
  commit;

  begin
    EXECUTE IMMEDIATE 'drop table TEST_VE ';
  exception  when others then
    if sqlcode = -00942 then null; else raise; end if;
  end;

  EXECUTE IMMEDIATE
  'Create table TEST_VE as select kv, acc from accounts '||
  'where kv<>980 and nls like ''3800_000000000'' ';

  for k in (select acc, kv, nls from accounts
            where (nls like '3800_000000000' or
                   nls like '3801_000000000' or
                   nls like '3801_000000001' )
           )
  loop
    update accounts set nbs=null where acc=k.ACC;
  end loop;

  commit;

  bc.set_context;

end op_9900v;
 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_9900V.sql =========*** End *** 
PROMPT ===================================================================================== 
