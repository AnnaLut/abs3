
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_role_admin.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ROLE_ADMIN wrapped
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
3
9
9200000
1
4
0
10
2 :e:
1PACKAGE:
1BARS_ROLE_ADMIN:
1VERSION_HEADER:
1CONSTANT:
1VARCHAR2:
164:
1version 1.01 06.09.2007:
1VERSION_HEADER_DEFS:
1512:
1:
1SET_ROLEAUTH_ON:
1SET_ROLEAUTH_OFF:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1BODY_VERSION:
0

0
0
33
2
0 a0 97 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 9a b4 55 6a 9a
b4 55 6a a0 8d a0 b4 a0
2c 6a a0 8d a0 b4 a0 2c
6a a0 :2 aa 59 58 1d 17 b5
33
2
0 3 7 32 15 19 1d 20
21 29 2e 14 57 3d 41 11
45 46 4e 53 3c 5e 39 72
76 7a 8e 8f 93 97 9b af
b3 b4 b8 bc c0 c4 d8 dc
dd e1 e5 e9 ed ef f1 f4
f7 f8 101
33
2
0 1 9 5 1a 23 2c 2b
23 34 1a :2 5 1a 23 2c 2b
23 34 1a 5 f 0 :2 5 f
0 :3 5 e 1d 0 24 :3 5 e
1b 0 22 :3 5 :7 1
33
4
0 :2 1 :9 11 :9 12
1d 0 :2 1d 27
0 :2 27 :3 31 0
:3 31 :3 3a 0 :3 3a
3d :7 1
103
4
:3 0 1 :3 0 2
:6 0 1 :2 0 9
:2 0 5 4 :3 0
5 :3 0 6 :2 0
3 5 7 :6 0
7 :4 0 b 8
9 2c 3 :9 0
9 4 :3 0 5
:3 0 7 e 10
:6 0 a :4 0 14
11 12 2c 8
:6 0 b :a 0 18
2 :7 0 16 :2 0
18 15 17 0
2c c :a 0 1c
3 :8 0 1a :2 0
1c 19 1b 0
2c d :3 0 e
:a 0 23 4 :7 0
f :4 0 5 :3 0
20 21 0 23
1e 22 0 2c
d :3 0 10 :a 0
2a 5 :7 0 f
:4 0 5 :3 0 27
28 0 2a 25
29 0 2c 2
:3 0 b 2e 0
2e 2c 2d 2f
2 2e 31 0
30 2f 32 :8 0

12
4
:3 0 1 6 1
3 1 f 1
c 6 a 13
18 1c 23 2a

1
4
0
31
0
1
14
5
7
0 1 1 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0
25 1 5
3 1 0
15 1 2
2 0 1
19 1 3
1e 1 4
c 1 0
0
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ROLE_ADMIN wrapped
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
3
b
9200000
1
4
0
97
2 :e:
1PACKAGE:
1BODY:
1BARS_ROLE_ADMIN:
1VERSION_BODY:
1CONSTANT:
1VARCHAR2:
164:
1version 1.02 18.09.2007:
1VERSION_BODY_DEFS:
1512:
1:
1PARAM_ROLEAUTH:
1PARAMS:
1PAR:
1TYPE:
1ROLEAUTH:
1AUTH_OFF:
1NUMBER:
10:
1AUTH_ON:
11:
1ROLEAUTH_NONE:
1ROLEAUTH_APP:
1ISET_ROLEAUTH_PARAM:
1P_STATE:
1L_CNT:
1L_TABNAME:
130:
1BARS_AUDIT:
1TRACE:
1roleadm.isetpar:: entry point par[0]=>%s:
1TO_CHAR:
1COUNT:
1USER_TABLES:
1TABLE_NAME:
1=:
1PARAMS$GLOBAL:
1roleadm.isetpar:: global params is %s:
1>:
1roleadm.isetpar:: par tabname is %s:
1EXECUTE:
1IMMEDIATE:
1insert into :
1||:
1(par, val) values (::par, ::val):
1USING:
1roleadm.isetpar:: param added.:
1DUP_VAL_ON_INDEX:
1roleadm.isetpar:: param already exists:
1update :
1 set val = ::val where par = ::par:
1roleadm.isetpar:: param is set.:
1roleadm.isetpar:: succ end:
1ICHG_ROLEAUTH:
1P_ROLENAME:
1P_AUTHTYPE:
1L_DATABUF:
14000:
1L_DATAHASH:
1L_ROLEPWD:
148:
1L_ROLEID:
1ROLES$BASE:
1ROLE_ID:
1roleadm.ichgrauth:: entry point par[0]=>%s par[1]=>%s:
1alter role :
1 not identified:
1ROLE_NAME:
1COMMIT:
1roleadm.igenpwd:: role %s changed (password cleared):
1 identified using bars.bars_role_auth:
1roleadm.igenpwd:: role %s changed (app auth):
1ISET_USER_DEFROLE:
1P_ROLEAUTH:
1L_DEFROLE:
1L_DEFROLES:
1L_AUTH:
1L_SETDEFROLE:
1BOOLEAN:
1L_EXCLDEFROLE:
1L_EXCLROLE:
1roleadm.isetusrdr:: entry point par[0]=>%s:
1ROLENAME:
1R:
1BARSROLES:
1ROLETYPE:
1U:
1B:
1AUTHENTICATED:
1EXISTS:
1NOT:
1ROLEID:
1ROWNUM:
1<=:
1NO_DATA_FOUND:
1roleadm.isetusrdr:: default role is %s:
1C:
1S:
1LOGNAME:
1STAFF$BASE:
1DBA_USERS:
1USERNAME:
1BARS:
1HIST:
1LOOP:
1roleadm.isetusrdr:: looking for user %s:
1TRUE:
1FALSE:
1C2:
1GRANTED_ROLE:
1ROLE:
1DBA_ROLE_PRIVS:
1GRANTEE:
1DEFAULT_ROLE:
1YES:
1roleadm.isetusrdr:: user role %s:
1NVL:
1, :
1roleadm.isetusrdr:: default role list is %s:
1IS NOT NULL:
1grant :
1 to :
1IS NULL:
1alter user :
1 default role none:
1 default role :
1roleadm.isetusrdr:: user %s changed:
1roleadm.isetusrdr:: user %s not changed:
1roleadm.isetusrdr:: succ end:
1ISET_ROLEAUTH:
1roleadm.isetrole:: entry point par[0]=>%s:
1AUTH:
1roleadm.isetrole:: succ end:
1SET_ROLEAUTH_ON:
1roleadm.setroleon:: entry point:
1roleadm.setroleon:: succ end:
1SET_ROLEAUTH_OFF:
1roleadm.setroleoff:: entry point:
1roleadm.setroleoff:: succ end:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1package header BARS_ROLE_ADMIN :
1VERSION_HEADER:
1CHR:
110:
1package header definition(s):::
1VERSION_HEADER_DEFS:
1BODY_VERSION:
1package body BARS_ROLE_ADMIN :
1package body definition(s):::
0

