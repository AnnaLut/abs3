

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PRVN_NBU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view PRVN_NBU ***

  CREATE OR REPLACE FORCE VIEW BARS.PRVN_NBU ("BRANCH", "FDAT", "KV", "ND", "NLS", "REZ", "REZQ", "RNK", "BV", "BVQ", "NMK", "REZ39", "REZQ39", "REZ23", "REZQ23", "ID", "TIP") AS 
  select BRANCH, FDAT,  KV, ND, NLS, REZ, REZQ, RNK, BV, BVQ, NMK, rez39, rezq39, rez23, rezq23, id, tip   from nbu23_rez where fdat = z23.B;

PROMPT *** Create  grants  PRVN_NBU ***
grant SELECT                                                                 on PRVN_NBU        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PRVN_NBU.sql =========*** End *** =====
PROMPT ===================================================================================== 
