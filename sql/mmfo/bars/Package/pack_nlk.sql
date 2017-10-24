
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pack_nlk.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PACK_NLK 
AS
   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.3.2  16.04.2014';



 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;


/**
 * body_version - возвращает версию тела пакета
 */
function body_version   return varchar2;
-------------------------------
--
--
-------------------------------
procedure NLK_REF_WEB(REF_ NUMBER, REFX_ NUMBER, ACC_ NUMBER, ID_ NUMBER);

--
--
procedure nlk_contr(p_acc_ nlk_ref_hist.acc%type,
                    p_ref_ nlk_ref_hist.ref1%type);

--
--
procedure nlk_del(p_acc_  nlk_ref_hist.acc%type,
                  p_ref1_ nlk_ref_hist.ref1%type,
                  p_ref2_ nlk_ref_hist.ref2%type);

procedure NLK_ADD(REF_ NUMBER, REFX_ NUMBER, ACC_ NUMBER, ERR_Message out varchar2, ERR_Code out varchar2);


Procedure Clean_job ;

END pack_nlk;
/
CREATE OR REPLACE PACKAGE BODY BARS.PACK_NLK 
AS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.3.2 16.04.2014';


 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header FIN_NBU '||G_HEADER_VERSION;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body FIN_NBU '||G_BODY_VERSION;
end body_version;

procedure NLK_REF_WEB(REF_ NUMBER, REFX_ NUMBER, ACC_ NUMBER, ID_ NUMBER)
is
c_ number:=0;
l_amount oper.s%type;
l_amounx oper.s%type;
l_ost oper.s%type;
begin
 If ID_ = 1
  THEN
   SELECT count(*)
     INTO c_
     FROM nlk_ref nn
    WHERE ref1=REF_
      and (ref2 is null  or exists (select 1 from oper where ref = nn.REF2 and sos < 0))
      and acc =ACC_;
   IF c_= 0 THEN
     raise_application_error(-(20000+999),'Увага!!! Документ вже був оплачений або вилучений з картотеки, обновіть екрану форму ',TRUE);
   END IF;

 ELSif id_ = 3  then

   Select s into l_amounx from oper where ref = REF_;
   Select s into l_amount from oper where ref = REFX_;

  UPDATE nlk_ref
      SET amount=nvl(amount,l_amounx)-l_amount,
          ref2 = case when nvl(amount,l_amounx)-l_amount = 0 then  REFX_ else null end
    WHERE ref1=REF_
      --and ref2 is null
      and acc =ACC_
       RETURNING amount INTO l_ost;
   IF SQL%ROWCOUNT=0 THEN
     raise_application_error(-(20000+999),'\9999 Увага!!! Документ вже був вилучений з картотеки, обновіть екрану форму ',TRUE);
   END IF;


       if l_ost  < 0
        then raise_application_error(-(20000+998),'\9999 Увага!!! Сума документа перевищила суму в картотеці.',TRUE);
       end if;

    insert into nlk_ref_hist (ref1, ref2, acc, amount)
        values (REF_, REFX_ , ACC_, l_amount);



 else
   UPDATE nlk_ref
      SET ref2=REFX_
    WHERE ref1=REF_
      --and ref2 is null
      and acc =ACC_;
   IF SQL%ROWCOUNT=0 THEN
     raise_application_error(-(20000+999),'\9999  Увага!!! Документ вже був вилучений з картотеки, обновіть екрану форму ',TRUE);
   END IF;
 END IF;

end NLK_REF_WEB;


procedure nlk_contr(p_acc_ nlk_ref_hist.acc%type,
                    p_ref_ nlk_ref_hist.ref1%type)
as
l_amounx oper.s%type;
l_amounl oper.s%type;
begin

  select s into l_amounx from oper where ref = p_ref_;

  Select sum(o.s)
    into l_amounl
    from oper o, nlk_ref_hist h
   where o.ref   = h.ref2
     and h.ref1  = p_ref_
     and h.acc   = p_acc_
     and o.sos  >= 0;

 UPDATE nlk_ref
    set amount =  l_amounx - l_amounl
  where acc = p_acc_
    and ref1= p_ref_;

end nlk_contr;

