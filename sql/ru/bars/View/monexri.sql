CREATE OR REPLACE FORCE VIEW BARS.MONEXRI
       ( KOD_NBU, Fdat1, fdat2, FL, RU, NAME_RU, KV, OB22, S_2909, K_2909, ek_2909, S_2809, K_2809, ek_2809, S_0000, K_0000, ek_0000, I_2909, R_2809, RK_2809, ERK_2809, S_3739 ) AS
SELECT i.kod_nbu, i.FDAT1 , i.FDAT2 ,  i.fl   , NVL (i.RU, -1), NVL (r.name, 'Íå âèçí.êîä ĞÓ'), i.KV,   i.ob22,
       i.S_2909 , i.K_2909, i.ek_2909, i.S_2809, i.K_2809, i.ek_2809, i.S_0000 , i.K_0000, i.ek_0000, i.I_2909 , i.R_2809 , i.RK_2809, i.ERK_2809, i.S_3739
FROM 
    (SELECT r.kod_nbu, min(r.FDAT) fdat1, max(r.FDAT) fdat2, r.fl, mfo_ru(SUBSTR(r.branch,2,6)) RU, r.kv , r.ob22,
            SUM(r.S_2909) S_2909 , SUM(NVL2(c.CCLC,0,r.K_2909)) k_2909, SUM(NVL2(c.CCLC,r.K_2909,0)) ek_2909, SUM(r.S_2809) S_2809, SUM(NVL2(c.CCLC,0,r.k_2809)) k_2809, SUM(NVL2(c.CCLC,r.k_2809,0)) ek_2809,
            SUM(r.S_0000) S_0000 , SUM(NVL2(c.CCLC,0,r.K_0000)) k_0000, SUM(NVL2(c.CCLC,r.k_0000,0)) ek_0000, SUM(r.S_2909 + NVL2(c.CCLC,0,r.K_2909)) I_2909, SUM(r.S_2809 +r.S_0000) R_2809, SUM(NVL2(c.CCLC,0,r.K_2809) +NVL2(c.CCLC,0,r.K_0000)) RK_2809,
			SUM(NVL2(c.CCLC,r.K_2809,0) +NVL2(c.CCLC,r.K_0000,0)) ERK_2809, SUM(r.S_2809+r.S_0000+NVL2(c.CCLC,0,r.K_2809)+NVL2(c.CCLC,0,r.K_0000)-r.S_2909-NVL2(c.CCLC,0,r.K_2909)) S_3739
     FROM monexr r
     inner join V_SFDAT v on r.fdat >= v.B and r.fdat <= v.E
     left join monex0 m on m.KOD_NBU = r.KOD_NBU
     left join SWI_MTI_LIST l on NVL(l.OB22_2909,'0') = NVL(m.OB22,'0') and NVL(l.OB22_2809,'0') = NVL(m.OB22_2809,'0') and NVL(l.OB22_KOM,'0') = NVL(m.OB22_KOM,'0')
     left join SWI_MTI_CURR c on l.NUM = c.NUM and c.kv = r.kv
     GROUP BY r.kod_nbu, r.fl, mfo_ru(SUBSTR(r.branch,2,6)),  r.kv,  r.ob22
     ) i
left join banks_ru r on i.ru = r.ru
  UNION ALL
     SELECT r.kod_nbu, min(r.FDAT) fdat1, max(r.FDAT) fdat2, r.fl, TO_NUMBER (NULL)  RU, 'ĞÀÇÎÌ ïî Ñèñò+Âàë', 
            r.KV , r.ob22,
            SUM(r.S_2909) S_2909 , SUM(NVL2(c.CCLC,0,r.K_2909)) k_2909, SUM(NVL2(c.CCLC,r.K_2909,0)) ek_2909, SUM(r.S_2809) S_2809,   SUM(NVL2(c.CCLC,0,r.k_2809)) k_2809, SUM(NVL2(c.CCLC,r.k_2809,0)) ek_2809,
            SUM(r.S_0000) S_0000 , SUM(NVL2(c.CCLC,0,r.K_0000)) k_0000, SUM(NVL2(c.CCLC,r.k_0000,0)) ek_0000, SUM(r.S_2909 + NVL2(c.CCLC,0,r.K_2909)) I_2909, SUM(r.S_2809 +r.S_0000) R_2809, SUM(NVL2(c.CCLC,0,r.K_2809) +NVL2(c.CCLC,0,r.K_0000)) RK_2809,
			SUM(NVL2(c.CCLC,r.K_2809,0) +NVL2(c.CCLC,r.K_0000,0)) ERK_2809, SUM(r.S_2809+r.S_0000+NVL2(c.CCLC,0,r.K_2809)+NVL2(c.CCLC,0,r.K_0000)-r.S_2909-NVL2(c.CCLC,0,r.K_2909)) S_3739
     FROM monexr r
     inner join V_SFDAT v on r.fdat >= v.B and r.fdat <= v.E
     left join monex0 m on m.KOD_NBU = r.KOD_NBU
     left join SWI_MTI_LIST l on NVL(l.OB22_2909,'0') = NVL(m.OB22,'0') and NVL(l.OB22_2809,'0') = NVL(m.OB22_2809,'0') and NVL(l.OB22_KOM,'0') = NVL(m.OB22_KOM,'0')
     left join SWI_MTI_CURR c on l.NUM = c.NUM and c.kv = r.kv
     GROUP BY r.kod_nbu, r.fl, r.kv, r.ob22
  UNION ALL
     SELECT r.kod_nbu, min(r.FDAT) fdat1, max(r.FDAT) fdat2, r.fl, TO_NUMBER (NULL)  RU, 'ĞÀÇÎÌ ïî êîì. äîõ. ÂÏ â ãğí.', 
            980 kv, r.ob22,
            0 S_2909 , 0 k_2909, SUM(NVL2(c.CCLC,r.K_2909,0)) ek_2909, 0 S_2809,   0 k_2809, SUM(NVL2(c.CCLC,r.k_2809,0)) ek_2809,
            0 S_0000 , 0 k_0000, SUM(NVL2(c.CCLC,r.k_0000,0)) ek_0000, 0 I_2909, 0 R_2809, 0 RK_2809,
			SUM(NVL2(c.CCLC,r.K_2809,0) +NVL2(c.CCLC,r.K_0000,0)) ERK_2809, SUM(-NVL2(c.CCLC,r.K_2909,0)+NVL2(c.CCLC,r.k_2809,0)+NVL2(c.CCLC,r.k_0000,0)) S_3739
     FROM monexr r
     inner join V_SFDAT v on r.fdat >= v.B and r.fdat <= v.E
     left join monex0 m on m.KOD_NBU = r.KOD_NBU
     left join SWI_MTI_LIST l on NVL(l.OB22_2909,'0') = NVL(m.OB22,'0') and NVL(l.OB22_2809,'0') = NVL(m.OB22_2809,'0') and NVL(l.OB22_KOM,'0') = NVL(m.OB22_KOM,'0')
     left join SWI_MTI_CURR c on l.NUM = c.NUM and c.kv = r.kv
GROUP BY r.kod_nbu, r.fl, r.ob22 ;
/

grant select, insert, update, delete on MONEXRI to bars_access_defrole
/	 