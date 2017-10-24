
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/xm2.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.XM2 IS

/*
 09.06.2011 Рассматриваем только 15 знаков от кода бранча
*/
  --- получение текста атрибута тега по имени
  function getNodeAttr(node in dbms_xmldom.DOMNode, -- текущий тег
                       attr in varchar2 -- имя атрибута
                       ) return varchar2 ;

  --оплата одного
  procedure OPLx (P_provID xml2_id.provID%type,
                  p_servID xml2_id.servID%type,
                  p_mfo    xml2_mfo.mfo%type,
                  P_br3    xml2_br3.br3%type,
                  p_S      oper.s%type
                  ) ;



  -- вычитка XML2_
  procedure GETX2 (p_Mode int, p_tag varchar2);

  RefG_ oper.ref%type;

end xm2;
/
CREATE OR REPLACE PACKAGE BODY BARS.XM2 IS

--- получение текста атрибута тега по имени
function getNodeAttr(node in dbms_xmldom.DOMNode, -- текущий тег
                     attr in varchar2 -- имя атрибута
                    ) return varchar2 is
begin
    return dbms_xmldom.getNodeValue
           (dbms_xmldom.getnameditem(dbms_xmldom.getattributes(node), attr)
            );
end getNodeAttr;
------------------------------------

--оплата одного
procedure OPLx (P_provID xml2_id.provID%type,
                p_servID xml2_id.servID%type,
                p_mfo    xml2_mfo.mfo%type,
                P_br3    xml2_br3.br3%type,
                p_S      oper.s%type
                ) is

   l_NBSA  xml2_bm.NBSA%type ; l_OB22A xml2_bm.OB22A%type ; l_KVA   xml2_bm.KVA%type   ;
   l_NBSB  xml2_bm.NBSB%type ; l_OB22B xml2_bm.OB22B%type ; l_DK    xml2_bm.DK%type    ;
   l_nlsa  oper.nlsa%type    ; l_nmsa  oper.nam_a%type    ; n980_   int := gl.baseval  ;
   l_nlsb  oper.nlsb%type    ; l_nmsb  oper.nam_b%type    ; l_branch branch.branch%type;
   ref_    oper.REF%type     ; vob_    oper.VOB%type      ; l_okpo  oper.id_b%type     ;
   q_      oper.S%type       ; isp_ oper.userid%type      ; tt_     oper.TT%type       ;
   l_Name  xml2_id.name%type ; l_bm     xml2_bm.bm%type   ; tto_    oper.TT%type       ;

begin

--if p_mfo = gl.aMfo   then RETURN; end if;


   Isp_  := gl.aUid;  if isp_ = 1 then isp_:=20094; end if;
   -----------------------------------------------------------
   begin
     select bm into l_bm from xml2_id
     where provID = P_provID and servID=P_servID and bm is not null;
   EXCEPTION WHEN NO_DATA_FOUND THEN
--RETURN;
     raise_application_error(-20100,
      '1)Не описана бух.мод для provID='|| p_provID || ' servID=' || p_servID  );
   end;

   begin
     select b.NBSA, b.OB22A, b.KVA, b.DK, b.NBSB, b.OB22B, b.bm,
            substr(b.name || ' '|| i.name,1,160)
     into   l_NBSA, l_OB22A, l_KVA, l_DK, l_NBSB, l_OB22B, l_bm, l_name
     from xml2_bm b, xml2_id i
     where i.provID = P_provID and i.servID=P_servID   and i.bm = b.bm
       and b.NBSA  is not null and b.OB22A is not null and b.KVA   is not null
       and b.NBSB  is not null and b.OB22B is not null and b.DK    is not null;
   EXCEPTION WHEN NO_DATA_FOUND THEN
--RETURN;
     raise_application_error(-20100,
      '2) Не описана бух.мод ='|| l_bm  );
   end;

   begin
--     select nls, substr(nms,1,38)  into l_nlsa,l_nmsa   from accounts
--     where kv= l_kva and nls = nbs_ob22_null ( l_nbsA, l_ob22A, '/' || gl.aMfo || '/' ) ;

     select nls, substr(nms,1,38)  into l_nlsa, l_nmsa   from accounts
     where kv     = l_kva
       and nbs    = l_nbsA
       and ob22   = l_ob22A
       and branch = '/' || gl.aMfo || '/'
       and dazs is null
       and rownum = 1  ;

   EXCEPTION WHEN NO_DATA_FOUND THEN
--RETURN;
     raise_application_error(-20100,
      '3) Не вiдкрито рах-А вал '||l_kva||' '||l_nbsA||'/'||l_ob22A||' для /'||gl.aMfo||'/') ;
   end;
   ----------------------------------------------
   If l_kva = n980_ then q_ := p_s ;
   else                  q_ := gl.p_icurval(l_kva, p_s, gl.bdate);
   end if;

   If p_mfo= gl.amfo then
      begin
        select substr(branch,1,15) into l_branch
        from xml2_br3 where br3 =P_br3 and branch is not null;
      EXCEPTION WHEN NO_DATA_FOUND THEN
