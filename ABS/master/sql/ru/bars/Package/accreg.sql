
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/accreg.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ACCREG is

--***************************************************************************--
-- (C) BARS. Accounts
--***************************************************************************--

g_head_version constant varchar2(64)  := 'Version 1.9 22/05/2015';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

procedure setAccountAttr(
  mod_            integer,   -- Opening mode : 0    1    2    3    4
  p1_             integer,   -- 1st Par      : 0-inst_num   1-nd   2-nd   3-main acc   4-mfo
  p2_             integer,   -- 2nd Par      : -    -    pawn   4-acc
  p3_             integer,   -- 3rd Par (Grp): -    -    mpawn
  p4_      in out integer,   -- 4th Par      : -    -    ndz(O)
  rnk_            integer,   -- Customer number
  nls_            varchar2,  -- Account  number
  kv_             smallint,  -- Currency code
  nms_            varchar2,  -- Account name
  tip_            char,      -- Account type
  isp_            smallint,
  accR_       out integer,
  nbsnull_        varchar2 DEFAULT '1',
  pap_            number   DEFAULT NULL,
  vid_            number   DEFAULT NULL,
  pos_            number   DEFAULT NULL,
  sec_            number   DEFAULT NULL,
  seci_           number   DEFAULT NULL,
  seco_           number   DEFAULT NULL,
  blkd_           number   DEFAULT NULL,
  blkk_           number   DEFAULT NULL,
  lim_            number   DEFAULT NULL,
  ostx_           varchar2 DEFAULT NULL,       -- 'NULL' for update
  nlsalt_         varchar2 DEFAULT NULL,       -- 'NULL' for update
  tobo_           varchar2 DEFAULT '0',
  accc_           number   DEFAULT NULL        -- 'NULL' for update
);

-- for sparam_list
procedure setAccountSParam (
  Acc_   number,
  Par_   varchar2,
  Val_   varchar2 );

-- for accountsw
procedure setAccountwParam (
  p_acc  accountsw.acc%type,
  p_tag  accountsw.tag%type,
  p_val  accountsw.value%type );

procedure setAccountProf (
  Acc_   number,
  Nbs_   char );

procedure setAccountAttrFromProf (
  Acc_   number,
  Nbs_   char,
  Np_    number );

procedure setAccountSParamFromProf (
  Acc_   number,
  Nbs_   char,
  Np_    number );

procedure setAccountIntFromProf (
  Acc_   number,
  Nbs_   char,
  Np_    number );

procedure setAccountTarif (
  Acc_    number,
  Kod_    number,
  Tar_    number,
  Pr_     number,
  SMin_   number,
  SMax_   number );

procedure setAccountSob (
  Acc_    number,
  Id_     number,
  Isp_    number,
  FDat_   date,
  Txt_    varchar2 );

procedure changeAccountOwner (
  Acc_    number,
  RnkA_   integer,
  RnkB_   integer );

procedure check_account (
  p_acc   in  accounts.acc%type,
  p_msg   out varchar2,
  p_check out number );

procedure closeAccount (
  p_acc         in accounts.acc%type,
  p_info       out varchar2,
  p_can_close  out number );

procedure p_acc_restore (
  p_acc  in number,
  p_daos in date default null );

procedure p_reserve_acc (
  p_acc  out number,
  p_rnk      number,    -- Customer number
  p_nls      varchar2,  -- Account  number
  p_kv       number,    -- Currency code
  p_nms      varchar2,  -- Account name
  p_tip      char,      -- Account type
  p_grp      number,
  p_isp      number,
  p_pap      number   default null,
  p_vid      number   default null,
  p_pos      number   default null,
  p_blkd     number   default null,
  p_blkk     number   default null,
  p_lim      number   default null,
  p_ostx     number   default null,
  p_nlsalt   varchar2 default null,
  p_branch   varchar2 default null );

procedure p_unreserve_acc (p_acc number, p_flagopen number default 1);

end accreg;
/
CREATE OR REPLACE PACKAGE BODY BARS.ACCREG is

--***************************************************************************--
-- (C) BARS. Accounts
--***************************************************************************--

g_body_version  constant varchar2(64)  := 'version 1.19 22/05/2015';
g_body_defs     constant varchar2(512) := ''
    || 'PROF    - с открытием счетов по профилю' || chr(10)
;

g_modcode constant varchar2(3) := 'CAC';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header ACCREG ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body ACCREG ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

