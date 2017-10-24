create or replace force view bars.v_notportfolio_nbs as
select p."NBS",p."XAR",p."PAP",p."NAME",p."CLASS",p."CHKNBS",p."AUTO_STOP",p."D_CLOSE",p."SB"
    from ps p join notportfolio_nbs n on p.nbs = n.nbs;
grant select on BARS.V_NOTPORTFOLIO_NBS to BARS_ACCESS_DEFROLE;


