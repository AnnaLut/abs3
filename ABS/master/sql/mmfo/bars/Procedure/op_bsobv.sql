create or replace procedure BARS.OP_BSOBV 
( p_mode          int      -- 0 = для всiх бранчiв 2,
                           -- 1 = для одного бранчу 2,2+,3 рiвня,
                           -- 2 = для кiлькох бр(2,2+,3)
, p_kv            int      -- код вал, по умолчаниею 980
, p_bbbboo        varchar2
, p1_branch       varchar2
, p2_branch       varchar2
, p3_branch       varchar2
, p4_branch       varchar2
) is
/*
 06.07.2016 убрала туда
 27.06.2013 Sta Авто-открытие счетов с кодом вал, по умолчаниею 980

 Так Станет:
  Авто-вiдкр.рах. по БР+ОБ22 для всiх бранчiв 2	   FunNSIEdit("[PROC=>OP_BSOBV(0,:V,:A,'''','''','''','''')][PAR=>:A(SEM=ББББОО,REF=V_NBSOB22)][MSG=>OK]")
  Авто-вiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня FunNSIEdit("[PROC=>OP_BSOBV(1,:V,:A,:B,'''','''',''''  )][PAR=>:A(SEM=ББББОО,REF=V_NBSOB22),:B(SEM=Бранч,REF=BRANCH_VAR)][MSG=>OK]")
  Авто-вiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3)  FunNSIEdit("[PROC=>OP_BSOBV(2,:V,:A,:B,:C,:D,:E        )][PAR=>:A(SEM=ББББОО,REF=V_NBSOB22),:B(SEM=Б-1,REF=BRANCH_VAR),:C(SEM=Б-2,REF=BRANCH_VAR),:D(SEM=Б-3,REF=BRANCH_VAR),:E(SEM=Б-4,REF=BRANCH_VAR)][MSG=>OK]")
 
 Так Было:
  Авто-вiдкр.рах. по БР+ОБ22 для всiх бранчiв 2	   FunNSIEdit("[PROC=>OP_BS_OB(:sPar1)][PAR=>:sPar1(SEM=ББББОО,TYPE=S,REF=V_NBSOB22)][MSG=>OK OP_BS_OB!]")
  Авто-вiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня FunNSIEdit("[PROC=>OP_BS_OB1(:sPar1,:sPar2)][PAR=>:sPar1(SEM=Бранч,TYPE=S,REF=BRANCH_VAR),:sPar2(SEM=ББББОО,TYPE=S,REF=V_NBSOB22)][MSG=>OK OP_BS_OB1!]")
  Авто-вiдкр.рах. по БР+ОБ22 для кiлькох бр(2,2+,3)  FunNSIEdit("[PROC=>OP_BS_OB2(:A,:B,:C,:D,:E)][PAR=>:A(SEM=ББББОО,TYPE=S,REF=V_NBSOB22),:B(SEM=Б-1,TYPE=S,REF=BRANCH_VAR),:C(SEM=Б-2,TYPE=S,REF=BRANCH_VAR),:D(SEM=Б-3,TYPE=S,REF=BRANCH_VAR),:E(SEM=Б-4,TYPE=S,REF=BRANCH_VAR)][MSG=>OK]")
*/
------------------------------------------------------------------------
begin
  
  PUL.Set_Mas_Ini( 'OP_BSOB_KV', to_char( NVL(p_KV,gl.baseval)),'KV для авто-откр сч' );
  
  If    p_mode = 0 then OP_BS_OB ( P_BBBBOO );                                             -- для всiх бранчiв 2,
  ElsIf p_mode = 1 then OP_BS_OB1( P1_BRANCH, P_BBBBOO ) ;                                 -- для одного бранчу 2,2+,3 рiвня,
  elsIf p_mode = 2 then OP_BS_OB2( P_BBBBOO, P1_BRANCH, P2_BRANCH, P3_BRANCH, P4_BRANCH ); -- для кiлькох бр(2,2+,3)
  end if;

end OP_BSOBV;
/

show err;

grant EXECUTE on OP_BSOBV to BARS_ACCESS_DEFROLE;
grant EXECUTE on OP_BSOBV to CUST001;