procedure nlk_del(p_acc_  nlk_ref_hist.acc%type,
                  p_ref1_ nlk_ref_hist.ref1%type,
                  p_ref2_ nlk_ref_hist.ref2%type)
as
begin

  Delete from nlk_ref_hist
        where acc  = p_acc_
          and ref1 = p_ref1_
          and ref2 = p_ref2_;

   nlk_contr(P_ACC_ => p_acc_,
             P_REF_ => p_ref1_);

end nlk_del;


procedure NLK_ADD(REF_ NUMBER, REFX_ NUMBER, ACC_ NUMBER,  ERR_Message out varchar2, ERR_Code out varchar2)
is
c_ number:=0;
l_amount oper.s%type;
l_amounx oper.s%type;
l_ost oper.s%type;
l_msg varchar2(4000);
l_code number := 0;
STOP_PRC EXCEPTION;
begin

   Select s into l_amounx from oper where ref = REF_;

   begin
   Select s into l_amount from oper where ref = REFX_ and sos >= 0;
   exception when no_data_found then
       ERR_Code := '1';
       ERR_Message := 'Не знайдено документ '|| to_char(REFX_) ||' або документ вже сторновано.';
       raise STOP_PRC;
   end;


   begin
   Select s into l_amount from opldok where ref = REFX_ and acc = acc_ and dk = 0 and sos >= 0;
   exception when no_data_found then
       ERR_Code := '1';
       ERR_Message := 'Не можливо привязати документ, дебетує інший рахунок.';
       raise STOP_PRC;
   end;

  Begin
   Select REF1 into c_ from nlk_ref_hist where ref2 = REFX_ and acc = acc_ and rownum = 1;
     if c_ > 0 then
       ERR_Code := '1';
       ERR_Message := ' Документ вже привязаний до РЕФ='||c_;
       raise STOP_PRC;
     End if;
  exception when no_data_found then null;
  End;



  UPDATE nlk_ref
      SET amount=nvl(amount,l_amounx)-l_amount,
          ref2 = case when nvl(amount,l_amounx)-l_amount = 0 then  REFX_ else null end
    WHERE ref1=REF_
      --and ref2 is null
      and acc =ACC_
       RETURNING amount INTO l_ost;
   IF SQL%ROWCOUNT=0 THEN
     ERR_Code := '1';
     ERR_Message := 'Увага!!! Документ вже був вилучений з картотеки, обновіть екрану форму ';
     --raise_application_error(-(20000+998),'Увага!!! Документ вже був вилучений з картотеки, обновіть екрану форму ',TRUE);
     raise STOP_PRC;
   END IF;


       if l_ost  < 0
        then
             ERR_Code := '1';
             ERR_Message := 'Увага!!! Сума документа перевищила суму в картотеці.';
             --raise_application_error(-(20000+997),'Увага!!! Сума документа перевищила суму в картотеці.',TRUE);
             raise STOP_PRC;
       end if;

  begin
    insert into nlk_ref_hist (ref1, ref2, acc, amount)
        values (REF_, REFX_ , ACC_, l_amount);
  exception
    when dup_val_on_index then
             ERR_Code := '1';
             ERR_Message := 'Увага!!! Документ вже привязаний до картотеки';
             raise STOP_PRC;
  End;

exception
    when others then

      if ERR_Message is null then
         ERR_Code    := '1';
         ERR_Message       := substr(SQLERRM,1,254);
         null;
      end if;

      null;

end NLK_ADD;


Procedure Clean_job
as
begin

for i in(select kf from mv_kf)
 LOOP

   BARS_CONTEXT.SUBST_MFO(i.kf);

   for k in (
            SELECT ROWID AS r1, n.*
              FROM nlk_ref n
             WHERE EXISTS (SELECT /*+ index(opldok pk_opldok)*/ 1
                             FROM opldok
                            WHERE REF = n.ref2      AND
                                  dk = 0            AND
                                  acc = n.acc       AND
                                  sos = 5           AND
                                  fdat < sysdate-30
                              )
                 )
         LOOP
             delete from nlk_ref where rowid = k.r1;
         END LOOP;

 END LOOP;

end Clean_job;


END pack_nlk;
/
 show err;
 
PROMPT *** Create  grants  PACK_NLK ***
grant EXECUTE                                                                on PACK_NLK        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pack_nlk.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 