--***************************************************************************--
-- Procedure   : setAccountAttr
-- Description : процедура регистрации счета/обновления реквизитов счета
--***************************************************************************--
procedure setAccountAttr (
  mod_            integer,   -- Opening mode : 1, 2, 3, 4, 5, 6, 9, 99, 77
  p1_             integer,   -- 1st Par      : 1-nd, 2-nd, 3-main acc, 4-mfo, 5-mfo, 6-acc
  p2_             integer,   -- 2nd Par      : 2-pawn, 4-acc
  p3_             integer,   -- 3rd Par (Grp): 2-mpawn, others-grp
  p4_      in out integer,   -- 4th Par      : 2-ndz(O)
  rnk_            integer,   -- Customer number
  nls_            varchar2,  -- Account  number
  kv_             smallint,  -- Currency code
  nms_            varchar2,  -- Account name
  tip_            char,      -- Account type
  isp_            smallint,
  accR_       out integer,
  nbsnull_        varchar2 DEFAULT '1',
  pap_            number   DEFAULT NULL,
  vid_            number   DEFAULT NULL,
  pos_            number   DEFAULT NULL,
  sec_            number   DEFAULT NULL,
  seci_           number   DEFAULT NULL,
  seco_           number   DEFAULT NULL,
  blkd_           number   DEFAULT NULL,
  blkk_           number   DEFAULT NULL,
  lim_            number   DEFAULT NULL,
  ostx_           varchar2 DEFAULT NULL,       -- 'NULL' for update
  nlsalt_         varchar2 DEFAULT NULL,       -- 'NULL' for update
  tobo_           varchar2 DEFAULT '0',
  accc_           number   DEFAULT NULL        -- 'NULL' for update
) IS
  l_title varchar2(70) := 'accreg.setAccountAttr: ';
begin
  op_reg_ex (mod_, p1_, p2_, p3_, p4_, rnk_,
    nls_, kv_, nms_, tip_, isp_, accR_, nbsnull_, pap_, vid_, pos_,
    sec_, seci_, seco_, blkd_, blkk_, lim_, ostx_, nlsalt_, tobo_, accc_ ) ;
end SetAccountAttr;

--***************************************************************************--
-- Procedure   : setAccountSParam
-- Description : процедура обновления спецпараметров счета
--***************************************************************************--
procedure setAccountSParam (Acc_ number, Par_ varchar2, Val_ varchar2)
is
   l_tabname     sparam_list.tabname%type;
   l_type        sparam_list.type%type;
   l_delonnull   sparam_list.delonnull%type;
   l_count       number;
   l_stmt        varchar2(2000);
   l_title       varchar2(70) := 'accreg.setAccountSParam: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Par_=>%s, Val_=>%s',
        l_title, to_char(Acc_), Par_, Val_);

   begin

      select tabname, upper(nvl(type,'C')) type, nvl(delonnull,0)
        into l_tabname, l_type, l_delonnull
        from sparam_list
       where upper(name) = upper(Par_) ;

      bars_audit.trace('%s found Par_ %s in sparam_list',
           l_title, Par_);

   exception when no_data_found then

      l_tabname := null ;
      l_type    := null ;

   end;

   bars_audit.trace('%s l_tabname=>%s, l_type=>%s, l_delonnull=>%s',
        l_title, l_tabname, l_type, to_char(l_delonnull));

   if ( l_tabname is not null and l_type is not null ) then

      begin

         l_stmt := 'select acc from '|| l_tabname ||' where acc=:Acc_' ;

         bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

         execute immediate l_stmt into l_count using Acc_ ;

         bars_audit.trace('%s specparam %s found for acc %s',
              l_title, Par_, to_char(Acc_));

      exception when no_data_found then

         if ( Val_ is not null ) then

            l_stmt := 'insert into ' || l_tabname || '(acc) values(:Acc_)' ;

            bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

            execute immediate l_stmt using Acc_ ;

            bars_audit.trace('%s specparam %s for acc %s inserted',
                 l_title, Par_, to_char(Acc_));

            l_count := 1 ;

         end if;

      end;

      bars_audit.trace('%s l_count=>%s', l_title, to_char(l_count));

      if ( l_count > 0 ) then

         if ( Val_ is null and l_delonnull = 1 ) then

            l_stmt := 'delete from ' || l_tabname || ' where acc=:Acc_' ;

            bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

            execute immediate l_stmt using Acc_ ;

            bars_audit.trace('%s specparam %s for acc %s deleted',
                 l_title, Par_, to_char(Acc_));

         else

            l_stmt := 'update ' || l_tabname || ' set '|| Par_ ||'=' ;

            if l_type = 'N' then
               l_stmt := l_stmt || 'to_number(:Val_)' ;
            elsif l_type ='D' then
               l_stmt := l_stmt || 'to_date(:Val_,''dd/MM/yyyy'')' ;
            else
               l_stmt := l_stmt || ':Val_' ;
            end if;

            l_stmt := l_stmt || ' where acc=:Acc_' ;

            bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

            execute immediate l_stmt using Val_, Acc_ ;

            bars_audit.trace('%s specparam %s set to %s for acc %s',
                 l_title, Par_, Val_, to_char(Acc_));

         end if;

      end if;

   end if;

end setAccountSParam;

--***************************************************************************--
-- Procedure   : setAccountwParam
-- Description : процедура обновления спецпараметров счета
--***************************************************************************--
-- for accountsw
procedure setAccountwParam (
  p_acc  accountsw.acc%type,
  p_tag  accountsw.tag%type,
  p_val  accountsw.value%type )
is
   l_title       varchar2(70) := 'accreg.setAccountwParam: ';
