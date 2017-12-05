

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_OB22.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_OB22 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_OB22 ("CODP", "TXT", "D_OPEN") AS 
  SELECT sb.r020 || sb.ob22 AS codp
      ,REPLACE(REPLACE(REPLACE(sb.txt, '¢', 'i'), '`?', 'º'),'?','I') txt
      ,sb.d_open
  FROM sb_ob22 sb, cck_ob22 cb
 WHERE sb.r020 = cb.nbs
   AND sb.ob22 = cb.ob22
   AND sb.r020 || sb.ob22 IN (decode(NEWNBS.GET_STATE,0,'220201','220354')
                             ,decode(NEWNBS.GET_STATE,0,'220202','220355')
                             ,decode(NEWNBS.GET_STATE,0,'220205','220356')
                             ,decode(NEWNBS.GET_STATE,0,'220206','220357')
                             ,decode(NEWNBS.GET_STATE,0,'220220','220358')
                             ,decode(NEWNBS.GET_STATE,0,'220227','220361')
                             ,decode(NEWNBS.GET_STATE,0,'220228','220362')
                             ,decode(NEWNBS.GET_STATE,0,'220232','220363')
                             ,decode(NEWNBS.GET_STATE,0,'220233','220364')
                             ,decode(NEWNBS.GET_STATE,0,'220234','220365')
                             ,decode(NEWNBS.GET_STATE,0,'220235','220366')
                             ,decode(NEWNBS.GET_STATE,0,'220238',null)
                             ,decode(NEWNBS.GET_STATE,0,'220239',null)
                             ,decode(NEWNBS.GET_STATE,0,'220240',null)
                             ,decode(NEWNBS.GET_STATE,0,'220241','220367')
                             ,decode(NEWNBS.GET_STATE,0,'220242','220368')
                             ,decode(NEWNBS.GET_STATE,0,'220243','220369')
                             ,decode(NEWNBS.GET_STATE,0,'220254','220378')
                             ,decode(NEWNBS.GET_STATE,0,'220255',null)
                             ,decode(NEWNBS.GET_STATE,0,'220256','220379')
                             ,decode(NEWNBS.GET_STATE,0,'220257','220380')
                             ,decode(NEWNBS.GET_STATE,0,'220258','220381')
                             ,decode(NEWNBS.GET_STATE,0,'220261','220384')
                             ,decode(NEWNBS.GET_STATE,0,'220262','220385')
                             ,'220301'
                             ,'220302'
                             ,'220304'
                             ,'220307'
                             ,'220308'
                             ,'220311'
                             ,'220312'
                             ,'220317'
                             ,'220321'
                             ,'220322'
                             ,'220323'
                             ,'220324'
                             ,'220325'
                             ,'220326'
                             ,'220330'
                             ,'220331'
                             ,'220332'
                             ,'220333'
                             ,'220334'
                             ,'220335'
                             ,'220336'
                             ,'220345'
                             ,'220346'
                             ,'220347'
                             ,'220348'
                             ,'220351'
                             ,'220352'
                             ,'223201'
                             ,'223202'
                             ,'223205'
                             ,'223206'
                             ,'223207'
                             ,'223301'
                             ,'223303'
                             ,'223305'
                             ,'223306'
                             ,'223307'
                             ,'223308'
                             ,'223309'
                             ,'223312'
                             ,'223313'
                             ,'223316'
                             ,'223317'
                             ,'223318'
                             ,'223319'
                             ,'223320'
                             ,'223321'
                             ,'223322')
 ORDER BY codp;

PROMPT *** Create  grants  V_WCS_OB22 ***
grant SELECT                                                                 on V_WCS_OB22      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_OB22.sql =========*** End *** ===
PROMPT ===================================================================================== 