0
0
43d
2
0 :2 a0 97 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :3 a0 6b :2 a0 f
1c 6e 1b b0 87 :2 a0 1c 51
1b b0 87 :2 a0 1c 51 1b b0
87 :2 a0 1c 51 1b b0 87 :2 a0
1c 51 1b b0 9a 8f a0 b0
3d b4 55 6a a3 a0 1c 81
b0 a3 a0 51 a5 1c 81 b0
:2 a0 6b 6e :2 a0 a5 b a5 57
a0 d2 9f ac :2 a0 b2 ee a0
7e 6e b4 2e ac e5 d0 b2
e9 :2 a0 6b 6e :2 a0 a5 b a5
57 a0 7e 51 b4 2e 5a a0
6e d b7 a0 6e d b7 :2 19
3c :2 a0 6b 6e a0 a5 57 :2 a0
6e 7e a0 b4 2e 7e 6e a0
b4 2e a0 112 :2 a0 a5 b 112
11e 11a 11d :2 a0 6b 6e a5 57
b7 :3 a0 6b 6e a5 57 :2 a0 6e
7e a0 b4 2e 7e 6e a0 b4
2e :2 a0 a5 b 112 a0 112 11e
11a 11d :2 a0 6b 6e a5 57 b7
a6 9 a4 b1 11 4f :2 a0 6b
6e a5 57 b7 a4 a0 b1 11
68 4f 9a 8f a0 b0 3d 8f
a0 b0 3d b4 55 6a a3 a0
51 a5 1c 81 b0 a3 a0 51
a5 1c 81 b0 a3 a0 51 a5
1c 81 b0 a3 :2 a0 6b :2 a0 f
1c 81 b0 :2 a0 6b 6e :3 a0 a5
b a5 57 :2 a0 7e b4 2e 5a
:2 a0 6e 7e a0 b4 2e 7e 6e
b4 2e 11e 11d :2 a0 4d e7 :2 a0
7e b4 2e ef f9 e9 a0 57
a0 b4 e9 :2 a0 6b 6e a0 a5
57 b7 :2 a0 6e 7e a0 b4 2e
7e 6e b4 2e 11e 11d :2 a0 4d
e7 :2 a0 7e b4 2e ef f9 e9
a0 57 a0 b4 e9 :2 a0 6b 6e
a0 a5 57 b7 :2 19 3c b7 a4
a0 b1 11 68 4f 9a 8f a0
b0 3d b4 55 6a a3 a0 51
a5 1c 81 b0 a3 a0 51 a5
1c 81 b0 a3 a0 1c 81 b0
a3 a0 1c 81 b0 a3 a0 1c
81 b0 a3 a0 1c 81 b0 :2 a0
6b 6e :2 a0 a5 b a5 57 a0
ac :3 a0 6b ac :2 a0 b9 b2 ee
:2 a0 6b 7e 6e b4 2e 51 ac
:2 a0 b9 b2 ee :2 a0 6b a0 7e
a0 6b b4 2e :2 a0 6b 7e 51
b4 2e a 10 a0 7e 51 b4
2e a 10 ac d0 eb 7e b4
2e 7e b4 2e a 10 ac d0
a0 de ac eb b2 ee a0 7e
51 b4 2e ac e5 d0 b2 e9
b7 a0 4f b7 a6 9 a4 b1
11 4f :2 a0 6b 6e a0 a5 57
91 :2 a0 6b ac :2 a0 b9 :2 a0 b9
b2 ee :2 a0 6b a0 7e a0 6b
b4 2e :2 a0 6b 4c :2 6e 5 48
a 10 ac d0 e5 e9 37 :3 a0
6b 6e :2 a0 6b a5 57 :2 a0 d
:2 a0 d :2 a0 d 91 :2 a0 b9 ac
a0 b2 ee :2 a0 7e a0 6b b4
2e a0 7e 6e b4 2e a 10
ac d0 e5 e9 37 :3 a0 6b 6e
:2 a0 6b a5 57 :2 a0 d :2 a0 6b
a0 7e b4 2e 5a :2 a0 d :2 a0
d b7 19 3c :2 a0 7e b4 2e
5a :2 a0 51 a5 b ac :2 a0 b2
ee :2 a0 7e a0 6b b4 2e ac
e5 d0 b2 e9 a0 7e 51 b4
2e 5a :2 a0 d :2 a0 d b7 19
3c b7 a0 4f b7 a6 9 a4
b1 11 4f b7 19 3c a0 7e
b4 2e 5a :2 a0 7e 6e b4 2e
7e :2 a0 6b b4 2e d b7 19
3c b7 a0 47 :2 a0 6b 6e a0
a5 57 :2 a0 52 10 5a :2 a0 7e
b4 2e a 10 5a :2 a0 6e 7e
a0 b4 2e 7e 6e b4 2e 7e
:2 a0 6b b4 2e 11e 11d b7 19
3c a0 7e b4 2e 5a :2 a0 6e
7e :2 a0 6b b4 2e 7e 6e b4
2e 11e 11d b7 :2 a0 6e 7e :2 a0
6b b4 2e 7e 6e b4 2e 7e
a0 b4 2e 11e 11d b7 :2 19 3c
:2 a0 6b 6e :2 a0 6b a5 57 b7
:2 a0 6b 6e :2 a0 6b a5 57 b7
:2 19 3c b7 a0 47 :2 a0 6b 6e
a5 57 b7 a4 a0 b1 11 68
4f 9a 8f a0 b0 3d b4 55
6a :2 a0 6b 6e :2 a0 a5 b a5
57 91 :3 a0 51 a5 b a0 b9
ac a0 b2 ee ac d0 e5 e9
37 :3 a0 7e b4 2e 5a :3 a0 6b
:2 a0 6b a5 57 b7 :3 a0 6b a0
a5 57 b7 :2 19 3c b7 a0 47
:2 a0 a5 57 :2 a0 a5 57 a0 57
a0 b4 e9 :2 a0 6b 6e a5 57
b7 a4 a0 b1 11 68 4f 9a
b4 55 6a :2 a0 6b 6e a5 57
:2 a0 a5 57 :2 a0 6b 6e a5 57
b7 a4 a0 b1 11 68 4f 9a
b4 55 6a :2 a0 6b 6e a5 57
:2 a0 a5 57 :2 a0 6b 6e a5 57
b7 a4 a0 b1 11 68 4f a0
8d a0 b4 a0 2c 6a a0 6e
7e a0 b4 2e 7e a0 51 a5
b b4 2e 7e 6e b4 2e 7e
a0 51 a5 b b4 2e 7e a0
b4 2e 65 b7 a4 a0 b1 11
68 4f a0 8d a0 b4 a0 2c
6a a0 6e 7e a0 b4 2e 7e
a0 51 a5 b b4 2e 7e 6e
b4 2e 7e a0 51 a5 b b4
2e 7e a0 b4 2e 65 b7 a4
a0 b1 11 68 4f b1 b7 a4
11 a0 b1 56 4f 1d 17 b5
43d
2
0 3 7 b 36 19 1d 21
24 25 2d 32 18 5b 41 45
15 49 4a 52 57 40 90 66
6a 6e 3d 72 76 7a 7f 87
8c 65 af 9b 9f a3 62 ab
9a ce ba be c2 97 ca b9
ed d9 dd e1 b6 e9 d8 10c
f8 fc 100 d5 108 f7 113 12f
12b f4 137 12a 13c 140 159 148
14c 154 127 175 160 164 167 168
170 147 17c 180 144 184 189 18d
191 192 194 195 19a 19e 1a2 1a5
1a6 1aa 1ae 1af 1b6 1ba 1bd 1c2
1c3 1c8 1c9 1cf 1d3 1d4 1d9 1dd
1e1 1e4 1e9 1ed 1f1 1f2 1f4 1f5
1fa 1fe 201 204 205 20a 20d 211
216 21a 21c 220 225 229 22b 22f
233 236 23a 23e 241 246 24a 24b
250 254 258 25d 260 264 265 26a
26d 272 276 277 27c 280 281 285
289 28a 28c 28d 292 293 297 29b
29f 2a2 2a7 2a8 2ad 2af 2b3 2b7
2bb 2be 2c3 2c4 2c9 2cd 2d1 2d6
2d9 2dd 2de 2e3 2e6 2eb 2ef 2f0
2f5 2f9 2fd 2fe 300 301 305 306
30b 30c 310 314 318 31b 320 321
326 328 329 32e 332 334 340 342
346 34a 34d 352 353 358 35a 35e
362 364 370 374 376 392 38e 38d
39a 3a7 3a3 38a 3af 3a2 3b4 3b8
3d2 3c0 39f 3c4 3c5 3cd 3bf 3ef
3dd 3bc 3e1 3e2 3ea 3dc 40c 3fa
3d9 3fe 3ff 407 3f9 439 417 41b
3f6 41f 423 427 42c 434 416 440
444 413 448 44d 451 455 459 45a
45c 45d 462 466 46a 46d 46e 473
476 47a 47e 483 486 48a 48b 490
493 498 499 49e 4a3 4a7 4ab 4af
4b0 4b2 4b6 4ba 4bd 4be 4c3 4c9
4ca 4cf 4d3 4d8 4dc 4dd 4e2 4e6
4ea 4ed 4f2 4f6 4f7 4fc 4fe 502
506 50b 50e 512 513 518 51b 520
521 526 52b 52f 533 537 538 53a
53e 542 545 546 54b 551 552 557
55b 560 564 565 56a 56e 572 575
57a 57e 57f 584 586 58a 58e 591
593 597 59b 59d 5a9 5ad 5af 5cb
5c7 5c6 5d3 5c3 5d8 5dc 5f9 5e4
5e8 5eb 5ec 5f4 5e3 616 604 5e0
608 609 611 603 632 621 625 62d
600 64a 639 63d 645 620 666 655
659 661 61d 67e 66d 671 679 654
685 689 651 68d 692 696 69a 69b
69d 69e 6a3 6a7 6a8 6ac 6b0 6b4
6b7 6b8 6bc 6c0 6c2 6c3 6ca 6ce
6d2 6d5 6d8 6dd 6de 6e3 6e6 6e7
6eb 6ef 6f1 6f2 6f9 6fd 701 704
708 70b 70f 712 713 718 71c 720
723 726 729 72a 1 72f 734 738
73b 73e 73f 1 744 749 74a 74e
752 755 756 75b 75e 75f 1 764
769 76a 76e 772 774 775 779 77a
781 785 788 78b 78c 791 792 798
79c 79d 7a2 7a4 7a8 7aa 7ac 7ad
7b2 7b6 7b8 7c4 7c6 7ca 7ce 7d1
7d6 7da 7db 7e0 7e4 7e8 7ec 7ef
7f0 7f4 7f8 7fa 7fe 802 804 805
80c 810 814 817 81b 81e 822 825
826 82b 82f 833 1 836 83b 840
844 1 847 84c 84d 851 857 85c
85e 862 866 86a 86d 872 876 87a
87d 87e 883 887 88b 88f 893 897
89b 89f 8a3 8a7 8ab 8af 8b3 8b5
8b6 8ba 8bb 8c2 8c6 8ca 8cd 8d1
8d4 8d5 8da 8de 8e1 8e6 8e7 1
8ec 8f1 8f2 8f6 8fc 901 903 907
90b 90f 912 917 91b 91f 922 923
928 92c 930 934 938 93c 93f 943
946 947 94c 94f 953 957 95b 95f
963 967 969 96d 970 974 978 97b
97c 981 984 988 98c 98f 990 992
993 997 99b 99c 9a3 9a7 9ab 9ae
9b2 9b5 9b6 9bb 9bc 9c2 9c6 9c7
9cc 9d0 9d3 9d6 9d7 9dc 9df 9e3
9e7 9eb 9ef 9f3 9f7 9f9 9fd a00
a02 a06 a08 a0a a0b a10 a14 a16
a22 a24 a26 a2a a2d a31 a34 a35
a3a a3d a41 a45 a48 a4d a4e a53
a56 a5a a5e a61 a62 a67 a6b a6d
a71 a74 a76 a7a a81 a85 a89 a8c
a91 a95 a96 a9b a9f 1 aa3 aa8
aab aaf ab3 ab6 ab7 1 abc ac1
ac4 ac8 acc ad1 ad4 ad8 ad9 ade
ae1 ae6 ae7 aec aef af3 af7 afa
afb b00 b05 b09 b0b b0f b12 b16
b19 b1a b1f b22 b26 b2a b2f b32
b36 b3a b3d b3e b43 b46 b4b b4c
b51 b56 b5a b5c b60 b64 b69 b6c
b70 b74 b77 b78 b7d b80 b85 b86
b8b b8e b92 b93 b98 b9d ba1 ba3
ba7 bab bae bb2 bb6 bb9 bbe bc2
bc6 bc9 bca bcf bd1 bd5 bd9 bdc
be1 be5 be9 bec bed bf2 bf4 bf8
bfc bff c01 c05 c0c c10 c14 c17
c1c c1d c22 c24 c28 c2c c2e c3a
c3e c40 c5c c58 c57 c64 c54 c69
c6d c71 c75 c79 c7c c81 c85 c89
c8a c8c c8d c92 c96 c9a c9e ca2
ca5 ca6 ca8 cac cae caf cb3 cb4
cbb cbc cc0 cc6 ccb ccd cd1 cd5
cd9 cdc cdd ce2 ce5 ce9 ced cf1
cf4 cf8 cfc cff d00 d05 d07 d0b
d0f d13 d16 d1a d1b d20 d22 d26
d2a d2d d2f d33 d3a d3e d42 d43
d48 d4c d50 d51 d56 d5a d5f d63
d64 d69 d6d d71 d74 d79 d7a d7f
d81 d85 d89 d8b d97 d9b d9d db1
db2 db6 dba dbe dc2 dc5 dca dcb
dd0 dd4 dd8 dd9 dde de2 de6 de9
dee def df4 df6 dfa dfe e00 e0c
e10 e12 e26 e27 e2b e2f e33 e37
e3a e3f e40 e45 e49 e4d e4e e53
e57 e5b e5e e63 e64 e69 e6b e6f
e73 e75 e81 e85 e87 e8b e9f ea3
ea4 ea8 eac eb0 eb4 eb9 ebc ec0
ec1 ec6 ec9 ecd ed0 ed1 ed3 ed4
ed9 edc ee1 ee2 ee7 eea eee ef1
ef2 ef4 ef5 efa efd f01 f02 f07
f0b f0d f11 f15 f17 f23 f27 f29
f2d f41 f45 f46 f4a f4e f52 f56
f5b f5e f62 f63 f68 f6b f6f f72
f73 f75 f76 f7b f7e f83 f84 f89
f8c f90 f93 f94 f96 f97 f9c f9f
fa3 fa4 fa9 fad faf fb3 fb7 fb9
fc5 fc9 fcb fcd fcf fd3 fdf fe3
fe5 fe8 fea feb ff4
43d
2
0 1 9 e 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 :2 5 18 21 28
21 :2 2c :2 21 34 18 :2 5 18 :2 21
34 18 :2 5 18 :2 21 34 18 :2 5
18 :2 21 34 18 :2 5 18 :2 21 34
18 5 f 13 23 :2 13 22 :3 5
:3 10 :2 5 10 19 18 :2 10 5 9
:2 14 1a 45 4d :2 45 :2 9 :4 10 1e
10 b :2 10 1b 1d :2 1b b :5 9
:2 14 1a 42 4a :2 42 :2 9 d 13
14 :2 13 c d 1a d 17 d
1a d :5 9 :2 14 1a 40 :2 9 d
15 1f 2e 31 :2 1f 3b 1f d
:2 1f 13 d 23 2b :2 23 21 :4 d
:2 18 1e :2 d 9 12 11 :2 1c 22
:3 11 19 23 2d 30 :2 23 3a 23
11 :2 23 17 1f :2 17 11 29 27
:4 11 :2 1c 22 :2 11 23 :2 d 9 :3 5
9 :2 14 1a :2 9 :2 5 9 :4 5 f
13 24 :3 13 24 :2 13 1c :3 5 12
1b 1a :2 12 :2 5 12 1b 1a :2 12
:2 5 12 1b 1a :2 12 :2 5 12 1d
12 :2 25 :3 12 5 9 :2 14 1a 52
5e 66 :2 5e :2 9 d 1a :3 18 c
d 15 1f 2d 30 :2 1f 3b 3e
:2 1f :2 d :2 14 1e :2 14 20 :3 1e :9 d
:2 18 1e 55 :2 d 29 d 15 1f
2d 30 :2 1f 3b 3e :2 1f :2 d :2 14
1e :2 14 20 :3 1e :9 d :2 18 1e 4d
:2 d :4 9 :2 5 9 :4 5 f 13 24
:2 13 20 :3 5 13 1c 1b :2 13 :2 5
13 1c 1b :2 13 :2 5 :3 13 :2 5 :3 13
:2 5 :3 13 :2 5 :3 13 5 9 :2 14 1a
47 4f :2 47 :2 9 :2 14 22 1c :2 1e
:2 1c 26 1c 17 :2 1c :2 1e 27 29
:2 27 :3 2f 3a 2f 2a :2 2f :2 31 41
3f :2 43 :2 3f 2f :2 31 3f 41 :2 3f
:3 2f 3f 41 :2 3f :2 2f 2a 28 27
:3 20 :5 1c 17 15 :2 1e 15 14 f
:2 14 1b 1e :2 1b f :4 d 9 12
25 20 :2 d 9 :3 5 9 :2 14 1a
43 :2 9 d 1a :2 1c :2 1a 25 1a
28 32 28 15 :2 1a :2 1c 26 24
:2 28 :2 24 1a :2 1c 24 2c 34 :4 1a
15 :3 13 :2 9 d :2 18 1e 48 :2 4a
:3 d 1e :2 d 1e :2 d 1b d 11
1f 2c :3 1f 1a :2 1f 29 27 :2 2b
:2 27 1f 2c 2e :2 2c :2 1f 1a :3 18
:2 d 11 :2 1c 22 45 :2 48 :3 11 1f
11 15 :2 18 1f :3 1d 14 15 25
:2 15 25 15 2a :2 11 15 22 :3 20
14 20 24 33 :3 20 3b 20 1b
:2 20 2c 2a :2 2f :2 2a 1b :4 19 1d
24 26 :2 24 1c 1d 2f :2 1d 2f
1d 29 :2 19 15 1e 31 2c :2 19
15 :4 2b :2 11 19 :3 15 14 15 23
2e 31 :2 23 36 39 :2 3c :2 23 15
25 :2 11 d 11 :2 d :2 18 1e 4c
:2 d 11 21 :2 11 10 15 :4 26 :2 15
14 15 1d 27 30 33 :2 27 3d
40 :2 27 47 4a :2 4c :2 27 :2 15 3d
:2 11 :4 15 14 15 1d 27 35 38
:2 3a :2 27 42 45 :2 27 :2 15 29 15
1d 27 35 38 :2 3a :2 27 42 45
:2 27 56 59 :2 27 :2 15 :5 11 :2 1c 22
48 :2 4a :2 11 30 11 :2 1c 22 4c
:2 4e :2 11 :4 d 9 d :2 9 :2 14 1a
:2 9 :2 5 a :4 5 f 13 21 :2 13
1c :2 5 9 :2 14 1a 46 4e :2 46
:2 9 d 1a 25 29 38 :2 25 3b
25 :2 1a 15 1a 15 :3 13 :2 9 11
1e :3 1c 10 11 1f :2 21 2c :2 2e
:2 11 27 11 1f :2 21 2c :2 11 :4 d
9 d :2 9 1b :3 9 1d :8 9 :2 14
1a :2 9 :2 5 9 :4 5 f 0 :2 5
9 :2 14 1a :3 9 17 :3 9 :2 14 1a
:2 9 :2 5 9 :4 5 f 0 :2 5 9
:2 14 1a :3 9 17 :3 9 :2 14 1a :2 9
:2 5 9 :5 5 e 1d 0 24 :2 5
9 10 32 35 :2 10 44 47 4b
:2 47 :2 10 4f :3 10 30 33 37 :2 33
:2 10 3b 3e :2 10 9 :2 5 9 :5 5
e 1b 0 22 :2 5 9 10 30
33 :2 10 40 43 47 :2 43 :2 10 4b
:3 10 2e 31 35 :2 31 :2 10 39 3c
:2 10 9 :2 5 9 :9 5 :6 1
43d
4
0 :3 1 :9 11 :9 12
:c 15 :7 18 :7 19 :7 1d
:7 1e 2f :4 30 :3 2f
:5 32 :7 33 :a 36 :5 38
:3 39 :5 3a 39 :4 38
:a 3b :6 3e :3 3f 3e
:3 41 40 :3 3e :7 43
:8 46 47 48 :2 46
:7 48 :3 46 :6 49 45
4b :6 4c :8 4d 4e
4f :2 4d :7 4f :3 4d
:6 50 :3 4b 4a :3 34
:6 53 :2 34 54 :4 2f
5f :4 60 :4 61 :3 5f
:7 63 :7 64 :7 65 :a 66
:b 68 :6 6a :d 6c 6e
:3 6f :5 70 :3 6e :5 71
:7 73 6a :d 77 79
:3 7a :5 7b :3 79 :5 7c
:7 7e 75 :3 6a :2 67
81 :4 5f 8c :4 8d
:3 8c :7 8f :7 90 :5 91
:5 92 :5 93 :5 94 :a 97
:3 9b :4 9c :5 9d :7 9e
:2 9f :5 a0 :9 a1 :7 a2
:2 a1 :5 a3 :2 a1 a0
:8 9f :2 9e 9d 9c
:3 a4 :3 9c :5 a5 9c
:4 9b 9a :5 a7 a6
:3 95 :7 a9 :5 ac :8 ad
:9 ae :8 af :2 ae ad
:4 ac b0 :9 b1 :3 b6
:3 b7 :3 bb :5 bd :3 be
:7 bf :5 c0 :2 bf be
:4 bd c1 :9 c2 :3 c5
:8 c8 :3 c9 :3 ca :3 c8
:6 d1 :7 d5 :3 d6 :7 d7
d6 :4 d5 :6 da :3 db
:3 dc :3 da d4 :5 e0
df :6 d1 :5 e5 :d e6
:3 e5 c1 e9 bd
:7 eb :5 ee :8 f0 :13 f1
:3 f0 :5 f4 :f f5 f4
:13 f7 f6 :3 f4 :9 f9
ee :9 fb fa :3 ee
b0 fe ac :6 100
:2 95 102 :4 8c 10c
:4 10d :3 10c :a 110 :a 113
:4 114 :4 113 115 :6 116
:9 117 116 :7 119 118
:3 116 115 11b 113
:4 11e :4 121 :5 122 :6 124
:2 10f 125 :4 10c 12f
0 :2 12f :6 132 :4 133
:6 134 :2 131 135 :4 12f
13f 0 :2 13f :6 142
:4 143 :6 144 :2 141 145
:4 13f :3 14f 0 :3 14f
:e 152 153 :2 152 :5 153
:2 152 :2 153 :3 152 :2 151
154 :4 14f :3 15e 0
:3 15e :e 161 162 :2 161
:5 162 :2 161 :2 162 :3 161
:2 160 163 :4 15e :4 2f
166 :6 1
ff6
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 a :2 0 :2 5
:3 0 6 :3 0 7
:2 0 3 6 8
:6 0 8 :4 0 c
9 a 437 4
:6 0 18 19 0
9 5 :3 0 6
:3 0 7 f 11
:6 0 b :4 0 15
12 13 437 9
:6 0 13 :2 0 b
5 :3 0 d :3 0
e :2 0 4 f
:3 0 f :2 0 1
1a 1c :3 0 1d
:7 0 10 :4 0 21
1e 1f 437 c
:6 0 15 :2 0 d
5 :3 0 12 :3 0
24 :7 0 28 25
26 437 11 :6 0
13 :2 0 f 5
:3 0 12 :3 0 2b
:7 0 2f 2c 2d
437 14 :6 0 15
:2 0 11 5 :3 0
12 :3 0 32 :7 0
36 33 34 437
16 :6 0 15 127
0 13 5 :3 0
12 :3 0 39 :7 0
3d 3a 3b 437
17 :6 0 18 :a 0
e2 2 :7 0 19
144 0 17 12
:3 0 19 :7 0 41
40 :3 0 43 :2 0
e2 3e 44 :2 0
52 53 0 1d
12 :3 0 47 :7 0
4a 48 0 e0
0 1a :6 0 6
:3 0 1c :2 0 1b
4c 4e :6 0 51
4f 0 e0 0
1b :6 0 1d :3 0
1e :3 0 1f :4 0
20 :3 0 19 :3 0
1f 56 58 21
54 5a :2 0 dd
21 :3 0 5e :3 0
21 :2 0 24 1a
:3 0 22 :3 0 26
62 68 0 69
:3 0 23 :3 0 24
:2 0 25 :4 0 2a
65 67 :4 0 6b
6c :5 0 5f 63
0 2d 0 6a
:2 0 dd 1d :3 0
1e :3 0 6e 6f
0 26 :4 0 20
:3 0 1a :3 0 2f
72 74 31 70
76 :2 0 dd 1a
:3 0 27 :2 0 13
:2 0 36 79 7b
:3 0 7c :2 0 1b
:3 0 25 :4 0 7e
7f 0 81 39
86 1b :3 0 d
:4 0 82 83 0
85 3b 87 7d
81 0 88 0
85 0 88 3d
0 dd 1d :3 0
1e :3 0 89 8a
0 28 :4 0 1b
:3 0 40 8b 8e
:2 0 dd 29 :3 0
2a :3 0 2b :4 0
2c :2 0 1b :3 0
43 93 95 :3 0
2c :2 0 2d :4 0
2e :3 0 46 97
9a :3 0 c :3 0
9c 20 :3 0 19
:3 0 49 9e a0
a1 9b 0 a4
:2 0 4b a3 :2 0
ac 1d :3 0 1e
:3 0 a6 a7 0
2f :4 0 4e a8
aa :2 0 ac 50
d5 30 :3 0 1d
:3 0 1e :3 0 ae
af 0 31 :4 0
53 b0 b2 :2 0
d0 29 :3 0 2a
:3 0 32 :4 0 2c
:2 0 1b :3 0 55
b7 b9 :3 0 2c
:2 0 33 :4 0 2e
:3 0 58 bb be
:3 0 20 :3 0 19
:3 0 5b c0 c2
c3 c :3 0 c5
bf 0 c8 :2 0
5d c7 :2 0 d0
1d :3 0 1e :3 0
ca cb 0 34
:4 0 60 cc ce
:2 0 d0 62 d2
66 d1 d0 :2 0
d3 68 :2 0 d5
0 d5 d4 ac
d3 :6 0 dd 2
:3 0 1d :3 0 1e
:3 0 d7 d8 0
35 :4 0 6a d9
db :2 0 dd 6c
e1 :3 0 e1 18
:3 0 74 e1 e0
dd de :6 0 e2
1 0 3e 44
e1 437 :2 0 36
:a 0 174 4 :7 0
79 39f 0 77
6 :3 0 37 :7 0
e7 e6 :3 0 3a
:2 0 7b 12 :3 0
38 :7 0 eb ea
:3 0 ed :2 0 174
e4 ee :2 0 3a
:2 0 80 6 :3 0
7e f1 f3 :6 0
f6 f4 0 172
0 39 :6 0 3d
:2 0 84 6 :3 0
82 f8 fa :6 0
fd fb 0 172
0 3b :6 0 106
107 0 88 6
:3 0 86 ff 101
:6 0 104 102 0
172 0 3c :6 0
10f 110 0 8a
3f :3 0 40 :2 0
4 f :3 0 f
:2 0 1 108 10a
:3 0 10b :7 0 10e
10c 0 172 0
3e :6 0 1d :3 0
1e :3 0 41 :4 0
37 :3 0 20 :3 0
38 :3 0 8c 114
116 8e 111 118
:2 0 16f 38 :3 0
16 :3 0 24 :2 0
94 11c 11d :3 0
11e :2 0 29 :3 0
2a :3 0 42 :4 0
2c :2 0 37 :3 0
97 123 125 :3 0
2c :2 0 43 :4 0
9a 127 129 :3 0
12a :4 0 12b :2 0
145 3f :3 0 40
:4 0 12e 12f 44
:3 0 37 :3 0 24
:2 0 9f 133 134
:3 0 12d 137 135
0 138 0 a2
0 136 :2 0 145
45 :3 0 13b 13c
:2 0 13d 45 :5 0
13a :2 0 145 1d
:3 0 1e :3 0 13e
13f 0 46 :4 0
37 :3 0 a4 140
143 :2 0 145 a7
16c 29 :3 0 2a
:3 0 42 :4 0 2c
:2 0 37 :3 0 ac
149 14b :3 0 2c
:2 0 47 :4 0 af
14d 14f :3 0 150
:4 0 151 :2 0 16b
3f :3 0 40 :4 0
154 155 44 :3 0
37 :3 0 24 :2 0
b4 159 15a :3 0
153 15d 15b 0
15e 0 b7 0
15c :2 0 16b 45
:3 0 161 162 :2 0
163 45 :5 0 160
:2 0 16b 1d :3 0
1e :3 0 164 165
0 48 :4 0 37
:3 0 b9 166 169
:2 0 16b bc 16d
11f 145 0 16e
0 16b 0 16e
c1 0 16f c4
173 :3 0 173 36
:3 0 c7 173 172
16f 170 :6 0 174
1 0 e4 ee
173 437 :2 0 49
:a 0 347 5 :7 0
ce :2 0 cc 12
:3 0 4a :7 0 179
178 :3 0 17b :2 0
347 176 17c :2 0
3a :2 0 d2 6
:3 0 1c :2 0 d0
17f 181 :6 0 184
182 0 345 0
4b :6 0 d8 61d
0 d6 6 :3 0
d4 186 188 :6 0
18b 189 0 345
0 4c :6 0 dc
651 0 da 12
:3 0 18d :7 0 190
18e 0 345 0
4d :6 0 4f :3 0
192 :7 0 195 193
0 345 0 4e
:6 0 1a0 1a1 0
de 4f :3 0 197
:7 0 19a 198 0
345 0 50 :6 0
4f :3 0 19c :7 0
19f 19d 0 345
0 51 :6 0 1d
:3 0 1e :3 0 52
:4 0 20 :3 0 4a
:3 0 e0 1a4 1a6
e2 1a2 1a8 :2 0
342 53 :3 0 e5
4b :3 0 54 :3 0
53 :3 0 1ad 1ae
0 e7 55 :3 0
54 :3 0 1b1 1b2
e9 1b4 1e7 0
1e8 :3 0 54 :3 0
56 :3 0 1b6 1b7
0 24 :2 0 57
:4 0 ed 1b9 1bb
:3 0 15 :2 0 f0
3f :3 0 58 :3 0
1bf 1c0 f2 1c2
1dc 0 1dd :3 0
58 :3 0 44 :3 0
1c4 1c5 0 54
:3 0 24 :2 0 53
:3 0 1c7 1c9 0
f6 1c8 1cb :3 0
58 :3 0 59 :3 0
1cd 1ce 0 24
:2 0 15 :2 0 fb
1d0 1d2 :3 0 1cc
1d4 1d3 :2 0 4a
:3 0 24 :2 0 15
:2 0 100 1d7 1d9
:3 0 1d5 1db 1da
:4 0 1be 1c3 0
1de :3 0 5a :2 0
103 1e0 1e1 :3 0
5b :2 0 105 1e3
1e4 :3 0 1bc 1e6
1e5 :4 0 1b0 1b5
0 5c :3 0 1
1ea 107 1e9 :2 0
1ec 109 1ee 1f4
0 1f5 :3 0 5d
:3 0 5e :2 0 15
:2 0 10d 1f1 1f3
:4 0 1f7 1f8 :5 0
1ab 1ef 0 110
0 1f6 :2 0 1fa
112 202 5f :4 0
1fd 114 1ff 116
1fe 1fd :2 0 200
118 :2 0 202 0
202 201 1fa 200
:6 0 342 5 :3 0
1d :3 0 1e :3 0
204 205 0 60
:4 0 4b :3 0 11a
206 209 :2 0 342
61 :3 0 62 :3 0
63 :3 0 20c 20d
0 11d 64 :3 0
62 :3 0 210 211
65 :3 0 57 :3 0
213 214 11f 216
22a 0 22b :3 0
62 :3 0 63 :3 0
218 219 0 57
:3 0 24 :2 0 66
:3 0 21b 21d 0
124 21c 21f :3 0
62 :3 0 63 :3 0
221 222 0 67
:4 0 68 :4 0 127
:3 0 223 224 227
220 229 228 :4 0
20f 217 0 22c
:6 0 22d :2 0 22f
20b 22e 69 :3 0
1d :3 0 1e :3 0
231 232 0 6a
:4 0 61 :3 0 63
:3 0 235 236 0
12a 233 238 :2 0
339 4e :3 0 6b
:3 0 23a 23b 0
339 50 :3 0 6c
:3 0 23d 23e 0
339 4c :3 0 4b
:3 0 240 241 0
339 6d :3 0 6e
:3 0 6f :3 0 244
245 12d 70 :3 0
12f 249 258 0
259 :3 0 71 :3 0
61 :3 0 24 :2 0
63 :3 0 24c 24e
0 133 24d 250
:3 0 72 :3 0 24
:2 0 73 :4 0 138
253 255 :3 0 251
257 256 :4 0 247
24a 0 25a :6 0
25b :2 0 25d 243
25c 69 :3 0 1d
:3 0 1e :3 0 25f
260 0 74 :4 0
6d :3 0 6f :3 0
263 264 0 13b
261 266 :2 0 2c9
51 :3 0 6c :3 0
268 269 0 2c9
6d :3 0 6f :3 0
26b 26c 0 4b
:3 0 24 :2 0 140
26f 270 :3 0 271
:2 0 4e :3 0 6c
:3 0 273 274 0
279 51 :3 0 6b
:3 0 276 277 0
279 143 27a 272
279 0 27b 146
0 2c9 4a :3 0
14 :3 0 24 :2 0
14a 27e 27f :3 0
280 :2 0 75 :3 0
59 :3 0 13 :2 0
14d 282 285 150
4d :3 0 3f :3 0
152 28a 292 0
293 :3 0 44 :3 0
6d :3 0 24 :2 0
6f :3 0 28d 28f
0 156 28e 291
:4 0 295 296 :5 0
287 28b 0 159
0 294 :2 0 2a7
4d :3 0 24 :2 0
15 :2 0 15d 299
29b :3 0 29c :2 0
50 :3 0 6b :3 0
29e 29f 0 2a4
51 :3 0 6b :3 0
2a1 2a2 0 2a4
160 2a5 29d 2a4
0 2a6 163 0
2a7 165 2af 5f
:4 0 2aa 168 2ac
16a 2ab 2aa :2 0
2ad 16c :2 0 2af
0 2af 2ae 2a7
2ad :6 0 2b1 8
:3 0 16e 2b2 281
2b1 0 2b3 170
0 2c9 51 :3 0
5b :2 0 172 2b5
2b6 :3 0 2b7 :2 0
4c :3 0 4c :3 0
2c :2 0 76 :4 0
174 2bb 2bd :3 0
2c :2 0 6d :3 0
6f :3 0 2c0 2c1
0 177 2bf 2c3
:3 0 2b9 2c4 0
2c6 17a 2c7 2b8
2c6 0 2c8 17c
0 2c9 17e 2cb
69 :3 0 25d 2c9
:4 0 339 1d :3 0
1e :3 0 2cc 2cd
0 77 :4 0 4c
:3 0 184 2ce 2d1
:2 0 339 4e :3 0
50 :3 0 2d3 2d5
2d4 :2 0 2d6 :2 0
4e :3 0 4b :3 0
78 :2 0 187 2da
2db :3 0 2d8 2dd
2dc :2 0 2de :2 0
29 :3 0 2a :3 0
79 :4 0 2c :2 0
4b :3 0 189 2e3
2e5 :3 0 2c :2 0
7a :4 0 18c 2e7
2e9 :3 0 2c :2 0
61 :3 0 63 :3 0
2ec 2ed 0 18f
2eb 2ef :3 0 2f0
:4 0 2f1 :2 0 2f3
192 2f4 2df 2f3
0 2f5 194 0
32b 4c :3 0 7b
:2 0 196 2f7 2f8
:3 0 2f9 :2 0 29
:3 0 2a :3 0 7c
:4 0 2c :2 0 61
:3 0 63 :3 0 2ff
300 0 198 2fe
302 :3 0 2c :2 0
7d :4 0 19b 304
306 :3 0 307 :4 0
308 :2 0 30a 19e
31f 29 :3 0 2a
:3 0 7c :4 0 2c
:2 0 61 :3 0 63
:3 0 30f 310 0
1a0 30e 312 :3 0
2c :2 0 7e :4 0
1a3 314 316 :3 0
2c :2 0 4c :3 0
1a6 318 31a :3 0
31b :4 0 31c :2 0
31e 1a9 320 2fa
30a 0 321 0
31e 0 321 1ab
0 32b 1d :3 0
1e :3 0 322 323
0 7f :4 0 61
:3 0 63 :3 0 326
327 0 1ae 324
329 :2 0 32b 1b1
336 1d :3 0 1e
:3 0 32c 32d 0
80 :4 0 61 :3 0
63 :3 0 330 331
0 1b5 32e 333
:2 0 335 1b8 337
2d7 32b 0 338
0 335 0 338
1ba 0 339 1bd
33b 69 :3 0 22f
339 :4 0 342 1d
:3 0 1e :3 0 33c
33d 0 81 :4 0
1c5 33e 340 :2 0
342 1c7 346 :3 0
346 49 :3 0 1cd
346 345 342 343
:6 0 347 1 0
176 17c 346 437
:2 0 82 :a 0 3a4
a :7 0 1d6 :2 0
1d4 12 :3 0 4a
:7 0 34c 34b :3 0
34e :2 0 3a4 349
34f :2 0 1d :3 0
1e :3 0 351 352
0 83 :4 0 20
:3 0 4a :3 0 1d8
355 357 1da 353
359 :2 0 39f 61
:3 0 44 :3 0 75
:3 0 59 :3 0 13
:2 0 1dd 35d 360
84 :3 0 361 362
1e0 3f :3 0 1e3
366 :2 0 368 :5 0
364 367 0 369
:6 0 36a :2 0 36c
35b 36b 69 :3 0
4a :3 0 14 :3 0
24 :2 0 1e7 370
371 :3 0 372 :2 0
36 :3 0 61 :3 0
44 :3 0 375 376
0 61 :3 0 84
:3 0 378 379 0
1ea 374 37b :2 0
37d 1ed 386 36
:3 0 61 :3 0 44
:3 0 37f 380 0
16 :3 0 1ef 37e
383 :2 0 385 1f2
387 373 37d 0
388 0 385 0
388 1f4 0 389
1f7 38b 69 :3 0
36c 389 :4 0 39f
49 :3 0 4a :3 0
1f9 38c 38e :2 0
39f 18 :3 0 4a
:3 0 1fb 390 392
:2 0 39f 45 :3 0
396 397 :2 0 398
45 :5 0 395 :2 0
39f 1d :3 0 1e
:3 0 399 39a 0
85 :4 0 1fd 39b
39d :2 0 39f 1ff
3a3 :3 0 3a3 82
:4 0 3a3 3a2 39f
3a0 :6 0 3a4 1
0 349 34f 3a3
437 :2 0 86 :a 0
3bf c :8 0 3a7
:2 0 3bf 3a6 3a8
:2 0 1d :3 0 1e
:3 0 3aa 3ab 0
87 :4 0 206 3ac
3ae :2 0 3ba 82
:3 0 14 :3 0 208
3b0 3b2 :2 0 3ba
1d :3 0 1e :3 0
3b4 3b5 0 88
:4 0 20a 3b6 3b8
:2 0 3ba 20c 3be
:3 0 3be 86 :4 0
3be 3bd 3ba 3bb
:6 0 3bf 1 0
3a6 3a8 3be 437
:2 0 89 :a 0 3da
d :8 0 3c2 :2 0
3da 3c1 3c3 :2 0
1d :3 0 1e :3 0
3c5 3c6 0 8a
:4 0 210 3c7 3c9
:2 0 3d5 82 :3 0
11 :3 0 212 3cb
3cd :2 0 3d5 1d
:3 0 1e :3 0 3cf
3d0 0 8b :4 0
214 3d1 3d3 :2 0
3d5 216 3d9 :3 0
3d9 89 :4 0 3d9
3d8 3d5 3d6 :6 0
3da 1 0 3c1
3c3 3d9 437 :2 0
8c :3 0 8d :a 0
405 e :7 0 8e
:4 0 6 :3 0 3df
3e0 0 405 3dd
3e1 :2 0 8e :3 0
8f :4 0 2c :2 0
90 :3 0 21a 3e5
3e7 :3 0 2c :2 0
91 :3 0 92 :2 0
21d 3ea 3ec 21f
3e9 3ee :3 0 2c
:2 0 93 :4 0 222
3f0 3f2 :3 0 2c
:2 0 91 :3 0 92
:2 0 225 3f5 3f7
227 3f4 3f9 :3 0
2c :2 0 94 :3 0
22a 3fb 3fd :3 0
3fe :2 0 400 22d
404 :3 0 404 8d
:4 0 404 403 400
401 :6 0 405 1
0 3dd 3e1 404
437 :2 0 8c :3 0
95 :a 0 430 f
:7 0 8e :4 0 6
:3 0 40a 40b 0
430 408 40c :2 0
8e :3 0 96 :4 0
2c :2 0 4 :3 0
22f 410 412 :3 0
2c :2 0 91 :3 0
92 :2 0 232 415
417 234 414 419
:3 0 2c :2 0 97
:4 0 237 41b 41d
:3 0 2c :2 0 91
:3 0 92 :2 0 23a
420 422 23c 41f
424 :3 0 2c :2 0
9 :3 0 23f 426
428 :3 0 429 :2 0
42b 242 42f :3 0
42f 95 :4 0 42f
42e 42b 42c :6 0
430 1 0 408
40c 42f 437 :3 0
435 0 435 :3 0
435 437 433 434
:6 0 438 :2 0 3
:3 0 244 0 3
435 43b :3 0 43a
438 43c :8 0
254
4
:3 0 1 7 1
4 1 10 1
d 1 16 1
22 1 29 1
30 1 37 1
3f 1 42 1
46 1 4d 1
4b 1 57 2
55 59 1 5d
1 61 1 66
2 64 66 1
60 1 73 2
71 75 1 7a
2 78 7a 1
80 1 84 2
86 87 2 8c
8d 2 92 94
2 96 98 1
9f 2 9d a2
1 a9 2 a5
ab 1 b1 2
b6 b8 2 ba
bc 1 c1 2
c4 c6 1 cd
3 b3 c9 cf
1 ad 1 d2
1 da 7 5b
6d 77 88 8f
d5 dc 2 49
50 1 e5 1
e9 2 e8 ec
1 f2 1 f0
1 f9 1 f7
1 100 1 fe
1 105 1 115
3 112 113 117
1 11b 2 11a
11b 2 122 124
2 126 128 1
132 2 131 132
1 130 2 141
142 4 12c 138
13d 144 2 148
14a 2 14c 14e
1 158 2 157
158 1 156 2
167 168 4 152
15e 163 16a 2
16c 16d 2 119
16e 4 f5 fc
103 10d 1 177
1 17a 1 180
1 17e 1 187
1 185 1 18c
1 191 1 196
1 19b 1 1a5
2 1a3 1a7 1
1aa 1 1af 1
1b3 1 1ba 2
1b8 1ba 1 1bd
1 1c1 1 1ca
2 1c6 1ca 1
1d1 2 1cf 1d1
1 1d8 2 1d6
1d8 1 1df 1
1e2 1 1eb 1
1ed 1 1f2 2
1f0 1f2 1 1ac
1 1f9 1 1fc
1 1fb 1 1ff
2 207 208 1
20e 2 212 215
1 21e 2 21a
21e 2 225 226
2 234 237 1
246 1 248 1
24f 2 24b 24f
1 254 2 252
254 2 262 265
1 26e 2 26d
26e 2 275 278
1 27a 1 27d
2 27c 27d 2
283 284 1 286
1 289 1 290
2 28c 290 1
288 1 29a 2
298 29a 2 2a0
2a3 1 2a5 2
297 2a6 1 2a9
1 2a8 1 2ac
1 2af 1 2b2
1 2b4 2 2ba
2bc 2 2be 2c2
1 2c5 1 2c7
5 267 26a 27b
2b3 2c8 2 2cf
2d0 1 2d9 2
2e2 2e4 2 2e6
2e8 2 2ea 2ee
1 2f2 1 2f4
1 2f6 2 2fd
301 2 303 305
1 309 2 30d
311 2 313 315
2 317 319 1
31d 2 31f 320
2 325 328 3
2f5 321 32a 2
32f 332 1 334
2 336 337 7
239 23c 23f 242
2cb 2d2 338 1
33f 5 1a9 202
20a 33b 341 6
183 18a 18f 194
199 19e 1 34a
1 34d 1 356
2 354 358 2
35e 35f 2 35c
363 1 365 1
36f 2 36e 36f
2 377 37a 1
37c 2 381 382
1 384 2 386
387 1 388 1
38d 1 391 1
39c 6 35a 38b
38f 393 398 39e
1 3ad 1 3b1
1 3b7 3 3af
3b3 3b9 1 3c8
1 3cc 1 3d2
3 3ca 3ce 3d4
2 3e4 3e6 1
3eb 2 3e8 3ed
2 3ef 3f1 1
3f6 2 3f3 3f8
2 3fa 3fc 1
3ff 2 40f 411
1 416 2 413
418 2 41a 41c
1 421 2 41e
423 2 425 427
1 42a f b
14 20 27 2e
35 3c e2 174
347 3a4 3bf 3da
405 430
1
4
0
43b
0
1
14
f
24
0 1 2 1 1 5 5 7
8 1 a 1 1 1 1 0
0 0 0 0
30 1 0
4 1 0
e4 1 4
191 5 0
f0 4 0
29 1 0
196 5 0
fe 4 0
16 1 0
4b 2 0
e9 4 0
408 1 f
176 1 5
19b 5 0
18c 5 0
3f 2 0
185 5 0
3a6 1 c
349 1 a
35b b 0
20b 7 0
34a a 0
177 5 0
37 1 0
3 0 1
3e 1 2
e5 4 0
3c1 1 d
243 8 0
46 2 0
22 1 0
17e 5 0
105 4 0
d 1 0
3dd 1 e
f7 4 0
0
/
 show err;
 
PROMPT *** Create  grants  BARS_ROLE_ADMIN ***
grant EXECUTE                                                                on BARS_ROLE_ADMIN to ABS_ADMIN;
grant EXECUTE                                                                on BARS_ROLE_ADMIN to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ROLE_ADMIN to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_role_admin.sql =========*** End
 PROMPT ===================================================================================== 
 