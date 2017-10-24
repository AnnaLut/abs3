

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_DIFF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view POLICY_TABLE_DIFF ***

  CREATE OR REPLACE FORCE VIEW BARS.POLICY_TABLE_DIFF ("TABLE_NAME", "SELECT_POLICY", "INSERT_POLICY", "UPDATE_POLICY", "DELETE_POLICY", "REPL_TYPE", "POLICY_GROUP", "OWNER", "POLICY_COMMENT", "CHANGE_TIME", "APPLY_TIME", "WHO_ALTER", "WHO_CHANGE", "WM_DIFFVER", "WM_CODE") AS 
  select TABLE_NAME,SELECT_POLICY,INSERT_POLICY,UPDATE_POLICY,DELETE_POLICY,REPL_TYPE,POLICY_GROUP,OWNER,POLICY_COMMENT,CHANGE_TIME,APPLY_TIME,WHO_ALTER,WHO_CHANGE, WM_diffver, WM_code  from
      (
        (select /*+ ORDERED USE_NL(other this) */
             other.TABLE_NAME,this.SELECT_POLICY,this.INSERT_POLICY,this.UPDATE_POLICY,this.DELETE_POLICY,this.REPL_TYPE,other.POLICY_GROUP,other.OWNER,this.POLICY_COMMENT,this.CHANGE_TIME,this.APPLY_TIME,this.WHO_ALTER,this.WHO_CHANGE,
             decode(t.val,
                    1, 'DiffBase',
                    decode(this.WM_rid,
                           other.WM_thisRID, decode(WM_dinfo,
                                             'diff1', sys_context('lt_ctx', 'diffInfo1'),
                                             sys_context('lt_ctx', 'diffInfo2')),
                           decode(WM_dinfo,
                                  'diff1', sys_context('lt_ctx', 'diffInfo2'),
                                  sys_context('lt_ctx', 'diffInfo1')))) WM_diffver,
             decode(this.WM_rid,
                    other.WM_baseRID, decode(t.val, 1, 'NC',
                                                    decode(sys_context('lt_ctx','isCRCase'),
                                                           'NO', 'NC',
                                                           decode(wm_thischildsourcever || ',' || wm_thischildsourceds,
                                                                  this.version || ',' || this.delstatus, 'NC',
                                                                  decode(sign(this.delstatus - 10), 0, 'I', -1, 'D', 1, 'U')))),
                    decode(sign(this.delstatus - 10), 0, 'I', -1, 'D', 1, 'U')) WM_code,
             decode(t.val,
                    1, '1',
                    decode(this.WM_rid,
                           other.WM_thisRID, decode(WM_dinfo,
                                                    'diff1', sys_context('lt_ctx','diff1Pos'),
                                                    sys_context('lt_ctx','diff2Pos')),
                           decode(WM_dinfo,
                                  'diff1', sys_context('lt_ctx','diff2Pos'),
                                  sys_context('lt_ctx','diff1Pos')))) WM_pos
    from BARS.POLICY_TABLE_PKD other,
         (select 1 val from dual union all select 2 val from dual) t,
         (select lt.*, lt.rowid WM_rid from BARS.POLICY_TABLE_LT lt) this
      where ((this.WM_rid = other.WM_thisRID and t.val=2) or
             (this.WM_rid = other.WM_baseRID and t.val=1) or
             (this.WM_rid = other.WM_otherRID and t.val=2)) and
            (this.TABLE_NAME = other.TABLE_NAME and this.POLICY_GROUP = other.POLICY_GROUP and this.OWNER = other.OWNER))
       union all 
       (select /*+ ORDERED */
               other.TABLE_NAME, cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)), other.POLICY_GROUP, other.OWNER, cast(NULL as VARCHAR2(1)), cast(NULL as DATE), cast(NULL as DATE), cast(NULL as VARCHAR2(1)), cast(NULL as VARCHAR2(1)),
               decode(t.val, 1, 'DiffBase',
                             decode(WM_dinfo, 'diff1', sys_context('lt_ctx', 'diffInfo2'),
                                            sys_context('lt_ctx', 'diffInfo1'))) WM_diffver,
               'NE' WM_code,
               decode(t.val, 1, '1',
                             decode(WM_dinfo, 'diff1', sys_context('lt_ctx','diff2Pos'),
                                              sys_context('lt_ctx','diff1Pos'))) WM_pos
        from BARS.POLICY_TABLE_PKD other,
             (select 1 val from dual union all select 2 val from dual) t
        where (WM_baseRID is null  and t.val=1) or
              (WM_otherRID is null and t.val=2))
       ) d order by TABLE_NAME,POLICY_GROUP,OWNER, WM_pos;

PROMPT *** Create  grants  POLICY_TABLE_DIFF ***
grant SELECT                                                                 on POLICY_TABLE_DIFF to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TABLE_DIFF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TABLE_DIFF to START1;
grant SELECT                                                                 on POLICY_TABLE_DIFF to WR_ALL_RIGHTS;
grant SELECT                                                                 on POLICY_TABLE_DIFF to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/POLICY_TABLE_DIFF.sql =========*** End 
PROMPT ===================================================================================== 
