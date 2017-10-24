

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_PKC ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_PKC ("TABLE_NAME", "POLICY_GROUP", "OWNER", "WM_RIDCHILD", "WM_RIDPARENT", "WM_CHILDSTATE", "WM_PARENTSTATE", "WM_CHILDDS", "WM_PARENTDS", "WM_CHILDVER", "WM_PARENTVER", "WM_RIDBASE", "WM_BASEVER", "WM_BASEDS") AS 
  select o1.TABLE_NAME, o1.POLICY_GROUP, o1.OWNER,
       o1.WM_ridchild, o1.WM_ridparent, o1.WM_childstate, o1.WM_parentstate,
       o1.WM_childds, o1.WM_parentds, o1.WM_childver, o1.WM_parentver,
       cast(decode(o1.WM_basever, 
             -1, null,
             (select rowid from BARS.POLICY_TABLE_LT o2
              where (o1.TABLE_NAME = o2.TABLE_NAME AND o1.POLICY_GROUP = o2.POLICY_GROUP AND o1.OWNER = o2.OWNER )
                and o2.version = o1.WM_basever
                and o2.delstatus = o1.WM_baseds)
             ) as rowid) WM_ridbase,
       o1.WM_basever, o1.WM_baseds
     from
       (select o1.*, nvl(o2.SnapShotChild, 0) sc, nvl(o2.SnapShotParent, 0) sp, o2.value
        from BARS.POLICY_TABLE_bpkc o1,
             BARS.POLICY_TABLE_aux o2
         where (o1.WM_childstate = o2.childstate (+)
           and  o1.WM_parentstate = o2.parentstate (+)
           and  (o1.TABLE_NAME = o2.TABLE_NAME (+) AND o1.POLICY_GROUP = o2.POLICY_GROUP (+) AND o1.OWNER = o2.OWNER (+) ) )) o1
     where ((o1.sc != o1.WM_childds or o1.value = 0)
       and   o1.sp != o1.WM_parentds
       and  (o1.WM_childds > 0 or o1.WM_parentds > 0));

PROMPT *** Create  grants  POLICY_TABLE_PKC ***
grant SELECT                                                                 on POLICY_TABLE_PKC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_PKC.sql =========*** End *
PROMPT ===================================================================================== 
