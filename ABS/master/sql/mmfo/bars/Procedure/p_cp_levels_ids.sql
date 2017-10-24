

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_LEVELS_IDS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_LEVELS_IDS ***

  CREATE OR REPLACE PROCEDURE BARS.P_CP_LEVELS_IDS (p_date_start date, p_date_finish date)
is
begin 
 bc.go(f_ourmfo_g);
 execute immediate 'truncate table CP_HIERARCHY_IDS';
 execute immediate 'truncate table CP_HIERARCHY_IDSREFS';
for k in (   SELECT distinct ds,df,h_id,cp_id,rnk
    FROM (SELECT ck.rnk,
                 GREATEST (cph.fdat, p_date_start) ds,
                 GREATEST (NVL (LEAD (cph.fdat, 1) OVER (PARTITION BY cph.cp_id ORDER BY cph.fdat ASC), p_date_finish),p_date_finish) AS df,
                 cph.HIERARCHY_ID h_id,
                 cph.cp_id
            FROM CP_HIERARCHY_HIST cph, cp_kod ck
           WHERE     (   cph.fdat BETWEEN p_date_start AND p_date_finish
                      OR (cph.fdat <= p_date_start and f_cp_get_hierarchy (ck.id, p_date_finish) = cph.HIERARCHY_ID))
                 AND cph.cp_id = ck.id
                 and CK.DATP >= p_date_start) a,
         cp_hierarchy ch
   WHERE a.h_id = ch.ID
ORDER BY 3 )
loop
 insert into CP_HIERARCHY_IDS (RNK,NBS,ID,DATE_START,DATE_FINISH,HIERARCHY_REP,H1,H2,R_INT, R_PAY, BV, BV_END, TR, BOUGHT, SOLD, SETTLED,RESERVED,RANSOM,OVERPRICED)
 values(
 k.rnk, (select concatstr(vidd) from cp_v where id = k.cp_id),
 k.cp_id, k.ds, k.df, k.h_id,
 f_cp_get_hierarchy (k.cp_id, p_date_start),
 f_cp_get_hierarchy (k.cp_id, p_date_finish),
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'R', k.h_id)+f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'D', k.h_id)-f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'P', k.h_id)-f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'UNREC', k.h_id), --R_INT 
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'RR2', k.h_id), --R_PAY
 f_cp_get_bvondate(k.cp_id, 'BV', k.ds),--BV
 f_cp_get_bvondate(k.cp_id, 'BV', k.df),--BV_END
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'TR', k.h_id),
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'BOUGHT', k.h_id),
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'SOLD', k.h_id),
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'SETTLED', k.h_id),
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'RESERVED', k.h_id),
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'RANSOM', k.h_id),
 f_cp_hierarchy_All_int(k.cp_id,k.ds, k.df, 'OVERPRICED', k.h_id) 
 );
 
 insert into CP_HIERARCHY_IDSREFS (RNK,NBS,ID,DATE_START,DATE_FINISH,HIERARCHY_REP,H1,H2,R_INT, R_PAY, BV, BV_END, TR, BOUGHT, SOLD, SETTLED,RESERVED,RANSOM,OVERPRICED)
 values(k.rnk, (select concatstr(vidd) from cp_v where id = k.cp_id),
 k.cp_id, k.ds, k.df, k.h_id,
 f_cp_get_hierarchy (k.cp_id, p_date_start),
 f_cp_get_hierarchy (k.cp_id, p_date_finish),
 '',--substr(f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'R', k.h_id)|| f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'D', k.h_id)||f_cp_hierarchy_All_int_REF(k.cp_id,k.ds, k.df, 'P', k.h_id)||f_cp_hierarchy_All_int_ref(k.cp_id,k.ds, k.df, 'UNREC', k.h_id),4000), --R_INT 
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'RR2', k.h_id), --R_PAY
 f_cp_get_bvondate(k.cp_id, 'BV', k.ds),--BV
 f_cp_get_bvondate(k.cp_id, 'BV', k.df),--BV_END
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'TR', k.h_id),
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'BOUGHT', k.h_id),
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'SOLD', k.h_id),
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'SETTLED', k.h_id),
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'RESERVED', k.h_id),
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'RANSOM', k.h_id),
 f_cp_hierarchy_All_int_Ref(k.cp_id,k.ds, k.df, 'OVERPRICED', k.h_id) 
 );
 
 end loop;
end;
/
show err;

PROMPT *** Create  grants  P_CP_LEVELS_IDS ***
grant EXECUTE                                                                on P_CP_LEVELS_IDS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_LEVELS_IDS.sql =========*** E
PROMPT ===================================================================================== 