begin

  bars_audit.trace('%s params: p_acc=>%s, p_tag=>%s, p_val=>%s',
       l_title, to_char(p_acc), p_tag, p_val);

  if p_val is null then

     delete from accountsw where acc = p_acc and tag = p_tag;

     bars_audit.trace(l_title || ' tag ' || p_tag || ' deleted for acc ' || p_acc);

  else

     begin

        insert into accountsw (acc, tag, value)
        values (p_acc, p_tag, p_val);

        bars_audit.trace(l_title || ' value on tag ' || p_tag || ' inserted for acc ' || p_acc);

     exception when dup_val_on_index then

        update accountsw
           set value = p_val
         where acc = p_acc and tag = p_tag;

        bars_audit.trace(l_title || ' value on tag ' || p_tag || ' modified for acc ' || p_acc);

     end;

  end if;

end setAccountwParam;


--***************************************************************************--
-- Procedure   : setAccountProf
-- Description : процедура заполнения параметров счета по профилю
--***************************************************************************--
procedure setAccountProf (Acc_ number, Nbs_ char)
is
   l_stmt    varchar2(4000);
   l_title   varchar2(70) := 'accreg.setAccountProf: ';
   l_acc     accounts.acc%type;
begin

   bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s',
        l_title, to_char(Acc_), Nbs_);

   for k in ( select np, sqlcondition from nbs_profacc
               where nbs = Nbs_ and sqlcondition is not null
               order by ord )
   loop

      begin

         l_stmt := 'select acc from accounts ' ||
                  ' where acc=:par_acc' ||
                  '   and (' || k.sqlcondition || ')';

         bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

         execute immediate l_stmt into l_acc using Acc_ ;

         bars_audit.trace('%s set params from prof for acc %s', l_title, to_char(acc_));

         accreg.setAccountAttrfromProf(Acc_, Nbs_, k.np);
         accreg.setAccountSParamfromProf(Acc_, Nbs_, k.np);
         accreg.setAccountIntfromProf(Acc_, Nbs_, k.np);

         bars_audit.trace('%s params from prof for acc %s is set', l_title, to_char(acc_));

         exit;

      exception when no_data_found then null;

      end;

   end loop;
end setAccountProf;

--***************************************************************************--
-- Procedure   : setAccountAttrfromProf
-- Description : процедура заполнения основных параметров счета по профилю
--***************************************************************************--
procedure setAccountAttrfromProf (Acc_ number, Nbs_ char, Np_ number)
is
   l_value   varchar2(70);
   l_kv      number := null;
   l_isp     number := null;
   l_pap     number := null;
   l_tip     varchar2(3) := null;
   l_pos     number := null;
   l_vid     number := null;
   l_tobo    varchar2(12) := null;
   l_mfop    varchar2(12) := null;
   l_grp     varchar2(30) := null;
   l_title   varchar2(70) := 'accreg.setAccountAttrfromProf: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s, Np_=>%s',
        l_title, to_char(Acc_), Nbs_, to_char(Np_));

   for k in ( select upper(t.tag) tag , p.val, p.sql_text
                from nbs_prof p, nbs_proftag t
               where p.nbs=nbs_ and p.np=np_ and p.pr=1 and p.id=t.id )

   loop

      bars_audit.trace('%s tag=>%s, val=>%s, sqltext=>%s',
           l_title, k.tag, k.val, k.sql_text);

      l_value := '' ;

      if k.val is not null then

         l_value := k.val ;

      elsif k.sql_text is not null then

         bars_audit.trace('%s executing stmt=>%s', l_title, k.sql_text);

         execute immediate k.sql_text into l_value;

         bars_audit.trace('%s stmt executed', l_title);

      end if;

      bars_audit.trace('%s l_value=>%s', l_title, l_value);

      if l_value is not null then

         bars_audit.trace('%s tag=>%s', l_title, k.tag);

         if k.tag    = 'KV' then
            l_kv   := to_number(l_value) ;
         elsif k.tag = 'ISP' then
            l_isp  := to_number(l_value) ;
         elsif k.tag = 'PAP' then
            l_pap  := to_number(l_value) ;
         elsif k.tag = 'TIP' then
            l_tip  := l_value ;
         elsif k.tag = 'POS' then
            l_pos  := to_number(l_value) ;
         elsif k.tag = 'VID' then
            l_vid  := to_number(l_value) ;
         elsif k.tag = 'TOBO' then
            l_tobo := l_value ;
         elsif k.tag = 'GRP' then
            l_grp := l_value ;
            while instr(l_grp,',') > 0 loop
               sec.addAGrp(acc_, to_number(substr(l_grp,1,instr(l_grp,',')-1)));
               l_grp := substr(l_grp, instr(l_grp,',')+1);
            end loop;
            sec.addAGrp(acc_, to_number(l_grp));
         elsif k.tag = 'MFOP' then
            l_mfop := l_value ;
         end if;

      end if;

   end loop;

   bars_audit.trace('%s set params: kv=>%s, isp=>%s, pap=>%s, tip=>%s, pos=>%s, vid=>%s, tobo=>%s, mfop=>%s',
        l_title, to_char(l_kv), to_char(l_isp), to_char(l_pap), l_tip,
        to_char(l_pos), to_char(l_vid), l_tobo, l_mfop);

   if l_kv   is not null or l_isp is not null or l_pap is not null or
      l_tip  is not null or l_pos is not null or l_vid is not null or
      l_tobo is not null
   then

      bars_audit.trace('%s set params for acc %s', l_title, to_char(acc_));

      update accounts
         set kv   = nvl(l_kv,kv),
             isp  = nvl(l_isp,isp),
             pap  = nvl(l_pap,pap),
             tip  = nvl(l_tip,tip),
             pos  = nvl(l_pos,pos),
             vid  = nvl(l_vid,vid),
             tobo = nvl(l_tobo,tobo)
       where acc = acc_;

      bars_audit.trace('%s params for acc %s is set', l_title, to_char(acc_));

   end if;

   if l_mfop is not null then

      bars_audit.trace('%s set mfop for acc %s', l_title, to_char(acc_));

      update bank_acc set mfo = l_mfop where acc = acc_;

      if sql%rowcount = 0 then

         insert into bank_acc(mfo, acc) values(l_mfop, acc_);

         bars_audit.trace('%s mfop %s for acc %s inserted', l_title, l_mfop, to_char(acc_));

      else

         bars_audit.trace('%s mfop %s for acc %s is set', l_title);

      end if;

   end if;