--RETURN;
        raise_application_error(-20100,
        '4)Не описано бранч власного МФО BR3=' || p_br3 );
      end;

      begin
        select nls, substr(nms,1,38)  into l_nlsb,l_nmsb   from accounts
        where kv= n980_ and nls = nbs_ob22_null ( l_nbsB, l_ob22B, l_branch ) ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        raise_application_error(-20100,
        '5)Не вiдкрито рах-Б вал '||n980_||' '||l_nbsB||'/'||l_ob22B||
        ' для '|| l_branch ) ;
      end;

      If l_kva = n980_ then vob_:= 6;   else    vob_:=16;   end if;

   else
      begin
        select nls, substr(namex,1,38)  into  l_nlsb, l_nmsb    from xml2_mfo
        where br3 = P_br3 and mfo = P_mfo and bm = l_bm and nls is not null;
      EXCEPTION WHEN NO_DATA_FOUND THEN
--RETURN;
        raise_application_error(-20100,
       '6)Не описано бранч Mfo=' || p_mfo || ' BR3=' || p_br3 || ' BM= ' || l_bm);
      end;

      begin
        select okpo  into l_okpo from customer c, custbank b
        where b.rnk  = c.rnk     and b.mfo  = p_mfo
          and rownum = 1         and okpo is not null;
      EXCEPTION WHEN NO_DATA_FOUND THEN
--RETURN;
        raise_application_error(-20100, '7)Не знайдено ОКПО для Mfo=' || p_mfo );
      end;

   end if;

   If l_nlsb like '6%' then tt_:='D06'; else tt_:='D07'; end if;

   If p_mfo = gl.amfo then
      tto_ := tt_;
      -- для внутр - один реф. для вал и один для грн
      If RefG_ is null then

         gl.ref (REFG_);

         REF_:= REFG_;

        gl.in_doc3
           (ref_  => REF_   ,
            tt_   => tto_   ,
            vob_  => VOB_   ,
            nd_   => substr(to_char(REF_),1,10),
            pdat_ => SYSDATE,
            vdat_ => gl.BDATE,
            dk_   => l_dk   ,
            kv_   => l_kva  ,
            s_    => p_S    ,
            kv2_  => n980_  ,
            s2_   => Q_     ,
            sk_   => null   ,
            data_ => gl.BDATE,
            datp_ => gl.bdate,
            nam_a_=> l_nmsa ,
            nlsa_ => l_nlsa ,
            mfoa_ => gl.aMfo,
            nam_b_=> l_nmsb ,
            nlsb_ => l_nlsb ,
            mfob_ => gl.aMfo,
            nazn_ => substr ( p_br3 || ' ' || l_Name, 1,160 ),
            d_rec_=> null   ,
            id_a_ => gl.aOKPO,
            id_b_ => gl.aOKPO,
            id_o_ => null   ,
            sign_ => null   ,
            sos_  => 1      ,
            prty_ => null   ,
            uid_  => isp_)  ;
      else
         REF_:= REFG_;
      end if;

      payTT(0,REF_, gl.bDATE, TT_, l_dk, l_kva, l_nlsa, p_s, n980_, l_nlsb, q_);
      update opldok
             set txt = substr ( p_br3 || ' ' || l_Name, 1,70 )
             where ref =ref_ and stmt= gl.aStmt;

--    gl.pay(2,ref_, gl.bdate);

   else
      If l_dk = 0 then tto_ := 'PS9' ; else tto_ := 'PS2'; end if;
      gl.ref (REF_);
      gl.in_doc3
        (ref_  => REF_   ,
         tt_   => tto_   ,
         vob_  => 6      ,
         nd_   => substr(to_char(REF_),1,10),
         pdat_ => SYSDATE,
         vdat_ => gl.BDATE,
         dk_   => l_dk   ,
         kv_   => n980_  ,
         s_    => q_     ,
         kv2_  => n980_  ,
         s2_   => Q_     ,
         sk_   => null   ,
         data_ => gl.BDATE,
         datp_ => gl.bdate,
         nam_a_=> l_nmsa ,
         nlsa_ => l_nlsa ,
         mfoa_ => gl.aMfo,
         nam_b_=> l_nmsb ,
         nlsb_ => l_nlsb ,
         mfob_ => p_mfo,
         nazn_ => substr ( p_br3 || ':' || l_Name, 1,160 ),
         d_rec_=> null   ,
         id_a_ => gl.aOKPO,
         id_b_ => l_okpo ,
         id_o_ => null   ,
         sign_ => null   ,
         sos_  => 1      ,
         prty_ => null   ,
         uid_  => isp_)  ;

   if l_kva <> n980_ then
      payTT(0,REF_, gl.bDATE,TT_ ,l_dk, l_kva, l_nlsa, p_s, n980_, l_nlsa, q_);
   end if;

      payTT(0,REF_, gl.bDATE,TTo_,l_dk, n980_, l_nlsa, q_ , n980_, l_nlsb, q_);

   end if;

