 PROMPT =====================================================================================  
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/F_GET_ADR_BPK.sql =========*** Run *** 
 PROMPT ===================================================================================== 
CREATE OR REPLACE FUNCTION BARS.F_GET_ADR_BPK (RK in varchar2,TYPE_A in numeric default 2) RETURN  varchar2
IS
  adr varchar2(290);

BEGIN
select
     zip||', '||
	 decode(domain,null,null,(domain||', '))||
     decode(st.SETTLEMENT_TP_CODE,null,null,(st.SETTLEMENT_TP_CODE||', '))||
	 decode(locality,null,null,(locality||', '))||
	 decode(strt.VALUE,null,null,(strt.VALUE||', '))||
	 decode(a.STREET,null,null,(a.STREET||', '))||
	 decode(aht.VALUE,null,null,(aht.VALUE||', '))||
	 decode(a.HOME,null,null,(a.HOME||', '))||
	 decode(ahpt.VALUE,null,null,(ahpt.VALUE||', '))||
	 decode(a.HOMEPART_TYPE,null,null,(a.HOMEPART_TYPE||', '))||
	 --case when a.ROOM is not null then	 
        decode(art.VALUE,null,null,(art.VALUE||', '))
     --   else null end 
     ||decode(a.ROOM,null,null,(a.ROOM||', ')) into adr
 from customer_address a, country c,
      adr_settlement_types st,
      ADDRESS_STREET_TYPE strt,
      ADR_HOME_TYPE aht,
      ADR_HOMEPART_TYPE ahpt,
      ADR_ROOM_TYPE art
 where
     a.rnk=RK
     and a.type_id=TYPE_A
     and c.country=a.country
     and a.locality_type = st.settlement_tp_id(+)
     and a.STREET_TYPE = strt.ID(+)
     and a.HOME_TYPE = aht.ID(+)    
     and a.HOMEPART_TYPE = ahpt.ID(+)    
     and a.ROOM_TYPE = art.ID(+);

RETURN adr ;

end;
/
 show err;
PROMPT *** Create  grants  F_GET_ADR_BPK ***
grant EXECUTE                                                                on F_GET_ADR_BPK       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ADR_BPK       to START1;
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/F_GET_ADR_BPK.sql =========*** End *** 
 PROMPT ===================================================================================== 