end setAccountAttrfromProf;

--***************************************************************************--
-- Procedure   : setAccountSParamfromProf
-- Description : процедура заполнения спец.параметров счета по профилю
--***************************************************************************--
procedure setAccountSParamfromProf (Acc_ number, Nbs_ char, Np_ number)
is
   l_value   varchar2(70);
   l_kv      number := null;
   l_stmt    varchar2(2000);
   l_title   varchar2(70) := 'accreg.setAccountSParamfromProf: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s, Np_=>%s',
        l_title, to_char(Acc_), Nbs_, to_char(Np_));

   for k in ( select s.name tag, p.val, p. sql_text, s.tabname, upper(nvl(s.type,'C')) type
                from nbs_prof p, sparam_list s
               where p.pr=2 and p.id=s.spid and nbs=nbs_ and np=np_ and s.inuse=1 )

   loop

      bars_audit.trace('%s tag=>%s, val=>%s, sqltext=>%s, tabname=>%s, type=>%s',
           l_title, k.tag, k.val, k.sql_text, k.tabname, k.type);

      l_value := '' ;

      if k.val is not null then

         l_value := k.val ;

      elsif k.sql_text is not null then

         bars_audit.trace('%s executing stmt=>%s', l_title, k.sql_text);

         execute immediate k.sql_text into l_value;

         bars_audit.trace('%s stmt executed', l_title);

      end if;

      bars_audit.trace('%s l_value=>%s', l_title, l_value);

      if l_value is not null then

         bars_audit.trace('%s type=>%s', l_title, k.type);

         if k.type = 'D' then
            l_value := 'to_date(''' || l_value || ''',''dd/MM/yyyy'')';
         elsif k.type = 'C' or k.type = 'S' then
            l_value := '''' || l_value || '''';
         end if;

         bars_audit.trace('%s l_value=>%s', l_title, l_value);

         l_stmt :=
            'begin ' ||
            '   update ' || k.tabname ||
            '   set ' || k.tag || '=' || l_value ||
            '   where acc=' || to_char(acc_) || ';' ||
            '   if sql%rowcount = 0 then ' ||
            '      insert into ' || k.tabname || '(acc,' || k.tag || ')' ||
            '      values (' || to_char(acc_) || ', ' || l_value || ');' ||
            '   end if;' ||
            'end;';

         bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

         execute immediate l_stmt;

         bars_audit.trace('%s specparam %s for acc %s is set', l_title, k.tag, to_char(acc_));

      end if;

   end loop;

end setAccountSParamfromProf;

--***************************************************************************--
-- Procedure   : setAccountIntfromProf
-- Description : процедура заполнения параметров %% счета (по профилю)
--***************************************************************************--
procedure setAccountIntfromProf (Acc_ number, Nbs_ char, Np_ number)
is
   bProf     number:=0;
   l_value   varchar2(70);
   l_pap     accounts.pap%type;
   l_lim     accounts.lim%type;
   l_id      number;
   l_metr    int_accn.metr%type  := 0;
   l_basem   int_accn.basem%type;
   l_basey   int_accn.basey%type := 0;
   l_freq    int_accn.freq%type  := 1;
   l_tt      int_accn.tt%type    := '%%1';
   l_acrb    int_accn.acrb%type;
   l_ttb     int_accn.ttb%type   := 'PS1';
   l_io      int_accn.io%type    := 0;
   l_bdat    date                := gl.bdate;
   l_ir      int_ratn.ir%type;
   l_br      int_ratn.br%type;
   l_title   varchar2(70) := 'accreg.setAccountIntfromProf: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s, Np_=>%s',
        l_title, to_char(Acc_), Nbs_, to_char(Np_));

   for k in ( select upper(t.tag) tag, p.val, p.sql_text
                from nbs_prof p, nbs_proftag t
               where p.nbs=Nbs_ and p.np=Np_ and p.pr=1 and p.id=t.id
                 and upper(t.tag) in ('P_RATI','P_RATB','P_METR','P_BASEY','P_FREQ',
                                      'P_IO','P_TT','P_TTB','P_ACRB') )
   loop

      bars_audit.trace('%s tag=>%s, val=>%s, sqltext=>%s',
           l_title, k.tag, k.val, k.sql_text);

      bProf   := 1 ;
      l_value := '' ;

      if k.val is not null then

         l_value := k.val ;

      elsif k.sql_text is not null then

         bars_audit.trace('%s executing stmt=>%s', l_title, k.sql_text);

         execute immediate k.sql_text into l_value;

         bars_audit.trace('%s stmt executed', l_title);

      end if;

      bars_audit.trace('%s l_value=>%s', l_title, l_value);

      if l_value is not null then

         bars_audit.trace('%s tag=>%s', l_title, k.tag);

         if k.tag = 'P_RATI' then
            l_ir    := to_number(l_value) ;
         elsif k.tag = 'P_RATB' then
            l_br    := to_number(l_value) ;
         elsif k.tag = 'P_METR' then
            l_metr  := to_number(l_value) ;
         elsif k.tag = 'P_BASEY' then
            l_basey := to_number(l_value) ;
         elsif k.tag = 'P_FREQ' then
            l_freq  := to_number(l_value) ;
         elsif k.tag = 'P_IO' then
            l_io    := to_number(l_value) ;
         elsif k.tag = 'P_TT' then
            l_tt    := l_value ;
         elsif k.tag = 'P_TTB' then
            l_ttb   := l_value ;
         elsif k.tag = 'P_ACRB' then
            begin
               select acc into l_acrb from accounts
                where nls=l_value and kv=gl.baseval ;
            exception when no_data_found then
               l_acrb := null ;
            end;
         end if;

      end if;

   end loop;

   bars_audit.trace('%s bProf=>%s', l_title, to_char(bProf));

   if bProf = 1 then

      select pap, lim into l_pap, l_lim from accounts where acc=Acc_ ;

      -- Определяем l_id
      if l_pap = 1 and l_lim >= 0 then
         l_id := 0 ;
      elsif l_pap = 2 and l_lim <= 0 then
         l_id := 1 ;
      else
         if l_lim > 0 then
            l_id := 0 ;
         else
            l_id := 1 ;
         end if;
      end if;

      -- Определяем nBaseM
      if l_basey = 2 then
         l_basem := 1 ;
      else
         l_basem := 0 ;
      end if;

      bars_audit.trace('%s set param: ir=>%s, br=>%s, metr=>%s, l_basem=>%s, basey=>%s, freq=>%s, io=>%s',
           l_title, to_char(l_ir), to_char(l_br), to_char(l_metr),
           to_char(l_basem), to_char(l_basey), to_char(l_freq), to_char(l_io));

      bars_audit.trace('%s set param: tt=>%s, ttb=>%s, acrb=>%s, id=>%s',
           l_title, l_tt, l_ttb, to_char(l_acrb), to_char(l_id));

      insert into int_accn (acc, id, metr, basem, basey, freq,
         stp_dat, acr_dat, apl_dat, tt, acra, acrb,
         ttb, kvb, nlsb, mfob, namb, nazn, io)
      values (Acc_, l_id, l_metr, l_basem, l_basey, l_freq,
         null, null, null, l_tt, null, l_acrb,
         l_ttb, null, null, null, null, null, l_io );

      bars_audit.trace('%s set int_accn for acc %s', l_title, to_char(acc_));

      insert into int_ratn (acc, id, bdat, ir, br, op)
      values (Acc_, l_id, l_bdat, l_ir, l_br, null ) ;

      bars_audit.trace('%s set int_ratn for acc %s', l_title, to_char(acc_));

   end if;

end setAccountIntfromProf;

--***************************************************************************--
-- Procedure   : setAccountTarif
-- Description : процедура обновления тарифов счета
--***************************************************************************--
procedure setAccountTarif (
   Acc_     number,
   Kod_     number,
   Tar_     number,
   Pr_      number,
   SMin_    number,
   SMax_    number )
is
   l_title   varchar2(70) := 'accreg.setAccountTarif: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Kod_=>%s, Tar_=>%s, Pr_=>%s, SMin_=>%s, SMax_=>%s',
        l_title, to_char(Acc_), to_char(Kod_), to_char(Tar_), to_char(Pr_), to_char(SMin_), to_char(SMax_));

   if Acc_ is not null and Kod_ is not null then

      if Tar_ is null and Pr_ is null and SMIn_ is null and SMax_ is null then

         bars_audit.trace('%s deleting kod %s for acc %s',
              l_title, to_char(Kod_), to_char(Acc_));

         delete from acc_tarif where acc=Acc_ and kod=Kod_ ;

         bars_audit.trace('%s kod %s for acc %s deleted',
              l_title, to_char(Kod_), to_char(Acc_));

      else

         bars_audit.trace('%s set kod %s for acc %s',
              l_title, to_char(Kod_), to_char(Acc_));

         update acc_tarif set tar=Tar_, pr=Pr_, smin=SMin_, smax=SMax_
          where acc=Acc_ and kod=Kod_ ;

         if sql%rowcount = 0 then

            insert into acc_tarif(acc,kod,tar,pr,smin,smax)
            values(Acc_, Kod_, Tar_, Pr_, SMin_, SMax_) ;

            bars_audit.trace('%s kod %s for acc %s inserted',
                 l_title, to_char(Kod_), to_char(Acc_));

         else

            bars_audit.trace('%s kod %s for acc %s is set',
                 l_title, to_char(Kod_), to_char(Acc_));

         end if;

      end if;

   end if;

end setAccountTarif;

--***************************************************************************--
-- Procedure   : setAccountSob
-- Description : процедура обновления событий счета
--***************************************************************************--
procedure setAccountSob (
   Acc_     number,
   Id_      number,
   Isp_     number,
   FDat_    date,
   Txt_     varchar2 )
is
   l_title   varchar2(70) := 'accreg.setAccountSob: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Id_=>%s, Isp_=>%s, FDat_=>%s, Txt_=>%s',
        l_title, to_char(Acc_), to_char(Id_), to_char(Isp_), to_char(FDat_,'dd.MM.yyyy'), Txt_);

   if Acc_ is not null then

      if Id_ is not null then

         bars_audit.trace('%s set act %s for acc %s', l_title, to_char(Id_), to_char(Acc_));

         update acc_sob set isp=Isp_, fdat=FDat_, txt=Txt_
          where Acc=Acc_ AND id=Id_ ;

         bars_audit.trace('%s act %s for acc %s is set', l_title, to_char(Id_), to_char(Acc_));

      else

         bars_audit.trace('%s inserting act for acc %s', l_title, to_char(Acc_));

         insert into acc_sob(acc,isp,fdat,txt)
         values (Acc_, Isp_, FDat_, Txt_);

         bars_audit.trace('%s act for acc %s inserted', l_title, to_char(Acc_));

      end if;

   end if;

end setAccountSob;

--***************************************************************************--
-- Procedure   : changeAccountOwner
-- Description : процедура перерегистрации счета на другого контрагента
--***************************************************************************--
procedure changeAccountOwner (Acc_ number, RnkA_ integer, RnkB_ integer)
is
   l_count   number;
   ern       number := 2;
   --        '9207 - Модульний рахунок! Неможливо перереєструвати на iншого контрагента' ;
   err       EXCEPTION;
   l_title   varchar2(70) := 'accreg.changeAccountOwner: ';
   procedure p_check_bpk(p_table varchar2, p_col varchar2)
   is
   begin
      execute immediate
      'select count(*) ' ||
      '  from ' || p_table || ' o, accounts a ' ||
      ' where o.' || p_col || ' = a.acc ' ||
      '   and a.rnk=' ||RnkA_ || ' and a.acc=' || Acc_ into l_count;
      if l_count > 0 then
         raise err;
      end if;
   end;
begin

   bars_audit.trace('%s params: Acc_=>%s, RnkA_=>%s, RnkB_=>%s',
        l_title, to_char(Acc_), to_char(RnkA_), to_char(RnkB_));

   begin
      select 1 into l_count from accounts where acc = Acc_ and rnk = RnkA_;
   exception when no_data_found then
      raise_application_error(-20000, 'Account not found or account don''t registered on rnk ' || RnkA_);
   end;

   select count(*) into l_count
     from cc_deal d, cc_add a
    where d.rnk=RnkA_ and d.nd=a.nd and (a.accs=Acc_ or a.accp=Acc_) ;

   bars_audit.trace('%s cc_deal: count=>%s', l_title, to_char(l_count));

   if l_count > 0 then
      raise err;
   end if;


   select count(*) into l_count
     from dpt_deposit
    where rnk=RnkA_ and acc=Acc_ ;

   bars_audit.trace('%s dpt: count=>%s', l_title, to_char(l_count));

   if l_count > 0 then
      raise err;
   end if;

   select count(*) into l_count
     from dpt_deposit_clos
    where rnk=RnkA_ and acc=Acc_ ;

   if l_count > 0 then
      raise err;
   end if;

   begin
      execute immediate
        'select count(*) from social_contracts
          where rnk=' || RnkA_ || ' and acc=' || Acc_ into l_count;

      if l_count > 0 then
         raise err;
      end if;

   exception when others then
      -- таблица или представление пользователя не существует
      if ( sqlcode = -00942 ) then null;
      else raise;
      end if;
   end;

   select count(*) into l_count
     from e_deal e, accounts a
    where e.rnk=RnkA_ and (e.nls36=a.nls or e.nls26=a.nls) and a.kv=980
      and a.acc=Acc_ ;

   bars_audit.trace('%s e_deal: count=>%s', l_title, to_char(l_count));

   if l_count > 0 then
      raise err;
   end if;

   p_check_bpk('bpk_acc', 'acc_pk');
   p_check_bpk('bpk_acc', 'acc_ovr');
   p_check_bpk('bpk_acc', 'acc_tovr');
   p_check_bpk('bpk_acc', 'acc_3570');
   p_check_bpk('bpk_acc', 'acc_2208');
   p_check_bpk('bpk_acc', 'acc_2207');
   p_check_bpk('bpk_acc', 'acc_3579');
   p_check_bpk('bpk_acc', 'acc_2209');

   p_check_bpk('w4_acc', 'acc_pk');
   p_check_bpk('w4_acc', 'acc_ovr');
   p_check_bpk('w4_acc', 'acc_9129');
   p_check_bpk('w4_acc', 'acc_3570');
   p_check_bpk('w4_acc', 'acc_2208');
   p_check_bpk('w4_acc', 'acc_2627');
   p_check_bpk('w4_acc', 'acc_2207');
   p_check_bpk('w4_acc', 'acc_3579');
   p_check_bpk('w4_acc', 'acc_2209');
   p_check_bpk('w4_acc', 'acc_2625x');
   p_check_bpk('w4_acc', 'acc_2625d');
   p_check_bpk('w4_acc', 'acc_2628');
   p_check_bpk('w4_acc', 'acc_2203');

   bars_audit.trace('%s set new rnk %s for acc %s', l_title, to_char(RnkB_), to_char(Acc_));

   update accounts set rnk=RnkB_ where acc=Acc_ ;

   bars_audit.trace('%s new rnk %s for acc %s is set', l_title, to_char(RnkB_), to_char(Acc_));

exception when err then
   bars_error.raise_error(g_modcode, ern);

end changeAccountOwner;

--***************************************************************************--
-- Procedure   : check_account
-- Params      :
--   p_acc   in  - acc счета
--   p_msg   out - текстовое сообщение
--   p_check out - =0-предупреждение, =1-ошибка
-- Description : процедура для всяческих проверок
--***************************************************************************--
procedure check_account (
   p_acc   in  accounts.acc%type,
   p_msg   out varchar2,
   p_check out number )
is
   l_title  varchar2(70) := 'accreg.check_account: ';
begin

   bars_audit.trace('%s params: p_acc=>%s', l_title, to_char(p_acc));

   p_msg   := null;
   p_check := 0;


end check_account;

procedure closeAccount (
  p_acc         in accounts.acc%type,
  p_info       out varchar2,
  p_can_close  out number )
-- после выполнения процедуры:
-- если p_info is not null and p_can_close
--   (p_info-здесь указана причина, почему счет не закрывается,
--    p_can_close=1 - счет все-таки можно закрыть, но желательно спросить)
-- для след. вариантов счет закрывать можно:
--   недоначислены %% ! Продолжать закрытие счета?
--   Счет начисления %% может еще быть задействован! Продолжать закрытие счета?
is
  l_bankdate date;

  l_ostc  accounts.ostc%type;
  l_ostb  accounts.ostb%type;
  l_ostf  accounts.ostf%type;
  l_dapp  accounts.dapp%type;
  l_dazs  accounts.dazs%type;
  l_daos  accounts.daos%type;
  l_kv    accounts.kv%type;
  l_nls   accounts.nls%type;

  h varchar2(100) := 'accreg.closeAccount: ';
begin

  -- признак: счет закрывать нельзя
  p_can_close := 0;
  p_info      := '';

  l_bankdate := bankdate;

  begin
     select ostc, ostb, ostf, dapp, dazs, daos, kv, nls
       into l_ostc, l_ostb, l_ostf, l_dapp, l_dazs, l_daos, l_kv, l_nls
       from accounts
      where acc = p_acc;

     if l_ostc <> 0 then
        p_info := 'Счет ' || l_nls || ': ненулевой остаток (Ф)';
     elsif l_ostb <> 0 then
        p_info := 'Счет ' || l_nls || ': ненулевой остаток (П)';
     elsif l_ostf <> 0 then
        p_info := 'Счет ' || l_nls || ': ненулевой остаток (Б)';
     elsif l_dapp = l_bankdate then
        p_info := 'Счет ' || l_nls || ': имеет обороты';
     elsif l_dazs is not null then
        p_info := 'Счет ' || l_nls || ': уже закрыт';
     elsif l_daos > l_bankdate then
        p_info := 'Счет ' || l_nls || ': нельзя закрыть датой, меньшей даты открытия';
     elsif l_dapp >= l_bankdate then
        p_info := 'Счет ' || l_nls || ': нельзя закрыть датой, меньшей даты последнего движения по счету';
     else
        -- признак: счет закрывать можно
        p_can_close := 1;
        p_info      := '';
     end if;

     if p_can_close = 1 then
        for k in ( select i.acra, i.acr_dat, i.stp_dat,
                          a.ostc, a.ostb, a.ostf, a.dapp, a.nls
                     from accounts a, int_accn i
                    where i.acc   = p_acc
                      and i.acra <> p_acc
                      and i.acra  = a.acc
                      and a.dazs is null )
        loop
           -- счет закрывать нельзя
           p_can_close := 0;

           if k.ostc <> 0 then
              p_info := 'Счет начисления %% ' || k.nls || ': ненулевой остаток (Ф)';
           elsif k.ostb <> 0 then
              p_info := 'Счет начисления %% ' || k.nls || ': ненулевой остаток (П)';
           elsif k.ostf <> 0 then
              p_info := 'Счет начисления %% ' || k.nls || ': ненулевой остаток (Б)';
           elsif l_dapp = l_bankdate then
              p_info := 'Счет начисления %% ' || k.nls || ': имеет обороты';
           elsif ( (k.stp_dat is null and l_bankdate > k.acr_dat)
                or (k.stp_dat is not null and k.stp_dat > k.acr_dat) ) then
              p_info := 'Счет начисления %% ' || k.nls || ': недоначислены %%';
              -- счет закрывать можно
              p_can_close := 1;
           elsif k.dapp > k.acr_dat then
              p_info := 'Счет начисления %% ' || k.nls || ' может еще быть задействован!';
              -- счет закрывать можно
              p_can_close := 1;
           else
              -- счет закрывать можно
              p_can_close := 1;
              p_info      := '';
           end if;

           if p_can_close = 1 then
              update accounts set dazs = l_bankdate where acc = k.acra;

              update int_accn
                 set stp_dat = l_bankdate,
                     acr_dat = l_bankdate
               where acc = p_acc and acra = k.acra;
           end if;

        end loop;

     end if;

  if p_can_close = 1 then
     update accounts set dazs = l_bankdate where acc = p_acc;
  end if;

  exception when no_data_found then
     p_can_close := 0;
     p_info      := 'Счет ' || l_nls || ' не найден';
  end;

end closeAccount;

procedure p_acc_restore (
  p_acc  in number,
  p_daos in date default null )
is
  l_dapp date;
begin

  -- ищем счет
  begin
     select dapp into l_dapp from accounts where acc = p_acc;
  exception when no_data_found then
     bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND');
  end;

  -- если нужно поменять дату открытия счета, проверим дату последнего движения:
  --   дата открытия счета д.б. < даты последнего движения
  if p_daos is not null then
     if l_dapp is not null and l_dapp < p_daos then
        bars_error.raise_nerror(g_modcode, 'ACC_DAOS_DAPP', to_char(p_daos,'dd.MM.yyyy'), to_char(l_dapp,'dd.MM.yyyy'));
     end if;
  end if;

  update accounts
     set dazs = null,
         daos = nvl(p_daos,daos)
   where acc = p_acc;

end p_acc_restore;

--***************************************************************************--
-- Procedure   : p_reserve_acc
-- Description : процедура резервирования номера счета (открытие счета и сразу закрытие)
--***************************************************************************--
procedure p_reserve_acc (
  p_acc  out number,
  p_rnk      number,    -- Customer number
  p_nls      varchar2,  -- Account  number
  p_kv       number,    -- Currency code
  p_nms      varchar2,  -- Account name
  p_tip      char,      -- Account type
  p_grp      number,
  p_isp      number,
  p_pap      number   default null,
  p_vid      number   default null,
  p_pos      number   default null,
  p_blkd     number   default null,
  p_blkk     number   default null,
  p_lim      number   default null,
  p_ostx     number   default null,
  p_nlsalt   varchar2 default null,
  p_branch   varchar2 default null )
is
  l_acc number;
  p_par number := null;
begin
  setAccountAttr (
     mod_     => 9,      -- Opening mode : 1, 2, 3, 4, 5, 6, 9, 99, 77
     p1_      => null,   -- 1st Par      : 1-nd, 2-nd, 3-main acc, 4-mfo, 5-mfo, 6-acc
     p2_      => null,   -- 2nd Par      : 2-pawn, 4-acc
     p3_      => p_grp,  -- 3rd Par (Grp): 2-mpawn, others-grp
     p4_      => p_par,  -- 4th Par      : 2-ndz(O)
     rnk_     => p_rnk,  -- Customer number
     nls_     => p_nls,  -- Account  number
     kv_      => p_kv,   -- Currency code
     nms_     => p_nms,  -- Account name
     tip_     => p_tip,  -- Account type
     isp_     => p_isp,
     accR_    => l_acc,
     nbsnull_ => '1',
     pap_     => p_pap,
     vid_     => p_vid,
     pos_     => p_pos,
     sec_     => null,
     seci_    => null,
     seco_    => null,
     blkd_    => p_blkd,
     blkk_    => p_blkk,
     lim_     => p_lim,
     ostx_    => to_char(p_ostx),
     nlsalt_  => p_nlsalt,
     tobo_    => p_branch,
     accc_    => null );
  update accounts set dazs = bankdate where acc = l_acc;
  setAccountwParam(l_acc, 'RESERVED', '1');
  p_acc := l_acc;
end p_reserve_acc;

--***************************************************************************--
-- Procedure   : p_unreserve_acc
-- Description : перевод счета из статуса "Резерв" в "Открытый"
--***************************************************************************--
procedure p_unreserve_acc (p_acc number, p_flagopen number default 1)
is
  i number;
  l_rnk number;
  l_msg varchar2(2000);
begin
  if p_flagopen = 1 then
     begin
        select 1 into i from accountsw where acc = p_acc and tag = 'RESERVED' and value = '1';
     exception when no_data_found then
        raise_application_error(-20000, 'Рахунок не є зарезервованим!');
     end;
     begin
        select rnk into l_rnk from accounts where acc = p_acc;
     exception when no_data_found then
        raise_application_error(-20000, 'Рахунок не знайдено');
     end;
     l_msg := kl.get_empty_attr_foropenacc(l_rnk);
     if l_msg is not null then
        raise_application_error(-20000, 'Для відкриття рахунку в картці клієнта необхідно заповнити поля:' || chr(10) || l_msg);
     end if;
     update accounts set daos = bankdate, dazs = null where acc = p_acc;
     setAccountwParam(p_acc, 'RESERVED', null);
  end if;
end p_unreserve_acc;

end accreg;
/
 show err;
 
PROMPT *** Create  grants  ACCREG ***
grant EXECUTE                                                                on ACCREG          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ACCREG          to CUST001;
grant EXECUTE                                                                on ACCREG          to WR_ALL_RIGHTS;
grant EXECUTE                                                                on ACCREG          to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/accreg.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 