end OPLx;
-------------------------


-- вычитка XML2_
procedure GETX2 (p_Mode int, p_tag varchar2) is

  g_numb_mask varchar2(100) := '9999999999999999999999999D99999999';
  g_nls_mask  varchar2(100) := 'NLS_NUMERIC_CHARACTERS = ''.,''';

  l_clob   clob;
  l_parser dbms_xmlparser.Parser := dbms_xmlparser.newParser;
  l_doc    dbms_xmldom.DOMDocument;

  l_children dbms_xmldom.DOMNodeList;
  l_child    dbms_xmldom.DOMNode;
  l_length   number;
  ------------------------------
  l_bm       xml2_bm.bm%type      ;
  l_mfo      xml2_mfo.mfo%type    ;
  l_br3      xml2_br3.br3%type    ;
  l_namex    xml2_br3.namex%type  ;
  l_provID   xml2_id.provID%type  ;
  l_servID   xml2_id.servID%type  ;
  l_itemName xml2_id.name%type    ;
  l_docAmt   oper.s%type          ;

begin

  If p_Mode = 1 then
     -- вычитываем clob из врем НАТАШИНОЙ таблицы
     bars_lob.import_clob(l_clob);
     -- записываем его в свою таблицу
     delete from tmp_lob_XML2;
     insert into tmp_lob_XML2 (telo) values (l_clob);
  else
     select telo into l_clob from tmp_lob_XML2;
     RefG_ := null;
  end if;

  -- парсим
  dbms_xmlparser.parseClob(l_parser, l_clob);
  l_doc := dbms_xmlparser.getDocument(l_parser);


  -- вычитываем свой тег (параметр)
  l_children := dbms_xmldom.getElementsByTagName(l_doc, p_tag);
  l_length   := dbms_xmldom.getLength(l_children);


  for i in 0 .. l_length - 1
  loop

    l_child := dbms_xmldom.item(l_children, i);


    -- вычитывае нужные  атрибуты
    If p_tag in ('branch','docf3c') then

       l_mfo := XM2.getNodeAttr(l_child, 'mfo');
       l_br3 := XM2.getNodeAttr(l_child, 'br3');

       If p_tag = 'branch' and l_mfo = gl.amfo and p_Mode = 1 then
          -- бранчи своего МФО -- пополнение справочника
          l_namex := XM2.getNodeAttr(l_child, 'name');
          update xml2_br3 set namex=l_namex where  br3=l_br3;
          if SQL%rowcount = 0 then
             insert into xml2_br3 (br3, namex) values(l_br3, l_namex);
          end if;

       ElsIf p_tag = 'branch' and l_mfo <> gl.amfo and p_Mode = 1 then
          -- бранчи чужого  МФО -- пополнение справочника
          l_namex := XM2.getNodeAttr(l_child, 'name');
          update xml2_mfo set namex=l_namex where  br3=l_br3 and mfo = l_mfo;
          if SQL%rowcount = 0 then
             insert into xml2_mfo(mfo, br3, namex, bm) values (l_mfo,l_br3,l_namex,1);
          end if;

       elsIf p_tag ='docf3c' then
          l_provID   := XM2.getNodeAttr(l_child, 'provID');
          l_servID   := XM2.getNodeAttr(l_child, 'servID');
          l_itemName := XM2.getNodeAttr(l_child, 'itemName');

          If p_Mode = 1 then
             -- пополнение справочника
             update xml2_id set name=l_itemName where provID=l_provID and servID=l_servID;
             if SQL%rowcount = 0 then
                insert into xml2_id (provID,  servID,  name ) values (l_provID,l_servID,l_itemName);
             end if;

             If l_mfo <> gl.amfo then

                insert into xml2_mfo ( mfo,  br3,  namex,  bm)
                select l_mfo,l_br3, m.namex, i.bm
                from xml2_mfo m, xml2_id i
                where m.mfo    = l_mfo
                  and m.br3    = l_br3
                  and m.bm     = 1
                  and i.provID = l_provID
                  and i.servID = l_servID
                  and nvl(i.bm,1) <> 1
                  and not exists
             (select 1 from xml2_mfo where mfo=l_mfo and br3=l_br3 and bm=i.bm);

             end if ;

          elsIf p_Mode = 2 then

             l_docAmt :=
 NVL(ABS(to_number( getNodeAttr(l_child,'docAmt'),g_numb_mask,g_nls_mask))*100,0) +
 NVL(ABS(to_number( getNodeAttr(l_child,'PdvAmt'),g_numb_mask,g_nls_mask))*100,0)
   ;

             If l_docAmt > 0 then
                XM2.OPLx ( l_provID,l_servID, l_mfo, l_br3,l_docAmt);
             end if;


          end if;

       end if;

    end if;

  end loop;

  return;

end GETX2;
----------------

end xm2;
/
 show err;
 
PROMPT *** Create  grants  XM2 ***
grant EXECUTE                                                                on XM2             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on XM2             to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/xm2.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 